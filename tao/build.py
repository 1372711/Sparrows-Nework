#!/usr/bin/env python3
"""Assemble index.html from tao.src.html + code snippets (escaped once, shared by all languages)."""
import html, pathlib, re, sys

here = pathlib.Path(__file__).parent
owrt = here.parent / "sparrows-openwrt"

snips, wrap, name = {}, set(), None
for line in (here / "snippets.txt").read_text().splitlines():
    if line.startswith("### "):
        parts = line[4:].split()
        name = parts[0]
        snips[name] = []
        if "wrap" in parts[1:]:
            wrap.add(name)
    elif name:
        snips[name].append(line)
snips = {k: "\n".join(v).strip("\n") for k, v in snips.items()}

# The OpenWrt image files are shown as they are in the build tree: one source of truth
for key, rel in {
    "owrt-profiles": "profiles.txt",
    "owrt-build": "build.sh",
    "owrt-common": "common/files/etc/uci-defaults/10-sparrows-common",
    "perch-defaults": "perch/files/etc/uci-defaults/90-sparrows-perch",
    "perch-tool": "perch/files/usr/sbin/perch",
    "feeder-defaults": "feeder/files/etc/uci-defaults/90-sparrows-feeder",
    "hedge-defaults": "hedge/files/etc/uci-defaults/90-sparrows-hedge",
    "ui-defaults": "ui/files/etc/uci-defaults/95-sparrows-ui",
    "zero-conf": "devices/rpi-zero-2-w/device.conf",
    "zero-defaults": "devices/rpi-zero-2-w/files/etc/uci-defaults/20-sparrows-device",
    "owrt-banner": "common/files/etc/sparrows/banner",
    "tree-conf": "tree/role.conf",
    "tree-defaults": "tree/files/etc/uci-defaults/90-sparrows-tree",
    "tree-rns-config": "tree/files/etc/reticulum/config",
    "tree-init": "tree/files/etc/init.d/rnsd",
    "tree-tool": "tree/files/usr/bin/rns",
    "tree-page": "tree/files/usr/share/sparrows/nomadnet/pages/index.mu",
    "tree-nomad-config": "tree/files/etc/nomadnetwork/config",
    "tree-nomad-init": "tree/files/etc/init.d/nomadnet",
}.items():
    snips[key] = (owrt / rel).read_text().strip("\n")

src = (here / "tao.src.html").read_text()

# French typography: no-break space before : ; ? ! » and after « (prose only, before code goes in)
head, rest = src.split("<main>", 1)
body, tail = rest.split("</main>", 1)
body = re.sub(r" ([:;?!»])", " \\1", body)
body = body.replace("« ", "« ")
src = head + "<main>" + body + "</main>" + tail

used = set()
def put(m):
    n, label = m.group(1), (m.group(2) or "")
    if n not in snips:
        sys.exit("unknown snippet: %s" % n)
    used.add(n)
    cls = ' class="wrap"' if n in wrap else ""
    return ('<div class="code"><div class="hd"><span class="file">%s</span></div>'
            '<pre%s><code>%s</code></pre></div>') % (html.escape(label), cls, html.escape(snips[n], quote=False))

out = re.sub(r"<!--code:([a-z0-9-]+)(?:\|([^>]*?))?-->", put, src)
missing = set(snips) - used
if missing:
    sys.exit("unused snippets: %s" % sorted(missing))
(here / "index.html").write_text(out)
print("index.html", len(out.encode()), "bytes,", len(used), "code blocks")
