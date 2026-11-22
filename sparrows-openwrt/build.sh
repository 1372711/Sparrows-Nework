#!/usr/bin/env bash
# Build the Sparrows-Network OpenWrt images with the OpenWrt Image Builder.
# One image per role and device: the same image goes on every unit of that role.
# What each port and radio does comes from the role (uses.txt), or from a manual line (profiles.txt).
# Runs on an x86_64 Debian or Ubuntu laptop (other distributions: not supported for now). Needs: wget, zstd, make, gcc, python3, perl, rsync (see OpenWrt IB docs), gpgv.
#
# Usage: ./build.sh              -> in a terminal: a menu to pick the devices (Enter = all of them)
#                                   without a terminal (a script, cron): every line of profiles.txt
#        ./build.sh all          -> every line of profiles.txt, no menu
#        ./build.sh perch        -> every line with that role, alone or combined (or: feeder, hedge,
#                                   tree, or a manual line's name), no menu
#        ./build.sh uses         -> what each port and radio of every line will do, nothing built
#        VER=25.12.x ./build.sh  -> another 25.12 release
#        UI=1 ./build.sh all     -> with the web interface (LuCI), only where profiles.txt says "ui"
#        COUNTRY=DE ./build.sh   -> the country the units stand in (two letters, ISO 3166). Asked once
#                                   and kept in local.conf (not in git) when not given
#        ./build.sh sd [image]   -> write a Raspberry Pi image (.img.gz) to an SD card: asks which
#                                   reader, shows what is on it, and asks you to type its name first.
#                                   A card with a locked /home: rewrite the system only, /home kept
#        ./build.sh home <unit>  -> set up the locked /home of a Pi unit (a nest, a tree), over SSH:
#                                   makes its passphrase, shows it once, keeps it in secrets/home/
#        ./build.sh unlock <unit> -> open a unit's /home with its passphrase from secrets/home/
#        ./build.sh approvers <unit> -> seal the unit's unlock key for the approvers of its image
#                                   (a unit set up before it had approvers, or to drop them all)
# Versions: each build is stamped with the build tree's git version (git describe: the last tag, the
# commits since, the commit; "-dirty" when files are changed and not committed). The images go to
# build/images/<version>/, with a SHA256SUMS file; build/images/latest points to the newest. Older
# versions stay, to go back to. On a unit, /etc/sparrows/version and the login text say which
# version it runs, and on the admin laptop  git log <that version>..  shows what changed since.
#
# Two checks, each can be skipped when needed:
#   CHECK_SIG=0 ./build.sh     -> don't check OpenWrt's signature on the Image Builder's checksums
#                                 (its public keys are in trust/; a new key: check its fingerprint on
#                                 https://openwrt.org/docs/guide-user/security/signatures, add it there)
#   CHECK_RULES=0 ./build.sh   -> don't check the image's package list against the hard rules
# One check is never skipped: an SD-card image must end before the locked /home (HOME_START_MB).
#
# Downloads are kept and checked by their sha256, so each is fetched once: build/dl (OpenWrt's Image
# Builders and their signed checksums), build/firmware, build/wheels. Nothing there is deleted; remove a
# file by hand to fetch it again. An Image Builder that stops working is unpacked again from build/dl.
#
# The menu lists the devices already in profiles.txt with what their interfaces do (several can be
# picked at once), can change the release, can turn the web interface on or off, and can add a new
# device: it searches the Image Builder for the model, asks the role (or the uses of each interface,
# in manual mode), the radio power and whether the web interface fits, shows what each interface
# will do, and adds the line to profiles.txt marked "not yet tested".
# Web interface: LuCI, listening on the unit itself only (ui/files, reached through SSH). Never on a
# device marked "-" (8 MB flash / 64 MB RAM); there the image is built without it, and says so.
#
# Before the first build:
#   keys/*.pub           admin SSH public keys (root password is locked)
#   secrets/flyway.key   the 5 GHz flyway SAE passphrase (images with a 5 GHz flyway: perch)
#   secrets/hedge.key    the 2.4 GHz flyway SAE passphrase (images with a 2.4 GHz flyway: hedge)
#                        Each: one line of 8 to 63 printable ASCII characters, ideally letters/digits only.
#                        Generate one: head -c 32 /dev/urandom | base64 | tr -dc 'A-Za-z0-9' | head -c 32
#                        Images with a flyway contain its key: never publish them.
#   secrets/home/        made by ./build.sh home: one passphrase per unit's /home. Never in an image
#   keys/approvers.txt   the approvers of the locked /home: one Reticulum public key per line (128 hex,
#                        from sparrows-approve id), no names. Asked once when missing; empty = none,
#                        /home then opens by hand only. Out of git, like the rest of keys/
set -euo pipefail

VER="${VER:-25.12.6}"     # 2026-10-18, security fixes. Check https://downloads.openwrt.org/releases/ for the latest 25.12.x
UI="${UI:-0}"             # 1 = add the web interface where profiles.txt allows it
CHECK_SIG="${CHECK_SIG:-1}"
CHECK_RULES="${CHECK_RULES:-1}"
HERE="$(cd "$(dirname "$0")" && pwd)"
# The country the units stand in: the radios follow its rules (channels, power, radar checks). Given as
# COUNTRY=XX, or kept in local.conf, which stays on this laptop (never in git: every builder has their own)
COUNTRY="${COUNTRY:-$(sed -n "s/^COUNTRY='*\([A-Za-z][A-Za-z]\)'*$/\1/p" "$HERE/local.conf" 2>/dev/null || true)}"
COUNTRY=$(printf '%s' "$COUNTRY" | tr '[:lower:]' '[:upper:]')
OUT="$HERE/build/images"
# The version of this build tree. Without git (a copy of the kit): "unversioned"
VERSION=$(git -C "$HERE" describe --tags --always --dirty 2>/dev/null || echo unversioned)
VERSION=${VERSION//\//-}
# The Image Builder's Makefiles break on a path with a space in it (seen 2026-11-21: "/home/me/00 - x"
# was cut at the first space, and "make info" failed). Then it works in a folder of its own, outside
# the tree; the images still land in build/images. SPARROWS_BUILD=<folder> chooses another one.
BUILD="${SPARROWS_BUILD:-$HERE/build}"
case "$BUILD" in *[[:space:]]*) BUILD="${XDG_CACHE_HOME:-$HOME/.cache}/sparrows-build" ;; esac

# Every image: no DHCP/RA server, no firewall, no PPP, no web UI (a station only bridges)
BASE="-dnsmasq -odhcpd-ipv6only -firewall4 -nftables -kmod-nft-offload -ppp -ppp-mod-pppoe -luci -luci-ssl"
# ...plus what its uses need
PKG_flyway="-wpad-basic-mbedtls wpad-mesh-mbedtls kmod-batman-adv batctl-default iw"
PKG_join="iw"
# A nest keeps odhcpd and dnsmasq (RA and DNS, no DHCP) and adds uhttpd: PKG_nest, in nest/role.conf.
# Reticulum: Python and the libraries Reticulum asks for; Reticulum and Nomad Network come as pinned
# wheels (tree/role.conf). Needs room: SD-card devices, not 8-16 MB flash.
PKG_reticulum="python3 python3-cryptography python3-pyserial iw"
# The locked /home (SD-card devices with HOME_START_MB in device.conf, on units that run Reticulum):
# LUKS, a filesystem inside it, and the tools that find its partition again after an update
PKG_home="cryptsetup kmod-crypto-xts kmod-fs-ext4 e2fsprogs sfdisk partx-utils blkid"
# LuCI = luci-light minus its firewall and PPP pages. luci-light itself would bring firewall4 and
# nftables back (luci-app-firewall needs a firewall): no firewall is a hard rule. No HTTPS: it only
# listens on 127.0.0.1 and ::1
PKG_ui="uhttpd uhttpd-mod-ubus luci-mod-admin-full luci-theme-bootstrap luci-proto-ipv6 rpcd-mod-rrdns"
# Never in a station image (hard rules: only nests send RAs; no DHCP, firewall or PPP). CHECK_RULES
FORBIDDEN="dnsmasq dnsmasq-full dnsmasq-dhcpv6 odhcpd odhcpd-ipv6only firewall firewall4 nftables
nftables-json nftables-nojson iptables iptables-nft ppp ppp-mod-pppoe luci-app-firewall"
FORBIDDEN_NO_UI="luci-base uhttpd"     # ...and no web interface unless it was asked for

die() { echo "$*" >&2; exit 1; }

# Identity (hard rule: nobody is named). What a machine can catch before anything is built; the rest
# is in the Sparrows Tao, "Staying unnamed". Warnings only, except the rights on secrets/.
identity_check() {
	local GE GN HITS
	if git -C "$HERE" rev-parse >/dev/null 2>&1; then
		GE=$(git -C "$HERE" config user.email || true)
		GN=$(git -C "$HERE" config user.name || true)
		echo "  Commits made here are signed \"${GN:-?} <${GE:-?}>\": public for good once pushed."
		case "$GE" in
			*noreply*|*no-reply*) ;;
			*) echo "    Safer: a pseudonym and a no-reply address (git config user.name / user.email)." ;;
		esac
	fi
	# An e-mail address in a file that goes into the images (the project's shared contact is fine)
	HITS=$(grep -rInE '[A-Za-z0-9._%+-]+@[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*\.[A-Za-z]{2,}' \
		"$HERE/common" "$HERE/station" "$HERE/perch" "$HERE/tree" "$HERE/nest" "$HERE/home" "$HERE/ui" "$HERE/devices" \
		2>/dev/null | grep -v -e 'sparrows-network@riseup\.net' || true)
	if [ -n "$HITS" ]; then
		echo "  Identity: an e-mail address in a file that goes into the images. Is it someone's?"
		printf '%s\n' "$HITS" | head -n 5 | sed 's/^/    /'
	fi
	# The radio keys and passphrases: readable by you only
	[ ! -d "$HERE/secrets" ] || chmod -R go-rwx "$HERE/secrets"
}

# The approvers' public keys from keys/approvers.txt: 128 hex characters each, one per line, the rest
# of a line dropped (a note there stays on this laptop). Prints the keys; fails on a line that isn't one
approver_keys() {
	awk '{ sub(/#.*/, "") } NF { if ($1 !~ /^[0-9a-fA-F]+$/ || length($1) != 128) { print "not a key: " substr($1, 1, 20) "..." > "/dev/stderr"; bad = 1 } else print tolower($1) }
		END { exit bad }' "$HERE/keys/approvers.txt"
}

