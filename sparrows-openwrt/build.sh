#!/usr/bin/env bash
# Build the Sparrows-Network OpenWrt images (perch, feeder, hedge, tree) with the OpenWrt Image Builder.
# One image per role and device: the same image goes on every unit of that role.
# Runs on x86_64 Linux. Needs: wget, zstd, make, gcc, python3, perl, rsync (see OpenWrt IB docs), gpgv.
#
# Usage: ./build.sh              -> in a terminal: a menu to pick the devices (Enter = all of them)
#                                   without a terminal (a script, cron): every line of profiles.txt
#        ./build.sh all          -> every line of profiles.txt, no menu
#        ./build.sh perch        -> perches only (or: feeder, hedge, tree), no menu
#        VER=25.12.x ./build.sh  -> another 25.12 release
#        UI=1 ./build.sh all     -> with the web interface (LuCI), only where profiles.txt says "ui"
#        ./build.sh sd [image]   -> write a Raspberry Pi image (.img.gz) to an SD card: asks which
#                                   reader, shows what is on it, and asks you to type its name first
# A build replaces the images of the devices it builds and keeps the others in build/images.
#
# Two checks, each can be skipped when needed:
#   CHECK_SIG=0 ./build.sh     -> don't check OpenWrt's signature on the Image Builder's checksums
#                                 (its public keys are in trust/; a new key: check its fingerprint on
#                                 https://openwrt.org/docs/guide-user/security/signatures, add it there)
#   CHECK_RULES=0 ./build.sh   -> don't check the image's package list against the hard rules
#
# The menu lists the devices already in profiles.txt (several can be picked at once), can change
# the release, can turn the web interface on or off, and can add a new device: it searches the
# Image Builder for the model, asks the role, the radio power and whether the web interface fits,
# and adds the line to profiles.txt marked "not yet tested".
# Web interface: LuCI, listening on the unit itself only (ui/files, reached through SSH). Never on a
# device marked "-" (8 MB flash / 64 MB RAM); there the image is built without it, and says so.
#
# Before the first build:
#   keys/*.pub           admin SSH public keys (root password is locked)
#   secrets/flyway.key   the flyway SAE passphrase (perch only)
#   secrets/hedge.key    the hedge mesh SAE passphrase (hedge only)
#                        Each: one line of 8 to 63 printable ASCII characters, ideally letters/digits only.
#                        Generate one: head -c 32 /dev/urandom | base64 | tr -dc 'A-Za-z0-9' | head -c 32
#                        Perch and hedge images contain their key: never publish them.
set -euo pipefail

VER="${VER:-25.12.6}"     # 2026-10-18, security fixes. Check https://downloads.openwrt.org/releases/ for the latest 25.12.x
UI="${UI:-0}"             # 1 = add the web interface where profiles.txt allows it
CHECK_SIG="${CHECK_SIG:-1}"
CHECK_RULES="${CHECK_RULES:-1}"
HERE="$(cd "$(dirname "$0")" && pwd)"
OUT="$HERE/build/images"
ROLES="perch feeder hedge tree"

