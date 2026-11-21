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
    "owrt-uses": "uses.txt",
    "owrt-build": "build.sh",
    "owrt-common": "common/files/etc/uci-defaults/10-sparrows-common",
    "station-defaults": "station/files/etc/uci-defaults/90-sparrows-station",
    "station-radios": "station/files/usr/lib/sparrows/radios",
    "station-hotplug": "station/files/etc/hotplug.d/ieee80211/20-sparrows-radios",
    "perch-tool": "perch/files/usr/sbin/perch",
    "ui-defaults": "ui/files/etc/uci-defaults/95-sparrows-ui",
    "zero-conf": "devices/rpi-zero-2-w/device.conf",
    "zero-defaults": "devices/rpi-zero-2-w/files/etc/uci-defaults/20-sparrows-device",
    "rpi4-conf": "devices/rpi-4/device.conf",
    "owrt-banner": "common/files/etc/sparrows/banner",
    "tree-conf": "tree/role.conf",
    "tree-rns-config": "tree/files/etc/reticulum/config",
    "tree-init": "tree/files/etc/init.d/rnsd",
    "tree-tool": "tree/files/usr/bin/rns",
    "tree-page": "tree/files/usr/share/sparrows/nomadnet/pages/index.mu",
    "tree-nomad-config": "tree/files/etc/nomadnetwork/config",
    "tree-nomad-init": "tree/files/etc/init.d/nomadnet",
    "nest-defaults": "nest/files/etc/uci-defaults/91-sparrows-nest",
    "nest-conf": "nest/role.conf",
    "nest-lxmd": "nest/files/etc/init.d/lxmd",
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

# README.md, the repository's front page on GitHub: the same handbook, in English, with the same code.
# GitHub shows no style or script, so there is no language switch, no schematic and no copy button:
# French and Spanish stay in index.html. Never edit README.md by hand: it is rewritten here.
from html.parser import HTMLParser

class English(HTMLParser):
    """Keep the blocks in English or with no lang. Drop the other languages, the schematic, scripts."""
    VOID = {"br", "hr", "img", "wbr", "input", "meta", "link", "source"}

    def __init__(self):
        super().__init__(convert_charrefs=False)
        self.out, self.drop, self.toc, self.head = [], 0, [], None

    def emit(self, s):
        if not self.drop:
            self.out.append(s)

    def handle_starttag(self, tag, attrs):
        a = dict(attrs)
        if self.drop:
            self.drop += tag not in self.VOID
        elif a.get("lang", "en") != "en" or tag in ("svg", "script", "style", "button"):
            if tag == "svg":
                self.out.append("<p><em>The schematic is in tao/index.html.</em></p>")
            self.drop = tag not in self.VOID
        else:
            self.out.append(self.get_starttag_text())
            if tag in ("h2", "h3") and a.get("id"):
                self.head = (tag, a["id"], len(self.out))

    def handle_startendtag(self, tag, attrs):
        if not self.drop and dict(attrs).get("lang", "en") == "en" and tag != "svg":
            self.out.append(self.get_starttag_text())

    def handle_endtag(self, tag):
        if self.drop:
            self.drop -= tag not in self.VOID
            return
        if self.head and tag == self.head[0]:
            text = re.sub(r'<span class="st[ "].*?</span>', "", "".join(self.out[self.head[2]:]))  # no status mark
            self.toc.append((tag, self.head[1], re.sub(r"<[^>]*>", "", text).strip()))
            self.head = None
        self.out.append("</%s>" % tag)

    def handle_data(self, d): self.emit(d)
    def handle_entityref(self, n): self.emit("&%s;" % n)
    def handle_charref(self, n): self.emit("&#%s;" % n)

p = English()
p.feed(out.split("<main>", 1)[1].split("</main>", 1)[0])
p.close()
if p.drop:
    sys.exit("README.md: a tag is left open in tao.src.html")

toc, part = ["<ul>"], False             # the parts (h2), each with its sections (h3)
for tag, hid, text in p.toc:
    item = '<a href="#%s">%s</a>' % (hid, text)
    if tag == "h2":
        toc.append(("</ul></li>" if part else "") + "<li>" + item + "<ul>")
        part = True
    else:
        toc.append("<li>" + item + "</li>")
toc.append(("</ul></li>" if part else "") + "</ul>")

# Markdown reads raw HTML only up to the first blank line: no blank line outside the code, and an
# empty line inside the code becomes a space (&#32;), which looks the same.
parts = re.split(r"(<pre.*?</pre>)", "".join(p.out), flags=re.S)
body = "".join(re.sub(r"\n[ \t]*(?=\n)", "", s) if i % 2 == 0 else re.sub(r"(?m)^[ \t]*$", "&#32;", s)
               for i, s in enumerate(parts))
readme = ("<!-- Written by tao/build.py from tao/tao.src.html. Edit the source and run build.py: never this file. -->\n\n"
          "<div>\n"
          "<p><em>This is the Sparrows Tao in English. In English, French and Spanish: <a href=\"tao/index.html\">tao/index.html</a>, "
          "to download and open in a browser.<br>\n"
          "Le Sparrows Tao en français, anglais et espagnol : <a href=\"tao/index.html\">tao/index.html</a>, à télécharger "
          "et à ouvrir dans un navigateur.<br>\n"
          "El Sparrows Tao en español, inglés y francés: <a href=\"tao/index.html\">tao/index.html</a>, para descargar y abrir "
          "en un navegador.</em></p>\n"
          "<details><summary>Contents</summary>\n" + "\n".join(toc) + "\n</details>\n"
          + body.strip("\n") + "\n</div>\n")
(here.parent / "README.md").write_text(readme)
print("README.md", len(readme.encode()), "bytes,", readme.count("<pre"), "code blocks")