# Asked once, when an image with a locked /home is built and keys/approvers.txt doesn't exist yet
ask_approvers() {
	local L N=0
	echo
	echo "  Pi units lock their /home. An approver can open it from their phone or laptop when a unit asks."
	echo "  Each approver runs  sparrows-approve id  (sparrows-openwrt/approver/) and gives you the key it prints."
	echo "  Paste one key per line, then an empty line. None (Enter now) = /home opens by hand only."
	( umask 077; : > "$HERE/keys/approvers.txt" )
	while L=$(ask "  approver key: ") && [ -n "$L" ]; do
		if [[ "$L" =~ ^[0-9a-fA-F]{128}$ ]]; then echo "$L" >> "$HERE/keys/approvers.txt"; N=$((N + 1))
		elif [[ "$L" =~ ^[A-Z2-7]{100,}=*$ ]]; then
			# Sideband's identity backup is the PRIVATE key in base32: it must never leave the phone
			echo "  That looks like a Sideband identity backup: a PRIVATE key. Left out, nothing kept."
			echo "  Whoever has it can be that identity: make a new one in Sideband if it went anywhere."
			echo "  An approver key comes from  sparrows-approve id  (128 hex characters), not from Sideband."
		else echo "  Not a key (128 hex characters): left out."; fi
	done
	echo "  $N approver(s), kept in keys/approvers.txt (no names). Change it there, then rebuild and update."
}

# The device lines of profiles.txt: role target profile tx2 tx5 [ui] [uses=...]. A # starts a comment anywhere
profiles() { awk '{ sub(/#.*/, "") } NF { $1 = $1; print }' "$HERE/profiles.txt"; }

# ---------------------------------------------------------------- uses of each interface

# The role presets of uses.txt: role ports 2.4GHz 5GHz services
presets() { awk '{ sub(/#.*/, "") } NF { $1 = $1; print }' "$HERE/uses.txt"; }
ROLES=$(presets | awk '{ printf "%s ", $1 }'); ROLES=${ROLES% }

has() { case " $1 " in *" $2 "*) return 0 ;; esac; return 1; }

# What a device's radios can do: CAN2 / CAN5 in devices/<profile>/device.conf, else everything
can() (
	CAN2='feeder flyway join' CAN5='feeder flyway join'
	if [ -f "$HERE/devices/$1/device.conf" ]; then
		# shellcheck source=/dev/null
		. "$HERE/devices/$1/device.conf"
	fi
	echo "$CAN2|$CAN5"
)

# The uses of a device line, as PORTS|USE2|USE5|RETICULUM|NEST (e.g. wire|flyway feeder|feeder|0|0),
# or why it can't be built (and returns 1). A role's preset is lenient (a band set to - is simply
# off); a manual uses= line is strict (it says exactly what it wants).
uses_of() {
	local R=$1 P=$2 X2=$3 X5=$4 SPEC=${5:-} PORTS='' U2='' U5='' S='' RNS=0 NEST=0 MANUAL=0
	local PART L A B C D W X C2 C5 N
	if [ -n "$SPEC" ]; then
		MANUAL=1
		IFS=, read -r PORTS U2 U5 S X <<<"${SPEC#uses=}"
		{ [ -n "$S" ] && [ -z "$X" ]; } || { echo "uses= needs 4 fields: ports,2.4GHz,5GHz,services"; return 1; }
		U2=${U2//+/ } U5=${U5//+/ }
		[ "$S" != - ] || S=''
		S=${S//+/ }
	else
		for PART in ${R//+/ }; do
			L=$(presets | awk -v r="$PART" '$1 == r')
			[ -n "$L" ] || { echo "unknown role '$PART' (roles: $ROLES)"; return 1; }
			read -r _ A B C D <<<"$L"
			[ "$A" != wire ] || PORTS=wire
			[ "$B" = off ] || U2="$U2 ${B//+/ }"
			[ "$C" = off ] || U5="$U5 ${C//+/ }"
			[ "$D" = - ] || S="$S $D"
		done
		[ -n "$PORTS" ] || PORTS=off
	fi
	case "$PORTS" in wire|off) ;; *) echo "ports '$PORTS' is not wire or off"; return 1 ;; esac
	for W in $U2 $U5; do
		case "$W" in feeder|flyway|join|off) ;; *) echo "'$W' is not a use (feeder, flyway, join, off)"; return 1 ;; esac
	done
	for W in $S; do
		case "$W" in
			reticulum) RNS=1 ;;
			nest) NEST=1 RNS=1 ;;      # a nest relays and stores for Reticulum too
			*) echo "'$W' is not a service (reticulum, nest, or -)"; return 1 ;;
		esac
	done
	# Each use once, always in the same order; off means nothing
	N=''; for W in flyway feeder join; do if has "$U2" "$W"; then N="$N $W"; fi; done; U2=${N# }
	N=''; for W in flyway feeder join; do if has "$U5" "$W"; then N="$N $W"; fi; done; U5=${N# }

	# A band set to - is off
	if [ "$X2" = - ] && [ -n "$U2" ]; then
		[ "$MANUAL" = 0 ] || { echo "uses on 2.4 GHz, but its power is -"; return 1; }
		U2=''
	fi
	if [ "$X5" = - ] && [ -n "$U5" ]; then
		[ "$MANUAL" = 0 ] || { echo "uses on 5 GHz, but its power is -"; return 1; }
		U5=''
	fi
	# What the chip can do (device.conf)
	IFS='|' read -r C2 C5 <<<"$(can "$P")"
	for W in $U2; do has "$C2" "$W" || { echo "this device's 2.4 GHz radio can't do '$W' (devices/$P/device.conf)"; return 1; }; done
	for W in $U5; do has "$C5" "$W" || { echo "this device's 5 GHz radio can't do '$W' (devices/$P/device.conf)"; return 1; }; done

	# A nest never joins: it serves the village, its radios don't hang on someone else's
	if [ "$NEST" = 1 ]; then U2=${U2% join}; U2=${U2%join}; U5=${U5% join}; U5=${U5%join}; fi
	# A radio that joins does nothing else: when it has another use, it doesn't join
	# (Reticulum then runs on the village bridge). And only one radio joins: the 2.4 GHz one
	if has "$U2" join && [ "$U2" != join ]; then U2=${U2% join}; fi
	if has "$U5" join && [ "$U5" != join ]; then U5=${U5% join}; fi
	if [ "$U2" = join ] && [ "$U5" = join ]; then U5=''; fi
	# One 5 GHz radio can't hold a flyway (ch 108) and a feeder (ch 132)
	if has "$U5" flyway && has "$U5" feeder; then
		echo "5 GHz: a flyway (ch 108) and a feeder (ch 132) can't share one radio"; return 1
	fi
	if [ -z "$U2$U5" ] && [ "$RNS" = 0 ]; then
		echo "with these bands, this unit would do nothing"; return 1
	fi
	echo "$PORTS|${U2:-off}|${U5:-off}|$RNS|$NEST"
}

# One line: "ports wire | 2.4 flyway+feeder | 5 feeder | Reticulum"
uses_short() {
	local PORTS U2 U5 RNS NEST
	IFS='|' read -r PORTS U2 U5 RNS NEST <<<"$1"
	printf 'ports %s | 2.4 %s | 5 %s%s' "$PORTS" "${U2// /+}" "${U5// /+}" \
		"$( if [ "$NEST" = 1 ]; then echo ' | nest'; elif [ "$RNS" = 1 ]; then echo ' | Reticulum'; fi )"
}

# What each interface will do, in words
uses_long() {
	local PORTS U2 U5 RNS NEST B U W T FIRST
	IFS='|' read -r PORTS U2 U5 RNS NEST <<<"$1"
	if [ "$PORTS" = wire ]; then
		printf '    %-10s %s\n' 'Ethernet' "wire: cable to the site's switch, part of the village (bridged)"
	else
		printf '    %-10s %s\n' 'Ethernet' "off: not in the village bridge"
	fi
	for B in 2.4 5; do
		if [ "$B" = 2.4 ]; then U=$U2; else U=$U5; fi
		if [ "$U" = off ]; then printf '    %-10s %s\n' "$B GHz" 'off'; continue; fi
		FIRST="$B GHz"
		for W in $U; do
			case "$W:$B" in
				feeder:*)  T='feeder: the open Sparrows Wi-Fi, for people'"'"'s devices' ;;
				flyway:5)  T='flyway: link to other perches, AP or client (perch ap), SAE, ch 108, batman-adv' ;;
				flyway:*)  T='flyway: mesh to the other units on ch 1 (802.11s, SAE), batman-adv' ;;
				join:*)    T='join: client of the Sparrows Wi-Fi, like a phone (not bridged)' ;;
			esac
			printf '    %-10s %s\n' "$FIRST" "$T"
			FIRST=''
		done
	done
	if [ "$RNS" = 1 ]; then
		if has "$U2 $U5" join; then W='wsta, the Wi-Fi client'; else W='br-lan, the village bridge'; fi
		printf '    %-10s %s\n' 'Services' "Reticulum relay + the Sparrows page, on $W"
	fi
	if [ "$NEST" = 1 ]; then
		printf '    %-10s %s\n' '' 'nest: router advertisements, DNS (sparrows.lan, catch-all), the welcome page,'
		printf '    %-10s %s\n' '' '      the message store (lxmd), on a fixed village address from the MAC'
	fi
}