# Every role: no DHCP/RA server, no firewall, no PPP, no web UI (perch, feeder and hedge only bridge)
BASE="-dnsmasq -odhcpd-ipv6only -firewall4 -nftables -kmod-nft-offload -ppp -ppp-mod-pppoe -luci -luci-ssl"
PKG_perch="$BASE -wpad-basic-mbedtls wpad-mesh-mbedtls kmod-batman-adv batctl-default iw"
PKG_feeder="$BASE"
PKG_hedge="$BASE -wpad-basic-mbedtls wpad-mesh-mbedtls kmod-batman-adv batctl-default iw"
# Tree: a Wi-Fi client running Reticulum and the Sparrows page (Nomad Network). Python and the
# libraries Reticulum asks for; Reticulum and Nomad Network come as pinned wheels (tree/role.conf). Needs room: SD-card devices, not 8-16 MB flash.
PKG_tree="$BASE python3 python3-cryptography python3-pyserial iw"
# LuCI = luci-light minus its firewall and PPP pages. luci-light itself would bring firewall4 and
# nftables back (luci-app-firewall needs a firewall): no firewall is a hard rule. No HTTPS: it only
# listens on 127.0.0.1 and ::1
PKG_ui="uhttpd uhttpd-mod-ubus luci-mod-admin-full luci-theme-bootstrap luci-proto-ipv6 rpcd-mod-rrdns"
# Never in a station image (hard rules: only nests send RAs; no DHCP, firewall or PPP). CHECK_RULES
FORBIDDEN="dnsmasq dnsmasq-full dnsmasq-dhcpv6 odhcpd odhcpd-ipv6only firewall firewall4 nftables
nftables-json nftables-nojson iptables iptables-nft ppp ppp-mod-pppoe luci-app-firewall"
FORBIDDEN_NO_UI="luci-base uhttpd"     # ...and no web interface unless it was asked for

die() { echo "$*" >&2; exit 1; }

# The device lines of profiles.txt: role target profile tx2 tx5 [ui]. A # starts a comment anywhere
profiles() { awk '{ sub(/#.*/, "") } NF { $1 = $1; print }' "$HERE/profiles.txt"; }

# Why a device line can't be built (nothing if it can): caught here, not on a mast
bad_line() {
	local R=$1 T=${2:-} P=${3:-} X2=${4:-} X5=${5:-} U=${6:--} REST=${7:-} X
	case " $ROLES " in *" $R "*) ;; *) echo "unknown role '$R'"; return ;; esac
	[[ "$T" =~ ^[a-z0-9_-]+/[a-z0-9_-]+$ ]] || { echo "target '$T' is not name/subtarget"; return; }
	[ -n "$P" ] || { echo "no profile"; return; }
	for X in "$X2" "$X5"; do
		[[ "$X" =~ ^(-|[0-9]|[12][0-9]|30)$ ]] || { echo "radio power '$X' is not - or 0 to 30 dBm"; return; }
	done
	case "$R" in
		perch) [ "$X5" != '-' ] || { echo "a perch needs its 5 GHz radio"; return; } ;;
		hedge) { [ "$X2" != '-' ] && [ "$X5" != '-' ]; } || { echo "a hedge needs both bands (2.4 GHz mesh, 5 GHz Wi-Fi)"; return; } ;;
		*)     { [ "$X2" != '-' ] || [ "$X5" != '-' ]; } || { echo "a $R needs at least one band"; return; } ;;
	esac
	[[ "$U" =~ ^(ui|-)$ ]] || { echo "last column '$U' is not ui or -"; return; }
	[ -z "$REST" ] || echo "too many columns"
}

ib_name() { echo "openwrt-imagebuilder-${VER}-${1/\//-}.Linux-x86_64"; }

