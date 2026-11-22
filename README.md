# Sparrows-Network

**Standalone Peer Access Radio Relay Over Wireless Stations**

A community network that runs without the Internet. Fixed Wi-Fi stations cover one village first, then link villages 1 to 15 km apart. Anyone nearby joins the open `Sparrows` Wi-Fi with an ordinary phone, and finds a welcome page, messages and local services, with no account and no operator.

## Goals

- **Free communication, without the Internet.** Neighbours reach each other, and the network keeps working when the Internet is down.
- **No centre to seize.** No leader, no list of users, nothing to hand over. Each station relays what it hears. Take one away and the others close the gap.
- **Cheap and ordinary.** Stock hardware (TP-Link CPE510 and EAP225, Raspberry Pi), standard OpenWrt, batman-adv and Reticulum. Every station of a role runs the same image.
- **Simple to join, simple to build.** One handbook says how to use the network, add a station and start a village.
- **Principles first.** The network follows the [Zen of Reticulum](https://reticulum.network/zenofreticulum.html), even where Reticulum itself isn't used.

## The handbook: the Sparrows Tao

Everything to build, install, check and troubleshoot is in one page, in English, French and Spanish:

**→ [Read the Sparrows Tao](https://1372711.github.io/Sparrows-Nework/tao/)**

Without Internet: open [`tao/index.html`](tao/index.html) from a copy of this repository in any browser. It needs nothing from outside.

## What's in this repository

- `tao/`: the handbook (`index.html`), built by `build.py` from `tao.src.html` and `snippets.txt`.
- `sparrows-openwrt/`: the scripts that build the station images (`build.sh`, `profiles.txt`, `uses.txt`, first-boot files per role).

---

*Français :* un réseau communautaire sans Internet. Le manuel : [Sparrows Tao](https://1372711.github.io/Sparrows-Nework/tao/).
*Español:* una red comunitaria sin Internet. El manual: [Sparrows Tao](https://1372711.github.io/Sparrows-Nework/tao/).