# Why a device line can't be built (nothing if it can): caught here, not on a mast
bad_line() {
	local R=$1 T=${2:-} P=${3:-} X2=${4:-} X5=${5:-} U=${6:--} SPEC=${7:-} REST=${8:-} X MAP
	if [ -n "$SPEC" ]; then
		[[ "$SPEC" =~ ^uses= ]] || { echo "7th column '$SPEC' is not uses=..."; return; }
		[[ "$R" =~ ^[a-z][a-z0-9-]*$ ]] || { echo "name '$R' (manual line): letters, digits and - only"; return; }
	else
		[[ "$R" =~ ^[a-z][a-z0-9+]*$ ]] || { echo "role '$R' is not a role or roles joined with +"; return; }
	fi
	[[ "$T" =~ ^[a-z0-9_-]+/[a-z0-9_-]+$ ]] || { echo "target '$T' is not name/subtarget"; return; }
	[ -n "$P" ] || { echo "no profile"; return; }
	for X in "$X2" "$X5"; do
		[[ "$X" =~ ^(-|[0-9]|[12][0-9]|30)$ ]] || { echo "radio power '$X' is not - or 0 to 30 dBm"; return; }
	done
	[[ "$U" =~ ^(ui|-)$ ]] || { echo "6th column '$U' is not ui or -"; return; }
	[ -z "$REST" ] || { echo "too many columns"; return; }
	MAP=$(uses_of "$R" "$P" "$X2" "$X5" "$SPEC") || echo "$MAP"
}

ib_name() { echo "openwrt-imagebuilder-${VER}-${1/\//-}.Linux-x86_64"; }