# OpenWrt's signature on a file, checked with the public keys kept in trust/. The checksums only prove
# the download isn't broken; the signature proves it is OpenWrt's, whatever server or mirror it came
# from. gpgv is enough: python unpacks the keys, so GnuPG itself isn't needed. Prints who signed.
check_sig() {
	local FILE=$1 SIG=$2 KR="$HERE/build/trust.gpg" GH="$HERE/build/gnupg" STATUS ID
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

# Image Builder for a target: downloaded once, checked against sha256sums. Runs in a subshell.
get_ib() (
	TARGET=$1
	IB=$(ib_name "$TARGET")
	URL="https://downloads.openwrt.org/releases/${VER}/targets/${TARGET}"
	mkdir -p "$HERE/build" && cd "$HERE/build" || exit 1
	[ -d "$IB" ] && exit 0
	echo "Downloading the Image Builder for $TARGET ($VER)..." >&2
	wget -q -O "$IB.sha256sums" "$URL/sha256sums" || { echo "No $VER release for $TARGET" >&2; exit 1; }
	if [ "$CHECK_SIG" = 1 ]; then
		wget -q -O "$IB.sha256sums.asc" "$URL/sha256sums.asc" || \
			{ echo "No signature at $URL/sha256sums.asc (CHECK_SIG=0 skips this check)" >&2; exit 1; }
		check_sig "$IB.sha256sums" "$IB.sha256sums.asc" || exit 1
	fi
	# -O: the same file name every time (without it, a second try lands in .tar.zst.1 and never checks).
	# A progress bar only in a terminal: the download is big
	PROGRESS=''; [ -t 2 ] && PROGRESS='--show-progress'
	wget -q $PROGRESS -O "$IB.tar.zst" "$URL/$IB.tar.zst" || { echo "Download failed: $URL/$IB.tar.zst" >&2; exit 1; }
	grep " \*\?$IB.tar.zst\$" "$IB.sha256sums" | sha256sum -c - >&2 || { rm -f "$IB.tar.zst"; echo "Checksum FAILED" >&2; exit 1; }
	# Unpacked aside, then moved: a cut-off unpack is never taken for a complete Image Builder
	rm -rf "$IB.part" && mkdir "$IB.part"
	tar -C "$IB.part" --zstd -xf "$IB.tar.zst" && mv "$IB.part/$IB" "$IB" && rmdir "$IB.part" || exit 1
	rm -f "$IB.tar.zst"
)

# A device left out of this build: said now, and again in the summary at the end
skip() { echo "$*" >&2; echo "$*" >> "$HERE/build/.skipped"; exit 0; }

# Build one image. Runs in a subshell: "exit 0" skips this device, any error stops the build.
build_one() (
	ROLE=$1 TARGET=$2 PROFILE=$3 TX2=$4 TX5=$5 UIOK=${6:--}
	[ -d "$HERE/$ROLE/files" ] || die "Unknown role '$ROLE' in profiles.txt"
	WITH_UI=0 NAME="sparrows-$ROLE"

	# --- A device that needs more than a line: devices/<name>/device.conf (see profiles.txt) ---
	IB_PROFILE=$PROFILE DEV_PACKAGES='' MACDEV='' CH2='' FW_URL='' FW_DIR='' FW_FILES=''
	DEV="$HERE/devices/$PROFILE"
	if [ -f "$DEV/device.conf" ]; then
		# shellcheck source=/dev/null
		. "$DEV/device.conf"
	else
		DEV=''
	fi
	if [ "$UI" = 1 ]; then
		if [ "$UIOK" = ui ]; then
			WITH_UI=1 NAME="sparrows-$ROLE-ui"
		else
			echo "$ROLE $PROFILE: too small for the web interface (profiles.txt), built without it" >&2
		fi
	fi

	# --- SAE passphrase for roles that carry a backbone link ---
	case "$ROLE" in
		perch) KEYF='flyway.key' ;;
		hedge) KEYF='hedge.key' ;;
		*)     KEYF='' ;;
	esac
	if [ -n "$KEYF" ]; then
		[ -s "$HERE/secrets/$KEYF" ] || die "Put the SAE passphrase in secrets/$KEYF first"
		# Seen 2026-11-14: a key outside 8-63 printable ASCII never links (see Sparrows Tao, Pitfalls).
		# The whole file is checked, as the unit reads it: one line (a final newline is fine)
		( LC_ALL=C; K=$(<"$HERE/secrets/$KEYF"); RE='^[ -~]{8,63}$'; [[ $K =~ $RE ]] ) || \
			die "secrets/$KEYF must be one line of 8 to 63 printable ASCII characters (no accents)"
	fi

	# --- Files for this role + device: common base, role files, keys, radio limits ---
	F="$HERE/build/files-$ROLE-$PROFILE"
	rm -rf "$F"
	cp -a "$HERE/common/files" "$F"
	cp -a "$HERE/$ROLE/files/." "$F/"
	install -d -m 700 "$F/etc/dropbear"
	cat "$HERE"/keys/*.pub > "$F/etc/dropbear/authorized_keys"
	chmod 600 "$F/etc/dropbear/authorized_keys"
	install -d -m 755 "$F/etc/sparrows"
	printf "ROLE='%s'\nTX2='%s'\nTX5='%s'\n" "$ROLE" "$TX2" "$TX5" > "$F/etc/sparrows/station"
	[ -z "$MACDEV" ] || printf "MACDEV='%s'\n" "$MACDEV" >> "$F/etc/sparrows/station"
	[ -z "$CH2" ] || printf "CH2='%s'\n" "$CH2" >> "$F/etc/sparrows/station"
	if [ -n "$DEV" ] && [ -d "$DEV/files" ]; then
		cp -a "$DEV/files/." "$F/"
	fi
	# Firmware the device needs and OpenWrt doesn't ship: fetched once, checked file by file
	if [ -n "$FW_FILES" ]; then
		C="$HERE/build/firmware/$PROFILE"
		mkdir -p "$C" "$F/$FW_DIR"
		while read -r SUM FILE; do
			[ -n "$FILE" ] || continue
			if ! echo "$SUM  $C/$FILE" | sha256sum -c --status - 2>/dev/null; then
				echo "Fetching $FILE..." >&2
				wget -q -O "$C/$FILE" "$FW_URL/$FILE" || die "Download failed: $FW_URL/$FILE"
				echo "$SUM  $C/$FILE" | sha256sum -c --status - || { rm -f "$C/$FILE"; die "$FILE: checksum FAILED"; }
			fi
			install -m 644 "$C/$FILE" "$F/$FW_DIR/$FILE"
		done <<<"$FW_FILES"
	fi
	if [ -n "$KEYF" ]; then
		install -m 600 "$HERE/secrets/$KEYF" "$F/etc/sparrows/$KEYF"
	fi
	if [ "$WITH_UI" = 1 ]; then
		cp -a "$HERE/ui/files/." "$F/"
	fi
	chmod 755 "$F"/etc/uci-defaults/*
	for D in usr/sbin usr/bin etc/init.d; do
		if [ -d "$F/$D" ]; then chmod 755 "$F/$D"/*; fi
	done

	# --- Python wheels the role needs (role.conf): fetched once, checked, unpacked into the image ---
	WHEELS='' HANDBOOK_TO=''
	if [ -f "$HERE/$ROLE/role.conf" ]; then
		# shellcheck source=/dev/null
		. "$HERE/$ROLE/role.conf"
	fi
	if [ -n "$WHEELS" ]; then
		C="$HERE/build/wheels"
		mkdir -p "$C" "$F/usr/lib/sparrows/python"
		while read -r SUM URL; do
			[ -n "$URL" ] || continue
			W="$C/${URL##*/}"
			if ! echo "$SUM  $W" | sha256sum -c --status - 2>/dev/null; then
				echo "Fetching ${URL##*/}..." >&2
				wget -q -O "$W" "$URL" || die "Download failed: $URL"
				echo "$SUM  $W" | sha256sum -c --status - || { rm -f "$W"; die "${URL##*/}: checksum FAILED"; }
			fi
			python3 -I -m zipfile -e "$W" "$F/usr/lib/sparrows/python/"
		done <<<"$WHEELS"
	fi
	# The built handbook, when the role offers it (the tree's page node)
	if [ -n "$HANDBOOK_TO" ]; then
		if [ -f "$HERE/../tao/index.html" ]; then
			install -D -m 644 "$HERE/../tao/index.html" "$F/$HANDBOOK_TO"
		else
			echo "$ROLE $PROFILE: no ../tao/index.html next to the build tree, so no handbook file in the image" >&2
		fi
	fi

	get_ib "$TARGET" || die "No Image Builder for $TARGET"
	cd "$HERE/build/$(ib_name "$TARGET")"
	# grep without -q: -q stops reading early, make dies of SIGPIPE and pipefail skips a valid profile
	make info | grep "^$IB_PROFILE:" >/dev/null || skip "$ROLE $PROFILE: no profile $IB_PROFILE in OpenWrt $VER $TARGET"
	PKG="PKG_$ROLE"
	PACKAGES="${!PKG} $DEV_PACKAGES"
	[ -z "$DEV" ] || NAME="$NAME-$PROFILE"       # e.g. sparrows-feeder-rpi-zero-2-w-...-rpi-3-...
	# Image names: openwrt-<release>-<NAME>-<target>-<profile>-squashfs-factory.bin. Matched exactly, so
	# sparrows-feeder never picks up sparrows-feeder-ui, and no image of an earlier run passes for this one
	STEM="$NAME-${TARGET/\//-}-$IB_PROFILE"
	rm -f bin/targets/"$TARGET"/*-"$STEM"-*
	[ "$WITH_UI" = 0 ] || PACKAGES="$PACKAGES $PKG_ui"
	# The hard rules, checked by the machine: the Image Builder lists every package the image would
	# hold, dependencies included, before building it. Seen 2026-11-20: luci-light brought a firewall back
	if [ "$CHECK_RULES" = 1 ]; then
		MANIFEST=$(make manifest PROFILE="$IB_PROFILE" PACKAGES="$PACKAGES" STRIP_ABI=1) || \
			die "$ROLE $PROFILE: the Image Builder can't put these packages together (make manifest)"
		NO="$FORBIDDEN"; [ "$WITH_UI" = 1 ] || NO="$NO $FORBIDDEN_NO_UI"
		BAD=$(printf '%s\n' "$MANIFEST" | awk -v no="$NO" 'BEGIN { split(no, a); for (i in a) f[a[i]] = 1 }
			($1 in f) { printf "%s ", $1 }')
		[ -z "$BAD" ] || die "$ROLE $PROFILE: the image would hold ${BAD}against the hard rules (no DHCP, RA, firewall or PPP on a station; no web interface unless asked). Fix the package lists in build.sh, or CHECK_RULES=0 to build it anyway"
	fi
	if [ "$WITH_UI" = 1 ]; then
		# Too big for the flash is the usual reason: skip this one, build the others
		make image PROFILE="$IB_PROFILE" PACKAGES="$PACKAGES" FILES="$F" EXTRA_IMAGE_NAME="$NAME" || \
			skip "$ROLE $PROFILE: no image with the web interface (too big?): build it without, or set ui to - in profiles.txt"
	else
		make image PROFILE="$IB_PROFILE" PACKAGES="$PACKAGES" FILES="$F" EXTRA_IMAGE_NAME="$NAME"
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
	# They replace this device's earlier images (any release, with or without -ui). Other devices' stay
	rm -f "$OUT"/*-"sparrows-$ROLE"{,-ui}"${DEV:+-$PROFILE}-${TARGET/\//-}-$IB_PROFILE"-*
	cp "${IMGS[@]}" "$OUT/"
	printf '%s\n' "${IMGS[@]##*/}" >> "$HERE/build/.built"
)

