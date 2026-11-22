#!/usr/bin/env python3
"""Assemble index.html from tao.src.html + code snippets (escaped once, shared by all languages).

The build scripts (sparrows-openwrt/) are not printed in the handbook: they travel with it, in the
archive or the git repository. snippets.txt holds what a reader types: build, install, change, check, undo."""
import html, pathlib, re, sys

here = pathlib.Path(__file__).parent

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

src = (here / "tao.src.html").read_text()

# French typography: no-break space before : ; ? ! » and after « (prose only, before code goes in)
head, rest = src.split("<main>", 1)
body, tail = rest.split("</main>", 1)
body = re.sub(r" ([:;?!»])", "\u202f\\1", body)
body = body.replace("« ", "«\u202f")
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

# README.md is written by hand: it says what the project is and links to the handbook on GitHub Pages.