# The end of an SD-card image's last partition, in MiB, read from its partition table (MBR). OpenWrt's
# .img.gz has metadata after the gzip data: only the first 512 bytes are read
img_end_mb() {
	python3 -I -c '
import gzip, struct, sys
with gzip.open(sys.argv[1]) as f:
    mbr = f.read(512)
if len(mbr) < 512 or mbr[510:512] != b"\x55\xaa":
    sys.exit("no partition table")
end = 0
for i in range(4):
    e = mbr[446 + 16 * i: 462 + 16 * i]
    start, count = struct.unpack("<II", e[8:16])
    if e[4] and count:
        end = max(end, start + count)
print(-(-end * 512 // 1048576))
' "$1"
}

# The kit: the project's public files in one archive, which trees and nests offer for download
# (KIT_TO in tree/ and nest/role.conf), so anyone on the village can get what builds it. Made from git:
# only committed files, so keys/, secrets/ and build/ can't be in it. Made once per version, then
# checked for a private key. Prints the archive's path.
make_kit() {
	local K="$BUILD/kit/sparrows-kit-$VERSION.tar.gz" TOP
	if [ ! -s "$K" ]; then
		TOP=$(git -C "$HERE" rev-parse --show-toplevel 2>/dev/null) || { echo "Not a git checkout: no kit" >&2; return 1; }
		mkdir -p "$BUILD/kit"
		git -C "$TOP" archive --format=tar.gz --prefix=sparrows/ -o "$K.part" HEAD || { rm -f "$K.part"; return 1; }
		# A real key block starts its own line (this script only names the words, inside quotes)
		if tar -xzOf "$K.part" | grep -a -q -E '^-----BEGIN ([A-Z]+ )*PRIVATE KEY( BLOCK)?-----'; then
			rm -f "$K.part"; echo "The kit would hold a private key: not made. Check what is committed" >&2; return 1
		fi
		mv "$K.part" "$K"
	fi
	echo "$K"
}

# OpenWrt's signature on a file, checked with the public keys kept in trust/. The checksums only prove
# the download isn't broken; the signature proves it is OpenWrt's, whatever server or mirror it came
# from. gpgv is enough: python unpacks the keys, so GnuPG itself isn't needed. Prints who signed.
check_sig() {
	local FILE=$1 SIG=$2 KR="$BUILD/trust.gpg" GH="$BUILD/gnupg" STATUS ID
	command -v gpgv >/dev/null || { echo "gpgv is missing (Debian/Ubuntu: apt install gpgv), or CHECK_SIG=0 to skip this check" >&2; return 1; }
	compgen -G "$HERE/trust/*.asc" >/dev/null || { echo "No OpenWrt public key in trust/*.asc, or CHECK_SIG=0 to skip this check" >&2; return 1; }
	mkdir -p "$GH" && chmod 700 "$GH"
	python3 -I -c '
import base64, sys
out = open(sys.argv[1], "wb")              # armored key files -> one binary keyring, as gpgv reads it
for name in sys.argv[2:]:
    body, inside, header = [], False, False
    for line in open(name, encoding="ascii", errors="replace"):
        line = line.strip()
        if line.startswith("-----BEGIN PGP PUBLIC KEY BLOCK"):
            inside, header, body = True, True, []
        elif line.startswith("-----END PGP PUBLIC KEY BLOCK"):
            out.write(base64.b64decode("".join(body)))
            inside = False
        elif inside and header:
            header = line != ""            # the armor headers end at the first empty line
        elif inside and not line.startswith("="):
            body.append(line)
' "$KR" "$HERE"/trust/*.asc || return 1
	if STATUS=$(gpgv --homedir "$GH" --status-fd 1 --keyring "$KR" "$SIG" "$FILE" 2>/dev/null); then
		echo "$(basename "$FILE"): signed by OpenWrt key $(printf '%s\n' "$STATUS" | awk '$2 == "VALIDSIG" { print $NF }')" >&2
		return 0
	fi
	ID=$(printf '%s\n' "$STATUS" | awk '$2 == "NO_PUBKEY" { print $3 }')
	if [ -n "$ID" ]; then
		echo "$(basename "$FILE"): signed by key $ID, which is not in trust/. If openwrt.org lists it" >&2
		echo "  (https://openwrt.org/docs/guide-user/security/signatures), add it to trust/; or CHECK_SIG=0 to skip" >&2
	else
		echo "$(basename "$FILE"): signature check FAILED. Don't use this download (CHECK_SIG=0 skips the check)" >&2
	fi
	return 1
}

# A file checked by its sha256 and kept: fetched only when it is missing or doesn't match. A download
# goes to .part first, so a cut-off one never passes for the real file. A progress bar in a terminal
fetch() {
	local URL=$1 FILE=$2 SUM=$3 PROGRESS=''
	if echo "$SUM  $FILE" | sha256sum -c --status - 2>/dev/null; then return 0; fi
	mkdir -p "$(dirname "$FILE")"
	echo "Fetching ${FILE##*/}..." >&2
	[ ! -t 2 ] || PROGRESS='--show-progress'
	wget -q $PROGRESS -O "$FILE.part" "$URL" || { rm -f "$FILE.part"; echo "Download failed: $URL" >&2; return 1; }
	echo "$SUM  $FILE.part" | sha256sum -c --status - || { rm -f "$FILE.part"; echo "${FILE##*/}: checksum FAILED" >&2; return 1; }
	mv "$FILE.part" "$FILE"
}

# Image Builder for a target. What OpenWrt publishes is kept in build/dl: its signed checksums and the
# Image Builder itself. Unpacked again from there when needed (FRESH=1, or the folder is gone);
# downloaded again only when the kept file is missing or doesn't match the checksums. Runs in a subshell.
get_ib() (
	TARGET=$1 FRESH=${2:-0}
	IB=$(ib_name "$TARGET")
	URL="https://downloads.openwrt.org/releases/${VER}/targets/${TARGET}"
	D="$BUILD/dl"
	mkdir -p "$D" && cd "$BUILD" || exit 1
	[ "$FRESH" = 0 ] || rm -rf "$IB"
	[ -d "$IB" ] && exit 0
	# OpenWrt's checksums for this release and target, with their signature: fetched once, checked every time
	if [ ! -s "$D/$IB.sha256sums" ]; then
		wget -q -O "$D/$IB.sha256sums.part" "$URL/sha256sums" && mv "$D/$IB.sha256sums.part" "$D/$IB.sha256sums" || \
			{ rm -f "$D/$IB.sha256sums.part"; echo "No $VER release for $TARGET" >&2; exit 1; }
		rm -f "$D/$IB.sha256sums.asc"
	fi
	if [ "$CHECK_SIG" = 1 ]; then
		[ -s "$D/$IB.sha256sums.asc" ] || wget -q -O "$D/$IB.sha256sums.asc" "$URL/sha256sums.asc" || \
			{ rm -f "$D/$IB.sha256sums.asc"; echo "No signature at $URL/sha256sums.asc (CHECK_SIG=0 skips this check)" >&2; exit 1; }
		check_sig "$D/$IB.sha256sums" "$D/$IB.sha256sums.asc" || exit 1
	fi
	SUM=$(awk -v f="$IB.tar.zst" '$2 == f || $2 == "*" f { print $1 }' "$D/$IB.sha256sums")
	[ -n "$SUM" ] || { echo "$IB.tar.zst is not in OpenWrt's checksums for $TARGET" >&2; exit 1; }
	fetch "$URL/$IB.tar.zst" "$D/$IB.tar.zst" "$SUM" || exit 1
	# Unpacked aside, then moved: a cut-off unpack is never taken for a complete Image Builder
	echo "Unpacking the Image Builder for $TARGET ($VER)..." >&2
	rm -rf "$IB.part" && mkdir "$IB.part"
	tar -C "$IB.part" --zstd -xf "$D/$IB.tar.zst" && mv "$IB.part/$IB" "$IB" && rmdir "$IB.part" || exit 1
)

# A device left out of this build: said now, and again in the summary at the end
skip() { echo "$*" >&2; echo "$*" >> "$BUILD/.skipped"; exit 0; }

# Build one image. Runs in a subshell: "exit 0" skips this device, any error stops the build.
build_one() (
	ROLE=$1 TARGET=$2 PROFILE=$3 TX2=$4 TX5=$5 UIOK=${6:--} SPEC=${7:-}
	MAP=$(uses_of "$ROLE" "$PROFILE" "$TX2" "$TX5" "$SPEC") || die "$ROLE $PROFILE: $MAP"
	IFS='|' read -r PORTS USE2 USE5 RNS NEST <<<"$MAP"
	[ "$USE2" != off ] || USE2=''
	[ "$USE5" != off ] || USE5=''
	NAMEROLE=${ROLE//+/-}            # tree+feeder -> tree-feeder: in the unit's name and the image's
	WITH_UI=0 NAME="sparrows-$NAMEROLE"

	# --- A device that needs more than a line: devices/<name>/device.conf (see profiles.txt) ---
	IB_PROFILE=$PROFILE DEV_PACKAGES='' MACDEV='' CH2='' FW_URL='' FW_DIR='' FW_FILES='' ROOTFS_MB='' HOME_START_MB=''
	DEV="$HERE/devices/$PROFILE"
	if [ -f "$DEV/device.conf" ]; then
		# shellcheck source=/dev/null
		. "$DEV/device.conf"
	else
		DEV=''
	fi
	if [ "$UI" = 1 ]; then
		if [ "$UIOK" = ui ]; then
			WITH_UI=1 NAME="sparrows-$NAMEROLE-ui"
		else
			echo "$ROLE $PROFILE: too small for the web interface (profiles.txt), built without it" >&2
		fi
	fi
	# The locked /home: on SD-card devices that say where it starts, for units that keep identities
	# (Reticulum: the message store, the Sparrows page node)
	LOCKED_HOME=0
	if [ -n "$HOME_START_MB" ] && [ "$RNS" = 1 ]; then LOCKED_HOME=1; fi

	# --- SAE passphrase for each flyway: 5 GHz (perch) and 2.4 GHz (hedge) ---
	KEYS=''
	if has "$USE5" flyway; then KEYS="$KEYS flyway.key"; fi
	if has "$USE2" flyway; then KEYS="$KEYS hedge.key"; fi
	for KEYF in $KEYS; do
		[ -s "$HERE/secrets/$KEYF" ] || die "$ROLE $PROFILE: put the SAE passphrase in secrets/$KEYF first"
		# Seen 2026-11-14: a key outside 8-63 printable ASCII never links (see Sparrows Tao, Pitfalls).
		# The whole file is checked, as the unit reads it: one line (a final newline is fine)
		( LC_ALL=C; K=$(<"$HERE/secrets/$KEYF"); RE='^[ -~]{8,63}$'; [[ $K =~ $RE ]] ) || \
			die "secrets/$KEYF must be one line of 8 to 63 printable ASCII characters (no accents)"
	done

	# --- Files for this unit: common base, the uses, keys, what the uses need, radio limits ---
	F="$BUILD/files-$NAMEROLE-$PROFILE"
	rm -rf "$F"
	cp -a "$HERE/common/files" "$F"
	cp -a "$HERE/station/files/." "$F/"
	if has "$USE5" flyway; then cp -a "$HERE/perch/files/." "$F/"; fi      # the perch tool
	if [ "$RNS" = 1 ]; then cp -a "$HERE/tree/files/." "$F/"; fi          # Reticulum + the page
	if [ "$NEST" = 1 ]; then cp -a "$HERE/nest/files/." "$F/"; fi         # RA, DNS, welcome page, lxmd
	if [ "$LOCKED_HOME" = 1 ]; then cp -a "$HERE/home/files/." "$F/"; fi  # the locked /home
	install -d -m 700 "$F/etc/dropbear"
	# Type and key only: the comment at the end of a .pub file (often user@laptop) would name the admin
	# to anyone who reads the card
	awk 'NF >= 2 && $1 ~ /^(ssh-|ecdsa-|sk-)/ { print $1, $2 }' "$HERE"/keys/*.pub > "$F/etc/dropbear/authorized_keys"
	[ -s "$F/etc/dropbear/authorized_keys" ] || die "No usable key in keys/*.pub (a line starts with ssh-ed25519, ssh-rsa, ecdsa-... or sk-...)"
	chmod 600 "$F/etc/dropbear/authorized_keys"
	install -d -m 755 "$F/etc/sparrows"
	printf "ROLE='%s'\nTX2='%s'\nTX5='%s'\nPORTS='%s'\nUSE2='%s'\nUSE5='%s'\nRETICULUM='%s'\nNEST='%s'\nCOUNTRY='%s'\n" \
		"$NAMEROLE" "$TX2" "$TX5" "$PORTS" "$USE2" "$USE5" "$RNS" "$NEST" "$COUNTRY" > "$F/etc/sparrows/station"
	printf "SPARROWS_VERSION='%s'\nOPENWRT='%s'\nBUILT='%s'\nLINE='%s'\n" "$VERSION" "$VER" "$(date -u +%F)" \
		"$ROLE $TARGET $PROFILE $TX2 $TX5 $UIOK${SPEC:+ $SPEC}" > "$F/etc/sparrows/version"
	[ -z "$MACDEV" ] || printf "MACDEV='%s'\n" "$MACDEV" >> "$F/etc/sparrows/station"
	[ -z "$CH2" ] || printf "CH2='%s'\n" "$CH2" >> "$F/etc/sparrows/station"
	[ "$LOCKED_HOME" = 0 ] || printf "HOME_START_MB='%s'\n" "$HOME_START_MB" >> "$F/etc/sparrows/station"
	# The approvers of the locked /home: their public keys only, never a name or a note
	if [ "$LOCKED_HOME" = 1 ] && [ -f "$HERE/keys/approvers.txt" ]; then
		approver_keys > "$F/etc/sparrows/approvers" || die "keys/approvers.txt: fix it first"
		chmod 644 "$F/etc/sparrows/approvers"
	fi
	if [ -n "$DEV" ] && [ -d "$DEV/files" ]; then
		cp -a "$DEV/files/." "$F/"
	fi
	# Firmware the device needs and OpenWrt doesn't ship: fetched once, checked file by file
	if [ -n "$FW_FILES" ]; then
		C="$BUILD/firmware/$PROFILE"
		mkdir -p "$C" "$F/$FW_DIR"
		while read -r SUM FILE; do
			[ -n "$FILE" ] || continue
			fetch "$FW_URL/$FILE" "$C/$FILE" "$SUM" || die "$ROLE $PROFILE: firmware $FILE"
			install -m 644 "$C/$FILE" "$F/$FW_DIR/$FILE"
		done <<<"$FW_FILES"
	fi
	for KEYF in $KEYS; do
		install -m 600 "$HERE/secrets/$KEYF" "$F/etc/sparrows/$KEYF"
	done
	if [ "$WITH_UI" = 1 ]; then
		cp -a "$HERE/ui/files/." "$F/"
	fi
	chmod 755 "$F"/etc/uci-defaults/*
	for D in usr/sbin usr/bin etc/init.d; do
		if [ -d "$F/$D" ]; then chmod 755 "$F/$D"/*; fi
	done

	# --- Reticulum: Python wheels (tree/role.conf), fetched once, checked, unpacked into the image ---
	WHEELS='' HANDBOOK_TO='' KIT_TO='' LICENSES_TO='' PKG_nest=''
	if [ "$RNS" = 1 ]; then
		# shellcheck source=/dev/null
		. "$HERE/tree/role.conf"
	fi
	if [ "$NEST" = 1 ]; then
		# shellcheck source=/dev/null
		. "$HERE/nest/role.conf"
	fi
	if [ -n "$WHEELS" ]; then
		C="$BUILD/wheels"
		mkdir -p "$C" "$F/usr/lib/sparrows/python"
		while read -r SUM URL; do
			[ -n "$URL" ] || continue
			W="$C/${URL##*/}"
			fetch "$URL" "$W" "$SUM" || die "$ROLE $PROFILE: Python wheel ${URL##*/}"
			python3 -I -m zipfile -e "$W" "$F/usr/lib/sparrows/python/"
		done <<<"$WHEELS"
	fi
	# --- Licences: each piece's own text, beside it in the image, in /usr/share/sparrows/licenses ---
	# A wheel brings its licence in its .dist-info; when it brings none (rns and lxmf today), the text
	# comes from licenses/<name>.txt. No licence text = no image: what we hand on carries its notice
	L="$F/usr/share/sparrows/licenses"
	mkdir -p "$L"
	[ -f "$HERE/../LICENSE" ] || die "No LICENSE next to sparrows-openwrt/: the project's own licence goes in every image"
	install -m 644 "$HERE/../LICENSE" "$L/sparrows-network.txt"
	cat > "$L/openwrt.txt" <<-EOT
		OpenWrt $VER, target $TARGET: this image is OpenWrt's own packages, unchanged, put together
		with OpenWrt's Image Builder. Each package keeps its licence: GPL-2.0 for Linux and most
		tools, other free licences for some packages.
		Their source code, for this exact release:
		  https://github.com/openwrt/openwrt/tree/v$VER   (and the package feeds it names)
		  https://downloads.openwrt.org/releases/$VER/
	EOT
	if [ -n "$FW_FILES" ]; then
		printf '%s\n' "Wi-Fi firmware in $FW_DIR, from the Raspberry Pi firmware-nonfree repository:" \
			"  ${FW_URL%/debian/*}" "under its maker's licence, kept in that repository. It may be used, not changed;" \
			"images that hold it are for the village's own units, never a public kit." > "$L/firmware.txt"
	fi
	if [ -d "$F/usr/lib/sparrows/python" ]; then
		for DI in "$F"/usr/lib/sparrows/python/*.dist-info; do
			N=${DI##*/}; N=${N%.dist-info}      # e.g. rns-1.6.1
			D=${N%-*}                           # e.g. rns
			mapfile -t LF < <(find "$DI" -type f \( -iname 'LICEN[CS]E*' -o -iname 'COPYING*' \) | sort)
			if [ "${#LF[@]}" -gt 0 ]; then
				cat "${LF[@]}" > "$L/$N.txt"
			elif [ -f "$HERE/licenses/$D.txt" ]; then
				install -m 644 "$HERE/licenses/$D.txt" "$L/$N.txt"
			else
				die "$ROLE $PROFILE: $N brings no licence text. Put it in licenses/$D.txt first"
			fi
		done
	fi
	{
		echo "The licences of the software in this unit, one file per piece. Each keeps its own licence."
		echo "Respect them: see the Sparrows Tao, \"Licences and thanks\"."
		echo
		echo "Reticulum (rns) and LXMF are under the Reticulum License. Never use them in a system"
		echo "built to harm people, never to make or train AI or machine-learning models, and keep"
		echo "their notice with every copy."
		echo
		( cd "$L" && ls -1 | grep -v -x index.txt )
	} > "$L/index.txt"
	for H in $LICENSES_TO; do mkdir -p "$F/$H" && cp -a "$L/." "$F/$H/"; done
	# The built handbook: offered by the page node, and the welcome page of a nest
	if [ -n "$HANDBOOK_TO" ]; then
		if [ -f "$HERE/../tao/index.html" ]; then
			for H in $HANDBOOK_TO; do install -D -m 644 "$HERE/../tao/index.html" "$F/$H"; done
		else
			echo "$ROLE $PROFILE: no ../tao/index.html next to the build tree, so no handbook file in the image" >&2
		fi
	fi
	# The kit, next to the handbook, with its checksum (the line sha256sum -c reads)
	if [ -n "$KIT_TO" ]; then
		if K=$(make_kit); then
			for H in $KIT_TO; do
				install -D -m 644 "$K" "$F/$H"
				printf '%s  %s\n' "$(sha256sum "$K" | cut -d' ' -f1)" "${H##*/}" > "$F/$H.sha256"
			done
		else
			echo "$ROLE $PROFILE: no kit in this image" >&2
		fi
	fi

	get_ib "$TARGET" || die "No Image Builder for $TARGET"
	cd "$BUILD/$(ib_name "$TARGET")"
	# The profile list. An Image Builder that doesn't run (a cut-off unpack, a moved folder) is unpacked
	# once more from the kept download, then said as such: never taken for a missing profile
	if ! INFO=$(make info 2>&1); then
		echo "$ROLE $PROFILE: the Image Builder doesn't run, unpacking it again from build/dl..." >&2
		cd "$BUILD" && get_ib "$TARGET" 1 && cd "$BUILD/$(ib_name "$TARGET")" || die "No Image Builder for $TARGET"
		INFO=$(make info 2>&1) || die "$ROLE $PROFILE: the Image Builder doesn't run (make info):"$'\n'"$(printf '%s\n' "$INFO" | tail -n 4)"
	fi
	printf '%s\n' "$INFO" | grep -q "^$IB_PROFILE:" || skip "$ROLE $PROFILE: no profile $IB_PROFILE in OpenWrt $VER $TARGET"
	# The packages: the base, then what the uses need, each package once
	PACKAGES="$BASE"
	if [ "$NEST" = 1 ]; then PACKAGES=$(printf '%s\n' $BASE | grep -v -x -e -dnsmasq -e -odhcpd-ipv6only | tr '\n' ' '); fi
	if has "$USE2 $USE5" flyway; then PACKAGES="$PACKAGES $PKG_flyway"; fi
	if has "$USE2 $USE5" join; then PACKAGES="$PACKAGES $PKG_join"; fi
	if [ "$RNS" = 1 ]; then PACKAGES="$PACKAGES $PKG_reticulum"; fi
	if [ "$LOCKED_HOME" = 1 ]; then PACKAGES="$PACKAGES $PKG_home"; fi
	PACKAGES="$PACKAGES $PKG_nest $DEV_PACKAGES"
	[ "$WITH_UI" = 0 ] || PACKAGES="$PACKAGES $PKG_ui"
	PACKAGES=$(printf '%s\n' $PACKAGES | awk '!seen[$0]++' | tr '\n' ' ')
	[ -z "$DEV" ] || NAME="$NAME-$PROFILE"       # e.g. sparrows-feeder-rpi-zero-2-w-...-rpi-3-...
	# Image names: openwrt-<release>-<NAME>-<target>-<profile>-squashfs-factory.bin. Matched exactly, so
	# sparrows-feeder never picks up sparrows-feeder-ui, and no image of an earlier run passes for this one
	STEM="$NAME-${TARGET/\//-}-$IB_PROFILE"
	rm -f bin/targets/"$TARGET"/*-"$STEM"-*
	# The hard rules, checked by the machine: the Image Builder lists every package the image would
	# hold, dependencies included, before building it. Seen 2026-11-20: luci-light brought a firewall back
	if [ "$CHECK_RULES" = 1 ]; then
		if ! MANIFEST=$(make manifest PROFILE="$IB_PROFILE" PACKAGES="$PACKAGES" STRIP_ABI=1 2>"$BUILD/.manifest.err"); then
			cat "$BUILD/.manifest.err" >&2
			# Seen 2026-11-22: the laptop was on the Sparrows Wi-Fi, which has no Internet
			if grep -q 'wget: exited with error' "$BUILD/.manifest.err"; then
				die "$ROLE $PROFILE: OpenWrt's packages could not be downloaded. The Image Builder fetches the ones it doesn't have yet: connect this laptop to the Internet (not the Sparrows Wi-Fi) and build again"
			fi
			die "$ROLE $PROFILE: the Image Builder can't put these packages together (make manifest)"
		fi
		NO="$FORBIDDEN"; [ "$WITH_UI" = 1 ] || NO="$NO $FORBIDDEN_NO_UI"
		# A nest is the one unit that sends RAs and answers DNS (no DHCP), and serves the page.
		# Still no firewall, no PPP, no DHCPv6 server
		if [ "$NEST" = 1 ]; then NO=$(printf '%s\n' $NO | grep -v -x -e dnsmasq -e odhcpd-ipv6only -e uhttpd | tr '\n' ' '); fi
		BAD=$(printf '%s\n' "$MANIFEST" | awk -v no="$NO" 'BEGIN { split(no, a); for (i in a) f[a[i]] = 1 }
			($1 in f) { printf "%s ", $1 }')
		[ -z "$BAD" ] || die "$ROLE $PROFILE: the image would hold ${BAD}against the hard rules (no DHCP, RA, firewall or PPP on a station; no web interface unless asked). Fix the package lists in build.sh, or CHECK_RULES=0 to build it anyway"
	fi
	# SD-card devices: the root partition's size, which holds the system and, after it, the space where
	# the unit keeps its changes and data. OpenWrt's default is small (104 MB on a Pi): device.conf can
	# ask for more with ROOTFS_MB, up to the locked /home (HOME_START_MB)
	SIZE=()
	[ -z "$ROOTFS_MB" ] || SIZE=(ROOTFS_PARTSIZE="$ROOTFS_MB")
	if ! make image PROFILE="$IB_PROFILE" PACKAGES="$PACKAGES" FILES="$F" EXTRA_IMAGE_NAME="$NAME" "${SIZE[@]}"; then
		# With the web interface, too big for the flash is the usual reason: skip it, build the others
		[ "$WITH_UI" = 0 ] || skip "$ROLE $PROFILE: no image with the web interface (too big?): build it without, or set ui to - in profiles.txt"
		die "$ROLE $PROFILE: make image failed (its messages are above)"
	fi
	# .bin for most routers, .img.gz for SD-card devices such as the Raspberry Pi. squashfs only: a Pi
	# build also makes ext4 images, but going back to the image's defaults (firstboot) needs squashfs.
	# No initramfs image either: it runs from RAM only, nothing to flash
	shopt -s nullglob
	IMGS=()
	for I in bin/targets/"$TARGET"/*-"$STEM"-*{.bin,.img.gz}; do
		case "$I" in *-ext4-*|*-initramfs-*) ;; *) IMGS+=("$I") ;; esac
	done
	[ "${#IMGS[@]}" -gt 0 ] || die "$ROLE $PROFILE: make image gave no .bin or .img.gz"
	# Never past the locked /home: an update writes the whole image, and must stop before HOME_START_MB.
	# Checked on every image of a device that has one, whatever its role (a unit may change role)
	if [ -n "$HOME_START_MB" ]; then
		for I in "${IMGS[@]}"; do
			case "$I" in *.img.gz) ;; *) continue ;; esac
			E=$(img_end_mb "$I") || die "$ROLE $PROFILE: can't read the partition table of ${I##*/}"
			[ "$E" -le "$HOME_START_MB" ] || die "$ROLE $PROFILE: ${I##*/} ends at $E MiB, past the start of the locked /home ($HOME_START_MB MiB, devices/$PROFILE/device.conf). An update with it would overwrite /home: make ROOTFS_MB smaller"
		done
	fi
	# They replace this device's earlier images (any release, with or without -ui). Other devices' stay
	# Into this version's folder. A rebuild of the same version replaces this device's images there
	V="$OUT/$VERSION"
	mkdir -p "$V"
	rm -f "$V"/*-"sparrows-$NAMEROLE"{,-ui}"${DEV:+-$PROFILE}-${TARGET/\//-}-$IB_PROFILE"-*
	cp "${IMGS[@]}" "$V/"
	printf '%s\n' "${IMGS[@]##*/}" >> "$BUILD/.built"
)

