# Sparrows-Network

**Standalone Peer Access Radio Relay Over Wireless Stations**

A community network that runs without the Internet. Fixed stations cover one village first, then link villages over any radio that carries the distance: Wi-Fi with directional antennas, LoRa, HF where the law allows, or a cable, whether the next village is 1 km away or 30 km and more. Anyone nearby joins the open `Sparrows` Wi-Fi with an ordinary phone, and finds a welcome page, messages and local services, with no account and no operator.

## Goals

- **Free communication, without the Internet.** Neighbours reach each other, and the network keeps working when the Internet is down.
- **No centre to seize.** No leader, no list of users, nothing to hand over. Each station relays what it hears. Take one away and the others close the gap.
- **Cheap and ordinary.** Stock hardware (TP-Link CPE510 and EAP225, Raspberry Pi), standard OpenWrt, batman-adv and Reticulum. Every station of a role runs the same image.
- **Simple to join, simple to build.** One handbook says how to use the network, add a station and start a village.
- **A stolen card tells nothing.** On Raspberry Pi stations, what people rely on (identities, stored messages) sits on a locked partition. It opens with the admin's passphrase, or when an approver says yes from their phone or laptop over Reticulum.
- **Principles first.** The network follows the [Zen of Reticulum](https://reticulum.network/zenofreticulum.html), even where Reticulum itself isn't used.

## The handbook: the Sparrows Tao

Everything to build, install, check and troubleshoot is in one page, in English, French and Spanish:

**→ [Read the Sparrows Tao](https://1372711.github.io/Sparrows-Nework/tao/)**

Without Internet: open [`tao/index.html`](tao/index.html) from a copy of this repository in any browser. It needs nothing from outside.

## Building the images

- **The stations** all run OpenWrt: one image per role (perch, feeder, hedge, tree, nest) and per device.
- **The build laptop** is an x86_64 machine running **Debian or Ubuntu**, with Internet access. `build.sh` is written and tested for Debian; other distributions may work but are not supported for now.

```sh
git clone https://github.com/1372711/Sparrows-Nework.git sparrows
cd sparrows/sparrows-openwrt
cp ~/.ssh/id_ed25519.pub keys/admin.pub   # the build refuses to run without an admin key
./build.sh                                # a menu: pick the devices, then build
```

The radio keys, the passphrases and the list of approvers stay on the build laptop (`keys/`, `secrets/`), never in git. The handbook explains each step, how to check it and how to undo it.

## What's in this repository

- `tao/`: the handbook (`index.html`), built by `build.py` from `tao.src.html` and `snippets.txt`.
- `sparrows-openwrt/`: the scripts that build the station images (`build.sh`, `profiles.txt`, `uses.txt`, first-boot files per role).
- `sparrows-openwrt/approver/`: `sparrows-approve`, the approver's tool (a laptop, or a phone in Termux), to open a station's locked partition after a reboot.

## Licence

The project's own files (the handbook and the build scripts) are under the BSD 2-Clause licence ([`LICENSE`](LICENSE)). The software they install keeps its own licence: OpenWrt, Reticulum, LXMF, Nomad Network and the others. Reticulum and LXMF must never be used in a system built to harm people, nor to make or train AI models. Every image carries these licences; see the handbook, "Licences and thanks".

---

*Français :* un réseau communautaire sans Internet. Le manuel : [Sparrows Tao](https://1372711.github.io/Sparrows-Nework/tao/).
*Español:* una red comunitaria sin Internet. El manual: [Sparrows Tao](https://1372711.github.io/Sparrows-Nework/tao/).