# ---------------------------------------------------------------- menu (terminal only)

ask() { local a; read -r -p "$1" a </dev/tty; printf '%s' "$a"; }

# Power at the radio: "-" (band off) or a whole number of dBm, 0 to 30 (no leading zero: 08 is octal)
ask_tx() {
	local v
	while :; do
		v=$(ask "$1")
		[[ "$v" =~ ^(-|[0-9]|[12][0-9]|30)$ ]] && { printf '%s' "$v"; return; }
		echo "  A number of dBm (0 to 30), or - if this band is not used." >&2
	done
}

# Find a device in the Image Builder of its target, then add it to profiles.txt
add_device() {
	local TARGET WORD FOUND N PROFILE R RS TX2 TX5 UIOK LINE WHY NEW='' i
	echo
	echo "The target is on the device's page of the OpenWrt Table of Hardware, e.g. ath79/generic, bcm27xx/bcm2711."
	TARGET=$(ask "Target: ")
	[[ "$TARGET" =~ ^[a-z0-9_-]+/[a-z0-9_-]+$ ]] || { echo "Not a target (form: name/subtarget)."; return; }
	get_ib "$TARGET" || return 0
	WORD=$(ask "Part of the model name, e.g. cpe510, eap225, rpi-4: ")
	mapfile -t FOUND < <(cd "$HERE/build/$(ib_name "$TARGET")" && make info 2>/dev/null \
		| sed -n 's/^\([A-Za-z0-9_.,-]*\):$/\1/p' | grep -i -F -- "$WORD" || true)
	[ "${#FOUND[@]}" -gt 0 ] || { echo "No model matching '$WORD' in $TARGET ($VER)."; return; }
	for i in "${!FOUND[@]}"; do printf '  %2d) %s\n' $((i + 1)) "${FOUND[$i]}"; done
	N=$(ask "Which one? ")
	[[ "$N" =~ ^[0-9]+$ && "$N" -ge 1 && "$N" -le "${#FOUND[@]}" ]] || { echo "Nothing added."; return; }
	PROFILE=${FOUND[$((N - 1))]}

	RS=$(ask "Role(s) for this device ($ROLES, several with spaces): ")
	[ -n "$RS" ] || { echo "Nothing added."; return; }
	for R in $RS; do
		case " $ROLES " in *" $R "*) ;; *) echo "Unknown role '$R'. Nothing added."; return ;; esac
	done

	echo "Power to set at the radio = legal EIRP (FR) - antenna gain. 2.4 GHz: 20 dBm EIRP."
	echo "5 GHz outdoor (ch 100-140): 30 dBm EIRP with TPC, 27 dBm without. - = band not used."
	TX2=$(ask_tx "2.4 GHz power in dBm, or -: ")
	TX5=$(ask_tx "5 GHz power in dBm, or -: ")
	case "$(ask "At least 16 MB of flash and 128 MB of RAM (web interface allowed)? [y/N] ")" in
		[yY]*) UIOK=ui ;; *) UIOK=- ;;
	esac

	for R in $RS; do
		WHY=$(bad_line "$R" "$TARGET" "$PROFILE" "$TX2" "$TX5" "$UIOK")
		if [ -n "$WHY" ]; then
			echo "  $R not added: $WHY."
			continue
		fi
		if profiles | awk -v r="$R" -v p="$PROFILE" '$1 == r && $3 == p { f = 1 } END { exit !f }'; then
			echo "  $R $PROFILE is already in profiles.txt: left as it is."
			continue
		fi
		LINE=$(printf '%-8s %-15s %-26s %-4s %-4s %s' "$R" "$TARGET" "$PROFILE" "$TX2" "$TX5" "$UIOK")
		NEW="$NEW$LINE"$'\n'
	done
	[ -n "$NEW" ] || return 0
	printf '\nTo add to profiles.txt:\n%s' "$NEW"
	case "$(ask "Add? [Y/n] ")" in [nN]*) echo "Nothing added."; return ;; esac
	[ -z "$(tail -c 1 "$HERE/profiles.txt")" ] || echo >> "$HERE/profiles.txt"   # last line not cut short
	{ printf '# added %s from the build menu: not yet tested\n' "$(date +%F)"; printf '%s' "$NEW"; } >> "$HERE/profiles.txt"
	echo "Added. It is now in the list."
}