# ---------------------------------------------------------------- menu (terminal only)

ask() { local a; read -r -p "$1" a </dev/tty; printf '%s' "$a"; }
# The same, without showing what is typed
ask_secret() { local a; read -r -s -p "$1" a </dev/tty; echo >&2; printf '%s' "$a"; }

# Power at the radio: "-" (band off) or a whole number of dBm, 0 to 30 (no leading zero: 08 is octal)
ask_tx() {
	local v
	while :; do
		v=$(ask "$1")
		[[ "$v" =~ ^(-|[0-9]|[12][0-9]|30)$ ]] && { printf '%s' "$v"; return; }
		echo "  A number of dBm (0 to 30), or - if this band is not used." >&2
	done
}

# Manual mode: the use of each interface, asked one by one. Prints uses=ports,2.4,5,services
ask_uses() {
	local P U2 U5 S
	echo "Manual mode. Uses: wire, feeder (open Wi-Fi), flyway (link carrying batman-adv)," >&2
	echo "join (client of the Sparrows Wi-Fi), off. Several on one radio with +, e.g. flyway+feeder." >&2
	echo "Services: nest (RAs, DNS, welcome page, message store, Reticulum), reticulum, or none." >&2
	P=$(ask "Ethernet ports (wire or off): ")
	U2=$(ask "2.4 GHz radio (e.g. feeder, flyway+feeder, join, off): ")
	U5=$(ask "5 GHz radio (e.g. feeder, flyway, join, off): ")
	S=$(ask "Services (nest, reticulum, or Enter for none; both need an SD-card device): ")
	printf 'uses=%s,%s,%s,%s' "${P:-wire}" "${U2:-off}" "${U5:-off}" "${S:--}"
}

# OpenWrt's list of every device of a release, all targets in one file (the firmware selector's):
# fetched once per release into build/dl. Only used to find a device: the image itself comes from the
# target's Image Builder, whose signature is checked. Prints its path, or fails without Internet
device_list() {
	local L="$BUILD/dl/overview-$VER.json"
	if [ ! -s "$L" ]; then
		mkdir -p "$BUILD/dl"
		wget -q -O "$L.part" "https://downloads.openwrt.org/releases/$VER/.overview.json" && mv "$L.part" "$L" \
			|| { rm -f "$L.part"; return 1; }
	fi
	echo "$L"
}

# The devices of that list whose name or profile holds every word given, as target<TAB>profile<TAB>name
find_devices() {
	python3 -I -c '
import json, re, sys
data = json.load(open(sys.argv[1]))
profiles = data.get("profiles", [])
if isinstance(profiles, dict):
    profiles = [dict(v, id=k) for k, v in profiles.items()]
words = sys.argv[2].lower().split()
out = set()
for p in profiles:
    names = []
    for t in p.get("titles", []):
        names.append(t.get("title") or " ".join(x for x in (t.get("vendor"), t.get("model"), t.get("variant")) if x))
    hay = (p.get("id", "") + " " + " ".join(names)).lower()
    # each word at the start of a word: "4" finds 4B, not the 4 in "64bit"
    if all(re.search(r"(?<![a-z0-9])" + re.escape(w), hay) for w in words):
        for n in names or [p.get("id", "")]:
            out.add((p.get("target", "?"), p.get("id", "?"), n))
for t, i, n in sorted(out, key=lambda x: x[2].lower()):
    print(t, i, n, sep="\t")
' "$1" "$2"
}

# Find a device in OpenWrt's list (or, without it, in the Image Builder of a target), then add it to
# profiles.txt
add_device() {
	local TARGET WORD FOUND N PROFILE R RS TX2 TX5 UIOK LINE WHY NEW='' SPEC='' MAP i LIST T P D
	echo
	WORD=$(ask "Part of the model name, e.g. cpe510, eap225, raspberry pi 4 (several words: all must match): ")
	[ -n "$WORD" ] || { echo "Nothing added."; return; }
	if LIST=$(device_list); then
		mapfile -t FOUND < <(find_devices "$LIST" "$WORD")
		[ "${#FOUND[@]}" -gt 0 ] || { echo "No device matching '$WORD' in OpenWrt $VER."; return; }
		if [ "${#FOUND[@]}" -gt 40 ]; then
			echo "${#FOUND[@]} devices match '$WORD': add a word (a model, a version) to narrow it down."; return
		fi
		for i in "${!FOUND[@]}"; do
			IFS=$'\t' read -r T P D <<<"${FOUND[$i]}"
			printf '  %2d) %-42s %-16s %s\n' $((i + 1)) "$D" "$T" "$P"
		done
		N=$(ask "Which one? ")
		[[ "$N" =~ ^[0-9]+$ && "$N" -ge 1 && "$N" -le "${#FOUND[@]}" ]] || { echo "Nothing added."; return; }
		IFS=$'\t' read -r TARGET PROFILE D <<<"${FOUND[$((N - 1))]}"
		get_ib "$TARGET" || return 0
		( cd "$BUILD/$(ib_name "$TARGET")" && make info 2>/dev/null | grep -q "^$PROFILE:" ) || \
			{ echo "$PROFILE is in OpenWrt's list but not in the $TARGET Image Builder ($VER). Nothing added."; return; }
	else
		# No list (no Internet, or a release without one): the old way, by target
		echo "OpenWrt's device list could not be fetched. The target is on the device's page of the OpenWrt"
		echo "Table of Hardware, e.g. ath79/generic, bcm27xx/bcm2711."
		TARGET=$(ask "Target: ")
		[[ "$TARGET" =~ ^[a-z0-9_-]+/[a-z0-9_-]+$ ]] || { echo "Not a target (form: name/subtarget)."; return; }
		get_ib "$TARGET" || return 0
		mapfile -t FOUND < <(cd "$BUILD/$(ib_name "$TARGET")" && make info 2>/dev/null \
			| sed -n 's/^\([A-Za-z0-9_.,-]*\):$/\1/p' | grep -i -F -- "${WORD%% *}" || true)
		[ "${#FOUND[@]}" -gt 0 ] || { echo "No model matching '$WORD' in $TARGET ($VER)."; return; }
		for i in "${!FOUND[@]}"; do printf '  %2d) %s\n' $((i + 1)) "${FOUND[$i]}"; done
		N=$(ask "Which one? ")
		[[ "$N" =~ ^[0-9]+$ && "$N" -ge 1 && "$N" -le "${#FOUND[@]}" ]] || { echo "Nothing added."; return; }
		PROFILE=${FOUND[$((N - 1))]}
	fi

	echo "Roles: $ROLES. Join roles with + to have both on one unit (e.g. tree+feeder)."
	RS=$(ask "Role(s) for this device (several with spaces), or m for manual mode: ")
	[ -n "$RS" ] || { echo "Nothing added."; return; }
	if [ "$RS" = m ]; then
		echo "Every unit of this kind carries the name, and a tree or a nest announces it: never a person's, a house's or a street's."
		RS=$(ask "A name for this kind of unit (letters, digits, -), e.g. garden: ")
		[[ "$RS" =~ ^[a-z][a-z0-9-]*$ ]] || { echo "Not a name. Nothing added."; return; }
		SPEC=$(ask_uses)
	fi

	echo "Power to set at the radio = the legal EIRP of your country - antenna gain. In the EU, for example:"
	echo "2.4 GHz 20 dBm EIRP; 5 GHz outdoor (ch 100-140) 30 dBm with TPC, 27 dBm without. - = band not used."
	TX2=$(ask_tx "2.4 GHz power in dBm, or -: ")
	TX5=$(ask_tx "5 GHz power in dBm, or -: ")
	case "$(ask "At least 16 MB of flash and 128 MB of RAM (web interface allowed)? [y/N] ")" in
		[yY]*) UIOK=ui ;; *) UIOK=- ;;
	esac

	for R in $RS; do
		WHY=$(bad_line "$R" "$TARGET" "$PROFILE" "$TX2" "$TX5" "$UIOK" "$SPEC")
		if [ -n "$WHY" ]; then
			echo "  $R not added: $WHY."
			continue
		fi
		if profiles | awk -v r="$R" -v p="$PROFILE" '$1 == r && $3 == p { f = 1 } END { exit !f }'; then
			echo "  $R $PROFILE is already in profiles.txt: left as it is."
			continue
		fi
		MAP=$(uses_of "$R" "$PROFILE" "$TX2" "$TX5" "$SPEC")
		echo "  $R on $PROFILE:"
		uses_long "$MAP"
		LINE=$(printf '%-9s %-15s %-26s %-4s %-4s %-3s %s' "$R" "$TARGET" "$PROFILE" "$TX2" "$TX5" "$UIOK" "$SPEC")
		NEW="$NEW${LINE% }"$'\n'
	done
	[ -n "$NEW" ] || return 0
	printf '\nTo add to profiles.txt:\n%s' "$NEW"
	case "$(ask "Add? [Y/n] ")" in [nN]*) echo "Nothing added."; return ;; esac
	[ -z "$(tail -c 1 "$HERE/profiles.txt")" ] || echo >> "$HERE/profiles.txt"   # last line not cut short
	{ printf '# added %s from the build menu: not yet tested\n' "$(date +%F)"; printf '%s' "$NEW"; } >> "$HERE/profiles.txt"
	echo "Added. It is now in the list."
}

# The lines whose role is R, alone or joined with +, or the manual line named R
lines_of_role() { awk -v r="$1" '{ n = split($1, p, "+"); for (i = 1; i <= n; i++) if (p[i] == r) { print; next } }'; }

# Sets CHOSEN to the picked device lines (and VER, if the release was changed)
menu() {
	local LINES CH T i R P X2 X5 U S PICK OK MAP
	while :; do
		mapfile -t LINES < <(profiles)
		echo
		echo "Sparrows images, OpenWrt $VER, web interface $( [ "$UI" = 1 ] && echo ON || echo off ). Devices in profiles.txt:"
		for i in "${!LINES[@]}"; do
			read -r R _ P X2 X5 U S <<<"${LINES[$i]}"
			[ "${U:--}" = ui ] && U=' +web' || U=''
			if MAP=$(uses_of "$R" "$P" "$X2" "$X5" "${S:-}"); then MAP=$(uses_short "$MAP"); else MAP="CAN'T BUILD: $MAP"; fi
			printf '  %2d) %-11s %-26s %s%s\n' $((i + 1)) "$R" "$P" "$MAP" "$U"
		done
		echo "   n) add a device that is not in the list (m there: manual mode, the use of each interface)"
		echo "   v) another OpenWrt release"
		echo "   w) web interface on/off (only where it fits)"
		echo "   s) write a Raspberry Pi image to an SD card (no build)"
		echo "   q) quit"
		CH=$(ask "Build: numbers and/or roles, with spaces (e.g. 1 3, or hedge). Enter = all: ")
		case "$CH" in
			''|all) CHOSEN=$(printf '%s\n' "${LINES[@]}"); return ;;
			q) exit 0 ;;
			w) if [ "$UI" = 1 ]; then UI=0; else UI=1; fi; continue ;;
			s) write_sd; continue ;;
			n) add_device; continue ;;
			v) T=$(ask "Release (now $VER), e.g. 25.12.6: ")
			   if [[ "$T" =~ ^[0-9]+\.[0-9]+\.[0-9]+(-rc[0-9]+)?$ ]]; then VER=$T; else echo "Not a release number."; fi
			   continue ;;
		esac
		PICK=() OK=1
		for T in $CH; do
			if [[ "$T" =~ ^[0-9]+$ ]] && [ "$T" -ge 1 ] && [ "$T" -le "${#LINES[@]}" ]; then
				PICK+=("${LINES[$((T - 1))]}")
			elif S=$(printf '%s\n' "${LINES[@]}" | lines_of_role "$T") && [ -n "$S" ]; then
				mapfile -t -O "${#PICK[@]}" PICK <<<"$S"
			else
				echo "'$T' is not in the list."; OK=0
			fi
		done
		if [ "$OK" = 1 ] && [ "${#PICK[@]}" -gt 0 ]; then
			CHOSEN=$(printf '%s\n' "${PICK[@]}" | awk '!seen[$0]++')     # each device once, even if picked twice
			return
		fi
	done
}

# ---------------------------------------------------------------- SD card (Raspberry Pi)

# Disks that can be a card reader: removable, USB or MMC. Never a disk that holds /, /boot, /home,
# /usr, /var or swap. Prints: device <tab> size <tab> model
sd_disks() {
	lsblk -Jpo NAME,TYPE,RM,TRAN,SIZE,MODEL,MOUNTPOINT | python3 -c '
import json, sys
SYSTEM = {"/", "/boot", "/boot/efi", "/boot/firmware", "/home", "/usr", "/var", "[SWAP]"}
def mounts(d):
    m = {d.get("mountpoint")}
    for c in d.get("children") or []:
        m |= mounts(c)
    return m
for d in json.load(sys.stdin)["blockdevices"]:
    if d.get("type") != "disk" or mounts(d) & SYSTEM:
        continue
    if d.get("rm") in (True, 1, "1") or d.get("tran") == "usb" or "mmcblk" in d["name"]:
        print(d["name"], d.get("size") or "?", (d.get("model") or "").strip() or "-", sep="\t")
'
}