# Sets CHOSEN to the picked device lines (and VER, if the release was changed)
menu() {
	local LINES CH T i R T2 P X2 X5 U PICK OK
	while :; do
		mapfile -t LINES < <(profiles)
		echo
		echo "Sparrows images, OpenWrt $VER, web interface $( [ "$UI" = 1 ] && echo ON || echo off ). Devices in profiles.txt:"
		for i in "${!LINES[@]}"; do
			read -r R T2 P X2 X5 U <<<"${LINES[$i]}"
			[ "${U:--}" = ui ] && U='web interface possible' || U=''
			printf '  %2d) %-7s %-28s 2.4 GHz: %-3s 5 GHz: %-3s %s\n' $((i + 1)) "$R" "$P" "$X2" "$X5" "$U"
		done
		echo "   n) add a device that is not in the list"
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
			elif [[ " $ROLES " == *" $T "* ]]; then
				for i in "${!LINES[@]}"; do
					read -r R _ <<<"${LINES[$i]}"
					if [ "$R" = "$T" ]; then PICK+=("${LINES[$i]}"); fi
				done
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
write_sd() {
	local IMGS DISKS N IMG DEV SIZE MODEL RAW BYTES P i
	[ -t 0 ] || die "Writing an SD card needs a terminal: it asks before erasing anything."
	if [ -n "${1:-}" ]; then
		IMGS=("$1")
	else
		shopt -s nullglob
		IMGS=("$OUT"/*factory*.img.gz)
		[ "${#IMGS[@]}" -gt 0 ] || IMGS=("$OUT"/*.img.gz)
		shopt -u nullglob
	fi
	[ "${#IMGS[@]}" -gt 0 ] || { echo "No .img.gz in $OUT: build a Raspberry Pi image first."; return 0; }
	IMG=${IMGS[0]}
	if [ "${#IMGS[@]}" -gt 1 ]; then
		for i in "${!IMGS[@]}"; do printf '  %2d) %s\n' $((i + 1)) "$(basename "${IMGS[$i]}")"; done
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

	echo
	echo "EVERYTHING on $DEV ($SIZE, $MODEL) will be erased:"
	lsblk -po NAME,SIZE,FSTYPE,LABEL,MOUNTPOINT "$DEV"
	echo "and replaced by: $(basename "$IMG")"
	[ "$(ask "To go on, type the disk name (${DEV#/dev/}): ")" = "${DEV#/dev/}" ] || { echo "Cancelled, nothing written."; return 0; }

	# OpenWrt puts its metadata after the gzip data: gzip warns "trailing garbage" and exits 2
	RAW="$HERE/build/sd-card.img"
	mkdir -p "$HERE/build"           # absent in a fresh copy of the kit, with an image from elsewhere
	echo "Unpacking..."
	gzip -dc "$IMG" > "$RAW" 2>/dev/null || [ $? -eq 2 ] || die "Cannot unpack $IMG"
	BYTES=$(stat -c %s "$RAW")
	[ "$BYTES" -gt 0 ] || die "Empty image: $IMG"

	for P in $(lsblk -lnpo NAME "$DEV"); do
		if findmnt -rn -S "$P" >/dev/null; then sudo umount "$P"; fi
	done
	echo "Erasing the old partition table, then writing $((BYTES / 1048576)) MiB (sudo asks for your password)..."
	sudo wipefs -a -q "$DEV"
	sudo dd if="$RAW" of="$DEV" bs=4M conv=fsync status=progress
	sync
	echo "Reading the card back..."
	sudo blockdev --flushbufs "$DEV"
	if sudo cmp -n "$BYTES" "$RAW" "$DEV"; then
		rm -f "$RAW"
		echo "OK: the card matches the image. You can take it out."
	else
		rm -f "$RAW"
		die "The card does NOT match the image: write it again, or use another card."
	fi
}

# ---------------------------------------------------------------- main

ARG="${1:-}"
MENU=0
[ -z "$ARG" ] && [ -t 0 ] && [ -t 1 ] && MENU=1
CHOSEN=''
case "$ARG" in
	'')    if [ "$MENU" = 1 ]; then menu; else CHOSEN=$(profiles); fi ;;
	all)   CHOSEN=$(profiles) ;;
	perch|feeder|hedge|tree) CHOSEN=$(profiles | awk -v r="$ARG" '$1 == r') ;;
	sd)    write_sd "${2:-}"; exit 0 ;;
	*)     die "Usage: ./build.sh [all|perch|feeder|hedge|tree] | ./build.sh sd [image.img.gz]" ;;
esac
[ -n "$CHOSEN" ] || die "Nothing to build."

# Every chosen line checked before anything is downloaded
BAD=''
while read -r ROLE TARGET PROFILE TX2 TX5 UIOK REST; do
	WHY=$(bad_line "$ROLE" "$TARGET" "$PROFILE" "$TX2" "$TX5" "${UIOK:--}" "$REST")
	[ -z "$WHY" ] || BAD="$BAD  $ROLE $TARGET $PROFILE: $WHY"$'\n'
done <<<"$CHOSEN"
[ -z "$BAD" ] || die "profiles.txt, line(s) to fix first:"$'\n'"${BAD%$'\n'}"

echo
echo "OpenWrt $VER. To build:"
printf '%s\n' "$CHOSEN" | awk -v ui="$UI" '{ w = (ui == 1 && $6 == "ui") ? "  + web interface" : ""
	printf "  %-7s %s (%s)%s\n", $1, $3, $2, w }'
[ "$CHECK_SIG" = 1 ] || echo "  Skipped on purpose: the check of OpenWrt's signature (CHECK_SIG=0)"
[ "$CHECK_RULES" = 1 ] || echo "  Skipped on purpose: the check of the packages against the hard rules (CHECK_RULES=0)"
if [ "$MENU" = 1 ]; then
	case "$(ask "Go? [Y/n] ")" in [nN]*) exit 0 ;; esac
fi

compgen -G "$HERE/keys/*.pub" >/dev/null || die "Put admin SSH public keys in keys/*.pub first"
MISSING=''
for C in wget zstd tar make gcc perl rsync python3 sha256sum $( [ "$CHECK_SIG" = 0 ] || echo gpgv ); do
	command -v "$C" >/dev/null || MISSING="$MISSING $C"
done
[ -z "$MISSING" ] || die "Missing on this machine:$MISSING (the Image Builder needs them; see its page on openwrt.org)"
mkdir -p "$HERE/build" "$OUT"
: > "$HERE/build/.built"; : > "$HERE/build/.skipped"

while read -r ROLE TARGET PROFILE TX2 TX5 UIOK; do
	build_one "$ROLE" "$TARGET" "$PROFILE" "$TX2" "$TX5" "${UIOK:--}" </dev/null
done <<<"$CHOSEN"

echo
if [ -s "$HERE/build/.skipped" ]; then
	echo "Skipped:"
	sed 's/^/  /' "$HERE/build/.skipped"
	echo
fi
[ -s "$HERE/build/.built" ] || die "No image was built."
echo "Built now, in $OUT:"
( cd "$OUT" && while read -r I; do sha256sum -- "$I"; done < "$HERE/build/.built" )

if grep -q -e '-ui-' "$HERE/build/.built"; then
	echo
	echo "Web interface (images with -ui): it only listens on the unit itself. From your laptop:"
	echo "  ssh -N -L 8080:127.0.0.1:80 root@<station address>    then open http://localhost:8080"
	echo "  The first time, set the root password over SSH:  passwd   (SSH itself stays keys only)"
fi

if [ "$MENU" = 1 ] && grep -q '\.img\.gz$' "$HERE/build/.built"; then
	echo
	case "$(ask "Write a Raspberry Pi image to an SD card now? [y/N] ")" in [yY]*) write_sd ;; esac
fi