# Write an SD-card image (.img.gz) to a card. Asks for the image, the reader, then the disk name.
# A card with a locked /home (label sparrows-home in its LUKS header, readable without the key) can
# have its system rewritten alone: /home and its partition entry stay as they were.
write_sd() {
	local IMGS DISKS N IMG DEV SIZE MODEL BYTES P L HSTART='' HSIZE='' KEEP=0 i
	[ -t 0 ] || die "Writing an SD card needs a terminal: it asks before erasing anything."
	if [ -n "${1:-}" ]; then
		IMGS=("$1")
	else
		shopt -s nullglob
		IMGS=("$OUT"/latest/*factory*.img.gz)
		[ "${#IMGS[@]}" -gt 0 ] || IMGS=("$OUT"/*/*factory*.img.gz "$OUT"/*.img.gz)
		shopt -u nullglob
	fi
	[ "${#IMGS[@]}" -gt 0 ] || { echo "No .img.gz in $OUT/latest: build a Raspberry Pi image first."; return 0; }
	IMG=${IMGS[0]}
	if [ "${#IMGS[@]}" -gt 1 ]; then
		for i in "${!IMGS[@]}"; do printf '  %2d) %s\n' $((i + 1)) "${IMGS[$i]#"$OUT"/}"; done
		N=$(ask "Which image? ")
		[[ "$N" =~ ^[0-9]+$ && "$N" -ge 1 && "$N" -le "${#IMGS[@]}" ]] || { echo "Cancelled, nothing written."; return 0; }
		IMG=${IMGS[$((N - 1))]}
	fi
	[ -s "$IMG" ] || die "No such image: $IMG"

	ask "Put the SD card in its reader, then press Enter. " >/dev/null
	mapfile -t DISKS < <(sd_disks)
	[ "${#DISKS[@]}" -gt 0 ] || { echo "No card reader found (removable, USB or MMC). Check with: lsblk"; return 0; }
	echo "Card readers and USB disks:"
	for i in "${!DISKS[@]}"; do
		IFS=$'\t' read -r DEV SIZE MODEL <<<"${DISKS[$i]}"
		printf '  %2d) %-14s %8s  %s\n' $((i + 1)) "$DEV" "$SIZE" "$MODEL"
	done
	N=$(ask "Which one holds the card? (Enter = cancel): ")
	[[ "$N" =~ ^[0-9]+$ && "$N" -ge 1 && "$N" -le "${#DISKS[@]}" ]] || { echo "Cancelled, nothing written."; return 0; }
	IFS=$'\t' read -r DEV SIZE MODEL <<<"${DISKS[$((N - 1))]}"

	# A locked /home on this card? Read from the partitions themselves (sudo: lsblk's labels come from
	# udev, which doesn't always know them). Its place, in 512-byte sectors
	echo "Looking at the card (sudo asks for your password)..."
	while read -r P L; do
		[ "$L" = part ] || continue
		[ "$(sudo blkid -p -s LABEL -o value "$P" 2>/dev/null)" = sparrows-home ] || continue
		HSTART=$(cat "/sys/class/block/${P#/dev/}/start") HSIZE=$(cat "/sys/class/block/${P#/dev/}/size")
	done < <(lsblk -lnpo NAME,TYPE "$DEV")

	echo
	if [ -n "$HSTART" ]; then
		echo "This card holds a locked /home (sparrows-home, from $((HSTART / 2048)) MiB): the unit's"
		echo "identities and the messages it keeps for people."
		echo "   k) keep it: rewrite the system only (the usual choice)"
		echo "   e) erase the whole card: /home and everything on it is lost for good"
		case "$(ask "k or e? (Enter = cancel): ")" in
			k) KEEP=1 ;;
			e) ;;
			*) echo "Cancelled, nothing written."; return 0 ;;
		esac
	fi
	if [ "$KEEP" = 1 ]; then
		echo "The system on $DEV ($SIZE, $MODEL) will be rewritten, /home kept:"
	else
		echo "EVERYTHING on $DEV ($SIZE, $MODEL) will be erased:"
	fi
	lsblk -po NAME,SIZE,FSTYPE,LABEL,MOUNTPOINT "$DEV"
	echo "and replaced by: $(basename "$IMG")"
	[ "$(ask "To go on, type the disk name (${DEV#/dev/}): ")" = "${DEV#/dev/}" ] || { echo "Cancelled, nothing written."; return 0; }

	# Unpacked on the fly, never to a file (a nest image is 1 GB). OpenWrt puts its metadata after the
	# gzip data: gzip warns "trailing garbage" and exits 2, which is fine
	unpack() { gzip -dc "$IMG" 2>/dev/null || [ $? -eq 2 ]; }
	BYTES=$(unpack | wc -c) || die "Cannot unpack $IMG"
	[ "$BYTES" -gt 0 ] || die "Empty image: $IMG"
	if [ "$KEEP" = 1 ] && [ "$BYTES" -gt $((HSTART * 512)) ]; then
		die "This image ($((BYTES / 1048576)) MiB) would run into /home (from $((HSTART / 2048)) MiB). Nothing written."
	fi

	for P in $(lsblk -lnpo NAME "$DEV"); do
		if findmnt -rn -S "$P" >/dev/null; then sudo umount "$P"; fi
	done
	if [ "$KEEP" = 0 ]; then
		echo "Erasing the old partition table (sudo asks for your password)..."
		sudo wipefs -a -q "$DEV"
	fi
	echo "Writing $((BYTES / 1048576)) MiB (sudo asks for your password)..."
	unpack | sudo dd of="$DEV" bs=4M iflag=fullblock conv=fsync status=progress
	sync
	echo "Reading the card back..."
	sudo blockdev --flushbufs "$DEV"
	unpack | sudo cmp -n "$BYTES" - "$DEV" || die "The card does NOT match the image: write it again, or use another card."
	echo "OK: the card matches the image."
	if [ "$KEEP" = 1 ]; then
		# The image brought its own partition table, without /home: its entry goes back, same place
		printf 'start=%s, size=%s, type=83\n' "$HSTART" "$HSIZE" | \
			sudo sfdisk --append --no-reread --no-tell-kernel --wipe-partitions never -q "$DEV" || \
			die "/home's partition entry could not be put back. Its data is still there: the unit puts it back at first boot, or by hand: start=$HSTART size=$HSIZE (sectors)"
		sudo blockdev --rereadpt "$DEV" 2>/dev/null || true
		[ "$(sudo blkid -p -O $((HSTART * 512)) -s LABEL -o value "$DEV" 2>/dev/null)" = sparrows-home ] || \
			die "/home is not where it was: check with  sudo blkid -p -O $((HSTART * 512)) $DEV"
		echo "OK: /home is kept, in its place."
	fi
	echo "You can take the card out."
}

# ---------------------------------------------------------------- locked /home (Pi units)

# A unit for ssh: root@<address> (fe80::...%eth0, or its village address), or as given with a user
ssh_to() { case "$1" in *@*) echo "$1" ;; *) echo "root@$1" ;; esac; }

# The unit's name, read over SSH with the admin key: the name its passphrase is kept under
unit_name() {
	local NAME
	# BatchMode can't answer ssh's "are you sure?" for a host it hasn't seen under this name
	# (seen 2026-11-22: root@tree-7cd0 failed while root@fe80::...%wlan0 was known)
	NAME=$(ssh -o BatchMode=yes "$1" 'uci -q get system.@system[0].hostname') || die "Can't log in to $1 with your key.
  Use the address you already log in with (e.g. fe80::...%wlan0), or log in once by hand
  (ssh $1) and answer yes to its host key, then run this again."
	[[ "$NAME" =~ ^[a-z][a-z0-9-]*$ ]] || die "Unexpected unit name '$NAME'."
	echo "$NAME"
}

# Set up a unit's /home: one passphrase per unit, made here (or chosen, 20 characters at least), shown
# once, kept in secrets/home/<unit>.key. It reaches the unit over SSH, on stdin: never on its card.
home_setup() {
	local T NAME F K K2
	[ -n "${1:-}" ] || die "Usage: ./build.sh home <unit address>   (e.g. fe80::...%eth0, or its village address)"
	[ -t 0 ] || die "Setting up /home needs a terminal: it shows the passphrase once."
	T=$(ssh_to "$1")
	NAME=$(unit_name "$T")
	ssh -o BatchMode=yes "$T" 'command -v sparrows-home >/dev/null' || \
		die "$NAME has no locked /home in its image (Pi nests and trees, built from 2026-11-22)."
	F="$HERE/secrets/home/$NAME.key"
	if [ -s "$F" ]; then
		echo "$NAME: its passphrase is already in secrets/home/$NAME.key, used again."
	else
		echo "$NAME gets its own passphrase for /home. It is never written on the unit's card."
		K=$(ask_secret "Type a passphrase (20 characters or more), or press Enter to make a random one: ")
		if [ -z "$K" ]; then
			K=$(head -c 48 /dev/urandom | base64 | tr -dc 'A-Za-z0-9' | head -c 40)
		else
			[ "${#K}" -ge 20 ] || die "Too short: 20 characters or more. Nothing done."
			K2=$(ask_secret "Again: ")
			[ "$K" = "$K2" ] || die "Not the same. Nothing done."
		fi
		( umask 077; mkdir -p "$HERE/secrets/home"; printf '%s\n' "$K" > "$F" )
		echo
		echo "Passphrase of $NAME's /home, shown this once:"
		echo
		echo "    $K"
		echo
		echo "A copy is in secrets/home/$NAME.key. Save it away from this laptop too (on paper, or in a"
		echo "password manager): without it, and with no approver, /home and what it holds are lost."
		if [ "$(ask "Type  saved  once it is saved: ")" != saved ]; then
			rm -f "$F"; die "Nothing done, and the passphrase is forgotten."
		fi
		K='' K2=''
	fi
	ssh "$T" sparrows-home setup < "$F"
	door_address "$T" "$NAME"
}

# What the approvers need from a unit: its door's address, for  sparrows-approve add <it>
door_address() {
	local D
	D=$(ssh -o BatchMode=yes "$1" 'sparrows-door id' 2>/dev/null) || { echo "$2 has no door (an image from before 2026-11-22)."; return 0; }
	echo
	echo "$2's door: $D"
	echo "Each approver, once:  sparrows-approve add $D $2"
}

# Seal the unit's unlock key for the approvers of its image, with its kept passphrase
home_approvers() {
	local T NAME F
	[ -n "${1:-}" ] || die "Usage: ./build.sh approvers <unit address>"
	T=$(ssh_to "$1")
	NAME=$(unit_name "$T")
	F="$HERE/secrets/home/$NAME.key"
	[ -s "$F" ] || die "No secrets/home/$NAME.key here: on the unit, sparrows-home approvers asks for the passphrase."
	ssh "$T" sparrows-home approvers < "$F"
	door_address "$T" "$NAME"
}

# Open a unit's /home with its kept passphrase (after a reboot it stays locked until someone does)
home_unlock() {
	local T NAME F
	[ -n "${1:-}" ] || die "Usage: ./build.sh unlock <unit address>"
	T=$(ssh_to "$1")
	NAME=$(unit_name "$T")
	F="$HERE/secrets/home/$NAME.key"
	[ -s "$F" ] || die "No secrets/home/$NAME.key here. On the unit, sparrows-unlock asks for the passphrase."
	ssh "$T" sparrows-home open < "$F"
}

# ---------------------------------------------------------------- main

ARG="${1:-}"
MENU=0
[ -z "$ARG" ] && [ -t 0 ] && [ -t 1 ] && MENU=1
CHOSEN=''
USAGE="Usage: ./build.sh [all|uses|<role>] | ./build.sh sd [image.img.gz] | ./build.sh home|unlock|approvers <unit address>"
case "$ARG" in
	'')    if [ "$MENU" = 1 ]; then menu; else CHOSEN=$(profiles); fi ;;
	all|uses) CHOSEN=$(profiles) ;;
	sd)    write_sd "${2:-}"; exit 0 ;;
	home)  home_setup "${2:-}"; exit 0 ;;
	unlock) home_unlock "${2:-}"; exit 0 ;;
	approvers) home_approvers "${2:-}"; exit 0 ;;
	-*|*/*) die "$USAGE" ;;
	*)     CHOSEN=$(profiles | lines_of_role "$ARG")
	       [ -n "$CHOSEN" ] || die "No line with role '$ARG' in profiles.txt (roles: $ROLES). $USAGE" ;;
esac
[ -n "$CHOSEN" ] || die "Nothing to build."

# Every chosen line checked before anything is downloaded
BAD=''
while read -r ROLE TARGET PROFILE TX2 TX5 UIOK SPEC REST; do
	WHY=$(bad_line "$ROLE" "$TARGET" "$PROFILE" "$TX2" "$TX5" "${UIOK:--}" "${SPEC:-}" "${REST:-}")
	[ -z "$WHY" ] || BAD="$BAD  $ROLE $TARGET $PROFILE: $WHY"$'\n'
done <<<"$CHOSEN"
[ -z "$BAD" ] || die "profiles.txt, line(s) to fix first:"$'\n'"${BAD%$'\n'}"

# What each port and radio will do, shown before anything is built
echo
echo "OpenWrt $VER. To build, and what each interface will do:"
while read -r ROLE TARGET PROFILE TX2 TX5 UIOK SPEC; do
	W=''; [ "$UI" = 1 ] && [ "${UIOK:--}" = ui ] && W='  + web interface'
	echo "  $ROLE on $PROFILE ($TARGET)${SPEC:+, manual}$W"
	uses_long "$(uses_of "$ROLE" "$PROFILE" "$TX2" "$TX5" "${SPEC:-}")"
done <<<"$CHOSEN"
# Every nest image gets the same village address scheme: say so once
if printf '%s\n' "$CHOSEN" | lines_of_role nest | grep -q . ; then
	echo "  Nests: Android needs a non-ULA prefix; the image uses 2001:db8:1::/64, the BENCH range (nest/files)."
fi
[ "$ARG" != uses ] || exit 0
# The country: asked once in a terminal, then kept in local.conf
if [ -z "$COUNTRY" ] && [ -t 0 ]; then
	echo "  Which country will these units stand in? Its radio rules apply to them."
	COUNTRY=$(ask "  Two letters, ISO 3166 (e.g. FR, DE, US, BR, IN): " | tr '[:lower:]' '[:upper:]')
	[[ "$COUNTRY" =~ ^[A-Z]{2}$ ]] && printf "COUNTRY='%s'\n" "$COUNTRY" > "$HERE/local.conf" && echo "  Kept in local.conf."
fi
[[ "$COUNTRY" =~ ^[A-Z]{2}$ ]] || die "The country the units stand in is needed: COUNTRY=XX ./build.sh (two letters, ISO 3166), or a line COUNTRY='XX' in local.conf"
echo "  Country: $COUNTRY. The radios use 2.4 GHz channel 1 (6 where a device fixes it) and 5 GHz 108 and 132"
echo "  (outdoor, radar checks). Check that $COUNTRY allows them, and the power in profiles.txt, before a unit goes up."
echo "  Version: $VERSION"
case "$VERSION" in
	*-dirty) echo "  Files are changed and not committed: these images can't be found in git later. Commit first to give them a version." ;;
	unversioned) echo "  Not a git checkout: these images have no version." ;;
esac
[ "$CHECK_SIG" = 1 ] || echo "  Skipped on purpose: the check of OpenWrt's signature (CHECK_SIG=0)"
[ "$CHECK_RULES" = 1 ] || echo "  Skipped on purpose: the check of the packages against the hard rules (CHECK_RULES=0)"
identity_check
# Approvers of the locked /home: asked once, if an image to build has one and the list doesn't exist yet
if [ ! -f "$HERE/keys/approvers.txt" ]; then
	LOCKS=0
	while read -r ROLE TARGET PROFILE TX2 TX5 UIOK SPEC; do
		IFS='|' read -r _ _ _ RNS _ <<<"$(uses_of "$ROLE" "$PROFILE" "$TX2" "$TX5" "${SPEC:-}")"
		if [ "$RNS" = 1 ] && grep -q '^HOME_START_MB=' "$HERE/devices/$PROFILE/device.conf" 2>/dev/null; then LOCKS=1; fi
	done <<<"$CHOSEN"
	if [ "$LOCKS" = 1 ]; then
		if [ -t 0 ]; then mkdir -p "$HERE/keys"; ask_approvers
		else echo "  No keys/approvers.txt: Pi units built now open their /home by hand only."; fi
	fi
elif [ -n "$(approver_keys 2>/dev/null)" ]; then
	echo "  Approvers of the locked /home: $(approver_keys | wc -l) key(s) from keys/approvers.txt"
fi
if [ "$MENU" = 1 ]; then
	case "$(ask "Go? [Y/n] ")" in [nN]*) exit 0 ;; esac
fi

compgen -G "$HERE/keys/*.pub" >/dev/null || die "Put admin SSH public keys in keys/*.pub first"
MISSING=''
for C in wget zstd tar make gcc perl rsync python3 sha256sum $( [ "$CHECK_SIG" = 0 ] || echo gpgv ); do
	command -v "$C" >/dev/null || MISSING="$MISSING $C"
done
# build.sh is written for a Debian or Ubuntu laptop (Sparrows Tao, "Build"): the packages are Debian's
[ -z "$MISSING" ] || die "Missing on this machine:$MISSING. On Debian or Ubuntu:
  sudo apt install build-essential file libncurses-dev zlib1g-dev gawk git gettext libssl-dev xsltproc rsync wget unzip python3 xz-utils zstd gpgv
(other distributions: the Image Builder's page on openwrt.org)"
mkdir -p "$BUILD" "$OUT"
case "$BUILD" in *[[:space:]]*) die "The build folder $BUILD has a space in its path, which the Image Builder can't handle. Set SPARROWS_BUILD=<a folder without spaces>" ;; esac
[ "$BUILD" = "$HERE/build" ] || echo "This folder's path has a space: the Image Builder works in $BUILD (images still go to $OUT)."
: > "$BUILD/.built"; : > "$BUILD/.skipped"

while read -r ROLE TARGET PROFILE TX2 TX5 UIOK SPEC; do
	build_one "$ROLE" "$TARGET" "$PROFILE" "$TX2" "$TX5" "${UIOK:--}" "${SPEC:-}" </dev/null
done <<<"$CHOSEN"

echo
if [ -s "$BUILD/.skipped" ]; then
	echo "Skipped:"
	sed 's/^/  /' "$BUILD/.skipped"
	echo
fi
[ -s "$BUILD/.built" ] || die "No image was built."
# This version's checksums, for the kit and for anyone who checks an image: SHA256SUMS in its folder
( cd "$OUT/$VERSION" && shopt -s nullglob && IMGS=(*.bin *.img.gz) && sha256sum -- "${IMGS[@]}" > SHA256SUMS )
ln -sfn "$VERSION" "$OUT/latest"
echo "Built now, version $VERSION, in $OUT/$VERSION (also $OUT/latest):"
( cd "$OUT/$VERSION" && while read -r I; do sha256sum -- "$I"; done < "$BUILD/.built" )

if grep -q -e '-ui-' "$BUILD/.built"; then
	echo
	echo "Web interface (images with -ui): it only listens on the unit itself. From your laptop:"
	echo "  ssh -N -L 8080:127.0.0.1:80 root@<station address>    then open http://localhost:8080"
	echo "  The first time, set the root password over SSH:  passwd   (SSH itself stays keys only)"
fi

if grep -q '\.img\.gz$' "$BUILD/.built"; then
	echo
	echo "Pi images: a unit with a locked /home stays locked after an update until  ./build.sh unlock <unit>"
	echo "(or sparrows-unlock on the unit). A card is written with  ./build.sh sd, which keeps /home."
fi

if [ "$MENU" = 1 ] && grep -q '\.img\.gz$' "$BUILD/.built"; then
	echo
	case "$(ask "Write a Raspberry Pi image to an SD card now? [y/N] ")" in [yY]*) write_sd ;; esac
fi
