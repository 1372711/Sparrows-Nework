<!-- Written by tao/build.py from tao/tao.src.html. Edit the source and run build.py: never this file. -->

<div>
<p><em>This is the Sparrows Tao in English. In English, French and Spanish: <a href="tao/index.html">tao/index.html</a>, to download and open in a browser.<br>
Le Sparrows Tao en français, anglais et espagnol : <a href="tao/index.html">tao/index.html</a>, à télécharger et à ouvrir dans un navigateur.<br>
El Sparrows Tao en español, inglés y francés: <a href="tao/index.html">tao/index.html</a>, para descargar y abrir en un navegador.</em></p>
<details><summary>Contents</summary>
<ul>
<li><a href="#part-way">I. The Way</a><ul>
<li><a href="#tale">The sparrows' tale</a></li>
<li><a href="#way">Eight lines</a></li>
<li><a href="#principles">Five principles as goals</a></li>
<li><a href="#layers">Two layers</a></li>
<li><a href="#tor">What we take from Tor, and what we leave</a></li>
<li><a href="#rule">Who rules the network? Nobody</a></li>
<li><a href="#limits">Hard rules</a></li>
<li><a href="#frugal">Frugal</a></li>
<li><a href="#law">The law in France</a></li>
</ul></li><li><a href="#start">Start here</a><ul>
<li><a href="#status">Where things stand</a></li>
</ul></li><li><a href="#part-network">II. The network</a><ul>
<li><a href="#schematic">Schematic of one village</a></li>
<li><a href="#roles">Role of each station</a></li>
<li><a href="#standard">Standard software, any hardware</a></li>
<li><a href="#flyways">Flyways: any medium</a></li>
<li><a href="#segment">One village, one segment</a></li>
<li><a href="#names">Names and addresses: nothing to set per unit</a></li>
<li><a href="#talk">Talking: messages, groups, calls</a></li>
<li><a href="#ipv6">IPv6 without DHCP</a></li>
</ul></li><li><a href="#part-build">III. How to build it</a><ul>
<li><a href="#images">Station images: perch, feeder, hedge, tree, nest</a></li>
<li><a href="#pi">Nests, example: Raspberry Pi</a></li>
<li><a href="#reticulum">Reticulum</a></li>
<li><a href="#page-node">A neighbour's page node, example: Pi Zero 2 W</a></li>
<li><a href="#pitfalls">Pitfalls</a></li>
<li><a href="#recovery">Recovery</a></li>
</ul></li><li><a href="#part-road">IV. The open road</a><ul>
<li><a href="#wikipedia">Wikipedia in the village</a></li>
<li><a href="#roadmap">Roadmap</a></li>
<li><a href="#ideas">Ideas not yet decided</a></li>
<li><a href="#outside">A hub between villages, on a VPS</a></li>
<li><a href="#lora">A LoRa flyway to a town 15 km away</a></li>
<li><a href="#growing">How this page grows</a></li>
</ul></li><li><a href="#glossary">Glossary</a><ul>
</ul></li></ul>
</details>
<p class="eyebrow">Standalone Peer Access Radio Relay Over Wireless Stations</p>
<h1>Sparrows Tao</h1>
<p class="lead" lang="en">Sparrows-Network is a community network that runs without the Internet: fixed Wi-Fi stations in one village first, then links between villages 1 to 15 km apart. This handbook holds its way of thinking and its way of building in one file: give it to anyone who wants to join or to build, or let a nest serve it as the village's welcome page.</p>
<p class="lead" lang="en"><strong>We fight for freedom of communication and of information.</strong></p>
<p class="meta"><span lang="en">Edition of 2026-11-15 (handbook). A living document: every block says whether it has run on the bench.</span></p>
<p lang="en">Stations are named by their role, after the places and things of birds: <a class="term" href="#g-feeder">feeders</a> let people's devices in, <a class="term" href="#g-perch">perches</a> hold the <a class="term" href="#g-flyway">flyways</a> between places, <a class="term" href="#g-hedge">hedges</a> do both at once, <a class="term" href="#g-nest">nests</a> welcome newcomers and keep what must wait, and <a class="term" href="#g-tree">trees</a> relay. Every term is in the <a href="#glossary">glossary</a> at the end. Hardware names such as Raspberry Pi, CPE510 or EAP225 are only examples.</p>
<p class="lead" lang="en">New here? The Way comes first, because it says why this network exists. To join or build right away, go to <a href="#start">Start here</a>.</p>
<p class="meta"><span lang="en">Contact</span>: <a href="mailto:sparrows-network@riseup.net">sparrows-network@riseup.net</a> · <span lang="en">Files and scripts</span>: <a href="kit/">kit/</a></p>
<h2 id="part-way"><span lang="en">I. The Way</span></h2>
<h3 id="tale"><span lang="en">The sparrows' tale</span></h3>
<div lang="en">
<p>The house sparrow has lived beside people for as long as there have been fields and roofs. It nests in the gaps of our walls, picks up the crumbs of our markets, and gathers at dusk in noisy roosts in the hedges of every town. Nobody notices one sparrow. There are always a hundred.</p>
<p>For centuries they were treated as vermin. English parishes ran sparrow clubs that paid a bounty for every dozen heads, from the 18th century until after the First World War. In 1958 China put the sparrow on its list of four pests, next to rats, flies and mosquitoes, and whole cities made noise day and night so the birds could never land. Scientists warned that sparrows also eat locusts. They were not heard. The sparrows nearly vanished, the locusts came, and <a href="https://epic.uchicago.edu/news/how-the-persecution-of-sparrows-killed-2m-people">a recent study</a> puts nearly a fifth of the harvest lost in the famine that followed down to the missing birds. In 1960 the sparrow was taken off the list, and sparrows had to be brought in from abroad.</p>
<p>And the sparrows are still here. Not because they are strong: a sparrow weighs about thirty grams. Because there are many of them, because they are ordinary, because none of them leads the others, and because the one that sees danger calls out and the whole flock hears it. You can scare a sparrow away. You cannot scare away the sparrows.</p>
<p>That is the network we want. Small, cheap stations nobody notices. No centre to seize, no leader to silence, no list of names to hand over. Each station passes on what it hears. Take one away and the others close the gap. A message waits in a nest until the person it is for comes home. And the knowledge of the world, starting with Wikipedia, is kept in many places at once, so that nobody can take it away from the village.</p>
<p>A sparrow eats a little grain. It also eats the locusts. Free communication is the same: it costs a little, it is sometimes a nuisance, and a field without it has no defence.</p>
</div>
<h3 id="way"><span lang="en">Eight lines</span></h3>
<p lang="en">Decided on 2026-11-11: the network respects the principles of the <a href="https://reticulum.network/zenofreticulum.html">Zen of Reticulum</a>, one way or another, even where Reticulum itself isn't used. The eight lines below follow its eight sections, in our own words, each with what Sparrows does about it and what is still open.</p>
<ol class="way" lang="en">
  <li><strong>No centre.</strong> Every nest is a replaceable peer. The welcome page is the same everywhere. A file is valid from any copy. <span class="open">Open: router advertisements still come from nests only.</span></li>
  <li><strong>Assume the link is hostile.</strong> Everything on Layer 1 is encrypted and authenticated by keys. The mesh and the on-ramp are treated as untrusted. <span class="open">Open: one shared SAE passphrase on the backbone; open client Wi-Fi.</span></li>
  <li><strong>Scarcity is normal.</strong> No streaming. A message waits for its reader. A file is fetched once and kept. <span class="open">Open: throughput not measured.</span></li>
  <li><strong>Own what you run.</strong> No ISP, no cloud, cheap stations anyone can buy and add. <span class="open">Open: Android needs a global-looking IPv6 prefix, and that number has to come from somewhere without making the village depend on its holder.</span></li>
  <li><strong>Identity travels with its owner.</strong> A person is a key they hold, not an account someone grants. No user key ever lives on a nest. <span class="open">Open: a usable iPhone client.</span></li>
  <li><strong>A tool carries an ethic.</strong> A usage charter on the welcome page. The conditions of Reticulum's licence are respected. <span class="open">Open: the charter is still to write.</span></li>
  <li><strong>Leave the habits of IP behind.</strong> A service is reached by its hash, not by a DNS name. Store-and-forward comes first. <span class="open">Open: the on-ramp itself is DNS + HTTP, by design.</span></li>
  <li><strong>A commons.</strong> Anyone can add a station or a tree. Each village holds its own keys. There is no master admin. <span class="open">Open: governance between villages.</span></li>
</ol>
<h3 id="principles"><span lang="en">Five principles as goals</span></h3>
<p lang="en">Every design choice should move at least one of these forward without breaking the others. A proposal says which principle it serves and what it costs: RAM, flash, complexity for amateurs, or legal risk.</p>
<div class="cards">
  <div class="card">
    <h4><span class="pn">P1</span><span lang="en">Identity = key</span></h4>
    <p lang="en">People and nodes are identified by a key pair they own, not by an account an admin can delete.</p>
    <p lang="en"><span class="k">Today</span>Shared SAE passphrase on the backbone; SSH passwords; Reticulum config written. The perch, feeder and hedge images take SSH keys only.</p>
    <p lang="en"><span class="k">Target</span>SSH keys for admin. Every person and every service is a Reticulum key hash. No accounts on any nest.</p>
  </div>
  <div class="card">
    <h4><span class="pn">P2</span><span lang="en">Content = hash</span></h4>
    <p lang="en">A file is fetched by what it is, not by where it is. It can't be silently altered, and any copy is valid.</p>
    <p lang="en"><span class="k">Today</span>An nginx <code>/files/</code> listing on one Pi.</p>
    <p lang="en"><span class="k">Target</span>Files offered over Reticulum, listed in a hash manifest signed by the village node. Wikipedia as ZIM files, read locally.</p>
  </div>
  <div class="card">
    <h4><span class="pn">P3</span><span lang="en">Every user is a relay</span></h4>
    <p lang="en">No central point. Losing one box loses nothing essential.</p>
    <p lang="en"><span class="k">Today</span>batman-adv nodes relay; with SLAAC there is no DHCP to lose; one Pi still does RA, DNS and web.</p>
    <p lang="en"><span class="k">Target</span>Nests are equal, replaceable peers. Anyone can run a tree. Cheap stations anyone can add.</p>
  </div>
  <div class="card">
    <h4><span class="pn">P4</span><span lang="en">Store and forward</span></h4>
    <p lang="en">It works with intermittent links. Data catches up when a link returns.</p>
    <p lang="en"><span class="k">Today</span>Live links only.</p>
    <p lang="en"><span class="k">Target</span>An LXMF propagation node on every nest. File stores and propagation nodes sync between villages after a cut. No streaming.</p>
  </div>
  <div class="card">
    <h4><span class="pn">P5</span><span lang="en">Boring and hard to block</span></h4>
    <p lang="en">Traffic and infrastructure don't stand out, and nothing depends on an outside party.</p>
    <p lang="en"><span class="k">Today</span>No Internet dependency; hidden, SAE-encrypted backbone.</p>
    <p lang="en"><span class="k">Target</span>All Layer 1 traffic encrypted end to end. No logs on nests or trees. No outside DNS, certificate authority or cloud.</p>
  </div>
</div>
<h4><span lang="en">When they conflict</span></h4>
<p class="order"><span lang="en">Zen of Reticulum &gt; works reliably for amateurs &gt; P3 &gt; P2 &gt; P1 &gt; P4 &gt; P5</span></p>
<p lang="en">One exception: on the on-ramp, ease of use comes first, because a network nobody can join protects nobody.</p>
<h3 id="layers"><span lang="en">Two layers</span></h3>
<p lang="en">DNS and HTTP exist only as an on-ramp for the first contact. Everything else is addressed by keys. Whatever a proposal adds to Layer 0, it must say why it can't live in Layer 1.</p>
<div class="tw"><table>
  <thead><tr><th></th>
    <th class="c0"><span lang="en">Layer 0: the on-ramp</span></th>
    <th class="c1"><span lang="en">Layer 1: the network</span></th></tr></thead>
  <tbody>
  <tr><th><span lang="en">Purpose</span></th>
    <td><span lang="en">First contact only: what this is, how to join</span></td>
    <td><span lang="en">Everything else</span></td></tr>
  <tr><th><span lang="en">Addressing</span></th>
    <td><span lang="en">IPv6 SLAAC + catch-all DNS</span></td>
    <td><span lang="en">Key hashes</span></td></tr>
  <tr><th><span lang="en">Protocols</span></th>
    <td><span lang="en">RA, DNS, plain HTTP</span></td>
    <td>Reticulum, LXMF</td></tr>
  <tr><th><span lang="en">State</span></th>
    <td><span lang="en">None: one static page, no accounts, no logs</span></td>
    <td><span lang="en">Held by users (their keys), replicated between peers</span></td></tr>
  <tr><th><span lang="en">If it's lost</span></th>
    <td><span lang="en">New people can't come in. Existing users notice nothing</span></td>
    <td><span lang="en">Peers route around the missing node</span></td></tr>
  <tr><th><span lang="en">Trust</span></th>
    <td><span lang="en">Untrusted: plain HTTP on an open Wi-Fi</span></td>
    <td><span lang="en">Cryptographic: every address is a key</span></td></tr>
  </tbody>
</table></div>
<p lang="en">Because the on-ramp is untrusted, anything a newcomer must trust (the hash of the app to install, the key hashes of the village) also has to be checkable on paper: a flyer, a noticeboard.</p>
<h3 id="tor"><span lang="en">What we take from Tor, and what we leave</span></h3>
<ul lang="en">
  <li><strong>Kept.</strong> Addresses that prove themselves: the address is the key.</li>
  <li><strong>Kept.</strong> Relays (our trees) run by volunteers, which log nothing and know only their neighbours.</li>
  <li><strong>Kept.</strong> Several independent signers for anything shared: lists, releases.</li>
  <li><strong>Left.</strong> Onion routing itself. In one village the crowd to hide in is a few dozen people, so it would cost a lot of complexity for little protection.</li>
</ul>
<h3 id="rule"><span lang="en">Who rules the network? Nobody</span> <span class="st idea" data-ui="idea">idea</span></h3>
<p lang="en">A network needs software updates, and updates look like a throne: whoever publishes them rules. The answer is to split that power instead of handing it to someone.</p>
<ul lang="en">
  <li><strong>Anyone can build and check</strong> a release: builds are reproducible.</li>
  <li><strong>Nobody can publish alone.</strong> A release needs signatures from k of n maintainer keys, for example 2 of 3. Later, one key per village.</li>
  <li><strong>Every station owner can say no:</strong> delay an update, refuse it, or trust another set of signers. That last one is a fork, and a fork still talks to everyone, because the protocol doesn't care which build a station runs.</li>
</ul>
<p class="note" lang="en">Cost: automatic update is remote code execution by design. A signature threshold only helps if the check underneath is sound: a flaw in Freifunk Gluon's signature library once let a forged manifest through <a href="https://github.com/freifunk-gluon/gluon/security/advisories/GHSA-xqhj-fmc7-f8mv">whatever the number of signatures required</a>. First step: signed bundles carried by hand on a USB stick, installed manually.</p>
<h3 id="limits"><span lang="en">Hard rules</span></h3>
<p lang="en">Already decided or learned the hard way. They change only by an explicit decision, written here with its date.</p>
<ul lang="en">
  <li><strong>Standalone.</strong> No Internet gateway, VPN exit or Tor exit on the mesh. It would change the legal status of the network.</li>
  <li><strong>IPv6 only.</strong> No IPv4 and no DHCP on the mesh. Legacy IPv4-only devices are not supported.</li>
  <li><strong>Only nests send router advertisements.</strong> Never a perch, a feeder, a hedge, a tree or a user device.</li>
  <li><strong>Names and addresses come from the MAC.</strong> Every station is <code>role-xxxx</code>, the last four hex digits of its MAC, and builds its IPv6 address from the same MAC. Nothing to set per unit, no list to keep (decided 2026-11-15). Nests still hold <code>::1</code> and <code>::2</code> for now.</li>
  <li><strong>Never filter ICMPv6.</strong> IPv6 doesn't work without it.</li>
  <li><strong>DNS and HTTP are the on-ramp and nothing more.</strong> No accounts, no logs, no streaming, no service that depends on a DNS name.</li>
  <li><strong>No user key on a nest.</strong> So no web client hosted on a nest.</li>
  <li><strong>Mesh and home LAN stay isolated.</strong> Forwarding off for both families (on the mesh side, <code>eth0.forwarding=1</code> only sets the router flag: <code>all.forwarding</code> stays 0), nftables <code>forward</code> drop, and never a bridge between them.</li>
  <li><strong>Radio, France.</strong> Outdoor 5 GHz on channels 100 to 140 (DFS), never 120 to 128 (weather radar), 30 dBm EIRP at most. Channels 36 to 48 are indoor only. No 802.11s on DFS channels: on 2.4 GHz it is fine.</li>
  <li><strong>Perches, feeders and hedges only bridge.</strong> No dnsmasq, no odhcpd, no firewall, no Reticulum on them. On small ones (8 MB of flash, 64 MB of RAM, like the CPE510), no LuCI either.</li>
  <li><strong>No encrypted traffic on amateur radio bands.</strong> Layer 1 is always encrypted, so it never uses them.</li>
  <li><strong>Nothing outside.</strong> No public DNS, certificate authority or cloud for anything the mesh needs to run.</li>
</ul>
<h3 id="frugal"><span lang="en">Frugal</span></h3>
<p lang="en">Frugality is a design rule, not a budget line. A station that already exists beats a better one to buy.</p>
<ul lang="en">
  <li><strong>Use what's on the shelf.</strong> Any device that runs a role's standard software can fill that role. An old laptop makes a good nest: its battery is a free UPS.</li>
  <li><strong>Standardise the software, not the hardware.</strong> One software stack per role, so one guide and one list of pitfalls, whatever box it runs on.</li>
  <li><strong>The smallest thing that does the job.</strong> A bridge stays a bridge. No daemon, page or log that the role doesn't need.</li>
  <li><strong>Watts count.</strong> A station on a roof runs all year. Prefer low-power boards, and turn off radios and LEDs nobody uses.</li>
  <li><strong>Bytes count.</strong> Layer 1 assumes slow links: text first, a file fetched once and kept, nothing streamed.</li>
</ul>
<h3 id="law"><span lang="en">The law in France</span></h3>
<p class="note" lang="en">Not legal advice. This is what we found on 2026-11-13, to confirm with a lawyer or with the Fédération FDN, whose member associations already run community networks as declared operators.</p>
<ul lang="en">
  <li><strong>Tor is legal in France</strong>, to use and to relay. An exit relay is legal too, but its operator gets the abuse complaints and its servers can be seized: in 2017, <a href="https://next.ink/news/104398-wannacrypt-nud-tor-saisi-chez-firstheberg.htm">Tor relays hosted in France were seized</a> during the WannaCry investigation. Sparrows runs no exit, and no Tor at all.</li>
  <li><strong>Data retention.</strong> Anyone who offers the public a connection for online communication, even for free, is treated as an operator under <a href="https://www.cnil.fr/fr/fournir-un-acces-internet-public-quelles-obligations">article L34-1 of the CPCE</a> and must keep traffic data. That clashes head-on with "no logs".</li>
  <li><strong>Does it apply to Sparrows?</strong> Our reading: that duty is about access to online communication, meaning the Internet, and Sparrows gives none. But a standalone local network open to the public could still be an "electronic communications network open to the public" (article L33-1, operator status with ARCEP). Unknown, and decisive: it is the first legal question to settle, before the network opens beyond friends.</li>
  <li><strong>Encryption is free to use</strong> in France (LCEN 2004, article 30).</li>
  <li><strong>Radio:</strong> the power and channel rules above, and no encrypted traffic on amateur bands.</li>
</ul>
<h2 id="start"><span lang="en">Start here</span></h2>
<p lang="en">Three ways in. Pick yours: each one says which parts of this handbook to read. Questions, or want to start a village near you? Write to <a href="mailto:sparrows-network@riseup.net">sparrows-network@riseup.net</a>.</p>
<div class="cards">
  <div class="card">
    <h4><span lang="en">I want to use the network</span></h4>
    <ol lang="en">
      <li>Join the Wi-Fi named <code>Sparrows</code>. There is no password. The phone says "no Internet": that is normal, and mobile data keeps working.</li>
      <li>Install a Reticulum app: Sideband or Columba on Android, MeshChat on a computer. Take it from a neighbour or from the village's welcome page, and check its SHA-256 against the paper notice.</li>
      <li>In the app, turn on the local Wi-Fi interface (AutoInterface), then restart the app.</li>
      <li>Swap addresses with a neighbour by QR code and send a message. Choose the village nest as propagation node, so messages wait while you are away.</li>
    </ol>
    <p lang="en"><span class="k">Read</span><a href="#talk">Talking</a>, <a href="#layers">Two layers</a>. iPhone: no app we can recommend yet.</p>
  </div>
  <div class="card">
    <h4><span lang="en">I want to add a station</span></h4>
    <p lang="en">Use what is on the shelf. The role follows the hardware:</p>
    <ul lang="en">
      <li>an outdoor access point with two radios: a <a class="term" href="#g-hedge">hedge</a></li>
      <li>any other access point or old home router: a <a class="term" href="#g-feeder">feeder</a></li>
      <li>a directional 5 GHz radio on a mast: a <a class="term" href="#g-perch">perch</a></li>
      <li>a Raspberry Pi, mini PC or old laptop on a cable: a <a class="term" href="#g-nest">nest</a></li>
      <li>a small Linux box on the Wi-Fi: a <a href="#page-node">page node</a> or a <a class="term" href="#g-tree">tree</a></li>
    </ul>
    <p lang="en">Ask a village admin for the image of your device and role, flash it, plug it in. Nothing to set: the station names itself and builds its own address. Perch and hedge images hold the village's radio key, so they are handed over in person, never published.</p>
    <p lang="en"><span class="k">Read</span><a href="#roles">Role of each station</a>, <a href="#names">Names and addresses</a>, then the section of your role in <a href="#part-build">Part III</a>.</p>
  </div>
  <div class="card">
    <h4><span lang="en">I want to start a village</span></h4>
    <ol lang="en">
      <li>Read the <a href="#limits">hard rules</a> and <a href="#law">the law</a>.</li>
      <li>Download the scripts from the <a href="kit/">kit folder</a>, then build the images with your own SSH key and radio keys (<a href="#images">images</a>).</li>
      <li>Set up one <a href="#pi">nest</a> on a small switch.</li>
      <li>Cable one <a href="#hedge-image">hedge</a> to that switch: phones can join.</li>
      <li>Add hedges by air for the village core, and <a href="#perch-image">perches</a> for far sites.</li>
      <li>Add <a href="#reticulum">Reticulum</a> on the nest, then serve <a href="#welcome">this handbook</a> as the welcome page.</li>
      <li>Print the paper notice: app hash and village key hashes.</li>
    </ol>
    <p lang="en"><span class="k">You need</span>to be at ease in a Linux shell. Using the network needs none of that.</p>
  </div>
  <div class="card">
    <h4><span lang="en">This village</span> <span class="tag"><span lang="en">fill in before serving this page</span></span></h4>
    <p lang="en"><span class="k">Village</span>1, <code>fd7e:4c1a:9b20:1::/64</code></p>
    <p lang="en"><span class="k">App file and SHA-256</span>not filled in yet</p>
    <p lang="en"><span class="k">Propagation node</span>not filled in yet</p>
    <p lang="en"><span class="k">Village pages</span>not filled in yet</p>
    <p lang="en"><span class="k">Files and scripts</span><a href="kit/">kit/</a>, next to this page. Check each file against <code>SHA256SUMS</code></p>
    <p lang="en">This page arrives over plain HTTP on an open Wi-Fi, so anyone could alter it on the way. Trust these values only if they match the paper notice.</p>
  </div>
</div>
<h3 id="status"><span lang="en">Where things stand</span></h3>
<ul class="status">
  <li><span><span lang="en">Backbone in IPv6: 2 perches (CPE510), batman-adv on a 5 GHz AP + client link, channel 108; each perch reaches the other and the first nest (2026-11-14, with a per-node script, now retired)</span></span><span class="st ok" data-ui="ok">tested</span></li>
  <li><span><span lang="en">People's devices in IPv6 through a hedge: a Linux laptop and an Android phone get SLAAC addresses and DNS from the nest's RA. Android needed the router flag and a non-ULA prefix on the nest (<a href="#android">see why</a>); the phone shows "no Internet", as intended (2026-11-14)</span></span><span class="st ok" data-ui="ok">tested</span></li>
  <li><span><span lang="en">Captive-portal pop-up; iPhone and Windows; the prefix for real deployments</span></span><span class="st nt" data-ui="nt">not yet tested</span></li>
  <li><span><span lang="en">Reticulum on the first nest (a Pi 4): <code>rnsd</code> + <code>lxmd</code></span></span><span class="st nt" data-ui="nt">not yet tested</span></li>
  <li><span><span lang="en">Standard OpenWrt images for every role, nests included since 2026-11-21, with what each port and radio does shown before the build: one image per role, nothing to set per unit (2026-11-14: the hedge image runs on one EAP225-Outdoor v3, flashed from stock; the rest not yet)</span></span><span class="st nt" data-ui="nt">not yet tested</span></li>
  <li><span><span lang="en">Role chosen on the unit after flashing, signed updates carried by the mesh; OpenBSD as a second nest system; a private hub on a VPS linking villages; the project in git over Reticulum</span></span><span class="st idea" data-ui="idea">idea</span></li>
</ul>
<h2 id="part-network"><span lang="en">II. The network</span></h2>
<h3 id="schematic"><span lang="en">Schematic of one village</span></h3>
<figure>
<div class="plate">
<p><em>The schematic is in tao/index.html.</em></p>
</div>
<figcaption id="net-cap">
  <span lang="en">At each site, the feeder, the perch and the nest plug into the same switch. The perches are bridges and carry that switch across the flyway, so the whole village is one Ethernet segment: every station and every device sees every other. Nests are the only stations that send router advertisements, and they are equal peers. Keys live on people's own devices, never on a station. Hardware names are examples.</span>
</figcaption>
</figure>
<ul class="legend">
  <li><span class="sw bus"></span><span><span lang="en">Switch at a site, with an Ethernet cable to each station: feeder, perch and nest share it</span></span></li>
  <li><span class="sw"></span><span><span lang="en">Other cable (USB)</span></span></li>
  <li><span class="sw r"></span><span><span lang="en">Radio link. Between perches, a flyway: hidden, SAE-encrypted, carries batman-adv. From a feeder: open</span></span></li>
  <li><span class="sw ky"></span><span><span lang="en">Peers syncing over Layer 1 (Reticulum), through the same segment</span></span></li>
  <li><span class="sw b0"></span><span><span lang="en">Layer 0, the on-ramp</span></span></li>
  <li><span class="sw b1"></span><span><span lang="en">Layer 1, key-addressed</span></span></li>
  <li><span class="sw bx"></span><span><span lang="en">Planned, not built yet</span></span></li>
  <li><span class="sw x"></span><span><span lang="en">Admin link outside the network: nothing is forwarded</span></span></li>
</ul>
<p lang="en">Not drawn: a <a class="term" href="#g-hedge">hedge</a> takes the place of a feeder and needs no perch beside it. Hedges link to each other by radio on 2.4 GHz, and one of them is cabled to a site switch to join the rest of the village.</p>
<h3 id="roles"><span lang="en">Role of each station</span></h3>
<p lang="en">A station is named by what it does. The hardware in each card is only an example: anything that runs the role's standard software can take the role.</p>
<div class="cards">
  <div class="card">
    <h4><span lang="en">User device</span> <span class="tag"><span lang="en">not a station</span></span></h4>
    <p lang="en">Holds its owner's key in an app: Sideband on Android, MeshChat or Nomad Network on a laptop. Builds its own IPv6 address. A laptop left on can also relay for others, and then it is a tree too. A small box left on can also publish its owner's pages (<a href="#page-node">a neighbour's page node</a>).</p>
    <p lang="en"><span class="k">Never</span>sends router advertisements.</p>
  </div>
  <div class="card">
    <h4><span lang="en">Feeder</span> <span class="tag"><span lang="en">access</span></span> <span class="st nt" data-ui="nt">not yet tested</span></h4>
    <p lang="en">The door of the neighbourhood: an open Wi-Fi, <code>Sparrows</code>, bridged to the village segment. It only bridges: no RA, no DHCP, no firewall, no Reticulum.</p>
    <p lang="en"><span class="k">Examples</span>EAP225-Outdoor with the feeder image; an old home router in access-point mode with its DHCP off.</p>
  </div>
  <div class="card">
    <h4><span lang="en">Perch</span> <span class="tag"><span lang="en">backbone</span></span> <span class="st nt" data-ui="nt">not yet tested</span></h4>
    <p lang="en">A radio station on a mast, at one end of a flyway. On outdoor 5 GHz each flyway has one perch in AP role, which beacons and carries the radar duty (60 s of listening before it transmits), and one or more in client role, which only transmit after hearing their AP. Both roles are layer-2 bridges running batman-adv: neither is a router.</p>
    <p lang="en">With the perch image, every unit boots as a client, and one command, <code>perch ap</code>, makes it the AP of its flyway. The flyway itself ran in IPv6 on 2026-11-14 with a per-node script that fixed each unit's name and address. That script is retired (2026-11-15); the image, with the same radio settings, is not yet tested.</p>
    <p lang="en"><span class="k">Example</span>TP-Link CPE510: 8 MB of flash, 64 MB of RAM, 13 dBi antenna.</p>
  </div>
  <div class="card">
    <h4><span lang="en">Hedge</span> <span class="tag"><span lang="en">access + backbone</span></span> <span class="st nt" data-ui="nt">not yet tested</span></h4>
    <p lang="en">A feeder and a perch in one box, for a station with two radios. One radio serves the open <code>Sparrows</code> Wi-Fi; the other links to the neighbouring hedges in an 802.11s mesh on 2.4 GHz that carries batman-adv. No AP or client to choose: every hedge on the same channel finds the others, so the village core grows by adding one. Bridge only, like the others.</p>
    <p lang="en"><span class="k">So far</span>one EAP225-Outdoor v3 runs the hedge image, cabled to the nest's switch, and a laptop and a phone joined the village through its open Wi-Fi (2026-11-14). Two hedges meshing over the air: not yet tested.</p>
    <p lang="en"><span class="k">Cost</span>omni antennas: a few hundred metres between hedges, and throughput roughly halves at each hop. Flyways between villages still need directional perches.</p>
    <p lang="en"><span class="k">Example</span>EAP225-Outdoor with the hedge image (<a href="#hedge-image">Part III</a>).</p>
  </div>
  <div class="card">
    <h4><span lang="en">Nest</span> <span class="tag"><span lang="en">peer</span></span> <span class="st nt" data-ui="nt">not yet tested</span></h4>
    <p lang="en"><span class="k c0">Layer 0</span>Router advertisements (prefix + DNS server), catch-all DNS, one static welcome page.</p>
    <p lang="en"><span class="k c1">Layer 1</span><code>rnsd</code> as a relay, <code>lxmd</code> holding messages for people who are offline, and on a store nest the file store.</p>
    <p lang="en">"Router" here only means "the one that sends RAs": a nest forwards no packet. Every nest serves the same on-ramp. None is "the" server.</p>
    <p lang="en"><span class="k">Examples</span>store nest: Pi 4 or 5 with an SSD, a mini PC, an old laptop. Light nest: Pi Zero 2 W with a USB Ethernet adapter. The original Pi Zero (ARMv6) is too old.</p>
  </div>
  <div class="card" id="role-tree">
    <h4><span lang="en">Tree</span> <span class="tag"><span lang="en">relay</span></span> <span class="st idea" data-ui="idea">idea</span></h4>
    <p lang="en">A relay and nothing else: <code>rnsd</code> with transport on, and <code>lxmd</code> if it has room. No RA, no on-ramp. It joins like a user device, on the open Wi-Fi, so anyone can add one anywhere. Where two media meet (Wi-Fi and LoRa, say), a tree or a nest holds one interface on each and relays between them.</p>
    <p lang="en"><span class="k">Examples</span>any Linux machine or laptop left on.</p>
  </div>
  <div class="card">
    <h4><span lang="en">Home box</span> <span class="tag"><span lang="en">outside</span></span></h4>
    <p lang="en">Not part of the network. Today the first nest's Wi-Fi joins it for admin SSH and package updates. Nothing passes between the two sides, and no perch, feeder or hedge is ever plugged into it.</p>
  </div>
</div>
<h3 id="standard"><span lang="en">Standard software, any hardware</span></h3>
<p lang="en">One software stack per role: one guide, one list of pitfalls, one way to update. The hardware is whatever is on the shelf, as long as it runs that stack. The minimums are indicative, not measured.</p>
<div class="tw"><table>
  <thead><tr>
    <th><span lang="en">Role</span></th>
    <th><span lang="en">Standard software</span></th>
    <th><span lang="en">Fits, for example</span></th>
    <th><span lang="en">At least</span></th></tr></thead>
  <tbody>
  <tr><th><span lang="en">User device</span></th>
    <td><span lang="en">Sideband or Columba (Android), MeshChat (Linux, Windows, macOS), Nomad Network (terminal); any browser for the on-ramp</span></td>
    <td><span lang="en">phones, laptops</span></td><td>—</td></tr>
  <tr><th><span lang="en">Feeder</span></th>
    <td><span lang="en">OpenWrt 25.12 + the feeder image. Accepted: stock firmware in access-point mode, DHCP off, checked with <code>rdisc6</code> to send no RA</span></td>
    <td><span lang="en">EAP225-Outdoor, old home router</span></td>
    <td><span lang="en">any access point</span></td></tr>
  <tr><th><span lang="en">Perch</span></th>
    <td><span lang="en">OpenWrt 25.12 + batman-adv + the perch image (the flyway ran on 2026-11-14 with the retired per-node script)</span></td>
    <td><span lang="en">CPE510, any OpenWrt device with the right radio</span></td>
    <td><span lang="en">8 MB flash, 64 MB RAM</span></td></tr>
  <tr><th><span lang="en">Hedge</span></th>
    <td><span lang="en">OpenWrt 25.12 + batman-adv + the hedge image</span></td>
    <td><span lang="en">EAP225-Outdoor, any OpenWrt device with two radios and 802.11s</span></td>
    <td><span lang="en">two radios, 16 MB flash</span></td></tr>
  <tr><th><span lang="en">Nest</span></th>
    <td><span lang="en">Moving to OpenWrt with the nest image (decided 2026-11-21, not yet tested). Today: Debian 13 family (Debian, Raspberry Pi OS…) + the nest config; Reticulum, LXMF and a Nomad Network page node with Retipedia, pinned, in a venv. OpenBSD as a second system is an idea (Part IV)</span></td>
    <td><span lang="en">Pi 4 or 5, Pi Zero 2 W, mini PC, old laptop</span></td>
    <td><span lang="en">arm64 or x86_64, 512 MB RAM; an SSD for a store nest</span></td></tr>
  <tr><th><span lang="en">Tree</span></th>
    <td><span lang="en">Reticulum: <code>rnsd</code> with transport on</span></td>
    <td><span lang="en">any Linux machine, a laptop</span></td><td>—</td></tr>
  <tr><th><span lang="en">Page node</span></th>
    <td><span lang="en">Reticulum + Nomad Network in node mode, in a venv (<a href="#page-node">Part III</a>)</span></td>
    <td><span lang="en">Pi Zero 2 W, any Linux machine left on</span></td>
    <td><span lang="en">512 MB RAM</span></td></tr>
  <tr><th><span lang="en">LoRa radio</span></th>
    <td><span lang="en">RNode firmware, plugged into a nest or a tree</span></td>
    <td><span lang="en">ESP32 LoRa boards</span></td><td>—</td></tr>
  </tbody>
</table></div>
<h3 id="flyways"><span lang="en">Flyways: any medium</span></h3>
<p lang="en">A flyway is any link between two places, and the design depends on no single band. batman-adv carries a village over any Wi-Fi or Ethernet link. Reticulum carries Layer 1 over almost anything, including links far too slow for IP. The on-ramp (Layer 0) only exists where people's devices connect, so slow flyways only ever carry Layer 1.</p>
<div class="tw"><table>
  <thead><tr>
    <th><span lang="en">Medium</span></th>
    <th><span lang="en">Licence-free in France</span></th>
    <th><span lang="en">Rate and reach</span></th>
    <th><span lang="en">Carries</span></th></tr></thead>
  <tbody>
  <tr><th><span lang="en">5 GHz Wi-Fi, ch 100–140</span></th>
    <td><span lang="en">yes: DFS, 30 dBm EIRP, never 120–128</span></td>
    <td><span lang="en">tens of Mbit/s; 1–15 km with directional antennas</span></td>
    <td><span lang="en">both layers (today's backbone)</span></td></tr>
  <tr><th><span lang="en">2.4 GHz Wi-Fi</span></th>
    <td><span lang="en">yes: 20 dBm EIRP</span></td>
    <td><span lang="en">a few Mbit/s; a few hundred metres with omni antennas</span></td>
    <td><span lang="en">both layers; 802.11s allowed here (between hedges)</span></td></tr>
  <tr><th>60 GHz</th>
    <td><span lang="en">yes, conditions to check</span></td>
    <td><span lang="en">up to Gbit/s; about 1 km in clear line of sight, rain fades it</span></td>
    <td><span lang="en">both layers, for busy flyways</span></td></tr>
  <tr><th>LoRa 868 MHz</th>
    <td><span lang="en">yes: 25 mW at 1 % duty cycle, or 500 mW at 10 % on 869.4–869.65 MHz</span></td>
    <td><span lang="en">about 1 to 20 kbit/s; several km</span></td>
    <td><span lang="en">Layer 1 only: messages, not files</span></td></tr>
  <tr><th><span lang="en">Ethernet, fibre</span></th>
    <td>—</td><td><span lang="en">high</span></td>
    <td><span lang="en">both layers</span></td></tr>
  <tr><th><span lang="en">Amateur bands</span></th>
    <td><span lang="en">no: licence, and encryption forbidden</span></td>
    <td>—</td>
    <td><span lang="en">not usable: Layer 1 is always encrypted</span></td></tr>
  <tr><th><span lang="en">A disk carried by hand</span></th>
    <td>—</td>
    <td><span lang="en">days, but a whole disk at once</span></td>
    <td><span lang="en">Layer 1 store-and-forward</span></td></tr>
  </tbody>
</table></div>
<p class="meta" lang="en">Radio rules change. Check the current ARCEP and ETSI rules before buying a radio.</p>
<h3 id="segment"><span lang="en">One village, one segment</span></h3>
<p lang="en">Perches, feeders, hedges and nests of a village are all on the same network. Each perch and each hedge bridges its Ethernet port with batman-adv, so together they act as one big switch, and anything cabled to them, directly or through a switch, joins it. That is why one RA from a nest reaches every device in the village, and why Reticulum finds its peers with no configuration.</p>
<ul lang="en">
  <li><strong>At a site, use a switch.</strong> A CPE510 and an EAP225-Outdoor each have a single Ethernet port, which also powers them. Each PoE injector's LAN port goes to a small switch, and the nest plugs into the same switch. Any old unmanaged switch will do. An old home router used as a feeder can stand in for the switch: use its LAN ports, never its WAN port.</li>
  <li><strong>Anything on that switch is on the village network.</strong> A laptop plugged in gets its address from the nests, like a phone on the Wi-Fi.</li>
  <li><strong>One LAN, end to end.</strong> A phone on a hedge at one end of the village and a laptop on a feeder behind a distant perch are in the same broadcast domain. Both build an address in the village /64 from the nests' RAs and reach each other directly by neighbour discovery: no router between them, and batman-adv picks the radio path underneath. The cost: the open Wi-Fi is like a big café Wi-Fi, where every device can see the others at IP level (link-local, mDNS). Layer 1 encrypts what people say, not the fact that a device is there. And broadcast and multicast load grows with the village: one more reason for one segment per village.</li>
  <li><strong>Never two paths, unless batman-adv knows.</strong> A cable between two sites that are also linked by radio, two perches on the same switch, or a hedge cabled to a switch that also holds a perch, make a loop, and a loop floods the whole village. batman-adv can detect loops through bridges (bridge loop avoidance), if it is on in every batman node. The perch and hedge images turn it on. Check with <code>batctl bl</code>. <span class="st nt" data-ui="nt">not yet tested</span></li>
  <li><strong>Between villages, one segment each.</strong> Proposal for Phase 3, not decided: each village keeps its own segment and /64. A flyway between two villages is a small segment of its own, and a nest or tree at each end holds an interface on it and relays at Layer 1 only. No IP routing between villages, and each village's broadcasts stay at home.</li>
</ul>
<h3 id="names"><span lang="en">Names and addresses: nothing to set per unit</span></h3>
<p lang="en">Every station of a role runs the same image, and still each one has its own name and its own address, because both come from the MAC address printed on its sticker. Decided on 2026-11-15: no station has a fixed, hand-chosen name or address any more, perches included. It serves "works for amateurs" (flash, plug, done) and line I (no list that someone must keep).</p>
<div class="tw"><table>
  <thead><tr>
    <th></th>
    <th><span lang="en">Rule</span></th>
    <th><span lang="en">Example, MAC <code>1C-61-B4-BD-26-DE</code></span></th></tr></thead>
  <tbody>
  <tr><th><span lang="en">Name</span></th>
    <td><span lang="en">role + last 4 hex digits of the MAC</span></td>
    <td><code>hedge-26de</code>, <code>perch-3fa2</code>, <code>feeder-91c0</code>, <code>nest-7a10</code></td></tr>
  <tr><th><span lang="en">Link-local address</span></th>
    <td><span lang="en"><code>fe80::</code> + the MAC with <code>ff:fe</code> in the middle and one bit flipped. Always there, with no nest</span></td>
    <td><code>fe80::1e61:b4ff:febd:26de</code></td></tr>
  <tr><th><span lang="en">Village address</span></th>
    <td><span lang="en">the village prefix from the nests' RAs + the same ending</span></td>
    <td><code>fd7e:4c1a:9b20:1:1e61:b4ff:febd:26de</code></td></tr>
  </tbody>
</table></div>
<div class="code"><div class="hd"><span class="file">find a station and log in</span></div><pre><code># The MAC is on the sticker:  1C-61-B4-BD-26-DE
#   name         hedge-26de                               role + last 4 hex digits of the MAC
#   link-local   fe80::1e61:b4ff:febd:26de                always there, even with no nest running
#   village      fd7e:4c1a:9b20:1:1e61:b4ff:febd:26de     once a nest sends RAs
# Rule: flip the second-lowest bit of the first byte (1c -&gt; 1e) and put ff:fe in the middle.
&#32;
# Every station on the cable or Wi-Fi you are on, with its MAC
ping -6 -c2 ff02::1%eth0; ip -6 neigh show dev eth0
# By link-local, from the same segment (give your own interface after the %)
ssh root@fe80::1e61:b4ff:febd:26de%eth0
# By its village address, from anywhere in the village
ssh root@fd7e:4c1a:9b20:1:1e61:b4ff:febd:26de
uci get system.@system[0].hostname      # hedge-26de</code></pre></div>
<ul lang="en">
  <li><strong>Read the sticker, know the station.</strong> Name and address can be worked out on paper before the unit is even powered. Write the name on the box.</li>
  <li><strong>Moving a station changes nothing.</strong> In another village it keeps its name and its ending, and takes that village's prefix.</li>
  <li><strong>Nests, today's exception.</strong> A nest is named <code>nest-xxxx</code> like the others, but still holds a short static address (<code>::1</code>, <code>::2</code>): the DNS server announced in the RA and the catch-all point at it. The <a href="#ideas">zero-config nest</a> removes that exception. <span class="st nt" data-ui="nt">not yet tested</span></li>
  <li><strong>User devices</strong> choose their own ending, often a random one that changes. That is their business: nothing in the network depends on it.</li>
</ul>
<h3 id="talk"><span lang="en">Talking: messages, groups, calls</span></h3>
<p lang="en">Everything people say to each other goes over Layer 1: encrypted end to end and addressed to keys. The apps all speak LXMF, so they understand each other whatever each person uses. Nothing is streamed: voice uses narrow codecs that also fit slow flyways.</p>
<div class="tw"><table>
  <thead><tr>
    <th><span lang="en">Need</span></th>
    <th><span lang="en">Tool</span></th>
    <th><span lang="en">Runs on</span></th>
    <th><span lang="en">Status</span></th></tr></thead>
  <tbody>
  <tr><th><span lang="en">Messages, photos, files, voice notes; delivered later if the person is away</span></th>
    <td><span lang="en">LXMF: Sideband (Android, desktop), Columba (Android), MeshChat (desktop), Nomad Network (terminal)</span></td>
    <td><span lang="en">user devices; <code>lxmd</code> on nests keeps messages for absent people</span></td>
    <td><span class="st nt" data-ui="nt">not yet tested</span></td></tr>
  <tr><th><span lang="en">Voice calls, one to one</span></th>
    <td><span lang="en">LXST: Sideband, Columba, MeshChatX</span></td>
    <td><span lang="en">user devices</span></td>
    <td><span class="st nt" data-ui="nt">not yet tested</span></td></tr>
  <tr><th><span lang="en">Group text chat</span></th>
    <td><span lang="en">a group chat service (for example reticulum-group-chat): one small program per group, joined by its key hash</span></td>
    <td><span lang="en">a member's laptop or tree</span></td>
    <td><span class="st idea" data-ui="idea">idea</span></td></tr>
  <tr><th><span lang="en">Group voice rooms</span></th>
    <td><span lang="en">Partyline: rooms like Mumble, Opus on fast links, Codec2 down to 700 bit/s on slow ones</span></td>
    <td><span lang="en">a member's laptop or tree</span></td>
    <td><span class="st idea" data-ui="idea">idea</span></td></tr>
  <tr><th><span lang="en">Village board, forum, pages</span></th>
    <td><span lang="en">Nomad Network pages (forum and board programs exist)</span></td>
    <td><span lang="en">the page node on a nest, or a neighbour's own (<a href="#page-node">Pi Zero 2 W</a>)</span></td>
    <td><span class="st nt" data-ui="nt">not yet tested</span></td></tr>
  <tr><th>Wikipedia</th>
    <td>Retipedia</td>
    <td><span lang="en">a store nest</span></td>
    <td><a href="#wikipedia"><span lang="en">Part IV</span></a></td></tr>
  </tbody>
</table></div>
<p class="note" lang="en">A group service has to decrypt each message to pass it on to the members, so whoever runs it can read that group. So a group runs its own service, on one member's machine, and never on a nest "for everyone". Video is left out on purpose: no streaming. Android is covered; the iPhone is still open.</p>
<h3 id="ipv6"><span lang="en">IPv6 without DHCP</span></h3>
<p lang="en">IPv4 needs DHCP because its addresses are scarce: something has to hand them out and remember who holds which. An IPv6 link has 2<sup>64</sup> addresses, so each device picks its own.</p>
<ol lang="en">
  <li><strong>Link-local first.</strong> Every interface makes an <code>fe80::</code> address on its own, with no router at all. That is the recovery path.</li>
  <li><strong>The device asks</strong> the link whether a router is there (router solicitation).</li>
  <li><strong>A nest answers</strong> with a router advertisement: the village prefix, and the DNS server (RDNSS).</li>
  <li><strong>The device builds its address:</strong> the prefix plus 64 bits of its own.</li>
  <li><strong>It checks</strong> that nobody else is using it (duplicate address detection).</li>
</ol>
<p lang="en">Nothing keeps a list of who has which address: there is nothing to lose, to sync between two nests, or to log. Android never speaks DHCPv6 and takes its DNS only from the RA, so this is also the one way that covers every phone.</p>
<h4 id="android"><span lang="en">What an Android phone needs before it stays</span> <span class="st ok" data-ui="ok">tested</span></h4>
<p lang="en">A laptop is happy with any address. Android is not: on a Wi-Fi with no IPv4, it keeps the network only if it gets, all at once, an address it counts as global, a default router, and a DNS server. Two of these failed on the bench on 2026-11-14, and each had its own symptom.</p>
<ul lang="en">
  <li><strong>"Obtaining IP address" forever:</strong> Android doesn't count a ULA address (<code>fd…</code>) as global, so a ULA-only network never counts as set up. Some versions also drop a ULA DNS server. Fix: the nest announces a second, non-ULA prefix next to the ULA, and lists its address in that prefix first as DNS server. On the bench that prefix is <code>2001:db8:1::/64</code>, the range reserved for documentation, which belongs to nobody and must never go on a roof.</li>
  <li><strong>"IP configuration failure" after half a second:</strong> Android checks its default router, and a nest with forwarding off answers that check without the router flag. Android then removes the default route and leaves. Fix: <code>net.ipv6.conf.eth0.forwarding=1</code> on the nest. The kernel then sets the router flag on that interface, while <code>all.forwarding=0</code> and the nftables <code>forward</code> drop still forward nothing.</li>
  <li><strong>Result:</strong> "connected / no Internet", which is what we want. The phone keeps using 4G for the Internet.</li>
</ul>
<p class="note" lang="en">Open: which non-ULA prefix for real villages. A /64 from a VPS would work for village 1, but every phone would then carry an address that points to one person's contract and name (P5), and the village would depend on that contract (line IV). A /48 held by the project, from a LIR or a sponsoring association and never routed to the Internet, fits the address plan: one /64 per village, next to the ULA. Not decided.</p>
<h4><span lang="en">With no nest at all</span></h4>
<ul lang="en">
  <li><strong>Still works:</strong> the backbone (layer 2, no IP involved), link-local addresses across the whole mesh, so every station stays reachable for admin.</li>
  <li><strong>Should still work:</strong> Reticulum between devices, since its peer discovery uses link-local multicast. <span class="st nt" data-ui="nt">not yet tested</span></li>
  <li><strong>Stops:</strong> new addresses and DNS, so the welcome page and the captive portal. Addresses already built expire with the RA lifetimes.</li>
  <li><strong>Likely:</strong> an Android phone leaves a Wi-Fi that gives it no RA, since it then has no global address and no router (see above). <span class="st nt" data-ui="nt">not yet tested</span></li>
</ul>
<h4><span lang="en">Address plan</span></h4>
<div class="tw"><table>
  <tbody>
  <tr><td><code>fd7e:4c1a:9b20::/48</code></td><td><span lang="en">The whole network (ULA, chosen 2026-11-11): infrastructure, admin, Reticulum</span></td></tr>
  <tr><td><code>fd7e:4c1a:9b20:1::/64</code></td><td><span lang="en">Village 1. One /64 per village: <code>:2::</code>, <code>:3::</code>…</span></td></tr>
  <tr><td><code>…:1::1</code>, <code>…:1::2</code></td><td><span lang="en">First nest, second nest: static for now (<a href="#names">see why</a>). The range <code>::1</code> to <code>::ff</code> is kept for nests</span></td></tr>
  <tr><td><code>…:1::99</code></td><td><span lang="en">Admin laptop on the bench (never <code>::2</code>: it belongs to the second nest)</span></td></tr>
  <tr><td>SLAAC</td><td><span lang="en">Every perch, feeder and hedge: the prefix + an ending built from the MAC on the sticker (<a href="#names">see how</a>). User devices: the prefix + an ending they choose</span></td></tr>
  <tr><td><code>2001:db8:1::/64</code></td><td><span lang="en">Bench only: the non-ULA prefix Android needs (<a href="#android">see above</a>), first nest at <code>::1</code>. Documentation range: never on a roof</span></td></tr>
  <tr><td><span lang="en">not decided</span></td><td><span lang="en">The non-ULA prefix for real villages: one /64 per village, next to the ULA</span></td></tr>
  </tbody>
</table></div>
<h2 id="part-build"><span lang="en">III. How to build it</span></h2>
<p lang="en">Each section below is a worked example of one role on one piece of hardware. Other hardware takes the same role if it runs the same standard software. Commands and config files are the same in every language, so they appear once. Comments inside them stay in English.</p>
<p lang="en">The scripts are separate files that travel with this handbook: <code>sparrows-openwrt/</code> builds the station images (<code>build.sh</code>, <code>profiles.txt</code>, <code>uses.txt</code>, one first-boot file for every role) and <code>tao/</code> builds this page (<code>build.py</code>). They are printed here in full, straight from those files, so they can be read before they are run. Download them from the <a href="kit/">kit folder</a> next to this page (<a href="#kit">how it is made</a>).</p>
<h3 id="images"><span lang="en">Station images: perch, feeder, hedge, tree, nest</span> <span class="st nt" data-ui="nt">not yet tested</span></h3>
<p lang="en">One build tree, <code>sparrows-openwrt</code>, makes one image per role and per device with the OpenWrt Image Builder. Every unit of a role gets the same image: nothing to set per unit. Written on 2026-11-13, hedge added on 2026-11-14, tree on 2026-11-19. So far the hedge image has run on one EAP225-Outdoor v3, flashed from stock firmware 5.1.0: it boots, takes SSH keys over link-local, brings up both radios and the mesh interface, passes the radar check, and lets a laptop and a phone into the village (2026-11-14). The perch, feeder and tree images have not run on a device yet.</p>
<ul lang="en">
  <li><strong>Name:</strong> each unit names itself after its role and the end of its MAC, for example <code>perch-3fa2</code>, <code>feeder-91c0</code> or <code>hedge-07be</code>. A unit with two roles takes both names: <code>nest-feeder-26de</code>.</li>
  <li><strong>Address:</strong> SLAAC from the nests' RAs, built from the MAC on the sticker, plus link-local. The unit receives RAs and never sends any. A nest sets the same address itself, from the same MAC, and sends the RAs.</li>
  <li><strong>Admin:</strong> SSH keys only, root password locked. Failsafe mode still works for recovery.</li>
  <li><strong>Never:</strong> IPv4, DHCP, a firewall, a link to the Internet. RAs only from a nest. This part is shared by every role. Reticulum only where the role asks for it: tree and nest.</li>
  <li><strong>Secrets:</strong> an image with a 5 GHz flyway (perch) carries the flyway key, one with a 2.4 GHz flyway (hedge) the hedge key. <code>build.sh</code> refuses a key that isn't one line of 8 to 63 printable ASCII characters.</li>
  <li><strong>Other hardware:</strong> one line in <code>profiles.txt</code>, with the power to set at the radio on each band: the legal EIRP minus the antenna gain. The build menu can write that line: <code>n</code>, then the target from the device's OpenWrt page, part of the model name, the role and the two powers. The line is marked "not yet tested" until the device has run on the bench. A device that needs more than a line (another OpenWrt profile, firmware to fetch, its own first-boot file) gets a folder in <code>devices/</code>, like the <a href="#zero">Pi Zero 2 W</a>.</li>
</ul>
<h4 id="uses"><span lang="en">What each port and radio does</span> <span class="st nt" data-ui="nt">not yet tested</span></h4>
<p lang="en">Decided on 2026-11-21. A role is a preset of uses, one per interface, written in <code>uses.txt</code>. One first-boot file, <code>90-sparrows-station</code>, reads them and sets up every role; it replaces the four per-role files, with the same radio settings. The uses:</p>
<ul lang="en">
  <li><a class="term" href="#g-wire">wire</a>: the Ethernet ports, a cable to the site's switch, part of the village segment.</li>
  <li><a class="term" href="#g-feeder">feeder</a>: an access point of the open <code>Sparrows</code> Wi-Fi.</li>
  <li><a class="term" href="#g-flyway">flyway</a>: a radio link to other stations carrying batman-adv. On 5 GHz, AP + client as on a perch; on 2.4 GHz, the 802.11s mesh of the hedges.</li>
  <li><a class="term" href="#g-join">join</a>: a client of the <code>Sparrows</code> Wi-Fi, like a phone. Never bridged.</li>
  <li><strong>off</strong>, and two services: <code>reticulum</code> (a tree) and <code>nest</code>.</li>
</ul>
<p lang="en">Roles add up on one unit when it has the room: <code>tree+feeder</code> or <code>nest+feeder</code> in the role column of <code>profiles.txt</code> takes the uses of both. A radio that would both join and serve doesn't join, and a nest never joins. A device that needs something else gets a manual line, <code>uses=wire,feeder,flyway,-</code> (ports, 2.4 GHz, 5 GHz, services), written by the menu: <code>n</code>, then <code>m</code>. The build refuses what can't work and says why, before downloading anything: a use the chip can't do (no mesh on a Pi's Wi-Fi, from <code>devices/*/device.conf</code>), a flyway and a feeder on one 5 GHz radio (two channels), a unit left with nothing to do. Before building it prints what each port and radio will do; <code>./build.sh uses</code> prints only that. Tried on 2026-11-21 against a stand-in Image Builder and a stand-in <code>uci</code>: each role gets the same settings as with its old file. Not yet run on a unit.</p>
<div class="code"><div class="hd"><span class="file">uses.txt</span></div><pre><code># Sparrows-Network: what each port and radio of a station does, by role. Read by build.sh.
# A role is a preset of uses, one per interface. To change what a role does, change its line here.
#
# Uses of a port or a radio:
#   wire     the Ethernet ports: a cable to the site's switch, part of the village segment (bridged)
#   feeder   an access point of the open "Sparrows" Wi-Fi, for people's devices (bridged)
#   flyway   a radio link to other stations, carrying batman-adv (bridged):
#              5 GHz   AP + client, hidden, SAE (secrets/flyway.key), ch 108; `perch ap` picks the AP
#              2.4 GHz 802.11s mesh to the other units on the same channel, SAE (secrets/hedge.key), ch 1
#   join     a client of the "Sparrows" Wi-Fi, like a phone. Never bridged: nothing hangs behind it
#   off      not used
#   Several uses on one radio: joined with +, e.g. flyway+feeder
# Services:
#   reticulum  rnsd with transport + the Sparrows page (Nomad Network). Needs room: SD-card devices
#   nest       Reticulum, plus RAs (odhcpd), DNS (dnsmasq, no DHCP), the welcome page (uhttpd) and
#              the message store (lxmd), on a fixed village address from the MAC. The only unit that
#              sends RAs. Never joins: its radios serve
#   -          none
#
# Roles add up on one unit: tree+feeder takes the uses of both. When a radio would both join and do
# something else, it doesn't join: Reticulum then runs on the village bridge (wire + feeders).
# Only one radio joins: when both would, the 2.4 GHz one does and the 5 GHz one is off.
# One 5 GHz radio can't hold a flyway and a feeder (two channels): the build refuses it.
# What a device's radios can't do (no mesh on a Pi's Wi-Fi, say) is in devices/&lt;it&gt;/device.conf.
# A band set to - in profiles.txt is off whatever the role says.
#
# role    ports  2.4GHz         5GHz     services
perch     wire   off            flyway   -
feeder    wire   feeder         feeder   -
hedge     wire   flyway+feeder  feeder   -
tree      wire   join           join     reticulum
nest      wire   off            off      nest</code></pre></div>
<div class="code"><div class="hd"><span class="file">station/files/etc/uci-defaults/90-sparrows-station</span></div><pre><code>#!/bin/sh
# Sparrows-Network: what each port and radio of this station does. One file for every role.
# build.sh writes the uses in /etc/sparrows/station, from uses.txt (or a manual line of profiles.txt):
#   PORTS = wire | off              USE2, USE5 = uses of the 2.4 / 5 GHz radio: off, or a list of
#   RETICULUM, NEST = 1 | 0         feeder (open Wi-Fi), flyway (batman-adv link), join (Wi-Fi client)
# Bridge only: no IPv4, no DHCP, no RA, no firewall (base in 10-sparrows-common). A nest adds its
# services after this file (91-sparrows-nest).
# Runs once at first boot (and again after `firstboot &amp;&amp; reboot`).
# Status: NOT YET TESTED. Replaces the per-role files (2026-11-21), with the same radio settings.
&#32;
. /etc/sparrows/station
&#32;
SSID='Sparrows'                  # the open Wi-Fi, for people's devices
FLYWAY_SSID='wifilibre-link'     # 5 GHz flyway: same as the running one, so new perches join it
FLYWAY_CH='108'                  # outdoor FR: 100-140 (DFS), never 120-128 (weather radar)
MESH_ID='sparrows-hedge'         # 2.4 GHz flyway: same on every unit of the village
MESH_CH='1'                      # fixed, same on every unit (a mesh can't use ACS): 1, 6 or 11
FEED_CH2="${CH2:-auto}"          # 2.4 GHz feeder alone: ACS, unless the device sets one (no ACS)
FEED_CH5='132'                   # 5 GHz feeder: outdoor DFS, VHT40 = 132+136. Far from 108
&#32;
has() { case " $1 " in *" $2 "*) return 0 ;; esac; return 1; }
ALL="$USE2 $USE5"
&#32;
# A radio key: 8-63 printable ASCII, or SAE never links (seen on the flyway 2026-11-14, Pitfalls).
# build.sh already refuses a bad key; this only catches a hand-edited one.
key() {
	chmod 600 "/etc/sparrows/$1"
	K=$(cat "/etc/sparrows/$1")
	printf '%s' "$K" | LC_ALL=C grep -qxE '[ -~]{8,63}' || \
		logger -p daemon.err -t sparrows "$1 is not 8-63 printable ASCII: this flyway will not link"
	printf '%s' "$K"
}
&#32;
# --- Ports: wire = in the village bridge (the image's default); off = out of it ---
BR=$(uci show network | sed -n "s/^network\.\([^.]*\)\.name='br-lan'$/\1/p")
[ "$PORTS" != off ] || uci -q delete network.$BR.ports
&#32;
# --- Flyway: batman-adv, bridged with the rest in br-lan ---
if has "$ALL" flyway; then
	uci set network.bat0=interface
	uci set network.bat0.proto='batadv'
	uci set network.bat0.routing_algo='BATMAN_IV'
	uci set network.bat0.bridge_loop_avoidance='1'   # a site switch with 2 batman nodes = two paths;
	                                                 # BLA must be on all of them
	uci set network.mesh0=interface
	uci set network.mesh0.proto='batadv_hardif'
	uci set network.mesh0.master='bat0'
	uci set network.mesh0.mtu='1536'                 # batman header, avoids fragmentation
	uci -q del_list network.$BR.ports='bat0'
	uci add_list network.$BR.ports='bat0'
fi
&#32;
# --- Join: the Wi-Fi client is an interface of its own, address by SLAAC from the nests' RAs ---
if has "$ALL" join; then
	uci set network.wsta=interface
	uci set network.wsta.proto='dhcpv6'
	uci set network.wsta.reqaddress='none'
	uci set network.wsta.reqprefix='no'
fi
uci commit network
&#32;
# --- Radios: the first radio of each band takes that band's uses, any other is off ---
[ -s /etc/config/wireless ] || wifi config
DONE=''
for r in $(uci show wireless | sed -n 's/^wireless\.\([^.=]*\)=wifi-device$/\1/p'); do
	uci -q delete wireless.default_$r
	B=$(uci -q get wireless.$r.band)
	case "$B" in
		2g) U=$USE2; TX=$TX2 ;;
		5g) U=$USE5; TX=$TX5 ;;
		*)  U=''; TX='-' ;;
	esac
	if [ "$TX" = '-' ] || [ -z "$U" ] || [ "$U" = off ] || has "$DONE" "$B"; then
		uci set wireless.$r.disabled='1'
		continue
	fi
	DONE="$DONE $B"
	uci set wireless.$r.disabled='0'
	uci set wireless.$r.country='FR'
	uci set wireless.$r.log_level='4'          # warnings only: no per-client connect lines
	uci set wireless.$r.txpower="$TX"
&#32;
	# Channel: a flyway fixes it; a client follows its AP; a feeder alone uses the feeder's
	if [ "$B" = 2g ]; then
		HT='HT20'
		if has "$U" flyway; then CH=$MESH_CH; elif has "$U" join; then CH='auto'; else CH=$FEED_CH2; fi
	else
		if has "$U" flyway; then CH=$FLYWAY_CH; HT='HT20'
		elif has "$U" join; then CH='auto'; HT='VHT40'
		else CH=$FEED_CH5; HT='VHT40'; fi
	fi
	uci set wireless.$r.channel="$CH"
	uci set wireless.$r.htmode="$HT"
&#32;
	if has "$U" flyway &amp;&amp; [ "$B" = 5g ]; then
		uci set wireless.flyway=wifi-iface       # the perch tool works on this one
		uci set wireless.flyway.device="$r"
		uci set wireless.flyway.mode='sta'       # safe default: a client only transmits after hearing its AP
		uci set wireless.flyway.ssid="$FLYWAY_SSID"
		uci set wireless.flyway.encryption='sae'
		uci set wireless.flyway.key="$(key flyway.key)"
		uci set wireless.flyway.network='mesh0'
	fi
	if has "$U" flyway &amp;&amp; [ "$B" = 2g ]; then
		uci set wireless.mesh_$r=wifi-iface
		uci set wireless.mesh_$r.device="$r"
		uci set wireless.mesh_$r.mode='mesh'
		uci set wireless.mesh_$r.mesh_id="$MESH_ID"
		uci set wireless.mesh_$r.encryption='sae'
		uci set wireless.mesh_$r.key="$(key hedge.key)"
		uci set wireless.mesh_$r.mesh_fwding='0'     # batman-adv does the routing, not 802.11s
		uci set wireless.mesh_$r.network='mesh0'
	fi
	if has "$U" feeder; then
		uci set wireless.ap_$r=wifi-iface
		uci set wireless.ap_$r.device="$r"
		uci set wireless.ap_$r.mode='ap'
		uci set wireless.ap_$r.ssid="$SSID"
		uci set wireless.ap_$r.encryption='none'         # on-ramp: anyone can join
		uci set wireless.ap_$r.network='lan'
		uci set wireless.ap_$r.isolate='0'               # phones must reach each other (Reticulum, P3)
		uci set wireless.ap_$r.multicast_to_unicast_all='1'  # RAs + Reticulum discovery reach clients reliably
	fi
	if has "$U" join; then
		uci set wireless.wsta=wifi-iface
		uci set wireless.wsta.device="$r"
		uci set wireless.wsta.mode='sta'
		uci set wireless.wsta.ssid="$SSID"
		uci set wireless.wsta.encryption='none'          # the open on-ramp Wi-Fi, like any phone
		uci set wireless.wsta.network='wsta'
		uci set wireless.wsta.ifname='wsta'              # fixed name: the Reticulum config uses it
	fi
done
uci commit wireless
&#32;
# --- Reticulum: on the Wi-Fi client if a radio joins, else on the village bridge ---
if [ "$RETICULUM" = 1 ]; then
	if has "$ALL" join; then DEV='wsta'; else DEV='br-lan'; fi
	sed -i "s|@RNSDEV@|$DEV|" /etc/reticulum/config
	. /lib/functions.sh
	group_add rns 1500 2&gt;/dev/null
	user_add rns 1500 1500 rns /etc/reticulum /bin/false 2&gt;/dev/null   # its own user, never root
	sed -i "s|@NAME@|$(uci -q get system.@system[0].hostname)|" /etc/nomadnetwork/config
	chown -R rns:rns /etc/reticulum /etc/nomadnetwork
	/etc/init.d/rnsd enable
	/etc/init.d/nomadnet enable
fi
&#32;
exit 0</code></pre></div>
<h4><span lang="en">1. Build</span></h4>
<p lang="en">On any x86_64 Linux machine with Internet access.</p>
<p lang="en">First an admin SSH key, if there is none yet: the images accept nothing else. Then the radio keys, then the build. OpenWrt 25.12 uses <code>apk</code>, not <code>opkg</code>.</p>
<p lang="en">In a terminal, <code>./build.sh</code> opens a menu: the devices already in <code>profiles.txt</code>, numbered. Pick several by number or by role (<code>1 3</code>, <code>hedge</code>), or press Enter for all. <code>v</code> changes the OpenWrt release, <code>w</code> turns the web interface on or off, <code>s</code> writes a Raspberry Pi image to an SD card, <code>n</code> adds a device. It shows the list and asks before building. From a script, <code>./build.sh all</code> or a role name builds with no questions. Menu added on 2026-11-18 and tried against a stand-in Image Builder; not yet run with the real one. Checks added on 2026-11-20, tried the same way: before downloading anything it checks each chosen line of <code>profiles.txt</code> (a known role, a power from 0 to 30 dBm, the bands the role needs); a build replaces the images of the devices it builds and keeps the others in <code>build/images</code>; at the end it lists what it built and what it skipped. Since 2026-11-21 each line of the menu shows what its ports and radios do, and the build lists it for every chosen device before asking to go on; in <code>n</code>, <code>m</code> asks the use of each interface instead of a role.</p>
<p lang="en">Two checks run on every build, added on 2026-11-20. The signature check ran on the real Image Builder on 2026-11-21; the rule check has only been tried against a stand-in. First, OpenWrt's signature. The checksums only prove that a download isn't broken, so the build also checks OpenWrt's signature on them, with OpenWrt's public keys kept in <code>trust/</code>, and prints the key that signed. A tampered server or mirror is then caught too. <code>trust/</code> holds OpenWrt's two build keys, the 2016 one and the 2023 Nitrokey one (fingerprints on openwrt.org); on 2026-11-21, 25.12.6 was signed by the 2023 Nitrokey key (<code>8A8BC12F46B836C0F9CDB36F1D53D1877742E911</code>) and the check passed. The tool is <code>gpgv</code>, already there on Debian and Ubuntu. Second, the hard rules. Before building, the Image Builder lists every package the image would hold, and the build stops if it finds a DHCP or RA server, a firewall, PPP, or a web interface nobody asked for. Either check can be skipped when needed: <code>CHECK_SIG=0</code> or <code>CHECK_RULES=0</code> in front of <code>./build.sh</code>, and the build says it skipped it. When OpenWrt signs with a new key, better check its fingerprint on openwrt.org's key page and add it to <code>trust/</code> than skip the check.</p>
<p class="note" lang="en">Back up <code>secrets/</code> offline, with your SSH key, for example on a USB stick kept away from the laptop. It holds the village's radio keys, and nothing else keeps a copy: not git, not the kit, not this handbook. If it is lost, a running perch or hedge still holds its key: <code>cat /etc/sparrows/flyway.key</code> (or <code>hedge.key</code>) over SSH. If every copy is lost, make a new key and reflash every perch, or every hedge.</p>
<div class="code"><div class="hd"><span class="file">admin key</span></div><pre><code># Once per admin, on the admin laptop
ssh-keygen -t ed25519 -C "sparrows-admin"     # Enter = default path ~/.ssh/id_ed25519; set a passphrase
# Back up ~/.ssh/id_ed25519 (the private half) offline. The images lock the root password:
# without that file, the only way back into a station is failsafe mode at the unit.
cd sparrows-openwrt &amp;&amp; mkdir -p keys secrets</code></pre></div>
<div class="code"><div class="hd"><span class="file">shell</span></div><pre><code># Layout:  sparrows-openwrt/profiles.txt   role, target, device, power per band, web interface, [uses=]
#          sparrows-openwrt/uses.txt       what each port and radio does, per role
#          sparrows-openwrt/build.sh       ./build.sh [all|uses|&lt;role&gt;], ./build.sh sd
#          sparrows-openwrt/common/ station/   files for every unit: base, ports and radios
#          sparrows-openwrt/perch/ tree/ nest/ files only some units need (perch tool, Reticulum, nest)
#          sparrows-openwrt/ui/ devices/   web interface files, devices that need more than a line
#          sparrows-openwrt/trust/         OpenWrt's public keys, to check its signature
cd sparrows-openwrt
cp ~/.ssh/id_ed25519.pub keys/admin.pub                    # the build refuses to run without a key
printf '%s' 'the-flyway-passphrase' &gt; secrets/flyway.key   # 5 GHz flyway (perch) only: same as the running flyway
head -c 32 /dev/urandom | base64 | tr -dc 'A-Za-z0-9' | head -c 32 &gt; secrets/hedge.key   # 2.4 GHz flyway (hedge) only
# Back up secrets/ offline now, with your SSH key: no other copy of the radio keys exists
./build.sh                    # a menu: pick devices by number or role (Enter = all), n = add a device
./build.sh all                # no menu: every line of profiles.txt (also: perch, feeder, hedge, tree, nest)
./build.sh uses               # only show what each port and radio of every line will do
VER=25.12.x ./build.sh all    # another release (or v in the menu)
UI=1 ./build.sh all           # with the web interface where profiles.txt says ui (or w in the menu)
CHECK_SIG=0 ./build.sh all    # skip the check of OpenWrt's signature (new OpenWrt key? add it to trust/)
CHECK_RULES=0 ./build.sh all  # skip the check of each image's packages against the hard rules
ls build/images/              # the images. The build ends with the sha256 of those it made, and what it skipped</code></pre></div>
<div class="code"><div class="hd"><span class="file">profiles.txt</span></div><pre><code># Sparrows-Network: hardware that can take each role.
# One line per device and role. To support another device, add a line: nothing else changes.
#
# role = a role of uses.txt (perch, feeder, hedge, tree, nest), or several joined with +, e.g. tree+feeder:
#   what each port and radio does comes from uses.txt. The unit is named after it (tree-feeder-26de).
#
# tx2 / tx5 = power set at the radio, in dBm = legal EIRP limit (FR) - antenna gain.
#   2.4 GHz: 20 dBm EIRP.
#   5 GHz outdoor (ch 100-140): 30 dBm EIRP with TPC, 27 dBm without TPC.
# "-" = this band is not used on this device (its radio is switched off).
#
# ui = the web interface (LuCI) may go in this image, when the build asks for it (UI=1, or w in the menu).
# "-" = never: 8 MB of flash or 64 MB of RAM is too small (Sparrows Tao, Hard rules). No column = "-".
#
# uses = manual mode, for a special device: what each interface does, instead of a role's preset.
#   uses=&lt;ports&gt;,&lt;2.4 GHz&gt;,&lt;5 GHz&gt;,&lt;services&gt;   e.g. uses=wire,feeder,flyway,-
#   The role column is then only a name for the unit (letters, digits, -). Needs the ui column before it.
#   The menu writes these lines for you (n, then m). Uses are explained in uses.txt.
#
# profile = the OpenWrt profile name, or a folder in devices/ for a device that needs more than a
#   line (another OpenWrt profile, firmware to fetch, what its radios can do, its own first-boot
#   file). See devices/*/device.conf.
#
# role    target          profile                    tx2  tx5  ui  uses
perch     ath79/generic   tplink_cpe510-v3           -    17   -
feeder    ath79/generic   tplink_eap225-outdoor-v1   17   23   ui
feeder    ath79/generic   tplink_eap225-outdoor-v3   17   23   ui
hedge     ath79/generic   tplink_eap225-outdoor-v1   17   23   ui
hedge     ath79/generic   tplink_eap225-outdoor-v3   17   23   ui
# Pi Zero 2 W: 2.4 GHz only, with a USB Ethernet adapter for the village cable. Not yet tested.
feeder    bcm27xx/bcm2710 rpi-zero-2-w               17   -    ui
# Same Pi Zero 2 W as a tree: a Wi-Fi client of the village running Reticulum. No adapter needed.
tree      bcm27xx/bcm2710 rpi-zero-2-w               17   -    ui
# Both at once: its Wi-Fi serves Sparrows, Reticulum runs on the cable (USB adapter). Not yet tested.
tree+feeder bcm27xx/bcm2710 rpi-zero-2-w             17   -    ui
# Pi 4 as a nest, its own Wi-Fi as Sparrows Wi-Fi (2.4 GHz: its chip has no radar check for 5 GHz
# outdoor channels). Replaces the Debian nest once it passes the same checks. Not yet tested.
nest+feeder bcm27xx/bcm2711 rpi-4                    17   -    ui</code></pre></div>
<div class="code"><div class="hd"><span class="file">build.sh</span></div><pre><code>#!/usr/bin/env bash
# Build the Sparrows-Network OpenWrt images with the OpenWrt Image Builder.
# One image per role and device: the same image goes on every unit of that role.
# What each port and radio does comes from the role (uses.txt), or from a manual line (profiles.txt).
# Runs on x86_64 Linux. Needs: wget, zstd, make, gcc, python3, perl, rsync (see OpenWrt IB docs), gpgv.
#
# Usage: ./build.sh              -&gt; in a terminal: a menu to pick the devices (Enter = all of them)
#                                   without a terminal (a script, cron): every line of profiles.txt
#        ./build.sh all          -&gt; every line of profiles.txt, no menu
#        ./build.sh perch        -&gt; every line with that role, alone or combined (or: feeder, hedge,
#                                   tree, or a manual line's name), no menu
#        ./build.sh uses         -&gt; what each port and radio of every line will do, nothing built
#        VER=25.12.x ./build.sh  -&gt; another 25.12 release
#        UI=1 ./build.sh all     -&gt; with the web interface (LuCI), only where profiles.txt says "ui"
#        ./build.sh sd [image]   -&gt; write a Raspberry Pi image (.img.gz) to an SD card: asks which
#                                   reader, shows what is on it, and asks you to type its name first
# A build replaces the images of the devices it builds and keeps the others in build/images.
#
# Two checks, each can be skipped when needed:
#   CHECK_SIG=0 ./build.sh     -&gt; don't check OpenWrt's signature on the Image Builder's checksums
#                                 (its public keys are in trust/; a new key: check its fingerprint on
#                                 https://openwrt.org/docs/guide-user/security/signatures, add it there)
#   CHECK_RULES=0 ./build.sh   -&gt; don't check the image's package list against the hard rules
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
set -euo pipefail
&#32;
VER="${VER:-25.12.6}"     # 2026-10-18, security fixes. Check https://downloads.openwrt.org/releases/ for the latest 25.12.x
UI="${UI:-0}"             # 1 = add the web interface where profiles.txt allows it
CHECK_SIG="${CHECK_SIG:-1}"
CHECK_RULES="${CHECK_RULES:-1}"
HERE="$(cd "$(dirname "$0")" &amp;&amp; pwd)"
OUT="$HERE/build/images"
# The Image Builder's Makefiles break on a path with a space in it (seen 2026-11-21: "/home/me/00 - x"
# was cut at the first space, and "make info" failed). Then it works in a folder of its own, outside
# the tree; the images still land in build/images. SPARROWS_BUILD=&lt;folder&gt; chooses another one.
BUILD="${SPARROWS_BUILD:-$HERE/build}"
case "$BUILD" in *[[:space:]]*) BUILD="${XDG_CACHE_HOME:-$HOME/.cache}/sparrows-build" ;; esac
&#32;
# Every image: no DHCP/RA server, no firewall, no PPP, no web UI (a station only bridges)
BASE="-dnsmasq -odhcpd-ipv6only -firewall4 -nftables -kmod-nft-offload -ppp -ppp-mod-pppoe -luci -luci-ssl"
# ...plus what its uses need
PKG_flyway="-wpad-basic-mbedtls wpad-mesh-mbedtls kmod-batman-adv batctl-default iw"
PKG_join="iw"
# A nest keeps odhcpd and dnsmasq (RA and DNS, no DHCP) and adds uhttpd: PKG_nest, in nest/role.conf.
# Reticulum: Python and the libraries Reticulum asks for; Reticulum and Nomad Network come as pinned
# wheels (tree/role.conf). Needs room: SD-card devices, not 8-16 MB flash.
PKG_reticulum="python3 python3-cryptography python3-pyserial iw"
# LuCI = luci-light minus its firewall and PPP pages. luci-light itself would bring firewall4 and
# nftables back (luci-app-firewall needs a firewall): no firewall is a hard rule. No HTTPS: it only
# listens on 127.0.0.1 and ::1
PKG_ui="uhttpd uhttpd-mod-ubus luci-mod-admin-full luci-theme-bootstrap luci-proto-ipv6 rpcd-mod-rrdns"
# Never in a station image (hard rules: only nests send RAs; no DHCP, firewall or PPP). CHECK_RULES
FORBIDDEN="dnsmasq dnsmasq-full dnsmasq-dhcpv6 odhcpd odhcpd-ipv6only firewall firewall4 nftables
nftables-json nftables-nojson iptables iptables-nft ppp ppp-mod-pppoe luci-app-firewall"
FORBIDDEN_NO_UI="luci-base uhttpd"     # ...and no web interface unless it was asked for
&#32;
die() { echo "$*" &gt;&amp;2; exit 1; }
&#32;
# The device lines of profiles.txt: role target profile tx2 tx5 [ui] [uses=...]. A # starts a comment anywhere
profiles() { awk '{ sub(/#.*/, "") } NF { $1 = $1; print }' "$HERE/profiles.txt"; }
&#32;
# ---------------------------------------------------------------- uses of each interface
&#32;
# The role presets of uses.txt: role ports 2.4GHz 5GHz services
presets() { awk '{ sub(/#.*/, "") } NF { $1 = $1; print }' "$HERE/uses.txt"; }
ROLES=$(presets | awk '{ printf "%s ", $1 }'); ROLES=${ROLES% }
&#32;
has() { case " $1 " in *" $2 "*) return 0 ;; esac; return 1; }
&#32;
# What a device's radios can do: CAN2 / CAN5 in devices/&lt;profile&gt;/device.conf, else everything
can() (
	CAN2='feeder flyway join' CAN5='feeder flyway join'
	if [ -f "$HERE/devices/$1/device.conf" ]; then
		# shellcheck source=/dev/null
		. "$HERE/devices/$1/device.conf"
	fi
	echo "$CAN2|$CAN5"
)
&#32;
# The uses of a device line, as PORTS|USE2|USE5|RETICULUM|NEST (e.g. wire|flyway feeder|feeder|0|0),
# or why it can't be built (and returns 1). A role's preset is lenient (a band set to - is simply
# off); a manual uses= line is strict (it says exactly what it wants).
uses_of() {
	local R=$1 P=$2 X2=$3 X5=$4 SPEC=${5:-} PORTS='' U2='' U5='' S='' RNS=0 NEST=0 MANUAL=0
	local PART L A B C D W X C2 C5 N
	if [ -n "$SPEC" ]; then
		MANUAL=1
		IFS=, read -r PORTS U2 U5 S X &lt;&lt;&lt;"${SPEC#uses=}"
		{ [ -n "$S" ] &amp;&amp; [ -z "$X" ]; } || { echo "uses= needs 4 fields: ports,2.4GHz,5GHz,services"; return 1; }
		U2=${U2//+/ } U5=${U5//+/ }
		[ "$S" != - ] || S=''
		S=${S//+/ }
	else
		for PART in ${R//+/ }; do
			L=$(presets | awk -v r="$PART" '$1 == r')
			[ -n "$L" ] || { echo "unknown role '$PART' (roles: $ROLES)"; return 1; }
			read -r _ A B C D &lt;&lt;&lt;"$L"
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
&#32;
	# A band set to - is off
	if [ "$X2" = - ] &amp;&amp; [ -n "$U2" ]; then
		[ "$MANUAL" = 0 ] || { echo "uses on 2.4 GHz, but its power is -"; return 1; }
		U2=''
	fi
	if [ "$X5" = - ] &amp;&amp; [ -n "$U5" ]; then
		[ "$MANUAL" = 0 ] || { echo "uses on 5 GHz, but its power is -"; return 1; }
		U5=''
	fi
	# What the chip can do (device.conf)
	IFS='|' read -r C2 C5 &lt;&lt;&lt;"$(can "$P")"
	for W in $U2; do has "$C2" "$W" || { echo "this device's 2.4 GHz radio can't do '$W' (devices/$P/device.conf)"; return 1; }; done
	for W in $U5; do has "$C5" "$W" || { echo "this device's 5 GHz radio can't do '$W' (devices/$P/device.conf)"; return 1; }; done
&#32;
	# A nest never joins: it serves the village, its radios don't hang on someone else's
	if [ "$NEST" = 1 ]; then U2=${U2% join}; U2=${U2%join}; U5=${U5% join}; U5=${U5%join}; fi
	# A radio that joins does nothing else: when it has another use, it doesn't join
	# (Reticulum then runs on the village bridge). And only one radio joins: the 2.4 GHz one
	if has "$U2" join &amp;&amp; [ "$U2" != join ]; then U2=${U2% join}; fi
	if has "$U5" join &amp;&amp; [ "$U5" != join ]; then U5=${U5% join}; fi
	if [ "$U2" = join ] &amp;&amp; [ "$U5" = join ]; then U5=''; fi
	# One 5 GHz radio can't hold a flyway (ch 108) and a feeder (ch 132)
	if has "$U5" flyway &amp;&amp; has "$U5" feeder; then
		echo "5 GHz: a flyway (ch 108) and a feeder (ch 132) can't share one radio"; return 1
	fi
	if [ -z "$U2$U5" ] &amp;&amp; [ "$RNS" = 0 ]; then
		echo "with these bands, this unit would do nothing"; return 1
	fi
	echo "$PORTS|${U2:-off}|${U5:-off}|$RNS|$NEST"
}
&#32;
# One line: "ports wire | 2.4 flyway+feeder | 5 feeder | Reticulum"
uses_short() {
	local PORTS U2 U5 RNS NEST
	IFS='|' read -r PORTS U2 U5 RNS NEST &lt;&lt;&lt;"$1"
	printf 'ports %s | 2.4 %s | 5 %s%s' "$PORTS" "${U2// /+}" "${U5// /+}" \
		"$( if [ "$NEST" = 1 ]; then echo ' | nest'; elif [ "$RNS" = 1 ]; then echo ' | Reticulum'; fi )"
}
&#32;
# What each interface will do, in words
uses_long() {
	local PORTS U2 U5 RNS NEST B U W T FIRST
	IFS='|' read -r PORTS U2 U5 RNS NEST &lt;&lt;&lt;"$1"
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
&#32;
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
&#32;
ib_name() { echo "openwrt-imagebuilder-${VER}-${1/\//-}.Linux-x86_64"; }
&#32;
# OpenWrt's signature on a file, checked with the public keys kept in trust/. The checksums only prove
# the download isn't broken; the signature proves it is OpenWrt's, whatever server or mirror it came
# from. gpgv is enough: python unpacks the keys, so GnuPG itself isn't needed. Prints who signed.
check_sig() {
	local FILE=$1 SIG=$2 KR="$BUILD/trust.gpg" GH="$BUILD/gnupg" STATUS ID
	command -v gpgv &gt;/dev/null || { echo "gpgv is missing (Debian/Ubuntu: apt install gpgv), or CHECK_SIG=0 to skip this check" &gt;&amp;2; return 1; }
	compgen -G "$HERE/trust/*.asc" &gt;/dev/null || { echo "No OpenWrt public key in trust/*.asc, or CHECK_SIG=0 to skip this check" &gt;&amp;2; return 1; }
	mkdir -p "$GH" &amp;&amp; chmod 700 "$GH"
	python3 -I -c '
import base64, sys
out = open(sys.argv[1], "wb")              # armored key files -&gt; one binary keyring, as gpgv reads it
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
	if STATUS=$(gpgv --homedir "$GH" --status-fd 1 --keyring "$KR" "$SIG" "$FILE" 2&gt;/dev/null); then
		echo "$(basename "$FILE"): signed by OpenWrt key $(printf '%s\n' "$STATUS" | awk '$2 == "VALIDSIG" { print $NF }')" &gt;&amp;2
		return 0
	fi
	ID=$(printf '%s\n' "$STATUS" | awk '$2 == "NO_PUBKEY" { print $3 }')
	if [ -n "$ID" ]; then
		echo "$(basename "$FILE"): signed by key $ID, which is not in trust/. If openwrt.org lists it" &gt;&amp;2
		echo "  (https://openwrt.org/docs/guide-user/security/signatures), add it to trust/; or CHECK_SIG=0 to skip" &gt;&amp;2
	else
		echo "$(basename "$FILE"): signature check FAILED. Don't use this download (CHECK_SIG=0 skips the check)" &gt;&amp;2
	fi
	return 1
}
&#32;
# Image Builder for a target: downloaded once, checked against sha256sums. Runs in a subshell.
get_ib() (
	TARGET=$1
	IB=$(ib_name "$TARGET")
	URL="https://downloads.openwrt.org/releases/${VER}/targets/${TARGET}"
	mkdir -p "$BUILD" &amp;&amp; cd "$BUILD" || exit 1
	[ -d "$IB" ] &amp;&amp; exit 0
	echo "Downloading the Image Builder for $TARGET ($VER)..." &gt;&amp;2
	wget -q -O "$IB.sha256sums" "$URL/sha256sums" || { echo "No $VER release for $TARGET" &gt;&amp;2; exit 1; }
	if [ "$CHECK_SIG" = 1 ]; then
		wget -q -O "$IB.sha256sums.asc" "$URL/sha256sums.asc" || \
			{ echo "No signature at $URL/sha256sums.asc (CHECK_SIG=0 skips this check)" &gt;&amp;2; exit 1; }
		check_sig "$IB.sha256sums" "$IB.sha256sums.asc" || exit 1
	fi
	# -O: the same file name every time (without it, a second try lands in .tar.zst.1 and never checks).
	# A progress bar only in a terminal: the download is big
	PROGRESS=''; [ -t 2 ] &amp;&amp; PROGRESS='--show-progress'
	wget -q $PROGRESS -O "$IB.tar.zst" "$URL/$IB.tar.zst" || { echo "Download failed: $URL/$IB.tar.zst" &gt;&amp;2; exit 1; }
	grep " \*\?$IB.tar.zst\$" "$IB.sha256sums" | sha256sum -c - &gt;&amp;2 || { rm -f "$IB.tar.zst"; echo "Checksum FAILED" &gt;&amp;2; exit 1; }
	# Unpacked aside, then moved: a cut-off unpack is never taken for a complete Image Builder
	rm -rf "$IB.part" &amp;&amp; mkdir "$IB.part"
	tar -C "$IB.part" --zstd -xf "$IB.tar.zst" &amp;&amp; mv "$IB.part/$IB" "$IB" &amp;&amp; rmdir "$IB.part" || exit 1
	rm -f "$IB.tar.zst"
)
&#32;
# A device left out of this build: said now, and again in the summary at the end
skip() { echo "$*" &gt;&amp;2; echo "$*" &gt;&gt; "$BUILD/.skipped"; exit 0; }
&#32;
# Build one image. Runs in a subshell: "exit 0" skips this device, any error stops the build.
build_one() (
	ROLE=$1 TARGET=$2 PROFILE=$3 TX2=$4 TX5=$5 UIOK=${6:--} SPEC=${7:-}
	MAP=$(uses_of "$ROLE" "$PROFILE" "$TX2" "$TX5" "$SPEC") || die "$ROLE $PROFILE: $MAP"
	IFS='|' read -r PORTS USE2 USE5 RNS NEST &lt;&lt;&lt;"$MAP"
	[ "$USE2" != off ] || USE2=''
	[ "$USE5" != off ] || USE5=''
	NAMEROLE=${ROLE//+/-}            # tree+feeder -&gt; tree-feeder: in the unit's name and the image's
	WITH_UI=0 NAME="sparrows-$NAMEROLE"
&#32;
	# --- A device that needs more than a line: devices/&lt;name&gt;/device.conf (see profiles.txt) ---
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
			WITH_UI=1 NAME="sparrows-$NAMEROLE-ui"
		else
			echo "$ROLE $PROFILE: too small for the web interface (profiles.txt), built without it" &gt;&amp;2
		fi
	fi
&#32;
	# --- SAE passphrase for each flyway: 5 GHz (perch) and 2.4 GHz (hedge) ---
	KEYS=''
	if has "$USE5" flyway; then KEYS="$KEYS flyway.key"; fi
	if has "$USE2" flyway; then KEYS="$KEYS hedge.key"; fi
	for KEYF in $KEYS; do
		[ -s "$HERE/secrets/$KEYF" ] || die "$ROLE $PROFILE: put the SAE passphrase in secrets/$KEYF first"
		# Seen 2026-11-14: a key outside 8-63 printable ASCII never links (see Sparrows Tao, Pitfalls).
		# The whole file is checked, as the unit reads it: one line (a final newline is fine)
		( LC_ALL=C; K=$(&lt;"$HERE/secrets/$KEYF"); RE='^[ -~]{8,63}$'; [[ $K =~ $RE ]] ) || \
			die "secrets/$KEYF must be one line of 8 to 63 printable ASCII characters (no accents)"
	done
&#32;
	# --- Files for this unit: common base, the uses, keys, what the uses need, radio limits ---
	F="$BUILD/files-$NAMEROLE-$PROFILE"
	rm -rf "$F"
	cp -a "$HERE/common/files" "$F"
	cp -a "$HERE/station/files/." "$F/"
	if has "$USE5" flyway; then cp -a "$HERE/perch/files/." "$F/"; fi      # the perch tool
	if [ "$RNS" = 1 ]; then cp -a "$HERE/tree/files/." "$F/"; fi          # Reticulum + the page
	if [ "$NEST" = 1 ]; then cp -a "$HERE/nest/files/." "$F/"; fi         # RA, DNS, welcome page, lxmd
	install -d -m 700 "$F/etc/dropbear"
	cat "$HERE"/keys/*.pub &gt; "$F/etc/dropbear/authorized_keys"
	chmod 600 "$F/etc/dropbear/authorized_keys"
	install -d -m 755 "$F/etc/sparrows"
	printf "ROLE='%s'\nTX2='%s'\nTX5='%s'\nPORTS='%s'\nUSE2='%s'\nUSE5='%s'\nRETICULUM='%s'\nNEST='%s'\n" \
		"$NAMEROLE" "$TX2" "$TX5" "$PORTS" "$USE2" "$USE5" "$RNS" "$NEST" &gt; "$F/etc/sparrows/station"
	[ -z "$MACDEV" ] || printf "MACDEV='%s'\n" "$MACDEV" &gt;&gt; "$F/etc/sparrows/station"
	[ -z "$CH2" ] || printf "CH2='%s'\n" "$CH2" &gt;&gt; "$F/etc/sparrows/station"
	if [ -n "$DEV" ] &amp;&amp; [ -d "$DEV/files" ]; then
		cp -a "$DEV/files/." "$F/"
	fi
	# Firmware the device needs and OpenWrt doesn't ship: fetched once, checked file by file
	if [ -n "$FW_FILES" ]; then
		C="$BUILD/firmware/$PROFILE"
		mkdir -p "$C" "$F/$FW_DIR"
		while read -r SUM FILE; do
			[ -n "$FILE" ] || continue
			if ! echo "$SUM  $C/$FILE" | sha256sum -c --status - 2&gt;/dev/null; then
				echo "Fetching $FILE..." &gt;&amp;2
				wget -q -O "$C/$FILE" "$FW_URL/$FILE" || die "Download failed: $FW_URL/$FILE"
				echo "$SUM  $C/$FILE" | sha256sum -c --status - || { rm -f "$C/$FILE"; die "$FILE: checksum FAILED"; }
			fi
			install -m 644 "$C/$FILE" "$F/$FW_DIR/$FILE"
		done &lt;&lt;&lt;"$FW_FILES"
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
&#32;
	# --- Reticulum: Python wheels (tree/role.conf), fetched once, checked, unpacked into the image ---
	WHEELS='' HANDBOOK_TO='' PKG_nest=''
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
			if ! echo "$SUM  $W" | sha256sum -c --status - 2&gt;/dev/null; then
				echo "Fetching ${URL##*/}..." &gt;&amp;2
				wget -q -O "$W" "$URL" || die "Download failed: $URL"
				echo "$SUM  $W" | sha256sum -c --status - || { rm -f "$W"; die "${URL##*/}: checksum FAILED"; }
			fi
			python3 -I -m zipfile -e "$W" "$F/usr/lib/sparrows/python/"
		done &lt;&lt;&lt;"$WHEELS"
	fi
	# The built handbook: offered by the page node, and the welcome page of a nest
	if [ -n "$HANDBOOK_TO" ]; then
		if [ -f "$HERE/../tao/index.html" ]; then
			for H in $HANDBOOK_TO; do install -D -m 644 "$HERE/../tao/index.html" "$F/$H"; done
		else
			echo "$ROLE $PROFILE: no ../tao/index.html next to the build tree, so no handbook file in the image" &gt;&amp;2
		fi
	fi
&#32;
	get_ib "$TARGET" || die "No Image Builder for $TARGET"
	cd "$BUILD/$(ib_name "$TARGET")"
	# The profile list. A failing Image Builder is said as such, not taken for a missing profile
	INFO=$(make info 2&gt;&amp;1) || die "$ROLE $PROFILE: the Image Builder doesn't run (make info):"$'\n'"$(printf '%s\n' "$INFO" | tail -n 4)"
	printf '%s\n' "$INFO" | grep -q "^$IB_PROFILE:" || skip "$ROLE $PROFILE: no profile $IB_PROFILE in OpenWrt $VER $TARGET"
	# The packages: the base, then what the uses need, each package once
	PACKAGES="$BASE"
	if [ "$NEST" = 1 ]; then PACKAGES=$(printf '%s\n' $BASE | grep -v -x -e -dnsmasq -e -odhcpd-ipv6only | tr '\n' ' '); fi
	if has "$USE2 $USE5" flyway; then PACKAGES="$PACKAGES $PKG_flyway"; fi
	if has "$USE2 $USE5" join; then PACKAGES="$PACKAGES $PKG_join"; fi
	if [ "$RNS" = 1 ]; then PACKAGES="$PACKAGES $PKG_reticulum"; fi
	PACKAGES="$PACKAGES $PKG_nest $DEV_PACKAGES"
	[ "$WITH_UI" = 0 ] || PACKAGES="$PACKAGES $PKG_ui"
	PACKAGES=$(printf '%s\n' $PACKAGES | awk '!seen[$0]++' | tr '\n' ' ')
	[ -z "$DEV" ] || NAME="$NAME-$PROFILE"       # e.g. sparrows-feeder-rpi-zero-2-w-...-rpi-3-...
	# Image names: openwrt-&lt;release&gt;-&lt;NAME&gt;-&lt;target&gt;-&lt;profile&gt;-squashfs-factory.bin. Matched exactly, so
	# sparrows-feeder never picks up sparrows-feeder-ui, and no image of an earlier run passes for this one
	STEM="$NAME-${TARGET/\//-}-$IB_PROFILE"
	rm -f bin/targets/"$TARGET"/*-"$STEM"-*
	# The hard rules, checked by the machine: the Image Builder lists every package the image would
	# hold, dependencies included, before building it. Seen 2026-11-20: luci-light brought a firewall back
	if [ "$CHECK_RULES" = 1 ]; then
		MANIFEST=$(make manifest PROFILE="$IB_PROFILE" PACKAGES="$PACKAGES" STRIP_ABI=1) || \
			die "$ROLE $PROFILE: the Image Builder can't put these packages together (make manifest)"
		NO="$FORBIDDEN"; [ "$WITH_UI" = 1 ] || NO="$NO $FORBIDDEN_NO_UI"
		# A nest is the one unit that sends RAs and answers DNS (no DHCP), and serves the page.
		# Still no firewall, no PPP, no DHCPv6 server
		if [ "$NEST" = 1 ]; then NO=$(printf '%s\n' $NO | grep -v -x -e dnsmasq -e odhcpd-ipv6only -e uhttpd | tr '\n' ' '); fi
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
	rm -f "$OUT"/*-"sparrows-$NAMEROLE"{,-ui}"${DEV:+-$PROFILE}-${TARGET/\//-}-$IB_PROFILE"-*
	cp "${IMGS[@]}" "$OUT/"
	printf '%s\n' "${IMGS[@]##*/}" &gt;&gt; "$BUILD/.built"
)
&#32;
# ---------------------------------------------------------------- menu (terminal only)
&#32;
ask() { local a; read -r -p "$1" a &lt;/dev/tty; printf '%s' "$a"; }
&#32;
# Power at the radio: "-" (band off) or a whole number of dBm, 0 to 30 (no leading zero: 08 is octal)
ask_tx() {
	local v
	while :; do
		v=$(ask "$1")
		[[ "$v" =~ ^(-|[0-9]|[12][0-9]|30)$ ]] &amp;&amp; { printf '%s' "$v"; return; }
		echo "  A number of dBm (0 to 30), or - if this band is not used." &gt;&amp;2
	done
}
&#32;
# Manual mode: the use of each interface, asked one by one. Prints uses=ports,2.4,5,services
ask_uses() {
	local P U2 U5 S
	echo "Manual mode. Uses: wire, feeder (open Wi-Fi), flyway (link carrying batman-adv)," &gt;&amp;2
	echo "join (client of the Sparrows Wi-Fi), off. Several on one radio with +, e.g. flyway+feeder." &gt;&amp;2
	echo "Services: nest (RAs, DNS, welcome page, message store, Reticulum), reticulum, or none." &gt;&amp;2
	P=$(ask "Ethernet ports (wire or off): ")
	U2=$(ask "2.4 GHz radio (e.g. feeder, flyway+feeder, join, off): ")
	U5=$(ask "5 GHz radio (e.g. feeder, flyway, join, off): ")
	S=$(ask "Services (nest, reticulum, or Enter for none; both need an SD-card device): ")
	printf 'uses=%s,%s,%s,%s' "${P:-wire}" "${U2:-off}" "${U5:-off}" "${S:--}"
}
&#32;
# Find a device in the Image Builder of its target, then add it to profiles.txt
add_device() {
	local TARGET WORD FOUND N PROFILE R RS TX2 TX5 UIOK LINE WHY NEW='' SPEC='' MAP i
	echo
	echo "The target is on the device's page of the OpenWrt Table of Hardware, e.g. ath79/generic, bcm27xx/bcm2711."
	TARGET=$(ask "Target: ")
	[[ "$TARGET" =~ ^[a-z0-9_-]+/[a-z0-9_-]+$ ]] || { echo "Not a target (form: name/subtarget)."; return; }
	get_ib "$TARGET" || return 0
	WORD=$(ask "Part of the model name, e.g. cpe510, eap225, rpi-4: ")
	mapfile -t FOUND &lt; &lt;(cd "$BUILD/$(ib_name "$TARGET")" &amp;&amp; make info 2&gt;/dev/null \
		| sed -n 's/^\([A-Za-z0-9_.,-]*\):$/\1/p' | grep -i -F -- "$WORD" || true)
	[ "${#FOUND[@]}" -gt 0 ] || { echo "No model matching '$WORD' in $TARGET ($VER)."; return; }
	for i in "${!FOUND[@]}"; do printf '  %2d) %s\n' $((i + 1)) "${FOUND[$i]}"; done
	N=$(ask "Which one? ")
	[[ "$N" =~ ^[0-9]+$ &amp;&amp; "$N" -ge 1 &amp;&amp; "$N" -le "${#FOUND[@]}" ]] || { echo "Nothing added."; return; }
	PROFILE=${FOUND[$((N - 1))]}
&#32;
	echo "Roles: $ROLES. Join roles with + to have both on one unit (e.g. tree+feeder)."
	RS=$(ask "Role(s) for this device (several with spaces), or m for manual mode: ")
	[ -n "$RS" ] || { echo "Nothing added."; return; }
	if [ "$RS" = m ]; then
		RS=$(ask "A name for this kind of unit (letters, digits, -), e.g. garden: ")
		[[ "$RS" =~ ^[a-z][a-z0-9-]*$ ]] || { echo "Not a name. Nothing added."; return; }
		SPEC=$(ask_uses)
	fi
&#32;
	echo "Power to set at the radio = legal EIRP (FR) - antenna gain. 2.4 GHz: 20 dBm EIRP."
	echo "5 GHz outdoor (ch 100-140): 30 dBm EIRP with TPC, 27 dBm without. - = band not used."
	TX2=$(ask_tx "2.4 GHz power in dBm, or -: ")
	TX5=$(ask_tx "5 GHz power in dBm, or -: ")
	case "$(ask "At least 16 MB of flash and 128 MB of RAM (web interface allowed)? [y/N] ")" in
		[yY]*) UIOK=ui ;; *) UIOK=- ;;
	esac
&#32;
	for R in $RS; do
		WHY=$(bad_line "$R" "$TARGET" "$PROFILE" "$TX2" "$TX5" "$UIOK" "$SPEC")
		if [ -n "$WHY" ]; then
			echo "  $R not added: $WHY."
			continue
		fi
		if profiles | awk -v r="$R" -v p="$PROFILE" '$1 == r &amp;&amp; $3 == p { f = 1 } END { exit !f }'; then
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
	[ -z "$(tail -c 1 "$HERE/profiles.txt")" ] || echo &gt;&gt; "$HERE/profiles.txt"   # last line not cut short
	{ printf '# added %s from the build menu: not yet tested\n' "$(date +%F)"; printf '%s' "$NEW"; } &gt;&gt; "$HERE/profiles.txt"
	echo "Added. It is now in the list."
}
&#32;
# The lines whose role is R, alone or joined with +, or the manual line named R
lines_of_role() { awk -v r="$1" '{ n = split($1, p, "+"); for (i = 1; i &lt;= n; i++) if (p[i] == r) { print; next } }'; }
&#32;
# Sets CHOSEN to the picked device lines (and VER, if the release was changed)
menu() {
	local LINES CH T i R P X2 X5 U S PICK OK MAP
	while :; do
		mapfile -t LINES &lt; &lt;(profiles)
		echo
		echo "Sparrows images, OpenWrt $VER, web interface $( [ "$UI" = 1 ] &amp;&amp; echo ON || echo off ). Devices in profiles.txt:"
		for i in "${!LINES[@]}"; do
			read -r R _ P X2 X5 U S &lt;&lt;&lt;"${LINES[$i]}"
			[ "${U:--}" = ui ] &amp;&amp; U=' +web' || U=''
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
			if [[ "$T" =~ ^[0-9]+$ ]] &amp;&amp; [ "$T" -ge 1 ] &amp;&amp; [ "$T" -le "${#LINES[@]}" ]; then
				PICK+=("${LINES[$((T - 1))]}")
			elif S=$(printf '%s\n' "${LINES[@]}" | lines_of_role "$T") &amp;&amp; [ -n "$S" ]; then
				mapfile -t -O "${#PICK[@]}" PICK &lt;&lt;&lt;"$S"
			else
				echo "'$T' is not in the list."; OK=0
			fi
		done
		if [ "$OK" = 1 ] &amp;&amp; [ "${#PICK[@]}" -gt 0 ]; then
			CHOSEN=$(printf '%s\n' "${PICK[@]}" | awk '!seen[$0]++')     # each device once, even if picked twice
			return
		fi
	done
}
&#32;
# ---------------------------------------------------------------- SD card (Raspberry Pi)
&#32;
# Disks that can be a card reader: removable, USB or MMC. Never a disk that holds /, /boot, /home,
# /usr, /var or swap. Prints: device &lt;tab&gt; size &lt;tab&gt; model
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
    if d.get("type") != "disk" or mounts(d) &amp; SYSTEM:
        continue
    if d.get("rm") in (True, 1, "1") or d.get("tran") == "usb" or "mmcblk" in d["name"]:
        print(d["name"], d.get("size") or "?", (d.get("model") or "").strip() or "-", sep="\t")
'
}
&#32;
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
		[[ "$N" =~ ^[0-9]+$ &amp;&amp; "$N" -ge 1 &amp;&amp; "$N" -le "${#IMGS[@]}" ]] || { echo "Cancelled, nothing written."; return 0; }
		IMG=${IMGS[$((N - 1))]}
	fi
	[ -s "$IMG" ] || die "No such image: $IMG"
&#32;
	ask "Put the SD card in its reader, then press Enter. " &gt;/dev/null
	mapfile -t DISKS &lt; &lt;(sd_disks)
	[ "${#DISKS[@]}" -gt 0 ] || { echo "No card reader found (removable, USB or MMC). Check with: lsblk"; return 0; }
	echo "Card readers and USB disks:"
	for i in "${!DISKS[@]}"; do
		IFS=$'\t' read -r DEV SIZE MODEL &lt;&lt;&lt;"${DISKS[$i]}"
		printf '  %2d) %-14s %8s  %s\n' $((i + 1)) "$DEV" "$SIZE" "$MODEL"
	done
	N=$(ask "Which one holds the card? (Enter = cancel): ")
	[[ "$N" =~ ^[0-9]+$ &amp;&amp; "$N" -ge 1 &amp;&amp; "$N" -le "${#DISKS[@]}" ]] || { echo "Cancelled, nothing written."; return 0; }
	IFS=$'\t' read -r DEV SIZE MODEL &lt;&lt;&lt;"${DISKS[$((N - 1))]}"
&#32;
	echo
	echo "EVERYTHING on $DEV ($SIZE, $MODEL) will be erased:"
	lsblk -po NAME,SIZE,FSTYPE,LABEL,MOUNTPOINT "$DEV"
	echo "and replaced by: $(basename "$IMG")"
	[ "$(ask "To go on, type the disk name (${DEV#/dev/}): ")" = "${DEV#/dev/}" ] || { echo "Cancelled, nothing written."; return 0; }
&#32;
	# OpenWrt puts its metadata after the gzip data: gzip warns "trailing garbage" and exits 2
	RAW="$BUILD/sd-card.img"
	mkdir -p "$BUILD"           # absent in a fresh copy of the kit, with an image from elsewhere
	echo "Unpacking..."
	gzip -dc "$IMG" &gt; "$RAW" 2&gt;/dev/null || [ $? -eq 2 ] || die "Cannot unpack $IMG"
	BYTES=$(stat -c %s "$RAW")
	[ "$BYTES" -gt 0 ] || die "Empty image: $IMG"
&#32;
	for P in $(lsblk -lnpo NAME "$DEV"); do
		if findmnt -rn -S "$P" &gt;/dev/null; then sudo umount "$P"; fi
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
&#32;
# ---------------------------------------------------------------- main
&#32;
ARG="${1:-}"
MENU=0
[ -z "$ARG" ] &amp;&amp; [ -t 0 ] &amp;&amp; [ -t 1 ] &amp;&amp; MENU=1
CHOSEN=''
case "$ARG" in
	'')    if [ "$MENU" = 1 ]; then menu; else CHOSEN=$(profiles); fi ;;
	all|uses) CHOSEN=$(profiles) ;;
	sd)    write_sd "${2:-}"; exit 0 ;;
	-*|*/*) die "Usage: ./build.sh [all|uses|&lt;role&gt;] | ./build.sh sd [image.img.gz]" ;;
	*)     CHOSEN=$(profiles | lines_of_role "$ARG")
	       [ -n "$CHOSEN" ] || die "No line with role '$ARG' in profiles.txt (roles: $ROLES). Usage: ./build.sh [all|uses|&lt;role&gt;] | ./build.sh sd [image.img.gz]" ;;
esac
[ -n "$CHOSEN" ] || die "Nothing to build."
&#32;
# Every chosen line checked before anything is downloaded
BAD=''
while read -r ROLE TARGET PROFILE TX2 TX5 UIOK SPEC REST; do
	WHY=$(bad_line "$ROLE" "$TARGET" "$PROFILE" "$TX2" "$TX5" "${UIOK:--}" "${SPEC:-}" "${REST:-}")
	[ -z "$WHY" ] || BAD="$BAD  $ROLE $TARGET $PROFILE: $WHY"$'\n'
done &lt;&lt;&lt;"$CHOSEN"
[ -z "$BAD" ] || die "profiles.txt, line(s) to fix first:"$'\n'"${BAD%$'\n'}"
&#32;
# What each port and radio will do, shown before anything is built
echo
echo "OpenWrt $VER. To build, and what each interface will do:"
while read -r ROLE TARGET PROFILE TX2 TX5 UIOK SPEC; do
	W=''; [ "$UI" = 1 ] &amp;&amp; [ "${UIOK:--}" = ui ] &amp;&amp; W='  + web interface'
	echo "  $ROLE on $PROFILE ($TARGET)${SPEC:+, manual}$W"
	uses_long "$(uses_of "$ROLE" "$PROFILE" "$TX2" "$TX5" "${SPEC:-}")"
done &lt;&lt;&lt;"$CHOSEN"
# Every nest image gets the same village address scheme: say so once
if printf '%s\n' "$CHOSEN" | lines_of_role nest | grep -q . ; then
	echo "  Nests: Android needs a non-ULA prefix; the image uses 2001:db8:1::/64, the BENCH range (nest/files)."
fi
[ "$ARG" != uses ] || exit 0
[ "$CHECK_SIG" = 1 ] || echo "  Skipped on purpose: the check of OpenWrt's signature (CHECK_SIG=0)"
[ "$CHECK_RULES" = 1 ] || echo "  Skipped on purpose: the check of the packages against the hard rules (CHECK_RULES=0)"
if [ "$MENU" = 1 ]; then
	case "$(ask "Go? [Y/n] ")" in [nN]*) exit 0 ;; esac
fi
&#32;
compgen -G "$HERE/keys/*.pub" &gt;/dev/null || die "Put admin SSH public keys in keys/*.pub first"
MISSING=''
for C in wget zstd tar make gcc perl rsync python3 sha256sum $( [ "$CHECK_SIG" = 0 ] || echo gpgv ); do
	command -v "$C" &gt;/dev/null || MISSING="$MISSING $C"
done
[ -z "$MISSING" ] || die "Missing on this machine:$MISSING (the Image Builder needs them; see its page on openwrt.org)"
mkdir -p "$BUILD" "$OUT"
case "$BUILD" in *[[:space:]]*) die "The build folder $BUILD has a space in its path, which the Image Builder can't handle. Set SPARROWS_BUILD=&lt;a folder without spaces&gt;" ;; esac
[ "$BUILD" = "$HERE/build" ] || echo "This folder's path has a space: the Image Builder works in $BUILD (images still go to $OUT)."
: &gt; "$BUILD/.built"; : &gt; "$BUILD/.skipped"
&#32;
while read -r ROLE TARGET PROFILE TX2 TX5 UIOK SPEC; do
	build_one "$ROLE" "$TARGET" "$PROFILE" "$TX2" "$TX5" "${UIOK:--}" "${SPEC:-}" &lt;/dev/null
done &lt;&lt;&lt;"$CHOSEN"
&#32;
echo
if [ -s "$BUILD/.skipped" ]; then
	echo "Skipped:"
	sed 's/^/  /' "$BUILD/.skipped"
	echo
fi
[ -s "$BUILD/.built" ] || die "No image was built."
echo "Built now, in $OUT:"
( cd "$OUT" &amp;&amp; while read -r I; do sha256sum -- "$I"; done &lt; "$BUILD/.built" )
&#32;
if grep -q -e '-ui-' "$BUILD/.built"; then
	echo
	echo "Web interface (images with -ui): it only listens on the unit itself. From your laptop:"
	echo "  ssh -N -L 8080:127.0.0.1:80 root@&lt;station address&gt;    then open http://localhost:8080"
	echo "  The first time, set the root password over SSH:  passwd   (SSH itself stays keys only)"
fi
&#32;
if [ "$MENU" = 1 ] &amp;&amp; grep -q '\.img\.gz$' "$BUILD/.built"; then
	echo
	case "$(ask "Write a Raspberry Pi image to an SD card now? [y/N] ")" in [yY]*) write_sd ;; esac
fi</code></pre></div>
<h4 id="web-ui"><span lang="en">Web interface, optional</span> <span class="st nt" data-ui="nt">not yet tested</span></h4>
<p lang="en">Added on 2026-11-18. Off by default. With <code>w</code> in the menu (or <code>UI=1</code>), images get LuCI, OpenWrt's web interface: radios, signal, clients and logs in a browser, with no commands to learn. Only on devices marked <code>ui</code> in <code>profiles.txt</code>: small ones (8 MB of flash, 64 MB of RAM, like the CPE510) are built without it and the build says so (hard rule). If an image comes out too big for the flash, that one is skipped and the others are built. Images with it have <code>-ui</code> in their name. It comes without LuCI's firewall page: the usual LuCI bundle (<code>luci-light</code>) would bring the firewall back, which the hard rules forbid (found 2026-11-20), so the image takes LuCI's parts without it.</p>
<p lang="en">It listens on the unit itself only, never on the open Wi-Fi: you reach it through SSH with your admin key (first lines of the file below). LuCI asks for the root password, which every image locks, so set one once over SSH with <code>passwd</code>. SSH itself stays keys only, so the password is useless without the key. A change made in LuCI is a test, as on the command line: to keep it, put it in the build tree and rebuild.</p>
<p lang="en"><strong>How to reach it.</strong> The same reminder is printed at the end of every build that made a <code>-ui</code> image, and at every SSH login on the unit.</p>
<div class="code"><div class="hd"><span class="file">laptop, then the station</span></div><pre><code># On your laptop: a tunnel through SSH, with your admin key. Leave it open.
ssh -N -L 8080:127.0.0.1:80 root@&lt;station address&gt;
# Then open http://localhost:8080 in the browser.
# First time only, on the station over SSH: the root password LuCI asks for
passwd
&#32;
# Verify on the station: the web server listens on the unit itself only
netstat -ltn | grep ':80 '                 # 127.0.0.1:80 and ::1:80 only, never 0.0.0.0:80 or :::80
# From another laptop on the village: must FAIL
curl -m 5 'http://[&lt;station address&gt;]/'
&#32;
# Undo: flash the same role without -ui (sysupgrade -n), or on the station:
/etc/init.d/uhttpd disable &amp;&amp; /etc/init.d/uhttpd stop</code></pre></div>
<div class="code"><div class="hd"><span class="file">ui/files/etc/uci-defaults/95-sparrows-ui</span></div><pre><code>#!/bin/sh
# Sparrows-Network: web interface (LuCI). Only in images built with the web interface on.
# It listens on the unit itself only, never on the village: reach it through SSH with the admin key.
#   On the laptop:  ssh -N -L 8080:127.0.0.1:80 root@&lt;station address&gt;
#   Then open:      http://localhost:8080
# LuCI asks for the root password, which every image locks. Set one once, over SSH:  passwd
# SSH itself stays keys only. `sysupgrade -n` and `firstboot` lock the password again.
# A change made in LuCI is a test: to keep it, put it in the build tree and rebuild.
# Status: NOT YET TESTED.
&#32;
uci -q delete uhttpd.main.listen_http
uci -q delete uhttpd.main.listen_https
uci add_list uhttpd.main.listen_http='127.0.0.1:80'
uci add_list uhttpd.main.listen_http='[::1]:80'
uci set uhttpd.main.redirect_https='0'
uci commit uhttpd
&#32;
# Reminder at every SSH login (once in the banner, even if this file runs again)
grep -q 'Sparrows web interface' /etc/banner 2&gt;/dev/null || cat &gt;&gt; /etc/banner &lt;&lt;'EOF'
 Sparrows web interface (LuCI): only through SSH. On your laptop:
   ssh -N -L 8080:127.0.0.1:80 root@&lt;this station&gt;   then open http://localhost:8080
   First time: set the root password here with  passwd   (SSH stays keys only)
&#32;
EOF
&#32;
exit 0</code></pre></div>
<h4 id="sd-card"><span lang="en">Write a Raspberry Pi image to an SD card</span> <span class="st nt" data-ui="nt">not yet tested</span></h4>
<p lang="en">Added on 2026-11-18. A Pi takes its system from an SD card, not from flash. <code>./build.sh sd</code> (or <code>s</code> in the menu, or yes after a build that made a Pi image) writes the image to a card: it asks which reader holds the card, shows what is on it, and writes nothing until you type the disk's name. Writing the image is also the formatting: the partitions come with the image, and everything that was on the card is gone. Then it reads the card back and compares it with the image. Tried on 2026-11-18 on a stand-in disk (a loop device), not yet on a real card. OpenWrt makes two kinds of Pi image, squashfs and ext4; the build keeps only squashfs, because going back to the image's defaults (<code>firstboot</code>) only works with it.</p>
<p class="note" lang="en">Erase risk: only removable, USB and MMC disks are offered, never one that holds the laptop's system. Still, read the size and the model before typing the name. A 1 TB "card" is your backup disk.</p>
<div class="code"><div class="hd"><span class="file">admin laptop, SD card in a reader</span></div><pre><code># On the admin laptop, after building a Raspberry Pi image (or s in the menu)
./build.sh sd                          # the factory .img.gz in build/images (asks which, if several)
./build.sh sd path/to/image.img.gz     # any other image
# It lists only removable, USB and MMC disks, never one that holds / /boot /home /usr /var or swap.
# It shows what is on the card, asks you to TYPE its name, writes, then reads the card back.
&#32;
# The same by hand, if the script can't run. Replace sdX, and check it twice with lsblk.
lsblk -po NAME,SIZE,TRAN,MODEL,MOUNTPOINT
gzip -dc image.img.gz &gt; card.img       # "trailing garbage ignored" is normal for OpenWrt images
sudo umount /dev/sdX?* 2&gt;/dev/null
sudo dd if=card.img of=/dev/sdX bs=4M conv=fsync status=progress
sudo blockdev --flushbufs /dev/sdX
sudo cmp -n "$(stat -c %s card.img)" card.img /dev/sdX &amp;&amp; echo "OK: the card matches"</code></pre></div>
<h4><span lang="en">2. Base shared by every station</span></h4>
<div class="code"><div class="hd"><span class="file">common/files/etc/uci-defaults/10-sparrows-common</span></div><pre><code>#!/bin/sh
# Sparrows-Network: base shared by every OpenWrt station, whatever its role.
# No IPv4, no DHCP, no RA (except on a nest: 91-sparrows-nest), no firewall, SSH keys only. The ports and radios get their uses in
# 90-sparrows-station, from /etc/sparrows/station.
# Runs once at first boot (and again after `firstboot &amp;&amp; reboot`).
# Status: NOT YET TESTED.
&#32;
. /etc/sparrows/station          # ROLE, TX2, TX5, PORTS, USE2, USE5, RETICULUM, NEST (written by build.sh)
&#32;
# --- Name: &lt;role&gt;-&lt;last 4 hex of the MAC&gt;, e.g. perch-3fa2. Same image on every unit ---
# MACDEV (in /etc/sparrows/station) = where the fixed MAC is: eth0 on most units; phy0 (the radio)
# on a unit with no Ethernet of its own, like the Pi Zero 2 W
case "${MACDEV:-eth0}" in
	phy*) MAC=$(cat "/sys/class/ieee80211/$MACDEV/macaddress" 2&gt;/dev/null) ;;
	*)    MAC=$(cat "/sys/class/net/${MACDEV:-eth0}/address" 2&gt;/dev/null) ;;
esac
[ -n "$MAC" ] || MAC=$(cat /sys/class/net/*/address 2&gt;/dev/null | grep -v '^00:00:00' | head -n1)
ID=$(echo "$MAC" | tr -d ':' | tail -c 5)
uci set system.@system[0].hostname="$ROLE-$ID"
uci set system.@system[0].log_size='16'
uci set system.@system[0].cronloglevel='9'
uci commit system
&#32;
# --- Login text: /etc/sparrows/banner (edit it in the build tree), filled in for this unit ---
# What it does, from its uses, e.g. "hedge: ports wire, 2.4 GHz flyway+feeder, 5 GHz feeder".
# No | in these texts: sed below uses it as its separator
use() { [ -z "$1" ] || [ "$1" = off ] &amp;&amp; echo off || echo "$1" | tr ' ' '+'; }
WHAT="$ROLE: ports $PORTS, 2.4 GHz $(use "$USE2"), 5 GHz $(use "$USE5")"
[ "$RETICULUM" != 1 ] || WHAT="$WHAT, Reticulum"
[ "${NEST:-0}" != 1 ] || WHAT="$WHAT, nest (RAs, DNS, welcome page, message store)"
HINT=''
case " $USE5 " in *" flyway "*) HINT="$HINT  perch status  perch ap" ;; esac
case " $USE2 $USE5 " in *" flyway "*) HINT="$HINT  batctl n  batctl o" ;; esac
case " $USE2 $USE5 " in *" feeder "*|*" join "*) HINT="$HINT  iw dev" ;; esac
[ "$RETICULUM" != 1 ] || HINT="$HINT  rns status"
[ "${NEST:-0}" != 1 ] || HINT="$HINT  logread -e odhcpd  /etc/init.d/lxmd status"
REL=$( [ -f /etc/openwrt_release ] &amp;&amp; . /etc/openwrt_release; echo "${DISTRIB_DESCRIPTION:-OpenWrt}")
[ -z "$HINT" ] || HINT="Useful here:${HINT# }"
sed -e "s|@NAME@|$ROLE-$ID|" -e "s|@ROLE@|$WHAT|" -e "s|@RELEASE@|$REL|" -e "s|@HINT@|$HINT|" \
	/etc/sparrows/banner &gt; /etc/banner
&#32;
# --- Admin: SSH keys only (P1). Failsafe mode still works for recovery ---
passwd -l root &gt;/dev/null 2&gt;&amp;1
uci set dropbear.@dropbear[0].PasswordAuth='off'
uci set dropbear.@dropbear[0].RootPasswordAuth='off'
uci commit dropbear
&#32;
# --- Network: br-lan = plain bridge. Management address by SLAAC from the nests' RAs ---
# odhcp6c is an RA *client*: it never sends RAs. With no nest up, link-local still works.
uci -q delete network.globals.ula_prefix
uci -q delete network.wan
uci -q delete network.wan6
uci -q delete network.lan.ipaddr
uci -q delete network.lan.netmask
uci -q delete network.lan.ip6assign
uci -q delete network.lan.ip6addr
uci -q delete network.lan.dns
uci set network.lan.proto='dhcpv6'
uci set network.lan.reqaddress='none'
uci set network.lan.reqprefix='no'
uci commit network
&#32;
exit 0</code></pre></div>
<h4 id="login-text"><span lang="en">Login text</span> <span class="st nt" data-ui="nt">not yet tested</span></h4>
<p lang="en">Added on 2026-11-19. Instead of OpenWrt's logo, every unit greets you at SSH login with the Sparrows text: its name, what it does, the OpenWrt version, where the handbook is, the reminder that a change by hand is only a test, and a few commands that are useful on that role. The text lives in one file of the build tree, <code>common/files/etc/sparrows/banner</code>. At first boot, the base above fills in the unit's own name and role and writes it to <code>/etc/banner</code>, which OpenWrt shows at each login. To change it, edit that one file and rebuild.</p>
<div class="code"><div class="hd"><span class="file">common/files/etc/sparrows/banner</span></div><pre><code>    .-.     Sparrows-Network   @NAME@
   (o &gt;     @ROLE@
   / )\     @RELEASE@
  --"-"--
 Handbook: http://sparrows.lan/  (the Sparrows Tao)
 This unit runs what the build tree makes. A change made here by hand is a test:
 to keep it, put it in sparrows-openwrt/ and rebuild.
 @HINT@</code></pre></div>
<div class="code"><div class="hd"><span class="file">admin laptop, then a unit</span></div><pre><code># On the admin laptop: edit the text, keep the @...@ words where you want them filled in
#   @NAME@ = feeder-26de   @ROLE@ = what this unit does   @RELEASE@ = OpenWrt version   @HINT@ = useful commands
nano sparrows-openwrt/common/files/etc/sparrows/banner
./build.sh                       # rebuild, then update the units (sysupgrade)
&#32;
# Verify: log in to a unit
ssh root@&lt;station address&gt;       # the new text, with the unit's own name
&#32;
# Try a change on one unit first, without rebuilding (gone at the next update)
vi /etc/banner
&#32;
# Undo: put the old text back in the build tree and rebuild</code></pre></div>
<h4 id="perch-image"><span lang="en">3. Perch image</span></h4>
<p lang="en">The same radio settings as the per-node script that ran on the bench on 2026-11-14, with nothing left to set per unit (name and address come from the MAC), plus bridge loop avoidance. Every perch boots as a client: a client only transmits after hearing its AP, so a fresh perch is harmless. On the one perch per flyway that must carry the radar duty, <code>perch ap</code> makes it the AP. The tool refuses channels 120 to 128 and the indoor channels. The image carries <code>batctl-default</code>, not <code>batctl-tiny</code>: <code>batctl n</code>, <code>o</code>, <code>ping</code>, <code>traceroute</code> and <code>tp</code> all work, and the CPE510 image built that way fits in its 8 MB of flash (2026-11-14). The flyway key is checked twice: by <code>build.sh</code>, and again at first boot, which logs an error if it was edited by hand.</p>
<p lang="en">First boot: the shared file in <a href="#uses">What each port and radio does</a>, with this line of <code>uses.txt</code>: <code>perch wire off flyway -</code>.</p>
<div class="code"><div class="hd"><span class="file">perch/files/usr/sbin/perch</span></div><pre><code>#!/bin/sh
# perch: switch this perch between flyway roles, or show its state.
#   perch ap  [channel]   this end beacons and does the radar duty (one AP per flyway)
#   perch sta [channel]   this end follows its AP (default after flashing)
#   perch status
# Channel: outdoor FR, HT20 = 100 104 108 112 116 132 136 140 (120-128 forbidden: weather radar).
&#32;
OK_CHANNELS='100 104 108 112 116 132 136 140'
&#32;
R=$(uci -q get wireless.flyway.device) || { echo "no flyway interface: not a perch image?" &gt;&amp;2; exit 1; }
&#32;
case "$1" in
ap|sta)
	if [ -n "$2" ]; then
		case " $OK_CHANNELS " in
			*" $2 "*) uci set wireless.$R.channel="$2" ;;
			*) echo "channel $2 not allowed outdoors. Use one of: $OK_CHANNELS" &gt;&amp;2; exit 1 ;;
		esac
	fi
	uci set wireless.flyway.mode="$1"
	if [ "$1" = ap ]; then uci set wireless.flyway.hidden='1'; else uci -q delete wireless.flyway.hidden; fi
	uci commit wireless
	wifi
	echo "flyway: $1 on channel $(uci get wireless.$R.channel)."
	if [ "$1" = ap ]; then
		echo "The AP listens 60 s for radar before it transmits: wait for DFS-CAC-COMPLETED in logread."
	fi
	;;
status)
	echo "role: $(uci get wireless.flyway.mode)  channel: $(uci get wireless.$R.channel)  txpower: $(uci -q get wireless.$R.txpower) dBm"
	iw dev 2&gt;/dev/null | grep -e Interface -e channel -e txpower
	batctl if
	batctl n          # neighbours on the flyway (needs batctl-default, not -tiny)
	logread | grep -i -e cac -e connected | tail -n 5
	;;
*)
	sed -n '2,7s/^# \{0,1\}//p' "$0"
	exit 1
	;;
esac</code></pre></div>
<div class="code"><div class="hd"><span class="file">install, verify, undo</span></div><pre><code># Find the new perch from a laptop on its cable
ping -6 -c2 ff02::1%eth0; ip -6 neigh show dev eth0
ssh root@fe80::&lt;from MAC&gt;%eth0
&#32;
# Every perch boots as a client. On the one perch per flyway that does the radar duty:
perch ap                # or: perch ap 116   (refuses 120-128 and indoor channels)
&#32;
# After ~70 s, on both ends
perch status            # AP: DFS-CAC-COMPLETED, then AP-STA-CONNECTED ... auth_alg=sae
batctl if               # phy0-ap0 / phy0-sta0: active
batctl n                # the perch at the other end of the flyway
batctl o                # every batman node of the village
batctl bl               # bridge loop avoidance: enabled
batctl tp &lt;other MAC&gt;   # throughput over the flyway (batman layer)
ip -6 addr show br-lan  # fe80:: (+ fd7e:4c1a:9b20:1:... once a nest sends RAs), no inet
&#32;
# Live signal while aiming the antennas (good: -40 to -70 dBm). Low rates on an idle link are normal
watch -n1 "iw dev phy0-sta0 link | grep -e signal -e bitrate"
&#32;
# Undo
perch sta               # back to client
firstboot &amp;&amp; reboot     # back to the image's defaults</code></pre></div>
<p class="note" lang="en">The flyway passphrase is read from <code>secrets/flyway.key</code> at build time, so it sits inside every perch image: keep perch images private, never publish them. Layer 1 doesn't rely on that passphrase, but it stays P1 debt until each flyway has its own key.</p>
<h4 id="perch-migrate"><span lang="en">Move the two bench perches to the standard</span> <span class="st nt" data-ui="nt">not yet tested</span></h4>
<p lang="en">The two CPE510s on the bench still carry the old per-node script: fixed names <code>node1</code>, <code>node2</code> and fixed addresses <code>::42</code>, <code>::43</code>. Flashing the perch image without keeping the config brings them to the standard. A fresh CPE510 takes the <code>factory</code> image from the stock web page, or the <code>sysupgrade</code> image from any OpenWrt.</p>
<p class="note" lang="en">Lock-out risk: after the flash the perch accepts SSH keys only and answers on its MAC-based addresses only. Check that your key is in <code>keys/</code> before building, and do it with the unit on a cable.</p>
<div class="code"><div class="hd"><span class="file">laptop, perch, nest</span></div><pre><code># Not yet tested. Do it on the bench, the client end (old node2) first, the AP end (old node1) last.
# LOCK-OUT RISK: after this the perch takes SSH keys only, and its old fixed address is gone.
scp -O build/images/*sparrows-perch*cpe510-v3*sysupgrade.bin 'root@[fd7e:4c1a:9b20:1::43]:/tmp/fw.bin'
ssh root@fd7e:4c1a:9b20:1::43
sysupgrade -T /tmp/fw.bin          # checks the image, flashes nothing
sysupgrade -n -v /tmp/fw.bin       # -n drops the old config, so the image's first-boot defaults run
&#32;
# Back in by link-local, with the key (address from the MAC on the sticker)
ssh root@fe80::&lt;from MAC&gt;%eth0
uci get system.@system[0].hostname # perch-xxxx
&#32;
# Same on the other perch (::42), then on that one only:
perch ap
&#32;
# On the nest: delete the two host-record lines for node1 and node2 in /etc/dnsmasq.d/mesh.conf, then
sudo dnsmasq --test &amp;&amp; sudo systemctl restart dnsmasq</code></pre></div>
<h4 id="eap"><span lang="en">4. Feeder image, example: EAP225-Outdoor</span></h4>
<p lang="en">Open SSID on both bands, clients can reach each other (Reticulum works phone to phone), multicast is sent to each client as unicast so RAs arrive reliably, no per-client log lines.</p>
<p lang="en">Three units arrived on 2026-11-14: two v1 and one v3. Both versions are supported by OpenWrt and are nearly the same box: the same SoC with its 2.4 GHz radio, a QCA9886 for 5 GHz, 128 MB of RAM and 16 MB of flash; the v3 differs by its Ethernet chip. Each gets the image built for its own version: check the label before flashing.</p>
<p lang="en">First boot: the shared file in <a href="#uses">What each port and radio does</a>, with this line of <code>uses.txt</code>: <code>feeder wire feeder feeder -</code>.</p>
<p lang="en">Flash the <code>factory</code> image as described in <a href="#flash-eap">Flash an EAP225-Outdoor</a> below, then plug the feeder into the site switch. Wait about 70 s after boot for the radar check on 5 GHz.</p>
<div class="code"><div class="hd"><span class="file">verify</span></div><pre><code># From a nest or a laptop on the mesh: find the feeder by its MAC
ping -6 -c2 ff02::1%eth0; ip -6 neigh show dev eth0
ssh root@fe80::&lt;from MAC&gt;%eth0
&#32;
# On the feeder (hostname feeder-&lt;last 4 hex of the MAC&gt;)
ip -6 addr show br-lan          # fe80:: (+ fd7e:4c1a:9b20:1:... once a nest sends RAs), no inet
iw dev                          # two APs, ch 132 / auto, txpower 23 / 17
logread | grep -i cac           # DFS-CAC-COMPLETED on 5 GHz
ps | grep -e dnsmasq -e odhcpd  # nothing
&#32;
# From a laptop on the SSID: only the nests should answer
rdisc6 wlan0</code></pre></div>
<div class="code"><div class="hd"><span class="file">undo</span></div><pre><code>firstboot &amp;&amp; reboot             # back to this image's defaults
# Locked out: failsafe mode (reset button during boot) -&gt; 192.168.1.1
# Back to stock firmware: procedure on the OpenWrt wiki page of the device</code></pre></div>
<p class="note" lang="en">Two open points. Any phone on the open SSID can send a rogue RA, and the bridge would spread it. Dropping RAs that arrive from the Wi-Fi side would fix it, but that is an exception to "never filter ICMPv6": not decided, not in the image. And TP-Link's CE figure for this unit is 27 dBm EIRP on 5 GHz, because it has no transmit power control (TPC), hence 23 dBm at the radio in <code>profiles.txt</code>. If the CPE510 has no TPC either, the same rule gives 14 dBm at its radio, not 17. To check against the French rules before perches go on masts: it is one number in <code>profiles.txt</code>.</p>
<h4 id="zero"><span lang="en">Feeder on a Raspberry Pi Zero 2 W</span> <span class="st nt" data-ui="nt">not yet tested</span></h4>
<p lang="en">Added on 2026-11-19. The Zero 2 W is not a standard OpenWrt device, so it has a folder of its own, <code>devices/rpi-zero-2-w/</code>, and <code>profiles.txt</code> names that folder instead of an OpenWrt profile. What differs:</p>
<ul lang="en">
  <li><strong>Image:</strong> OpenWrt has none of its own. The Pi 3 image (<code>rpi-3</code>) boots it: same chip.</li>
  <li><strong>Wi-Fi firmware:</strong> OpenWrt doesn't ship it, because its licence is unclear. The build fetches it from Raspberry Pi's firmware repository at a fixed version and checks every file. Images that contain it are for the village's own units: don't put them in a public kit.</li>
  <li><strong>No Ethernet on the board:</strong> the village cable goes into a USB Ethernet adapter, on the port marked USB through an OTG cable or hub. Drivers for the common adapters are in the image.</li>
  <li><strong>MAC:</strong> the adapter can be swapped, so the name and the address come from the radio's MAC.</li>
  <li><strong>Radio:</strong> 2.4 GHz only, a fixed channel (6), because its driver can't pick one by itself. So it can be a feeder (with the adapter) or a <a href="#tree-image">tree</a> (Wi-Fi client, no adapter), not a perch or a hedge.</li>
</ul>
<p class="note" lang="en">Small: its Wi-Fi chip serves only a few phones at a time, and may not send multicast to each client as unicast, so RAs can arrive late. Fine for a corner of the village, not for the square. Build it with <code>./build.sh</code>, pick the <code>rpi-zero-2-w</code> line, then write the card with <code>./build.sh sd</code>.</p>
<div class="code"><div class="hd"><span class="file">devices/rpi-zero-2-w/device.conf</span></div><pre><code># Raspberry Pi Zero 2 W: not a standard OpenWrt device. build.sh reads this file when a line of
# profiles.txt names "rpi-zero-2-w" in its profile column.
# Status: NOT YET TESTED on the unit (written 2026-11-19).
&#32;
# OpenWrt has no image of its own for it: the Pi 3 image boots it (same SoC, BCM2710).
IB_PROFILE='rpi-3'
&#32;
# What its radio can do (uses.txt): access point and client, but no 802.11s mesh in its driver,
# so no flyway. The build refuses a flyway on it. One band only: 2.4 GHz.
CAN2='feeder join'
CAN5=''
&#32;
# No Ethernet on the board: the village cable goes into a USB Ethernet adapter on the micro-USB
# OTG port (an OTG cable or hub). Drivers for the common adapters:
#   cdc-ether = generic, rtl8152 = Realtek RTL8152/8153, asix = AX88772, asix-ax88179 = AX88179
DEV_PACKAGES='kmod-usb-net-cdc-ether kmod-usb-net-rtl8152 kmod-usb-net-asix kmod-usb-net-asix-ax88179'
&#32;
# The only fixed MAC on the board is the radio's: the name (feeder-xxxx) and address come from it,
# not from the USB adapter, which can be swapped.
MACDEV='phy0'
&#32;
# Its Wi-Fi driver has no automatic channel choice (ACS): a fixed 2.4 GHz channel.
CH2='6'
&#32;
# Wi-Fi firmware: not shipped by OpenWrt (licence unclear), so the build fetches it from the
# Raspberry Pi firmware repository, at a fixed commit, and checks each file. Two chip variants exist
# (43436 and 43436s): both go in, the driver picks the right one.
# Images that contain it are for the village's own units: don't put them in a public kit.
FW_URL='https://github.com/RPi-Distro/firmware-nonfree/raw/c91cd2804cf7463aab913e7247c176049f16bbd6/debian/config/brcm80211/brcm'
FW_DIR='lib/firmware/brcm'
FW_FILES='
510a7dd1e056199b309425548ee0bd846993a1837ac7fa1e4d3e641f05a1327a  brcmfmac43436-sdio.bin
4cda90facd8844cff60d80b34b24ecbae76adb9a62508a109461b8bf42b478d1  brcmfmac43436-sdio.txt
fce7cbb62ffa6a5a65ca97b13f6fbf28d06c02d986c2072d65bf72164755fc34  brcmfmac43436-sdio.clm_blob
68b9bcc9855d91733cd44c21de4cb507c91b0d32d838c0696def5eb96c99e2de  brcmfmac43436s-sdio.bin
37a8b85a5a9742761101b764a07bc4d0c8b09f2e180eaea3b503a834277ad595  brcmfmac43436s-sdio.txt
'</code></pre></div>
<div class="code"><div class="hd"><span class="file">devices/rpi-zero-2-w/files/etc/uci-defaults/20-sparrows-device</span></div><pre><code>#!/bin/sh
# Sparrows-Network: Raspberry Pi Zero 2 W. Runs after the common base, before the role.
# No Ethernet on the board: OpenWrt puts the Wi-Fi in the LAN bridge. Here the bridge gets the USB
# Ethernet adapter (eth0) instead; the role adds its Wi-Fi to the bridge itself.
# Name and address both come from the radio's MAC (MACDEV in device.conf), not the adapter's.
# Status: NOT YET TESTED.
&#32;
BR=$(uci show network | sed -n "s/^network\.\([^.]*\)\.name='br-lan'$/\1/p")
if [ -z "$BR" ]; then
	BR='brlan'
	uci set network.$BR=device
	uci set network.$BR.name='br-lan'
	uci set network.$BR.type='bridge'
fi
uci -q delete network.$BR.ports
uci add_list network.$BR.ports='eth0'
uci set network.lan.device='br-lan'
# The bridge takes the radio's MAC, so the village address comes from the same MAC as the name
MAC=$(cat /sys/class/ieee80211/phy0/macaddress 2&gt;/dev/null)
[ -z "$MAC" ] || uci set network.$BR.macaddr="$MAC"
uci commit network
&#32;
exit 0</code></pre></div>
<div class="code"><div class="hd"><span class="file">laptop on the village cable, then the Pi</span></div><pre><code># Before the first boot: the factory image written with ./build.sh sd. A USB Ethernet adapter in the
# port marked USB (not PWR), through an OTG cable or hub, and the village cable in the adapter.
# Find it from a laptop on that cable. Its name and address come from the radio's MAC, not the adapter's.
ping -6 -c2 ff02::1%eth0; ip -6 neigh show dev eth0
ssh root@fe80::&lt;from the radio MAC&gt;%eth0
&#32;
# On the Pi (hostname feeder-&lt;last 4 hex of the radio MAC&gt;)
dmesg | grep -i brcmfmac        # "using brcm/brcmfmac43436-sdio" (or 43436s): firmware found
iw dev                          # one AP, channel 6
bridge link                     # eth0 (the adapter) and the Wi-Fi, both in br-lan
ip -6 addr show br-lan          # fe80:: from the radio MAC (+ fd7e:4c1a:9b20:1:... once a nest sends RAs)
ps | grep -e dnsmasq -e odhcpd  # nothing
&#32;
# From a phone on the SSID: it joins, gets an address from the nest, reaches http://sparrows.lan/
&#32;
# Undo: write the SD card again, with another image or with Raspberry Pi OS</code></pre></div>
<h4 id="hedge-image"><span lang="en">5. Hedge image: feeder and perch in one box, example: EAP225-Outdoor</span> <span class="st nt" data-ui="nt">not yet tested</span></h4>
<p lang="en">The EAP225-Outdoor has two radios, so one box can both let people in and carry the village. The hedge image gives each radio a job:</p>
<ul lang="en">
  <li><strong>5 GHz:</strong> the open <code>Sparrows</code> Wi-Fi on channel 132, exactly as on a feeder. Most phones use this one.</li>
  <li><strong>2.4 GHz:</strong> an 802.11s mesh, <code>sparrows-hedge</code>, on channel 1, encrypted with SAE, carrying batman-adv to the neighbouring hedges. The same radio also serves the open <code>Sparrows</code> Wi-Fi for devices that only have 2.4 GHz.</li>
  <li><strong>Ethernet:</strong> bridged as on every station. A hedge cabled to a site switch joins the perches and nests on it.</li>
</ul>
<p lang="en">Why 802.11s on 2.4 GHz: it is the only band where 802.11s works for us (never on DFS channels), and a mesh needs no AP and client roles, so there is nothing to set per unit and no radar wait on the backbone side. It is also how Freifunk communities run this kind of box. It serves P3 (any hedge relays, losing one loses nothing) and "works for amateurs" (flash, power, done).</p>
<p lang="en"><span class="st idea" data-ui="idea">idea</span> Not chosen for now: the EAP joining a CPE510 flyway on 5 GHz as a client, with the open Wi-Fi on the same radio. The open Wi-Fi would then sit on the flyway's channel and eat its airtime, and an access point next to a client on a DFS channel is untested ground.</p>
<p lang="en">First boot: the shared file in <a href="#uses">What each port and radio does</a>, with this line of <code>uses.txt</code>: <code>hedge wire flyway+feeder feeder -</code>.</p>
<div class="code"><div class="hd"><span class="file">install, verify, undo</span></div><pre><code># Find it like a feeder, from a laptop on its cable
ping -6 -c2 ff02::1%eth0; ip -6 neigh show dev eth0
ssh root@fe80::&lt;from MAC&gt;%eth0
&#32;
# On the hedge (hostname hedge-&lt;last 4 hex of the MAC&gt;)
iw dev | grep -e Interface -e type -e channel   # 2.4 GHz: mesh point + AP, ch 1; 5 GHz: AP, ch 132
logread | grep -i -e cac -e mesh                # DFS-CAC-COMPLETED on 5 GHz; mesh peering on 2.4 GHz
batctl if                       # the 2.4 GHz mesh interface: active
batctl n                        # the other hedges in radio range
batctl o                        # every batman node of the village
batctl bl                       # bridge loop avoidance: enabled
batctl tp &lt;other hedge MAC&gt;     # throughput between two hedges
ps | grep -e dnsmasq -e odhcpd  # nothing
&#32;
# From a laptop on the SSID: only the nests should answer
rdisc6 wlan0
ip -6 route | grep default      # default via the nest's fe80 only (seen 2026-11-14)
ip -6 addr show wlan0           # SLAAC addresses from the nest's prefixes
&#32;
# Undo
firstboot &amp;&amp; reboot             # back to this image's defaults
# Or flash the feeder image: same box, open Wi-Fi only</code></pre></div>
<h4 id="tree-image"><span lang="en">Tree image: a Reticulum relay and the Sparrows page, on the village Wi-Fi, example: Pi Zero 2 W</span> <span class="st nt" data-ui="nt">not yet tested</span></h4>
<p lang="en">Added on 2026-11-19. A <a class="term" href="#g-tree">tree</a> on OpenWrt. It joins the open <code>Sparrows</code> Wi-Fi as a client, like a phone, gets its address from the nests' RAs, and runs <code>rnsd</code> with transport on, so it relays Reticulum traffic for the others. It bridges nothing, sends no RA, serves no on-ramp. On a Pi Zero 2 W it needs no USB adapter: plug it in where the Wi-Fi reaches.</p>
<p lang="en">Reticulum is not an OpenWrt package. <code>build.sh</code> downloads its wheel at a pinned version (<code>tree/role.conf</code>: version and sha256), checks it, and unpacks it into the image, so the tree needs no Internet and no <code>pip</code>. Python and the two libraries Reticulum needs come from OpenWrt. <code>rnsd</code> runs as its own user, not root, and its identity survives updates. The config was checked on 2026-11-19 with <code>rnsd</code> 1.6.1 on a laptop (it starts, the interface waits for <code>wsta</code>); the image itself has not run yet. It needs room: SD-card devices only, never 8 or 16 MB of flash.</p>
<div class="code"><div class="hd"><span class="file">tree/role.conf</span></div><pre><code># Sparrows-Network: what Reticulum needs beyond OpenWrt packages. Read by build.sh for any image
# that runs Reticulum (the tree role, or a reticulum service in uses.txt or a manual line).
# Python wheels, pinned by version and sha256, unpacked into /usr/lib/sparrows/python in the image,
# so the unit needs no Internet and no pip. A new version = a new line here, after a bench test.
#   rns + lxmf + nomadnet: Reticulum, messages, the page node
#   urwid, wcwidth, qrcode, typing_extensions: what nomadnet imports (wcwidth 0.8.5: the last pure-Python one)
WHEELS='
f276cb7d818df5cfd6ecc59a8a4f3344e47d46acdfdb48e75537400309547959  https://files.pythonhosted.org/packages/b1/df/c8ad51a9b2b7af893290fa06b8de272507800642808120fb8d5c3e4c3fa2/rns-1.6.1-0-py3-none-any.whl
42795725445177c78522154c234bc0aabcdb93b7f85883a27921a37ec86d9416  https://files.pythonhosted.org/packages/3f/09/c16d278a4e30f6af867d04ad0d6c501dcec3d9762f5d60cc44b3b6c3c22a/lxmf-1.3.1-py3-none-any.whl
bb075315d310951d3cc894f7c21cc7fab3c5b8c802af3ffad4d1fa4e54093329  https://files.pythonhosted.org/packages/da/66/2c17e08b5ba17d28f15bd2abf1a5aa664e6a58e7e541b7c9bb45578ed04e/nomadnet-1.5.1-py3-none-any.whl
6ec613909e3839f665dd23aa5b46c2698e476f3af8f8b760b5d012938af99475  https://files.pythonhosted.org/packages/03/42/486b3e7083bb0491187559385d7bc42694e216ab0afaa0f2fea1bb1ff938/urwid-5.1.3-py3-none-any.whl
04c88cff9dc3766fe621898afcaff8af3d803b4268804c348f6d973d61e862dc  https://files.pythonhosted.org/packages/2e/b6/138605bb73076873eb382840af4239127d197bbc3d43e7743e15e80278b0/wcwidth-0.8.5-py3-none-any.whl
16e64e0716c14960108e85d853062c9e8bba5ca8252c0b4d0231b9df4060ff4f  https://files.pythonhosted.org/packages/dd/b8/d2d6d731733f51684bbf76bf34dab3b70a9148e8f2cef2bb544fccec681a/qrcode-8.2-py3-none-any.whl
481caa481374e813c1b176ada14e97f1f67a4539ce9cfeb3f350d78d6370c2e8  https://files.pythonhosted.org/packages/49/d3/b8441a820a491ddfc024b0b0cf0393375b75ea13866d9c66727e54c2fc80/typing_extensions-4.16.0-py3-none-any.whl
'
&#32;
# The built handbook (tao/index.html, next to sparrows-openwrt/) goes in the image too, as a file the
# page node offers for download. Rebuild the Tao before the image to ship the latest one.
HANDBOOK_TO='usr/share/sparrows/nomadnet/files/sparrows-tao.html'</code></pre></div>
<p lang="en">First boot: the shared file in <a href="#uses">What each port and radio does</a>, with this line of <code>uses.txt</code>: <code>tree wire join join reticulum</code>.</p>
<p lang="en">On a <code>tree+feeder</code> unit (or a nest) no radio joins, so Reticulum runs on the village bridge, <code>br-lan</code>, instead of <code>wsta</code>: first boot writes the right one in the config below.</p>
<div class="code"><div class="hd"><span class="file">tree/files/etc/reticulum/config</span></div><pre><code># Sparrows-Network: Reticulum transport node (tree, or any unit with the reticulum service).
# Status: NOT YET TESTED on OpenWrt.
[reticulum]
  enable_transport = Yes          # a tree relays for the others
  share_instance = Yes            # rns status and the other tools use this rnsd
  panic_on_interface_error = No
&#32;
[logging]
  loglevel = 2                    # errors only: a tree remembers as little as possible
&#32;
[interfaces]
  # The village. First boot puts the interface here: wsta (the Wi-Fi client) when a radio joins the
  # Sparrows Wi-Fi, br-lan (the village bridge: wire and feeders) when none does
  [[Sparrows]]
    type = AutoInterface
    enabled = yes
    devices = @RNSDEV@</code></pre></div>
<div class="code"><div class="hd"><span class="file">tree/files/etc/init.d/rnsd</span></div><pre><code>#!/bin/sh /etc/rc.common
# Sparrows-Network tree: Reticulum transport daemon, as user rns, restarted if it stops.
&#32;
START=95
STOP=10
USE_PROCD=1
&#32;
start_service() {
	procd_open_instance
	procd_set_param env PYTHONPATH=/usr/lib/sparrows/python
	procd_set_param command /usr/bin/python3 -m RNS.Utilities.rnsd --config /etc/reticulum -s
	procd_set_param user rns
	procd_set_param respawn 3600 5 0
	procd_close_instance
}</code></pre></div>
<div class="code"><div class="hd"><span class="file">tree/files/usr/bin/rns</span></div><pre><code>#!/bin/sh
# rns: the Reticulum tools on a Sparrows tree, with its config.
#   rns status          interfaces and traffic (rnstatus)
#   rns path &lt;hash&gt;     is there a path to this destination (rnpath)
#   rns probe &lt;...&gt;     (rnprobe)
[ -n "$1" ] || { sed -n '2,5s/^# \{0,1\}//p' "$0"; exit 1; }
TOOL=$1; shift
PYTHONPATH=/usr/lib/sparrows/python exec /usr/bin/python3 -m "RNS.Utilities.rn$TOOL" --config /etc/reticulum "$@"</code></pre></div>
<h4 id="sparrows-page"><span lang="en">The Sparrows page, served by every tree</span> <span class="st nt" data-ui="nt">not yet tested</span></h4>
<p lang="en">Added on 2026-11-19. Each tree also runs Nomad Network in node mode, so anyone with a Reticulum app (Nomad Network, MeshChat) can read a short page about Sparrows-Network: what it is, how to join, the birds, the rules we keep, how to help. It is in English, French and Spanish, with links between them, and offers this handbook as a file to download. The tree announces itself as <code>Sparrows-Network (tree-xxxx)</code> every six hours. It stores no messages: that stays on the nests (<code>lxmd</code>). A tree is a relay first; it serves this page because it has room, as the <a href="#role-tree">tree</a> card allows.</p>
<p lang="en">The pages are Micron, Nomad Network's markup, in the build tree: <code>index.mu</code> (English, below), <code>fr.mu</code> and <code>es.mu</code> next to it. Change all three together. Nomad Network and the libraries it needs come as pinned wheels, like Reticulum. Checked on 2026-11-19 on a laptop, from the files <code>build.sh</code> put in the image: the node started and served the three pages and the handbook file to a second Reticulum program. Not yet run on OpenWrt.</p>
<div class="code"><div class="hd"><span class="file">tree/files/usr/share/sparrows/nomadnet/pages/index.mu</span></div><pre><code>#!c=3600
&gt;Sparrows-Network
&#32;
`c`!Standalone Peer Access Radio Relay Over Wireless Stations`!
`a
`[English`:/page/index.mu]  ·  `[Français`:/page/fr.mu]  ·  `[Español`:/page/es.mu]
`a
&#32;
-
&#32;
A community network that runs without the Internet. Fixed Wi-Fi stations carry it across the village, and later from one village to the next.
&#32;
You reached this page over it: it was served by a small box nearby, called a tree.
&#32;
&gt;&gt;Join
&#32;
`!1.`! Connect to the open Wi-Fi `!Sparrows`!. No password, no account.
`!2.`! Open `!http://sparrows.lan/`! in a browser: the handbook, the Sparrows Tao.
`!3.`! To write to others, use a Reticulum app: Sideband on Android, MeshChat or Nomad Network on a laptop. Your app makes your key. Your key is your address.
&#32;
&gt;&gt;How it works
&#32;
Stations are named after birds:
 `!nest`!     the village's small server: addresses, the welcome page, a mailbox for messages
 `!perch`!    a radio on a mast; two perches make a `!flyway`! between places
 `!feeder`!   open Wi-Fi where people connect
 `!hedge`!    a feeder that also links to the next hedges by radio
 `!tree`!     a relay anyone can plant: it passes on what it hears
&#32;
&gt;&gt;The rules we keep
&#32;
 - No Internet on the network, no account, no logs.
 - You are your key, not a login an admin can delete.
 - A commons: anyone can add a station or a tree. Each village holds its own keys.
&#32;
&gt;&gt;Help
&#32;
Plant a tree, put up a feeder, or bring a mast. Everything is in the handbook.
`[Download the handbook (HTML file)`:/file/sparrows-tao.html]</code></pre></div>
<div class="code"><div class="hd"><span class="file">tree/files/etc/nomadnetwork/config</span></div><pre><code># Sparrows-Network tree: Nomad Network in node mode, serving the Sparrows page. No client, no UI.
# Status: NOT YET TESTED on OpenWrt.
[logging]
  loglevel = 2                    # errors only
  destination = file
&#32;
[client]
  enable_client = no
  announce_at_start = no
&#32;
[node]
  enable_node = yes
  node_name = Sparrows-Network (@NAME@)       # first boot puts the unit's name here
  announce_at_start = yes
  announce_interval = 360         # minutes: every 6 hours
  pages_path = /usr/share/sparrows/nomadnet/pages
  files_path = /usr/share/sparrows/nomadnet/files
  disable_propagation = yes       # message storage stays on the nests (lxmd)</code></pre></div>
<div class="code"><div class="hd"><span class="file">tree/files/etc/init.d/nomadnet</span></div><pre><code>#!/bin/sh /etc/rc.common
# Sparrows-Network tree: Nomad Network page node (the Sparrows page), as user rns.
# It uses the rnsd started just before it (shared instance).
&#32;
START=96
STOP=09
USE_PROCD=1
&#32;
start_service() {
	procd_open_instance
	procd_set_param env PYTHONPATH=/usr/lib/sparrows/python HOME=/etc/nomadnetwork
	procd_set_param command /usr/bin/python3 -m nomadnet.nomadnet --daemon \
		--config /etc/nomadnetwork --rnsconfig /etc/reticulum
	procd_set_param user rns
	procd_set_param respawn 3600 10 0
	procd_close_instance
}</code></pre></div>
<div class="code"><div class="hd"><span class="file">admin laptop, or one tree to try</span></div><pre><code># On the admin laptop: the page is Micron markup, one file per language
cd sparrows-openwrt/tree/files/usr/share/sparrows/nomadnet/pages
nano index.mu fr.mu es.mu         # keep the three saying the same thing
cd - &amp;&amp; ./build.sh tree           # rebuild (rebuild the Tao first: the image ships tao/index.html too)
&#32;
# Try it on one tree first: the pages are in the read-only image, so copy them to the overlay
mkdir -p /etc/sparrows-pages &amp;&amp; cp /usr/share/sparrows/nomadnet/pages/* /etc/sparrows-pages/
vi /etc/sparrows-pages/index.mu
sed -i 's|^  pages_path = .*|  pages_path = /etc/sparrows-pages|' /etc/nomadnetwork/config
/etc/init.d/nomadnet restart
&#32;
# Undo the try: put pages_path back to /usr/share/sparrows/nomadnet/pages, restart, rm -r /etc/sparrows-pages</code></pre></div>
<div class="code"><div class="hd"><span class="file">laptop on the village, then the tree</span></div><pre><code># Find it from a laptop on the village Wi-Fi or cable. Name and address come from the radio's MAC.
ping -6 -c2 ff02::1%&lt;if&gt;; ip -6 neigh show dev &lt;if&gt;
ssh root@&lt;its fe80:: or fd7e:4c1a:9b20:1:... address&gt;
&#32;
# On the tree (hostname tree-&lt;last 4 hex of the radio MAC&gt;)
iw dev wsta link                 # Connected to ... SSID: Sparrows
ip -6 addr show wsta             # fe80:: + SLAAC addresses from the nests' prefixes, no inet
/etc/init.d/rnsd status          # running
rns status                       # "Sparrows" interface Up, transport on
/etc/init.d/nomadnet status      # running: the page node
logread | grep -i python         # nothing (errors would show here)
ps | grep -e dnsmasq -e odhcpd   # nothing
&#32;
# From a laptop on the village with Reticulum: the tree is seen as a peer
rnstatus
# In Nomad Network or MeshChat: Network -&gt; announced nodes -&gt; "Sparrows-Network (tree-xxxx)"
# The page opens in English, with links to French and Spanish, and the handbook to download.
&#32;
# Undo the page only: /etc/init.d/nomadnet disable &amp;&amp; /etc/init.d/nomadnet stop
# Undo all: write the card with another image</code></pre></div>
<h4 id="nest-image"><span lang="en">Nest image: a Raspberry Pi 4 as nest + feeder</span> <span class="st nt" data-ui="nt">not yet tested</span></h4>
<p lang="en">Decided on 2026-11-21: nests run OpenWrt too, so every unit of the village runs one system, is built by one <code>build.sh</code> and updated one way. The nest is a role like the others, so one Pi 4 can be <code>nest+feeder</code>: its cable on the site's switch, its own Wi-Fi as <code>Sparrows</code> Wi-Fi. It has no home side: admin from a laptop on the village with the SSH key, software as images built on the admin laptop. The Debian nest below stays the running one until this image passes the same checks on the bench (RAs, DNS, router flag, Android, the welcome page, Reticulum).</p>
<ul lang="en">
  <li><strong>Address:</strong> fixed, from its MAC, as every station builds by SLAAC: <code>fd7e:4c1a:9b20:1:</code> + the interface ID. Two nests never clash, and none is "the" nest at <code>::1</code>.</li>
  <li><strong>RAs:</strong> <code>odhcpd</code>, SLAAC only, router lifetime 1800 s, the router flag, its own address as DNS server and <code>sparrows.lan</code> as domain inside. The same values as the tested Debian nest.</li>
  <li><strong>DNS:</strong> <code>dnsmasq</code> with DHCP off and no upstream: every name, <code>sparrows.lan</code> included, points to this nest. No query log.</li>
  <li><strong>Welcome page:</strong> <code>uhttpd</code> on the nest's village addresses, serving this handbook; any unknown path gives the page, so a phone's connection check lands on it.</li>
  <li><strong>Reticulum:</strong> <code>rnsd</code> with transport, <code>lxmd</code> as message store, and the Sparrows page, all from the pinned wheels.</li>
  <li><strong>Still never:</strong> IPv4, DHCP, a firewall. The build's rule check lets <code>odhcpd</code>, <code>dnsmasq</code> and <code>uhttpd</code> into a nest image only.</li>
  <li><strong>The Pi 4's Wi-Fi:</strong> access point and client only (no mesh, so no flyway), 2.4 GHz on channel 6 (no automatic channel in its driver). No 5 GHz feeder: its chip can't do the radar check the outdoor channels need. A small access point: fine for a house or a garden.</li>
  <li><strong>Android:</strong> the image announces <code>2001:db8:1::/64</code>, the bench prefix, next to the village one, as the Debian nest does. The real non-ULA prefix is still to decide.</li>
</ul>
<p class="note" lang="en">Lock-out risk: the Pi then has no home Wi-Fi. Check that your key is in <code>keys/</code> before building, and keep the Debian SD card aside: putting it back is the undo.</p>
<div class="code"><div class="hd"><span class="file">admin laptop, then a laptop on the village</span></div><pre><code># Not yet tested. ---- On the admin laptop: the line is already in profiles.txt ----
#   nest+feeder bcm27xx/bcm2711 rpi-4   17   -   ui
./build.sh nest                  # shows what each interface will do, then builds
./build.sh sd                    # write the rpi-4 factory .img.gz to a NEW card (keep the Debian card aside)
&#32;
# Its village address comes from the Ethernet MAC (on the Pi:  cat /sys/class/net/eth0/address)
# e.g. dc:a6:32:12:34:56  -&gt;  fd7e:4c1a:9b20:1:dea6:32ff:fe12:3456   (same rule as names-find)
&#32;
# ---- Card in the Pi, cable on the site's switch. From a laptop on the village ----
ping -6 -c2 ff02::1%&lt;if&gt;; ip -6 neigh show dev &lt;if&gt;
ssh root@fe80::&lt;from MAC&gt;%&lt;if&gt;
# On the nest (hostname nest-feeder-xxxx)
. /etc/sparrows/station; echo $ADDR        # its village address
ip -6 addr show br-lan                     # fd7e:4c1a:9b20:1:... and 2001:db8:1:... /64, no inet
bridge link                                # eth0 and the Wi-Fi AP, both in br-lan
iw dev                                     # one AP, SSID Sparrows, channel 6
logread -e odhcpd                          # RAs sent on br-lan, no error
netstat -lnu | grep ':53 '; netstat -ltn | grep ':80 '   # dnsmasq on 53, uhttpd on the village addresses
rns status                                 # "Sparrows" interface Up, on br-lan
/etc/init.d/lxmd status                    # running: the message store
&#32;
# ---- From the laptop (and a phone on the Sparrows Wi-Fi): the same checks as the Debian nest ----
rdisc6 &lt;if&gt;                       # both prefixes, Router lifetime 1800, the nest's address as DNS
ip -6 neigh show dev &lt;if&gt;         # the nest's fe80 entry says "router"
dig AAAA sparrows.lan @&lt;nest address&gt;        # the nest's address
curl -sI http://connectivitycheck.gstatic.com/generate_204   # the welcome page, not 204
ping 192.168.1.1                  # must FAIL (no IPv4)
# On an Android phone: "connected / no Internet", an fd7e: and a 2001:db8: address, the page opens
&#32;
# Undo: put the Debian SD card back in the Pi</code></pre></div>
<div class="code"><div class="hd"><span class="file">nest/files/etc/uci-defaults/91-sparrows-nest</span></div><pre><code>#!/bin/sh
# Sparrows-Network: nest services, on OpenWrt (decided 2026-11-21: one system on every unit).
# The same on-ramp as the Debian nest, with OpenWrt's own tools:
#   a fixed village address, built from the MAC (EUI-64), so every nest has its own: nests are equal
#   odhcpd   router advertisements: SLAAC only, the router flag, the DNS server and domain inside
#   dnsmasq  DNS only, no DHCP: sparrows.lan and every other name -&gt; this nest (catch-all)
#   uhttpd   the welcome page (this handbook) on the village address
#   rnsd + lxmd   Reticulum relay and the message store (propagation node)
# Still never: IPv4, DHCP, a firewall, a link to the Internet. Runs after 90-sparrows-station.
# Status: NOT YET TESTED.
&#32;
. /etc/sparrows/station
&#32;
ULA='fd7e:4c1a:9b20:1'           # the village prefix, as on the Debian nest
NONULA='2001:db8:1'              # BENCH ONLY (documentation range): Android wants a non-ULA prefix.
                                 # The real one is not decided yet
&#32;
# --- Interface ID from the MAC, the same rule as every station: flip bit 2 of byte 1, ff:fe inside ---
case "${MACDEV:-eth0}" in
	phy*) MAC=$(cat "/sys/class/ieee80211/$MACDEV/macaddress" 2&gt;/dev/null) ;;
	*)    MAC=$(cat "/sys/class/net/${MACDEV:-eth0}/address" 2&gt;/dev/null) ;;
esac
OLDIFS=$IFS; IFS=':'
# shellcheck disable=SC2086
set -- $MAC
IFS=$OLDIFS
IID=$(printf '%02x%s:%sff:fe%s:%s%s' $((0x$1 ^ 2)) "$2" "$3" "$4" "$5" "$6")
ADDR="$ULA:$IID"
ADDR2="$NONULA:$IID"
echo "ADDR='$ADDR'" &gt;&gt; /etc/sparrows/station
&#32;
# --- The village bridge gets fixed addresses instead of SLAAC: a nest sends RAs, it doesn't take them ---
uci set network.lan.proto='static'
uci -q delete network.lan.reqaddress
uci -q delete network.lan.reqprefix
uci -q delete network.lan.ip6addr
uci add_list network.lan.ip6addr="$ADDR/64"
uci add_list network.lan.ip6addr="$ADDR2/64"
uci commit network
&#32;
# --- Router advertisements (odhcpd). Nothing else from it: no DHCPv4, no DHCPv6 ---
uci set dhcp.odhcpd.maindhcp='0'
uci set dhcp.lan=dhcp
uci set dhcp.lan.interface='lan'
uci set dhcp.lan.ignore='1'               # dnsmasq: no DHCPv4 here
uci set dhcp.lan.dhcpv4='disabled'
uci set dhcp.lan.dhcpv6='disabled'        # SLAAC only (Android ignores DHCPv6 anyway)
uci set dhcp.lan.ra='server'
uci set dhcp.lan.ra_flags='none'          # no managed / other-config flag
uci set dhcp.lan.ra_slaac='1'
uci set dhcp.lan.ra_default='2'           # announce a default router though there is no route out:
                                          # Android drops a network without one. Nothing is forwarded:
                                          # this nest has no other network to forward to
uci set dhcp.lan.ra_maxinterval='60'      # RA every 60 s at most
uci set dhcp.lan.ra_lifetime='1800'       # router lifetime 1800 s, as on the Debian nest
uci -q delete dhcp.lan.dns
uci add_list dhcp.lan.dns="$ADDR2"        # non-ULA first: some Android versions drop a ULA DNS server
uci add_list dhcp.lan.dns="$ADDR"
uci -q delete dhcp.lan.domain
uci add_list dhcp.lan.domain='sparrows.lan'
&#32;
# --- DNS (dnsmasq): no upstream, sparrows.lan and every other name -&gt; this nest ---
uci set dhcp.@dnsmasq[0].noresolv='1'
uci set dhcp.@dnsmasq[0].domainneeded='1'
uci set dhcp.@dnsmasq[0].domain='sparrows.lan'
uci set dhcp.@dnsmasq[0].local='/sparrows.lan/'
uci set dhcp.@dnsmasq[0].logqueries='0'   # never log who asks for what
uci -q delete dhcp.@dnsmasq[0].address
uci add_list dhcp.@dnsmasq[0].address="/#/$ADDR"   # captive: any name -&gt; the welcome page
uci commit dhcp
&#32;
# --- Welcome page (uhttpd), on the village addresses only. LuCI, if any, stays on 127.0.0.1 ---
uci set uhttpd.sparrows=uhttpd
uci -q delete uhttpd.sparrows.listen_http
uci add_list uhttpd.sparrows.listen_http="[$ADDR]:80"
uci add_list uhttpd.sparrows.listen_http="[$ADDR2]:80"
uci set uhttpd.sparrows.home='/www/sparrows'
uci set uhttpd.sparrows.error_page='/index.html'   # any unknown path (phones' checks) -&gt; the page
uci set uhttpd.sparrows.rfc1918_filter='0'
uci set uhttpd.sparrows.max_requests='10'
# No web interface in this image (its first-boot file is absent): the default instance goes
[ -f /etc/uci-defaults/95-sparrows-ui ] || uci -q delete uhttpd.main
uci commit uhttpd
&#32;
# --- Message store: lxmd as propagation node, as user rns (made in 90-sparrows-station) ---
mkdir -p /etc/lxmd &amp;&amp; chown rns:rns /etc/lxmd
/etc/init.d/lxmd enable
&#32;
exit 0</code></pre></div>
<div class="code"><div class="hd"><span class="file">nest/role.conf</span></div><pre><code># Sparrows-Network: what the nest service needs beyond its files. Read by build.sh.
# A nest also runs Reticulum: its wheels come from tree/role.conf.
&#32;
# The built handbook is the welcome page, served by uhttpd on the village address
HANDBOOK_TO="$HANDBOOK_TO www/sparrows/index.html"
&#32;
# A nest sends RAs and answers DNS: odhcpd and dnsmasq stay in its image (DNS only, no DHCP),
# and uhttpd serves the page. Still no firewall.
PKG_nest='dnsmasq odhcpd-ipv6only uhttpd'</code></pre></div>
<div class="code"><div class="hd"><span class="file">nest/files/etc/init.d/lxmd</span></div><pre><code>#!/bin/sh /etc/rc.common
# Sparrows-Network nest: LXMF propagation node (keeps messages for people who are away), as user rns.
# It uses the rnsd started just before it (shared instance). First run writes /etc/lxmd/config.
&#32;
START=96
STOP=09
USE_PROCD=1
&#32;
start_service() {
	procd_open_instance
	procd_set_param env PYTHONPATH=/usr/lib/sparrows/python HOME=/etc/lxmd
	procd_set_param command /usr/bin/python3 -m LXMF.Utilities.lxmd --config /etc/lxmd --rnsconfig /etc/reticulum -p
	procd_set_param user rns
	procd_set_param respawn 3600 10 0
	procd_close_instance
}</code></pre></div>
<div class="code"><div class="hd"><span class="file">devices/rpi-4/device.conf</span></div><pre><code># Raspberry Pi 4: OpenWrt profile rpi-4 (bcm27xx/bcm2711). build.sh reads this file when a line of
# profiles.txt names "rpi-4" in its profile column. OpenWrt ships its Wi-Fi firmware.
# Status: NOT YET TESTED on the unit (written 2026-11-21).
&#32;
# Its radio (brcmfmac): access point and client, no 802.11s mesh, so no flyway. 5 GHz: no radar
# detection, so no AP on the outdoor DFS channels the feeders use; set tx5 to - in profiles.txt.
CAN2='feeder join'
CAN5='join'
&#32;
# No automatic channel choice (ACS) in its driver: a fixed 2.4 GHz channel
CH2='6'
&#32;
# The name and the village address come from the Ethernet MAC (eth0), as on most units
MACDEV='eth0'</code></pre></div>
<h4 id="flash-eap"><span lang="en">6. Flash an EAP225-Outdoor from TP-Link stock firmware</span> <span class="st ok" data-ui="ok">tested</span></h4>
<p lang="en">Tested on 2026-11-14 on a v3 (hardware 3.0, stock firmware 5.1.0) with the hedge image. The v1 is not yet tested; the OpenWrt wiki gives the same method. The same steps serve the feeder image.</p>
<p class="note" lang="en">Do not update the stock firmware before flashing. The OpenWrt wiki reports bricked units when flashing from stock 5.1.1, and says v3.20 hardware with 5.2.x firmware can't be flashed at all. The v4 is not supported.</p>
<div class="code"><div class="hd"><span class="file">laptop, stock web UI, then the station</span></div><pre><code># 0. Note the hardware and stock firmware versions (web UI -&gt; Status). Do NOT update the stock firmware first.
# 1. Web UI -&gt; Management -&gt; SSH: enable, Save.
# 2. SSH in with the web UI admin login. Stock firmware only offers old algorithms:
ssh -o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedAlgorithms=+ssh-rsa \
    -o KexAlgorithms=+diffie-hellman-group1-sha1 admin@&lt;stock-ip&gt;
cliclientd stopcs        # signature check off until the next reboot: flash right away
&#32;
# 3. On the laptop: a short file name (long ones are refused), and check the hash
cp build/images/*sparrows-hedge*eap225-outdoor-v3*factory.bin firmware.bin &amp;&amp; sha256sum firmware.bin
#    Web UI -&gt; System -&gt; Firmware Upgrade -&gt; firmware.bin
#    "bad file" = stopcs was not run. If it fails once, upload again.
&#32;
# 4. LOOP RISK: the image boots as an open-Wi-Fi bridge. Move the unit off the home LAN
#    (injector LAN cable to the laptop or to the village switch) before it finishes booting.
&#32;
# 5. Log in by key over link-local (address from the MAC on the label)
ssh-keygen -R 'fe80::1e61:b4ff:febd:26de%eth0'      # after each reflash the host key changes
ssh -o IdentitiesOnly=yes -i ~/.ssh/id_ed25519 root@fe80::1e61:b4ff:febd:26de%eth0
uci get system.@system[0].hostname                  # hedge-26de
&#32;
# Back to stock: convert TP-Link's file with tplink-safeloader -z (OpenWrt wiki, EAP225 page),
# then sysupgrade -n it. A unit that no longer boots needs a serial console on its test points.</code></pre></div>
<h4 id="upgrade"><span lang="en">7. Update a running station</span></h4>
<p lang="en">To a rebuilt image of the same role, keeping its config. On a flyway, update the far end first: if it fails, the near end still reaches you.</p>
<div class="code"><div class="hd"><span class="file">laptop, then the station</span></div><pre><code># From a laptop on the village. dropbear has no sftp server, so -O; an IPv6 address needs [brackets]
scp -O &lt;image&gt;-sysupgrade.bin 'root@[fd7e:4c1a:9b20:1:1e61:b4ff:febd:26de]:/tmp/fw.bin'
# A Raspberry Pi takes its &lt;image&gt;-squashfs-sysupgrade.img.gz the same way
# On the station
sysupgrade -T /tmp/fw.bin       # checks the image, flashes nothing
sysupgrade -v /tmp/fw.bin       # keeps the config and the role, reboots (+ 60 s of radar check on 5 GHz)</code></pre></div>
<h4><span lang="en">Bench plan with the three units</span></h4>
<ol lang="en">
  <li>The v3 as a feeder first: the simplest image, and it checks flashing from stock firmware and the "no RA" rule. Done differently on 2026-11-14: the v3 went straight to the hedge image, and a laptop and a phone joined through it.</li>
  <li>The two v1 as hedges, both on the bench at low power, one cabled to the perch switch. They should mesh by themselves: <code>batctl n</code> on each shows the other, and a phone on the uncabled one reaches the nest.</li>
  <li>The v3 reflashed as a hedge, to check that v1 and v3 mesh together.</li>
  <li>Unplug the cable of one hedge while a phone is on it: traffic should move to the air path. Plug it back: <code>batctl bl</code> must stop the loop.</li>
  <li>Measure between two hedges with <code>batctl tp</code>, then at the real distance outdoors.</li>
</ol>
<p class="note" lang="en">Costs. Omni antennas, so a few hundred metres between hedges. The 2.4 GHz mesh shares its channel with the 2.4 GHz open Wi-Fi of the same box, and throughput roughly halves at each hop: good for a village core, not for links between villages. The hedge key sits inside every hedge image, like the flyway key in perch images: keep them private. A hedge is lower and easier to reach than a perch on a mast, which is why it has its own key rather than the flyway's. The rogue-RA point of the feeder applies here too.</p>
<h3 id="pi"><span lang="en">Nests, example: Raspberry Pi</span> <span class="st nt" data-ui="nt">not yet tested</span></h3>
<p class="note" lang="en">Since 2026-11-21 nests move to OpenWrt (<a href="#nest-image">Nest image</a>). This Debian nest is the one running today and stays the reference until the OpenWrt nest passes the same checks.</p>
<p lang="en">This is the configuration as it stands today, one Pi 4 at <code>::1</code>. It still carries things the target model removes; they stay until their replacement is tested (see the end of this section). Tested on 2026-11-14: the router advertisements, the DNS answers, the router flag and the non-ULA bench prefix, with a laptop and an Android phone. The local domain is now <code>sparrows.lan</code>.</p>
<h4><span lang="en">1. Flash</span></h4>
<p lang="en">Raspberry Pi OS Lite 64-bit (Trixie) with an up-to-date Raspberry Pi Imager. Customisation: any hostname (the nest renames itself just below), a user, SSH enabled, the home box Wi-Fi, country FR. Admin goes through the home Wi-Fi side.</p>
<div class="code"><div class="hd"><span class="file">shell</span></div><pre><code>sudo apt update &amp;&amp; sudo apt full-upgrade -y
sudo apt install -y dnsmasq nginx nftables ndisc6
&#32;
# Name the nest like every station: nest-&lt;last 4 hex digits of the eth0 MAC&gt; (not yet tested)
sudo hostnamectl set-hostname "nest-$(tr -d : &lt;/sys/class/net/eth0/address | tail -c 5)"</code></pre></div>
<h4><span lang="en">2. Network: mesh side IPv6 only, routing off</span></h4>
<p lang="en">The second address and the <code>eth0.forwarding</code> line are what Android needs (<a href="#android">see why</a>). Undo: <code>-ipv6.addresses</code> for the address; delete the <code>eth0</code> line, then <code>sysctl -w net.ipv6.conf.eth0.forwarding=0</code>.</p>
<div class="code"><div class="hd"><span class="file">shell</span></div><pre><code>sudo nmcli con delete mesh 2&gt;/dev/null
sudo nmcli con delete "Wired connection 1" 2&gt;/dev/null
sudo nmcli con add type ethernet ifname eth0 con-name mesh \
  ipv4.method disabled \
  ipv6.method manual ipv6.addresses fd7e:4c1a:9b20:1::1/64 \
  ipv6.never-default yes ipv6.ignore-auto-dns yes ipv6.addr-gen-mode eui64 \
  connection.autoconnect yes
sudo nmcli con up mesh
&#32;
# Non-ULA prefix next to the ULA: Android refuses a network with only ULA addresses.
# Bench only: 2001:db8::/32 is the documentation range. The real prefix is not decided yet.
sudo nmcli con mod mesh +ipv6.addresses 2001:db8:1::1/64 &amp;&amp; sudo nmcli con up mesh
&#32;
# Routing stays off for both families. eth0.forwarding=1 only sets the router flag in
# neighbour advertisements (Android drops a gateway without it); all.forwarding=0 keeps
# IPv6 forwarding off. Keep the eth0 line AFTER the "all" line: writing "all" resets every interface.
sudo tee /etc/sysctl.d/90-no-forward.conf &gt;/dev/null &lt;&lt;'EOF'
net.ipv4.ip_forward=0
net.ipv6.conf.all.forwarding=0
net.ipv6.conf.eth0.forwarding=1
EOF
sudo sysctl --system
sysctl net.ipv6.conf.eth0.forwarding net.ipv6.conf.all.forwarding net.ipv4.ip_forward   # 1 0 0</code></pre></div>
<h4><span lang="en">3. Router advertisements and DNS</span></h4>
<p lang="en">No DHCP at all. To keep the Pi's own DNS on the home box, set <code>DNSMASQ_EXCEPT="lo"</code> in <code>/etc/default/dnsmasq</code>. Never add <code>log-queries</code>.</p>
<div class="code"><div class="hd"><span class="file">/etc/dnsmasq.d/mesh.conf</span></div><pre><code># Mesh only. bind-dynamic = OK even if eth0 comes up after dnsmasq
interface=eth0
bind-dynamic
&#32;
# Isolated network: no upstream DNS for mesh clients
no-resolv
domain-needed
&#32;
# Local domain (AAAA records only)
domain=sparrows.lan
local=/sparrows.lan/
expand-hosts
host-record=sparrows.lan,dns.sparrows.lan,fd7e:4c1a:9b20:1::1
cname=www.sparrows.lan,sparrows.lan
&#32;
# Router advertisements: SLAAC only (no DHCPv6, Android ignores it anyway)
# constructor:eth0 = one prefix announced per /64 on eth0 (the ULA + the non-ULA one)
enable-ra
dhcp-range=::,constructor:eth0,ra-only,64,12h
# RA every 60 s, router lifetime 1800 s (phones accept the network)
ra-param=eth0,60,1800
# DNS + search domain sent inside the RA (RDNSS / DNSSL)
# Non-ULA address first: some Android versions drop a ULA DNS server. Bench: 2001:db8:1::1
dhcp-option=option6:dns-server,[2001:db8:1::1],[fd7e:4c1a:9b20:1::1]
dhcp-option=option6:domain-search,sparrows.lan
&#32;
# Captive portal: any unknown name -&gt; the Pi (AAAA)
address=/#/fd7e:4c1a:9b20:1::1</code></pre></div>
<h4><span lang="en">4. Firewall and isolation</span></h4>
<div class="code"><div class="hd"><span class="file">/etc/nftables.conf</span></div><pre><code>#!/usr/sbin/nft -f
flush ruleset
&#32;
table inet filter {
  chain input {
    type filter hook input priority 0; policy drop;
    iif "lo" accept
    ct state established,related accept
    ct state invalid drop
    # ICMP/ICMPv6: ping, and IPv6 can't work without it (NDP, RS/RA, MLD)
    meta l4proto { icmp, ipv6-icmp } accept
&#32;
    # Home side: DHCP / DHCPv6 client replies + admin SSH
    iifname "wlan0" udp sport 67 udp dport 68 accept
    iifname "wlan0" udp dport 546 accept
    iifname "wlan0" tcp dport 22 accept
&#32;
    # Mesh side: IPv6 only (IPv4 falls to policy drop)
    iifname "eth0" meta nfproto ipv6 meta l4proto { tcp, udp } th dport 53 accept   # DNS
    iifname "eth0" meta nfproto ipv6 tcp dport { 22, 80, 443 } accept               # SSH, web
  }
  chain forward {
    type filter hook forward priority 0; policy drop;            # NEVER mesh &lt;-&gt; home
  }
  chain output {
    type filter hook output priority 0; policy accept;
  }
}
&#32;
# Captive portal: catch hard-coded DNS and any web request
table ip6 nat {
  chain prerouting {
    type nat hook prerouting priority dstnat;
    iifname "eth0" meta l4proto { tcp, udp } th dport 53 redirect to :53
    iifname "eth0" tcp dport 80 ip6 daddr != fd7e:4c1a:9b20:1::1 redirect to :80
  }
}</code></pre></div>
<h4><span lang="en">5. Web server</span></h4>
<div class="code"><div class="hd"><span class="file">/etc/nginx/sites-available/sparrows</span></div><pre><code>server {
    listen [::]:80;                    # IPv6; wlan0 side blocked by nftables
    server_name sparrows.lan www.sparrows.lan;
    root  /var/www/sparrows;
    index index.html;
&#32;
    location /files/ {
        alias /data/files/;
        autoindex on;                  # goes away in the target model
    }
}
&#32;
# Captive portal catch-all
server {
    listen [::]:80 default_server;
    server_name _;
    return 302 http://sparrows.lan/;
}</code></pre></div>
<div class="code"><div class="hd"><span class="file">apply</span></div><pre><code>sudo dnsmasq --test &amp;&amp; sudo systemctl enable --now dnsmasq &amp;&amp; sudo systemctl restart dnsmasq
sudo nft -c -f /etc/nftables.conf &amp;&amp; sudo systemctl enable --now nftables &amp;&amp; sudo systemctl restart nftables
sudo nginx -t &amp;&amp; sudo systemctl reload nginx</code></pre></div>
<h4><span lang="en">6. Captive portal</span></h4>
<p lang="en">Every name resolves to the Pi, hard-coded DNS is redirected, and any unknown web request is sent to the welcome page. A phone's connectivity check gets a redirect instead of its expected answer, so the phone opens the page by itself. The network keeps showing "no Internet" on purpose: a phone that believes the Wi-Fi has Internet would send everything over it and break its own 4G use.</p>
<p lang="en">Seen on 2026-11-14: the phone shows "connected / no Internet", and on a laptop a request for <code>deb.debian.org</code> came back as the redirect to <code>http://sparrows.lan/</code>. The "sign in to network" window itself is <span class="st nt" data-ui="nt">not yet tested</span>.</p>
<h4><span lang="en">7. Verify</span></h4>
<div class="code"><div class="hd"><span class="file">Pi, then a laptop</span></div><pre><code># On the Pi
ip -br a                          # eth0: fd7e:4c1a:9b20:1::1/64 (+ 2001:db8:1::1/64) + fe80::, NO IPv4
ip route; ip -6 route             # IPv4 default via wlan0 ONLY; no IPv6 default via eth0
sysctl net.ipv4.ip_forward net.ipv6.conf.all.forwarding net.ipv6.conf.eth0.forwarding   # 0 0 1
ss -lntup | grep -e dnsmasq -e nginx
journalctl -fu dnsmasq            # RTR-ADVERT lines on eth0
sudo nft list table ip6 nat
&#32;
# From a Linux laptop on the mesh
rdisc6 &lt;if&gt;                       # both prefixes, Router lifetime 1800, the DNS servers
ip -6 addr show &lt;if&gt;              # fd7e:4c1a:9b20:1:... and 2001:db8:1:... (SLAAC)
ip -6 neigh show dev &lt;if&gt;         # the nest's fe80 entry says "router"
dig AAAA sparrows.lan @fd7e:4c1a:9b20:1::1   # the nest answers
getent ahosts sparrows.lan        # the laptop's own resolver agrees (see Pitfalls if not)
ping 192.168.10.254               # must FAIL (no IPv4 at all on the mesh)
ping -6 2001:4860:4860::8888      # must FAIL (nothing forwarded to the home side)
&#32;
# Captive portal
nslookup google.com               # -&gt; fd7e:4c1a:9b20:1::1
curl -sI http://connectivitycheck.gstatic.com/generate_204   # 302 -&gt; http://sparrows.lan/
&#32;
# On an Android phone: "connected / no Internet", an fd7e: and a 2001:db8: address, no IPv4</code></pre></div>
<h4 id="welcome"><span lang="en">8. This handbook as the welcome page</span> <span class="st nt" data-ui="nt">not yet tested</span></h4>
<p lang="en">This file needs nothing from outside: no font, no script, no image. So the nest can serve it as it is, and a newcomer's phone opens it on joining the Wi-Fi. It starts with <a href="#start">Start here</a>, which is what a newcomer needs. It lives in Layer 0 because nothing else can reach a phone that has no app yet.</p>
<div class="code"><div class="hd"><span class="file">nest</span></div><pre><code># On the nest: this file becomes the page every newcomer sees
sudo cp /var/www/sparrows/index.html /var/www/sparrows/index.html.bak 2&gt;/dev/null
sudo install -m 644 index.html /var/www/sparrows/index.html
curl -sI http://sparrows.lan/ | head -n1        # HTTP/1.1 200 OK
# No logs on the on-ramp: add  access_log off;  inside both server blocks, then
sudo nginx -t &amp;&amp; sudo systemctl reload nginx
&#32;
# Undo
sudo mv /var/www/sparrows/index.html.bak /var/www/sparrows/index.html</code></pre></div>
<ul lang="en">
  <li><strong>Fill in the "This village" card first:</strong> the app file with its SHA-256 and the village key hashes. The same values go on the paper notice.</li>
  <li><strong>The "sign in to network" window is a small, limited browser.</strong> Downloads often fail in it. Tell people to open <code>http://sparrows.lan</code> in their normal browser and to add it to their home screen.</li>
  <li><strong>The links to outside sites don't work in the village.</strong> That is expected: there is no Internet here.</li>
  <li><strong>Same file on every nest.</strong> Compare with <code>sha256sum</code>.</li>
</ul>
<h4 id="kit"><span lang="en">9. The kit folder: files and scripts to download</span> <span class="st nt" data-ui="nt">not yet tested</span></h4>
<p lang="en">Next to this page, the nest serves a <code>kit/</code> folder: the build scripts, this handbook's sources, and the app install file, with a <code>SHA256SUMS</code> list. It belongs to the on-ramp (Layer 0) for the same reason as this page: someone with no app yet, or about to build a first station, can't reach anything on Layer 1. It holds only public files: no radio key, no SSH key, no built perch or hedge image (those carry the village's radio keys and are handed over in person). An admin with Internet access can also take everything straight from the project's git repository on GitHub, and update it with <code>git pull</code>. The repository is public since 2026-11-21: no account is needed to read it. Its front page shows this handbook in English.</p>
<div class="code"><div class="hd"><span class="file">admin laptop, then nest</span></div><pre><code># On any computer with Internet and git: the whole project from GitHub. Public: no account needed
git clone https://github.com/1372711/Sparrows-Nework.git sparrows
cd sparrows &amp;&amp; ls                             # tao/ (this handbook) and sparrows-openwrt/ (the build)
git pull                                      # later, from inside sparrows/: get the latest
git log -1 --format='%h %ad %s'               # which version you have
&#32;
# On the admin laptop, from the folder that holds tao/ and sparrows-openwrt/.
# Public files only: keys/, secrets/ and build/ never go in the kit.
mkdir -p kit
rsync -a --delete --exclude keys/ --exclude secrets/ --exclude build/ sparrows-openwrt tao kit/
cp &lt;app-install-file&gt; kit/                    # e.g. the Sideband APK, once chosen
( cd kit &amp;&amp; find . -type f ! -name SHA256SUMS -print0 | sort -z | xargs -0 sha256sum &gt; SHA256SUMS )
grep -r -l -i -e passphrase -e 'BEGIN OPENSSH PRIVATE' kit/ &amp;&amp; echo "STOP: check these files"   # should print nothing
scp -r kit index.html &lt;user&gt;@[fd7e:4c1a:9b20:1::1]:/tmp/
&#32;
# On the nest
sudo rm -rf /var/www/sparrows/kit &amp;&amp; sudo cp -r /tmp/kit /var/www/sparrows/kit
sudo install -m 644 /tmp/index.html /var/www/sparrows/index.html
# In /etc/nginx/sites-available/sparrows, inside the sparrows.lan server block:
#     location /kit/ { autoindex on; }
sudo nginx -t &amp;&amp; sudo systemctl reload nginx
curl -s http://sparrows.lan/kit/ | grep -c href           # the files are listed
&#32;
# Anyone who downloaded the kit checks it
cd kit &amp;&amp; sha256sum -c SHA256SUMS
&#32;
# Undo on the nest: remove the location line, then
sudo rm -rf /var/www/sparrows/kit &amp;&amp; sudo nginx -t &amp;&amp; sudo systemctl reload nginx</code></pre></div>
<p lang="en">Anyone who copies the handbook with its <code>kit/</code> folder, on a USB stick or by mail, carries the whole project. On the Internet, the address to download it from is not chosen yet. A git repository carried by Reticulum is the next step (<a href="#ideas">Part IV</a>).</p>
<h4><span lang="en">Towards the target model</span></h4>
<p lang="en">Once Reticulum and the file store are tested, the Pi is stripped down to the on-ramp: remove <code>/files/</code> and the <code>www</code> name from nginx, port 443 from nftables, and add <code>access_log off;</code>. The welcome page then holds four things: what Sparrows is, how to install the app with its SHA-256, the key hashes of the village, and the charter.</p>
<h3 id="reticulum">Reticulum <span class="st nt" data-ui="nt">not yet tested</span></h3>
<p lang="en">Two daemons on the nest and nothing on perches, feeders or hedges. <code>rnsd</code> is the relay: peers find each other by IPv6 link-local multicast, with no address, DNS or RA needed. <code>lxmd -p</code> keeps encrypted messages for people who are offline and syncs with the other nests.</p>
<p class="note" lang="en">Write the config before the first start. With no config, <code>rnsd</code> opens on every interface, the home Wi-Fi included, and would announce on the home LAN.</p>
<h4><span lang="en">How it uses the village segment</span></h4>
<ul lang="en">
  <li><strong>Discovery:</strong> AutoInterface finds peers by IPv6 link-local multicast on the village segment. It needs no SLAAC address, no RA and no DNS, so Sideband, MeshChat and Nomad Network anywhere in the village find each other and the nest with no settings.</li>
  <li><strong>Live traffic goes direct.</strong> Two people online at the same time talk peer to peer across the segment. The nest is not in the data path.</li>
  <li><strong>What the nest adds:</strong> <code>lxmd</code> holds messages for people who are offline; transport (<code>enable_transport = Yes</code>) relays between interfaces, toward a LoRa flyway or another village; and it is an always-on peer that answers path requests.</li>
  <li><strong>Without the nest:</strong> live chat inside the village should still work. Offline delivery and links beyond the village stop. <span class="st nt" data-ui="nt">not yet tested</span></li>
</ul>
<h4><span lang="en">1. Install, while the Pi has Internet through the home Wi-Fi</span></h4>
<div class="code"><div class="hd"><span class="file">shell</span></div><pre><code>sudo apt install -y python3-venv
sudo useradd --system --create-home --home-dir /var/lib/reticulum --shell /usr/sbin/nologin rns
sudo python3 -m venv /opt/reticulum
sudo /opt/reticulum/bin/pip install rns lxmf
/opt/reticulum/bin/rnsd --version; /opt/reticulum/bin/lxmd --version
sudo -u rns mkdir -p /var/lib/lxmd</code></pre></div>
<h4><span lang="en">2. Config, owned by the <code>rns</code> user</span></h4>
<div class="code"><div class="hd"><span class="file">/var/lib/reticulum/config</span></div><pre><code>[reticulum]
  enable_transport = Yes          # the Pi relays for other peers
  share_instance = Yes            # lxmd and the rn* tools use this rnsd
  panic_on_interface_error = No
&#32;
[logging]
  loglevel = 4
&#32;
[interfaces]
  # Mesh side ONLY. Never wlan0 (home LAN).
  [[Sparrows Mesh]]
    type = AutoInterface
    enabled = yes
    devices = eth0</code></pre></div>
<h4><span lang="en">3. Services</span></h4>
<div class="code"><div class="hd"><span class="file">/etc/systemd/system/rnsd.service</span></div><pre><code>[Unit]
Description=Reticulum transport node (Sparrows mesh)
After=network-online.target
Wants=network-online.target
&#32;
[Service]
User=rns
ExecStart=/opt/reticulum/bin/rnsd --config /var/lib/reticulum -s
Restart=always
RestartSec=5
&#32;
[Install]
WantedBy=multi-user.target</code></pre></div>
<div class="code"><div class="hd"><span class="file">/etc/systemd/system/lxmd.service</span></div><pre><code>[Unit]
Description=LXMF propagation node (Sparrows mesh)
After=rnsd.service
Requires=rnsd.service
&#32;
[Service]
User=rns
ExecStart=/opt/reticulum/bin/lxmd --config /var/lib/lxmd --rnsconfig /var/lib/reticulum -p
Restart=always
RestartSec=5
&#32;
[Install]
WantedBy=multi-user.target</code></pre></div>
<h4><span lang="en">4. Firewall: one line in the <code>input</code> chain, under the mesh-side lines</span></h4>
<p lang="en">The ports are the AutoInterface defaults. Check them against <code>rnsd --exampleconfig</code> and fix the rule if they differ.</p>
<div class="code"><div class="hd"><span class="file">/etc/nftables.conf</span></div><pre><code>    iifname "eth0" meta nfproto ipv6 udp dport { 29716, 42671 } accept   # Reticulum AutoInterface</code></pre></div>
<h4><span lang="en">5. Start and verify</span></h4>
<div class="code"><div class="hd"><span class="file">shell</span></div><pre><code>sudo nft -c -f /etc/nftables.conf &amp;&amp; sudo systemctl restart nftables
sudo systemctl daemon-reload
sudo systemctl enable --now rnsd lxmd
&#32;
# Verify on the Pi
sudo -u rns /opt/reticulum/bin/rnstatus --config /var/lib/reticulum   # "Sparrows Mesh" Up; only eth0
sudo ss -lunp | grep -e rnsd -e python                                # UDP bound on eth0 / fe80, none on wlan0
journalctl -u rnsd -u lxmd -n 50                                      # lxmd prints its propagation node address
&#32;
# From a Linux laptop on the village (rns in a venv, devices = &lt;its interface&gt; in ~/.reticulum/config)
rnstatus                          # the nest shows up as a peer
rnpath &lt;lxmd address&gt;             # a path to the nest's propagation node
&#32;
# Once a version is tested: note it, and keep the wheels for installs without Internet
/opt/reticulum/bin/pip freeze | grep -i -e rns -e lxmf
/opt/reticulum/bin/pip download rns lxmf -d wheels/</code></pre></div>
<p lang="en">On Android: install Sideband, connect through local Wi-Fi (AutoInterface), restart the app, then pick the Pi as propagation node. The test that matters: two phones swap addresses, phone B is switched off, A sends a message, B comes back on the mesh. The message must arrive through the Pi.</p>
<h4><span lang="en">Undo, and what to back up</span></h4>
<div class="code"><div class="hd"><span class="file">shell</span></div><pre><code>sudo systemctl disable --now lxmd rnsd
sudo rm /etc/systemd/system/rnsd.service /etc/systemd/system/lxmd.service &amp;&amp; sudo systemctl daemon-reload
# remove the "Reticulum AutoInterface" line from /etc/nftables.conf, then:
sudo systemctl restart nftables
sudo rm -rf /opt/reticulum /var/lib/lxmd &amp;&amp; sudo userdel -r rns</code></pre></div>
<p lang="en">Back up <code>/var/lib/reticulum/storage/</code> and <code>/var/lib/lxmd/</code>. They hold the Pi's identity keys, and the identity <em>is</em> the address: losing them changes the address every phone has stored.</p>
<h3 id="page-node"><span lang="en">A neighbour's page node, example: Pi Zero 2 W</span> <span class="st nt" data-ui="nt">not yet tested</span></h3>
<p lang="en">Anyone can publish pages and files on Layer 1 from their own small box: a bakery's opening hours, a club's board, a family's photos. It serves P3 (every user is a relay, nothing sits on a nest) and P1 (the node's address is its own key hash, held by its owner, not a name an admin grants). It is not a station: no RA, no on-ramp, and it joins the open Wi-Fi like a phone.</p>
<p lang="en">Example: a Pi Zero 2 W (512 MB of RAM, one 2.4 GHz radio) on the <code>Sparrows</code> Wi-Fi, running Nomad Network in node mode. Fine for pages, slow for big files. Install it while it is still on the home Wi-Fi, then move it to the village.</p>
<p class="note" lang="en">Lock-out risk at step 1: once the home Wi-Fi profile is deleted, the Pi Zero is only reachable from the village, by SSH to its SLAAC or link-local address. Write the Reticulum config (step 2) before that, and keep a keyboard and screen at hand the first time.</p>
<h4><span lang="en">1. Install, then join the village</span></h4>
<div class="code"><div class="hd"><span class="file">shell</span></div><pre><code># 1. While the Pi Zero is still on the home Wi-Fi (Raspberry Pi OS Lite 64-bit, user + SSH set in Imager)
sudo apt update &amp;&amp; sudo apt install -y python3-venv
python3 -m venv ~/rns
~/rns/bin/pip install rns lxmf nomadnet
~/rns/bin/rnsd --version; ~/rns/bin/nomadnet --version
&#32;
# 2. Move it to the village: open Wi-Fi, IPv6 only. Write the Reticulum config (step 2) FIRST.
sudo nmcli dev wifi connect Sparrows
sudo nmcli con mod Sparrows ipv4.method disabled ipv6.method auto
nmcli con show                                   # name of the home Wi-Fi profile
sudo nmcli con delete "&lt;home Wi-Fi profile&gt;"     # LOCK-OUT RISK: from now on, admin only from the village
# From a laptop on the village: ssh &lt;user&gt;@&lt;its SLAAC address&gt;, or fe80::...%&lt;if&gt;</code></pre></div>
<h4><span lang="en">2. Reticulum config, before the first start</span></h4>
<p lang="en">With no config, Reticulum opens a default interface on every network the box is on. Transport stays off: the nests relay, a small host doesn't need to.</p>
<div class="code"><div class="hd"><span class="file">~/.reticulum/config</span></div><pre><code>[reticulum]
  enable_transport = No           # the nests relay; a small host doesn't need to
  share_instance = Yes            # nomadnet and the rn* tools share this instance
&#32;
[logging]
  loglevel = 3
&#32;
[interfaces]
  # The village open Wi-Fi only
  [[Sparrows]]
    type = AutoInterface
    enabled = yes
    devices = wlan0</code></pre></div>
<h4><span lang="en">3. Nomad Network in node mode</span></h4>
<p lang="en">Pages are micron files (<code>.mu</code>) in <code>storage/pages</code>, starting with <code>index.mu</code>. Files to offer go in <code>storage/files</code>.</p>
<div class="code"><div class="hd"><span class="file">shell</span></div><pre><code># First run writes ~/.nomadnetwork/config; stop it with Ctrl-C
~/rns/bin/nomadnet --daemon
# In ~/.nomadnetwork/config, section [node]:
#   enable_node = yes
#   node_name = Bakery
mkdir -p ~/.nomadnetwork/storage/pages ~/.nomadnetwork/storage/files
printf '&gt;Bakery\n\nOpen 7:00-13:00. Bread on Saturday.\n' &gt; ~/.nomadnetwork/storage/pages/index.mu
&#32;
# Run it at boot
sudo tee /etc/systemd/system/nomadnet.service &gt;/dev/null &lt;&lt;EOF
[Unit]
Description=Nomad Network page node (Sparrows)
After=network-online.target
Wants=network-online.target
&#32;
[Service]
User=$USER
ExecStart=$HOME/rns/bin/nomadnet --daemon
Restart=always
RestartSec=5
&#32;
[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload &amp;&amp; sudo systemctl enable --now nomadnet</code></pre></div>
<h4><span lang="en">4. Verify, undo, back up</span></h4>
<div class="code"><div class="hd"><span class="file">shell</span></div><pre><code># On the Pi Zero
ip -6 addr show wlan0               # fe80:: + SLAAC addresses from the nests' prefixes, no inet
~/rns/bin/rnstatus                  # "Sparrows" Up
journalctl -u nomadnet -n 30        # the node announces itself
&#32;
# From a laptop on the village: Nomad Network or MeshChat, Network list -&gt; "Bakery"
&#32;
# Undo
sudo systemctl disable --now nomadnet &amp;&amp; sudo rm /etc/systemd/system/nomadnet.service
rm -rf ~/rns ~/.reticulum ~/.nomadnetwork   # back up ~/.nomadnetwork/storage/identity first to keep the address</code></pre></div>
<p lang="en">Back up <code>~/.nomadnetwork/storage/identity</code>: it is the node's key, so it is its address. Lose it and every link to the node breaks. Reading the pages: Nomad Network in a terminal, or MeshChat on a laptop. Whether Sideband on Android shows Nomad pages is still to check.</p>
<h3 id="pitfalls"><span lang="en">Pitfalls</span></h3>
<h4><span lang="en">Building images</span></h4>
<ul lang="en">
  <li>A space anywhere in the build tree's path (<code>~/00 - sparrows-network/...</code>) breaks the OpenWrt Image Builder: its Makefiles cut the path at the space, <code>make info</code> fails, and an older <code>build.sh</code> reported it as "no profile rpi-3" (seen 2026-11-21). Since then <code>build.sh</code> runs the Image Builder in <code>~/.cache/sparrows-build</code> when the path has a space, and still puts the images in <code>build/images</code>. Another folder: <code>SPARROWS_BUILD=/some/path ./build.sh</code>. A failing <code>make info</code> is now shown as such.</li>
  <li>The Image Builder needs <code>rsync</code>, missing on a fresh Debian 12: <code>sudo apt install rsync</code>. <code>build.sh</code> lists what is missing before downloading anything.</li>
</ul>
<h4>Radio</h4>
<ul lang="en">
  <li>802.11s mesh does not work on DFS channels. Both nodes pass the radar check, then never peer. Use AP + client on 5 GHz. 802.11s is fine on 2.4 GHz, which is what hedges use.</li>
  <li>The SAE key must be 8 to 63 printable ASCII characters (seen 2026-11-14). Longer than 63: the client silently drops its network and never even tries to authenticate. Shorter than 8: the AP rejects it, then the client logs <code>SSID-TEMP-DISABLED</code>. Use 32 letters and digits, and compare the keys of two units with <code>md5sum</code> rather than by eye.</li>
  <li>DFS means 60 s of silence after every boot or <code>wifi</code> restart. Nothing links before <code>DFS-CAC-COMPLETED</code>. Change the client first, then the AP, to pay the 60 s only once.</li>
  <li>Full power at 1 m overloads the receivers. On the bench, <code>txpower</code> about 5.</li>
  <li>Interface names differ by role: <code>phy0-ap0</code> on the AP, <code>phy0-sta0</code> on the client. <code>No such device</code> usually means the wrong name: <code>iw dev</code> lists them.</li>
  <li>OpenWrt 25.12 has no <code>wpa_cli</code>: the Wi-Fi config is pushed over ubus. Debug with <code>logread</code>, and raise the radio's <code>log_level</code> to 2 on the AP to see its side.</li>
  <li>Node clocks are not synchronised. Ignore timestamps when comparing logs between nodes.</li>
  <li>EAP225-Outdoor: the OpenWrt wiki says recent TP-Link stock firmware can block installing OpenWrt, and v4 is not supported. Check the revision and the stock firmware first.</li>
</ul>
<h4><span lang="en">Admin access</span></h4>
<ul lang="en">
  <li><code>scp</code> to an IPv6 address needs brackets: <code>'root@[fd7e:…:febd:26de]:/tmp/'</code>. Add <code>-O</code>: dropbear has no sftp server.</li>
  <li>BusyBox <code>ip</code> on OpenWrt has no <code>-br</code>, and there is no <code>bridge</code> command: use <code>ip -6 addr show br-lan</code> and <code>uci show network.@device[0].ports</code>.</li>
  <li>The bench laptop is <code>::99</code>, never <code>::2</code>, which belongs to the second nest.</li>
  <li><code>ping -6 ff02::1%eth0</code> makes every station on the segment answer, the nest included. Pick yours by its MAC in <code>ip -6 neigh</code>. A password prompt means it is not a Sparrows image: they take keys only.</li>
  <li>After each reflash a station's SSH host key changes: <code>ssh-keygen -R '&lt;address&gt;'</code>.</li>
</ul>
<h4><span lang="en">Network and IPv6</span></h4>
<ul lang="en">
  <li>Never plug a perch, a feeder or a hedge into the home box: loop risk, and the Pi's RAs and DNS would reach home devices.</li>
  <li>Docker and some VPN tools silently turn forwarding on. The nftables <code>forward</code> drop still holds.</li>
  <li>An Android phone stuck on "Obtaining IP address" on a network with only ULA addresses: it needs a non-ULA prefix next to the ULA (seen 2026-11-14, <a href="#android">see why</a>). A Linux laptop on the same Wi-Fi works fine, so test with a phone.</li>
  <li>An Android phone that joins for half a second, then says "IP configuration failure" and goes back to another Wi-Fi: the nest answers without the router flag. <code>net.ipv6.conf.eth0.forwarding=1</code> on the nest (seen 2026-11-14). Check from a laptop: <code>ip -6 neigh show dev wlan0</code> must show <code>router</code> on the nest's entry.</li>
  <li>Android takes DNS only from the RA (RDNSS). DHCPv6 is ignored.</li>
  <li>A router lifetime of 0 in the RA makes phones refuse or rank the network badly. Check <code>Router lifetime: 1800</code> with <code>rdisc6</code>.</li>
  <li>Android "Private DNS" set to a fixed provider bypasses the DNS redirect. In automatic mode it falls back fine.</li>
</ul>
<h4>Raspberry Pi, Reticulum</h4>
<ul lang="en">
  <li>With an old Raspberry Pi Imager the customisation can silently fail on Trixie: no user, no SSH, no Wi-Fi.</li>
  <li>Two nginx servers with <code>default_server</code> on port 80 make <code>nginx -t</code> fail.</li>
  <li><code>curl</code> to the nest says "Connection refused": nginx isn't listening on <code>[::]:80</code>. A firewall drop would time out instead. Check <code>ss -lntp | grep :80</code>.</li>
  <li>The nest answers <code>dig</code> but the laptop can't resolve any name: the laptop sends its queries to its own resolver on <code>127.0.0.1</code> and ignores the RA's DNS server (seen 2026-11-14 with resolvconf and a stopped dnsmasq). Start that resolver and give it <code>server=/sparrows.lan/fd7e:4c1a:9b20:1::1</code> and <code>rebind-domain-ok=/sparrows.lan/</code>.</li>
  <li>Peers never show up in <code>rnstatus</code>: first suspect the nftables <code>input</code> drop.</li>
  <li>Reticulum's founder stepped back in December 2025. Pin the versions that were tested, keep the wheels for offline installs, and keep the design portable to another implementation.</li>
  <li>The protocol is public domain, but the reference implementation's licence carries conditions. Read it before selling a kit.</li>
  <li>No Reticulum on perches, feeders or hedges (decided 2026-11-12). They bridge, so every phone already reaches the nest's <code>rnsd</code> directly. A relay on them would add announce traffic, not reach. Extra relays go where two media meet.</li>
  <li><code>apt</code> on a laptop joined to the village fails with "Could not resolve": the catch-all DNS sends every name to the nest. Expected. Update from another network.</li>
  <li>Wi-Fi power saving can drop the nest's home link: <code>sudo nmcli con mod preconfigured 802-11-wireless.powersave 2</code>.</li>
</ul>
<h3 id="recovery"><span lang="en">Recovery</span></h3>
<p lang="en"><strong>Any node:</strong> link-local often still reaches a device whose addresses are wrong. <code>ping -6 ff02::1%eth0</code> makes every IPv6 device on the cable answer.</p>
<p lang="en"><strong>CPE510:</strong> TFTP recovery, described on the device's OpenWrt wiki page. The file name and the PC address depend on the hardware version.</p>
<p lang="en"><strong>Pi with no network:</strong> fix it from the SD card. NetworkManager ignores a profile that isn't <code>600</code> and owned by root.</p>
<div class="code"><div class="hd"><span class="file">mesh profile</span></div><pre><code># SD card in a Linux laptop: R=/media/$USER/rootfs  B=/media/$USER/bootfs
# On the bench, also add under [ipv6]:  address2=2001:db8:1::1/64
sudo tee $R/etc/NetworkManager/system-connections/mesh.nmconnection &gt;/dev/null &lt;&lt;'EOF'
[connection]
id=mesh
type=ethernet
interface-name=eth0
autoconnect=true
autoconnect-priority=10
&#32;
[ipv4]
method=disabled
&#32;
[ipv6]
method=manual
address1=fd7e:4c1a:9b20:1::1/64
never-default=true
addr-gen-mode=eui64
EOF
sudo chmod 600 $R/etc/NetworkManager/system-connections/mesh.nmconnection
sudo chown root:root $R/etc/NetworkManager/system-connections/mesh.nmconnection</code></pre></div>
<p lang="en"><strong>Ping works but SSH is refused:</strong> sshd was never enabled.</p>
<div class="code"><div class="hd"><span class="file">enable sshd from the SD card</span></div><pre><code>ls $R/home; grep ':1000:' $R/etc/passwd            # empty -&gt; update Imager and reflash
sudo ln -sf /usr/lib/systemd/system/ssh.service \
  $R/etc/systemd/system/multi-user.target.wants/ssh.service
sudo rm -f $R/etc/ssh/sshd_not_to_be_run
ls $R/etc/ssh/ssh_host_* || sudo ssh-keygen -A -f $R
HASH=$(openssl passwd -6)                          # set or reset the user's password
sudo sed -i "s|^moonshiner:[^:]*:|moonshiner:$HASH:|" $R/etc/shadow
sync &amp;&amp; sudo umount $R $B</code></pre></div>
<p lang="en"><strong>The Pi's home Wi-Fi doesn't connect:</strong> check <code>ssid=</code> and <code>psk=</code> in <code>$R/etc/NetworkManager/system-connections/</code>, and <code>cfg80211.ieee80211_regdom=FR</code> in <code>$B/cmdline.txt</code>. The home box must not be WPA3-only.</p>
<h2 id="part-road"><span lang="en">IV. The open road</span></h2>
<h3 id="wikipedia"><span lang="en">Wikipedia in the village</span> <span class="st nt" data-ui="nt">not yet tested</span></h3>
<p lang="en">One of the goals of the network: Wikipedia in French and in English, readable by anyone in the village, with no Internet, and on Layer 1 like everything else. Nothing needs converting by hand. Kiwix publishes all of Wikipedia as ZIM files, and <a href="https://lavaforge.org/Reticulum-Things/Retipedia">Retipedia</a> serves a ZIM file as Nomad Network pages: each article is turned into micron when someone asks for it, with search.</p>
<ul lang="en">
  <li><strong>On every store nest:</strong> a Nomad Network page node with Retipedia, and the French and English Wikipedia ZIM files on the SSD. The node's address is a key hash, printed on paper with the others.</li>
  <li><strong>Which edition:</strong> micron shows text, not pictures, so the <em>nopic</em> edition (full articles without images, about a quarter of the full size) is enough for the nest. Frugal.</li>
  <li><strong>Reading it:</strong> in any Nomad Network client: Nomad Network in a terminal, MeshChat on a laptop. A page is a few kilobytes of text, so it even crosses slow flyways. The Android app that renders these pages is still to check.</li>
  <li><strong>Reading it with no network at all:</strong> anyone can also fetch a ZIM file by hash over Layer 1 and open it in the Kiwix app. <em>mini</em> (introductions only, about 5 %) fits any phone; <em>maxi</em> has the pictures.</li>
  <li><strong>Moving it between nests:</strong> on a disk carried by hand, each file checked against its hash in a manifest signed by several keys (P2). A new dump every few months, by the same path.</li>
</ul>
<p class="note" lang="en">This replaces the idea of serving Wikipedia over HTTP: no web service beyond the on-ramp is needed. To check before relying on it: Retipedia handles one ZIM file per instance today, so French and English need two; its version must be pinned like Reticulum's; and Wikipedia's licence (CC BY-SA) asks that every page keep its attribution.</p>
<h3 id="roadmap"><span lang="en">Roadmap</span></h3>
<h4><span lang="en">Phase 1: one village works</span></h4>
<ul class="todo" lang="en">
  <li class="done">Two CPE510s linked by batman-adv, AP + client on channel 108</li>
  <li class="done">Pi 4 server in IPv4, with isolation from the home LAN</li>
  <li class="done">Backbone in IPv6 only, with <code>batctl-default</code> (2026-11-14)</li>
  <li class="done">People's devices in IPv6 on Linux and Android, through a hedge, with the router flag and a non-ULA bench prefix on the nest (2026-11-14)</li>
  <li>People's devices on iPhone and Windows</li>
  <li>Choose the non-ULA prefix for real villages (Android needs one)</li>
  <li>Reticulum on the first nest: laptop first, then Sideband, then store-and-forward</li>
  <li>Measure file transfer rate over Reticulum. Too slow for films means revisiting that choice</li>
  <li>Welcome page and captive portal on Android and iPhone</li>
  <li>Nomad Network node (pages and files) and the signed manifest format; a neighbour's page node on a Pi Zero 2 W</li>
  <li>EAP225-Outdoor on the bench (two v1, one v3): the v3 runs as a hedge; next, the two v1 as hedges meshing with it</li>
  <li>Build the perch, feeder and hedge images for real and run them on the bench; settle the CPE510's 5 GHz power (TPC); move the two bench perches to the perch image</li>
  <li>Admin by SSH keys only; data on a USB SSD</li>
  <li>Settle the legal status (operator, data retention) before opening beyond friends</li>
</ul>
<h4><span lang="en">Phase 2: no single point of failure</span></h4>
<ul class="todo" lang="en">
  <li>A second nest as an equal peer: same on-ramp, same /64, its own propagation node</li>
  <li>Wikipedia in French and English on every store nest, browsable over Layer 1 with Retipedia</li>
  <li>App hash and village key hashes on paper</li>
  <li>Backup and restore, identity keys included</li>
</ul>
<h4><span lang="en">Phase 3: village to village</span></h4>
<ul class="todo" lang="en">
  <li>One /64 per village, and how villages are separated and linked</li>
  <li>Propagation nodes and file stores that sync and survive a cut</li>
  <li>Optional LoRa flyway as backup (RNode), and other media where they fit (<a href="#lora">see the idea</a>)</li>
  <li>A private hub on a VPS that the nests connect to, then a second one with another provider. Peering with the public network stays a separate decision (<a href="#outside">see the idea</a>)</li>
</ul>
<h4><span lang="en">Phase 4: social layer and governance</span></h4>
<ul class="todo" lang="en">
  <li>A local social layer with key-based identity</li>
  <li>Usage charter; shared lists governed by several independent signers</li>
  <li>Privacy policy: nothing is logged. Legal duties to check before any Internet gateway</li>
</ul>
<h4><span lang="en">Phase 5: the kit</span></h4>
<ul class="todo" lang="en">
  <li>Prebuilt images per role (nest, perch, feeder, hedge), with first-boot scripts. Perch, feeder and hedge: written</li>
  <li>Install guide for non-experts; troubleshooting page from the pitfalls</li>
  <li>Reticulum licence conditions checked before selling</li>
</ul>
<h3 id="ideas"><span lang="en">Ideas not yet decided</span></h3>
<p lang="en">Discussed from 2026-11-12 to 2026-11-18. None of this is built, and none of it overrides a hard rule until it is decided. Three ideas once here have moved up to <a href="#images">Part III</a>: the perch images, the village of feeders that also mesh, which became the <a href="#hedge-image">hedge</a> on 2026-11-14, and two checks in the build on 2026-11-20.</p>
<div class="cards">
  <div class="card">
    <h4><span lang="en">A nest image with nothing to configure</span></h4>
    <p lang="en">At first boot the nest makes its own keys, then listens for RAs. If it hears one, it joins that village as an equal peer and takes a free address in the infrastructure range. If it hears none, it is the first nest of a new village and needs one thing from a person: the village number. Home Wi-Fi stays off.</p>
    <p lang="en"><span class="k">Changes</span>the static <code>::1</code>, <code>::2</code> rule becomes "any free address in <code>::10</code> to <code>::ff</code>".</p>
  </div>
  <div class="card">
    <h4><span lang="en">Updates carried by the mesh itself</span></h4>
    <p lang="en">A release is a manifest of file hashes signed by k of n keys. It is announced over Reticulum, and files are fetched by hash from any nest that has them. A node installs only if the signatures and hashes check and the version is newer, then rolls back if its health check fails. The owner's policy decides: automatic, delayed, or manual.</p>
    <p lang="en"><span class="k">Perches</span>a nest hands the image over with a restricted SSH key, and the node checks the signatures itself. Manual by default: a bad image on a pole means a ladder. Upgrade the farthest node first.</p>
  </div>
  <div class="card">
    <h4><span lang="en">The on-ramp on every feeder</span></h4>
    <p lang="en">A feeder like the EAP225 has the room to send RAs, answer DNS and serve the page. Phones would then stay on the network with no nest running. If it is done, the three go together or not at all: an RA that points to a dead DNS server is worse than no RA.</p>
    <p lang="en"><span class="k">Breaks</span>"only nests send RAs". One misconfigured feeder would poison the whole village.</p>
  </div>
  <div class="card">
    <h4><span lang="en">A second operating system: an OpenBSD nest</span></h4>
    <p lang="en">OpenBSD runs on the Pi 4, wired (<code>bse</code>) and Wi-Fi (<code>bwfm</code>, WPA2 only), and has the whole on-ramp in its base system: <code>rad</code> for RAs with the DNS server inside, <code>unbound</code> for the catch-all DNS, <code>httpd</code> for the page, <code>pf</code> for the redirect and the isolation. Two independent systems sending the same RAs means one bug can't take down every peer (P3, P5).</p>
    <p lang="en"><span class="k">Updates</span>every OpenBSD file set, binary patch and package is signed with <code>signify</code>, and <code>syspatch</code>, <code>pkg_add</code> and <code>sysupgrade</code> check the signature themselves. So any copy is valid, from any nest (P2), and nobody needs to rule. A nest with a home uplink mirrors what nests need; the mirror travels over Layer 1 or on a disk; the other nests point <code>/etc/installurl</code> at their local copy, then run <code>syspatch</code> and <code>pkg_add -u</code>, and <code>sysupgrade</code> at each release. Only the pinned Reticulum wheels need a village signature. A local <code>file://</code> installurl is still to check on the bench.</p>
    <p lang="en"><span class="k">Cost</span>Reticulum on OpenBSD is untested (an AutoInterface fix for OpenBSD landed in 2023). Only the last two releases are supported, about a year each, and <code>sysupgrade</code> goes one release at a time, so a village cut off for long must keep the old sets in its mirror. And it is a second nest image to document and test: only after the Debian nest works.</p>
  </div>
  <div class="card">
    <h4><span lang="en">The project in git, carried by Reticulum</span></h4>
    <p lang="en">Reticulum ships <code>rngit</code>: git repositories served over Reticulum, cloned with addresses like <code>rns://&lt;node hash&gt;/public/sparrows</code>. The handbook, the snippets and the scripts would live in one repository. Every nest keeps a full copy and serves it; admins push, everyone else clones and pulls. The same node can show the repository as Nomad Network pages: files, history, changes.</p>
    <p lang="en"><span class="k">Serves</span>P2: every clone is a full, checkable copy, so nothing is lost with a nest. P3: no outside hosting. P4: a village cut off syncs when the link returns, or by a disk carried by hand. And it gives the "Who rules? Nobody" idea its tool: releases as signed tags, several signers.</p>
    <p lang="en"><span class="k">Cost</span>one more service on every nest, and a young tool to pin and test. Write access by key, read access open. The Reticulum manual warns to take care when hosting public repositories: never commit a secret, and check who may push. The <code>kit/</code> folder stays as the way in for people with no app.</p>
  </div>
  <div class="card">
    <h4><span lang="en">A nest on the open Wi-Fi, with no home side</span></h4>
    <p lang="en">A nest can join the <code>Sparrows</code> Wi-Fi as a client: IPv4 off, its static address set by hand, Reticulum on that interface. Dropping the home side removes the only link to the Internet: admin comes from a laptop on the village with SSH keys, and software arrives as signed bundles.</p>
    <p lang="en"><span class="k">Cost</span>RAs over Wi-Fi are less reliable than on a cable, because multicast over Wi-Fi is slow and lossy. Fine for a light nest next to a feeder; a store nest stays on a cable.</p>
  </div>
  <div class="card">
    <h4><span lang="en">One build, the same on every unit (the NixOS way)</span></h4>
    <p lang="en">Discussed on 2026-11-18. Taken from NixOS: a unit runs only what the repository builds, and the previous build is kept to go back to. A change made by hand on a unit is a test. To keep it, put it in the repository and rebuild. NixOS itself runs on a Pi 4, but every volunteer would have to learn Nix: we copy the method, not the system.</p>
    <p lang="en"><span class="k">Stations</span>update with <code>sysupgrade -n</code> instead of <code>-v</code> (<a href="#upgrade">Part III, 7</a>), so nothing survives but what the image makes from the MAC. Today <code>-v</code> keeps hand edits, and stations slowly drift apart. The kit keeps the last two images of each role; going back means flashing the previous one. A CPE510 has one firmware slot, so failsafe mode stays the last resort.</p>
    <p lang="en"><span class="k">Nests</span>build the whole nest image on the admin laptop (<code>mkosi</code> or <code>debos</code>) from a pinned local copy of the Debian packages (an <code>aptly</code> snapshot). Install it with RAUC: two system slots, a signature check on every update bundle, and a switch back to the old slot if the new one doesn't boot. What belongs to one nest (its Reticulum identity, its keys) lives on a separate data partition. A bundle travels over the village or on a USB stick, and is what the card "Updates carried by the mesh itself" would carry. If nests run OpenWrt (next card), this part goes away: the same <code>build.sh</code> and <code>sysupgrade</code> serve every unit.</p>
    <p lang="en"><span class="k">Cost</span>with <code>-n</code>, the one choice made on a unit today, <code>perch ap</code>, is lost at each update: either the <code>perch</code> tool keeps it in one small file that comes back after the update, or it is redone by hand. The SSH host key also changes at each update; host certificates signed by a village key would fix that. On the nest, two slots double the system space on the card, and RAUC's switch back on a failed boot depends on the Pi's boot loader: still to check on the bench, on the Pi model we use.</p>
  </div>
  <div class="card">
    <h4><span lang="en">The role chosen on the unit</span></h4>
    <p lang="en">Discussed on 2026-11-18. Today stations run OpenWrt and nests run Debian: two systems to build, update and learn. Debian can't run on a CPE510 or an EAP225, but OpenWrt runs on a Raspberry Pi, so OpenWrt is the only way to have one system everywhere. A nest's on-ramp is already in OpenWrt: <code>odhcpd</code> sends RAs with the DNS server inside, <code>dnsmasq</code> answers the catch-all DNS, <code>uhttpd</code> serves the page, <code>fw4</code> (nftables) does the redirect and the isolation. <strong>Decided on 2026-11-21:</strong> one system, OpenWrt, nests included (<a href="#nest-image">Nest image</a>), with what each port and radio does chosen at build time (<a href="#uses">uses</a>). What stays an idea is below: choosing the role on the unit after flashing.</p>
    <p lang="en"><span class="k">How</span>one image per hardware model, holding every role that model can take (<code>profiles.txt</code> already lists them; a CPE510 has no room for Python, so it can never be a nest). After flashing, one command picks the role, for example <code>sparrows role hedge</code>, and writes it to <code>/etc/sparrows/role</code>. At every boot, not only the first, the config is rebuilt from that file: a hand edit is gone at the next reboot. Only the role file and the keys survive an update. <code>perch ap</code> becomes a role of its own, so it is no longer lost.</p>
    <p lang="en"><span class="k">Cost</span>Reticulum supports OpenWrt packaging since version 0.8.7 (2024), but its OpenWrt package feed was still being stabilized, and LXMF, Nomad Network and Retipedia must each be tested on it. A Pi update rewrites the SD card, so Wikipedia and other big data go on a USB disk. Fewer people know OpenWrt as a server, though everyone who builds stations learns it anyway. The Debian nest stays the reference until an OpenWrt nest on a second Pi passes the same checks.</p>
  </div>
</div>
<h3 id="outside"><span lang="en">A hub between villages, on a VPS</span> <span class="st idea" data-ui="idea">idea</span></h3>
<p lang="en">Discussed on 2026-11-15, preferred over linking a nest straight to the public testnet. Not decided, not tested. We run our own Reticulum relay on a rented server (a VPS). Each nest opens one outgoing TCP link to it through its home line. Villages then reach each other through the hub, and the hub decides whether anything goes further.</p>
<h4><span lang="en">What it gives</span></h4>
<ul lang="en">
  <li><strong>The home address stays out of sight.</strong> Public relays would see the VPS, never the house. Only the VPS provider sees the house connect.</li>
  <li><strong>We hold the door.</strong> An interface access code (<code>network_name</code> + <code>passphrase</code>) drops every packet that doesn't carry it, so only our nests join. Peering with the public network is one block on the hub, off by default.</li>
  <li><strong>It is the Phase 3 link between villages</strong> for places no flyway reaches.</li>
  <li><strong>Nothing opens at home.</strong> The nest only connects outwards. Forwarding stays off and the nftables <code>forward</code> drop stays: the mesh still can't reach the Internet. Only Reticulum packets cross, through <code>rnsd</code>.</li>
  <li><strong>The village keeps working</strong> if the hub is down: the link only adds, it replaces nothing.</li>
</ul>
<h4><span lang="en">What it costs: security and anonymity</span></h4>
<ul lang="en">
  <li><strong>The hub sees who talks to whom, not what is said.</strong> Content stays encrypted end to end. But whoever controls the VPS (us, the provider, or someone who seizes it) sees which home addresses connect, when, how much, and which key hashes exchange packets. In a village of a few dozen people, timing alone says a lot.</li>
  <li><strong>If the VPS is taken over,</strong> the intruder holds the hub's key and the access code: they can join the private network, pose as the hub, drop or delay traffic, or flood announces. They can't read messages or take anyone's address, because announces are signed. On a nest, a hostile hub reaches <code>rnsd</code>, which runs as the unprivileged <code>rns</code> user, not the system.</li>
  <li><strong>A centre and an outside party.</strong> One hub is a single point for links between villages (line I, P3), and the VPS is rented in one person's name from a company (P5). A second hub with another provider, with every nest connected to both, removes the single point and splits what each provider sees.</li>
  <li><strong>The traffic is recognisable.</strong> The home ISP and the provider can tell it is Reticulum, even if they can't read it. The access code keeps strangers out; it hides nothing. A WireGuard tunnel under the TCP link would make it look ordinary.</li>
  <li><strong>A port open on the Internet</strong> gets scanned and flooded, and <code>rnsd</code> is what answers. Open that port and SSH only, keys only, keep the software patched and the logs low, and assume the provider keeps its own logs.</li>
  <li><strong>People can be followed by their key hash.</strong> A phone that always announces the same identity can be tracked over time by anyone who sees its announces. Inside a private hub that means our own villages. With public peering on, it means everyone: the reason it is off by default.</li>
  <li><strong>The whole village is linked, not just the nest.</strong> With transport on, every phone can reach and be reached through the hub. Within one <code>rnsd</code> it is all or nothing.</li>
  <li><strong>The law.</strong> A hub that only links our own villages is a private link. A hub that relays public traffic makes its owner the operator of that relay. See <a href="#law">The law in France</a>.</li>
</ul>
<h4><span lang="en">How we would do it</span></h4>
<ol lang="en">
  <li>One hub with the access code, private only. Nests connect by its IP address, never by a name.</li>
  <li>A second hub with another provider. Every nest connects to both: Reticulum drops duplicate packets by their hash and keeps the best path, so two links make no loop.</li>
  <li>Public peering only by an explicit decision, written here with its date. The public testnet often runs experimental versions; the community entry points are the ones meant for everyday use.</li>
</ol>
<p class="note" lang="en">It touches the hard rule "Standalone". It is not an Internet gateway: no IP packet of the mesh leaves. But it ties the villages to a rented machine on the Internet, so it needs an explicit decision before it is built.</p>
<div class="code"><div class="hd"><span class="file">VPS, then each nest</span></div><pre><code># ---- On the VPS (Debian family). Same install as on a nest: venv, user rns, rnsd.service ----
# /var/lib/reticulum/config
[reticulum]
  enable_transport = Yes
  share_instance = Yes
&#32;
[logging]
  loglevel = 3                    # keep it low: the hub should remember as little as possible
&#32;
[interfaces]
  [[Sparrows Hub]]
    type = TCPServerInterface
    enabled = yes
    listen_ip = 0.0.0.0           # for IPv6 listening, check `rnsd --exampleconfig` on your version
    listen_port = 4242
    network_name = sparrows-hub   # interface access code: packets without it are dropped
    passphrase = &lt;long random, the same on every nest&gt;
&#32;
  # Optional, OFF by default, an explicit decision: peer the hub with the public Reticulum network
  # [[Public entry point]]
  #   type = TCPClientInterface
  #   enabled = no
  #   target_host = &lt;a community entry point&gt;
  #   target_port = 4242
  #   mode = boundary
&#32;
# VPS firewall: SSH (keys only) and the hub port, nothing else:   tcp dport { 22, 4242 } accept
&#32;
# ---- On each nest: add under [interfaces] in /var/lib/reticulum/config ----
  [[Sparrows Hub]]
    type = TCPClientInterface
    enabled = yes
    target_host = &lt;VPS address&gt;   # an IP address, not a name: no outside DNS needed
    target_port = 4242
    network_name = sparrows-hub
    passphrase = &lt;the same&gt;
    mode = boundary               # a link to a very different segment
&#32;
# Apply and verify on the nest. The TCP session leaves by wlan0: no forwarding, no firewall change
sudo systemctl restart rnsd lxmd
sudo -u rns /opt/reticulum/bin/rnstatus --config /var/lib/reticulum   # "Sparrows Hub" Up
ss -tnp | grep 4242                                                   # one TCP session, from the wlan0 address
&#32;
# Undo on the nest: enabled = no on that block (or delete it), then
sudo systemctl restart rnsd lxmd</code></pre></div>
<h3 id="lora"><span lang="en">A LoRa flyway to a town 15 km away</span> <span class="st idea" data-ui="idea">idea</span></h3>
<p lang="en">Discussed on 2026-11-20. Not decided, not tested. Two LoRa boards running RNode firmware, one at each end, each plugged by USB into a nest. Reticulum on the nests relays between the village and the LoRa link. It carries messages and small pages, slowly, with no Internet and no operator in between.</p>
<h4><span lang="en">Which board</span></h4>
<ul lang="en">
  <li><strong>The chip:</strong> an SX1262 on 868 MHz. It hears weaker signals than the older SX1276 and sends up to +22 dBm. Avoid 433 MHz (10 mW only in the EU) and 2.4 GHz LoRa (shorter range).</li>
  <li><strong>LilyGO T3S3 (SX1262):</strong> cheap and well supported by RNode. The default choice.</li>
  <li><strong>Heltec LoRa32 V3 or V4:</strong> same chip, also cheap. Its small antenna socket is fragile: use a short pigtail to an N connector.</li>
  <li><strong>RAK4631 (WisBlock):</strong> nRF52 and SX1262. It uses very little power: the one for a solar relay on a mast.</li>
  <li>Check the list of supported boards in <code>rnodeconf</code> before buying: it changes with new versions.</li>
</ul>
<h4><span lang="en">What makes 15 km work: height</span></h4>
<ul lang="en">
  <li><strong>Line of sight is not enough: keep the Fresnel zone clear.</strong> At 868 MHz over 15 km it is about 36 m in radius at the middle. Keep at least 60 % of it clear (about 22 m), plus about 3 m for the curve of the Earth, above the trees and roofs at mid-path.</li>
  <li><strong>The country is flat, so go up:</strong> a water tower, a church tower or a tall mast, at both ends.</li>
  <li><strong>The margin is large.</strong> Free-space loss over 15 km is about 115 dB. With about 20 dBm radiated, a 5 dBi antenna at the other end and SF9, the signal arrives near −90 dBm and the board hears down to about −129 dBm: about 35 dB to spare. A partly blocked path may still work. Only a test on site will tell.</li>
  <li><strong>Antennas:</strong> an outdoor collinear (about 5 dBi), or a Yagi aimed at the other end. Put the board in a box at the top, next to the antenna, with a short cable. Bring USB or Ethernet down the mast, not a long antenna cable.</li>
  <li><strong>Test before mounting:</strong> two boards on battery, one person at each site, and the signal strength that <code>rnprobe</code> shows (RSSI and SNR; the other end needs <code>respond_to_probes = Yes</code>).</li>
</ul>
<h4><span lang="en">The law: one sub-band</span></h4>
<ul lang="en">
  <li><strong>869.4–869.65 MHz:</strong> up to 500 mW <a href="#g-erp">ERP</a>, sending at most 10 % of the time. The best sub-band for a long link. Elsewhere in 868 MHz it is 25 mW and 1 %.</li>
  <li><strong>The limit includes the antenna.</strong> ERP = power set on the board + antenna gain (dBi) − cable loss − 2.15. With a high-gain Yagi, lower the power.</li>
  <li><strong>Reticulum keeps the 10 %</strong> with <code>airtime_limit_long</code> and <code>airtime_limit_short</code> in the config below.</li>
  <li><strong>Speed:</strong> about 1.7 kbit/s at SF9 and 125 kHz. Enough for LXMF messages and Nomad Network pages, not for files. Where both ends see each other, a pair of perches on 5 GHz carries the same distance at tens of Mbit/s: LoRa is then a backup, or a first link while the masts wait.</li>
</ul>
<h4><span lang="en">How we would do it</span></h4>
<p lang="en">Flash both boards while the laptop has Internet, plug each into a nest, and add the same block to both nests. Both ends must use the same frequency, bandwidth, spreading factor and coding rate, or they don't hear each other. The nest's existing village interface stays as it is. <span class="st nt" data-ui="nt">not yet tested</span></p>
<div class="code"><div class="hd"><span class="file">admin laptop, then each nest</span></div><pre><code># Not yet tested. ---- On the admin laptop, while it has Internet: flash each board once ----
python3 -m venv ~/rns &amp;&amp; ~/rns/bin/pip install rns
~/rns/bin/rnodeconf --autoinstall            # pick the board (e.g. LilyGO T3S3, SX1262) and 868 MHz
~/rns/bin/rnodeconf /dev/ttyACM0 --info      # firmware version, board, frequency range
&#32;
# ---- On each nest: the board on USB, readable by the rns user ----
ls -l /dev/serial/by-id/                     # a stable name for the board
sudo usermod -aG dialout rns
# Add under [interfaces] in /var/lib/reticulum/config. The SAME radio values at both ends.
  [[LoRa flyway]]
    type = RNodeInterface
    enabled = yes
    port = /dev/serial/by-id/&lt;the board&gt;
    frequency = 869525000         # middle of 869.4-869.65 MHz: 500 mW ERP, 10 % of the time
    bandwidth = 125000
    spreadingfactor = 9           # about 1.7 kbit/s. Higher = farther and slower
    codingrate = 5
    txpower = 17                  # dBm on the board. ERP = txpower + antenna dBi - cable loss - 2.15, max 27
    airtime_limit_long = 9        # % of the time over the long window: under the 10 % of the law
    airtime_limit_short = 33      # % over the short window: bursts allowed, the long limit still holds
&#32;
# Apply and verify on the nest
sudo systemctl restart rnsd lxmd
sudo -u rns /opt/reticulum/bin/rnstatus --config /var/lib/reticulum   # "LoRa flyway" Up, its airtime and channel load
journalctl -u rnsd -n 50                                              # no serial error
# From a laptop in this village: the other village's nest is reachable over LoRa
rnpath &lt;lxmd address of the other nest&gt;      # a path, 2 or more hops
rnprobe rnstransport.probe &lt;the other nest's transport hash&gt;   # RSSI and SNR (needs respond_to_probes = Yes there)
&#32;
# Undo on the nest: enabled = no on that block (or delete it), then
sudo systemctl restart rnsd lxmd</code></pre></div>
<p class="note" lang="en">It keeps the hard rule "Standalone": no Internet and no company on the link. LoRa itself is not encrypted, but Reticulum encrypts every packet. The board and the antenna on a public building need the owner's agreement.</p>
<h3 id="growing"><span lang="en">How this page grows</span></h3>
<ul lang="en">
  <li><strong>One file.</strong> No outside font, script or image, so a Pi can serve it on the mesh as it is.</li>
  <li><strong>A new idea</strong> goes in Part IV with the <span class="st idea" data-ui="idea">idea</span> mark. When it is decided it moves up with its date. When it has run on the bench it earns <span class="st ok" data-ui="ok">tested</span>.</li>
  <li><strong>A new language:</strong> add its code to <code>LANGS</code> and its short labels to <code>UI</code> in the script at the bottom, then add a sibling block with <code>lang="xx"</code> next to each block of the other languages. A block with no <code>lang</code> attribute shows in every language: use that for anything not translated yet.</li>
  <li><strong>Code appears once.</strong> A translation never touches a command. The OpenWrt image files are shown straight from the <code>sparrows-openwrt</code> build tree, so the page and the images can't drift apart.</li>
  <li><strong>One handbook.</strong> This page is the only document: no separate how-to, no README. Whatever is decided or learned goes here. The scripts stay separate files beside it, and the page prints them as they are.</li>
  <li><strong>A new kind of station</strong> gets a name from the places and things of birds, and an entry in the glossary with its hardware as an example.</li>
</ul>
<h2 id="glossary"><span lang="en">Glossary</span></h2>
<h3><span lang="en">Names of stations</span></h3>
<p lang="en">Named after the places and things of birds, by role. Hardware names are examples only.</p>
<dl class="gloss">
  <dt id="g-feeder"><span lang="en">Feeder</span><span class="tr" lang="en">FR mangeoire</span></dt>
  <dd lang="en">An access point: the open Wi-Fi where people's devices come in. Bridge only. Example: EAP225-Outdoor, an old home router.</dd>
  <dt id="g-perch"><span lang="en">Perch</span><span class="tr" lang="en">FR perchoir</span></dt>
  <dd lang="en">A radio station on a mast, at one end of a flyway. Bridge only, running batman-adv. Example: CPE510.</dd>
  <dt id="g-hedge"><span lang="en">Hedge</span><span class="tr" lang="en">FR haie</span></dt>
  <dd lang="en">A feeder and a perch in one box: open Wi-Fi for people, and a mesh to the neighbouring hedges. Sparrows feed, shelter and travel along hedgerows. Bridge only, running batman-adv. Example: EAP225-Outdoor.</dd>
  <dt id="g-flyway"><span lang="en">Flyway</span><span class="tr" lang="en">FR voie de migration</span></dt>
  <dd lang="en">A link between two places, on any medium: 5 GHz, 2.4 GHz, 60 GHz, LoRa, cable, or a disk carried by hand.</dd>
  <dt id="g-nest"><span lang="en">Nest</span><span class="tr" lang="en">FR nid</span></dt>
  <dd lang="en">A peer that sends router advertisements, serves the on-ramp, and relays and stores for Layer 1. All nests are equal. A store nest also keeps files. Example: Raspberry Pi, mini PC, old laptop.</dd>
  <dt id="g-tree"><span lang="en">Tree</span><span class="tr" lang="en">FR arbre</span></dt>
  <dd lang="en">A relay that only does Layer 1 (Reticulum transport), with no on-ramp. Sparrows gather in a tree and call to each other: a tree passes on what it hears. Anyone can plant one. Example: any Linux machine or laptop left on.</dd>
  <dt id="g-wire"><span lang="en">Wire</span><span class="tr" lang="en">FR fil</span></dt>
  <dd lang="en">What a station's Ethernet ports do: a cable to the site's switch, part of the village segment. Sparrows sit on wires.</dd>
  <dt id="g-join"><span lang="en">Join</span><span class="tr" lang="en">FR rejoindre</span></dt>
  <dd lang="en">What a radio does when it is a client of the <code>Sparrows</code> Wi-Fi, like a phone: a tree joins. Never bridged, so nothing hangs behind it.</dd>
  <dt id="g-station"><span lang="en">Station</span></dt>
  <dd lang="en">Any of the above. A user device is not a station: it belongs to a person and holds their key. Nor is a neighbour's page node: it is a user device that publishes.</dd>
</dl>
<h3><span lang="en">Technical terms</span></h3>
<dl class="gloss">
  <dt>RA</dt>
  <dd lang="en">Router advertisement: the message a nest sends to give the village prefix and the DNS server.</dd>
  <dt>SLAAC</dt>
  <dd lang="en">Each device builds its own IPv6 address from the prefix in the RA. No DHCP.</dd>
  <dt>RDNSS</dt>
  <dd lang="en">The DNS server address, carried inside the RA. The only way Android learns it.</dd>
  <dt>ULA</dt>
  <dd lang="en">A private IPv6 range. Ours is <code>fd7e:4c1a:9b20::/48</code>. Android does not count it as global, so a network with only ULA addresses and no IPv4 is refused by Android phones.</dd>
  <dt><span lang="en">Router flag</span></dt>
  <dd lang="en">A bit in the neighbour discovery answers of IPv6 that says "I am a router". Linux sets it only on an interface with forwarding on; Android drops a default router that answers without it.</dd>
  <dt>DFS</dt>
  <dd lang="en">The radar rule on 5 GHz channels 52 to 140: listen 60 s before transmitting, and leave the channel if a radar shows up.</dd>
  <dt><span lang="en">EIRP</span></dt>
  <dd lang="en">Radiated power with the antenna gain included. It is what the law limits.</dd>
  <dt id="g-erp"><span lang="en">ERP</span></dt>
  <dd lang="en">Radiated power compared with a simple dipole antenna: EIRP minus 2.15 dB. The LoRa limits are given in ERP.</dd>
  <dt><span lang="en">Fresnel zone</span></dt>
  <dd lang="en">The fat oval of space around the straight line between two antennas. Most of the signal travels through it, so trees or roofs inside it weaken a link even when each end can see the other.</dd>
  <dt>TPC</dt>
  <dd lang="en">Transmit power control: a radio that can lower its power on its own. On 5 GHz channels 100 to 140, a radio without it is allowed 3 dB less.</dd>
  <dt>SAE</dt>
  <dd lang="en">The WPA3 handshake that encrypts flyways and the hedge mesh. Its passphrase must be 8 to 63 printable ASCII characters.</dd>
  <dt>802.11s</dt>
  <dd lang="en">Wi-Fi mesh mode: every radio on the same channel and mesh ID links with the others, with no AP or client. Used between hedges on 2.4 GHz; it doesn't work on DFS channels.</dd>
  <dt>batman-adv</dt>
  <dd lang="en">Layer-2 mesh routing in the Linux kernel. It makes all the perches and hedges of a village behave like one switch. Its bridge loop avoidance stops loops when two of them share a cable.</dd>
  <dt>Reticulum</dt>
  <dd lang="en">The network stack of Layer 1: every address is the hash of a key, every link is encrypted, and it runs over almost any medium.</dd>
  <dt>AutoInterface</dt>
  <dd lang="en">The Reticulum interface that finds peers on a local segment by IPv6 link-local multicast, with no address or setting to give.</dd>
  <dt><span lang="en">Boundary mode</span></dt>
  <dd lang="en">A Reticulum interface mode for a link to a very different network, such as the Internet seen from a LoRa village. It changes how announces cross that link.</dd>
  <dt><span lang="en">Hub</span></dt>
  <dd lang="en">A Reticulum relay on a server that several nests connect to, to link villages no flyway joins. Closed by an interface access code.</dd>
  <dt><span lang="en">Interface access code</span></dt>
  <dd lang="en">A name and passphrase set on a Reticulum interface. Packets that don't carry the matching signature are dropped. It keeps strangers out; it does not hide the traffic.</dd>
  <dt>EUI-64</dt>
  <dd lang="en">The rule that turns a MAC address into the last 64 bits of an IPv6 address. It is why a station's address can be read off its sticker.</dd>
  <dt>LXMF</dt>
  <dd lang="en">Reticulum's message format. A propagation node keeps messages for people who are offline.</dd>
  <dt>Nomad Network</dt>
  <dd lang="en">Pages and files on Reticulum, written in micron. A node is reached by its key hash, never by a name.</dd>
  <dt>rngit</dt>
  <dd lang="en">The git tool that ships with Reticulum: repositories served and cloned over Reticulum, by key hash.</dd>
  <dt>RNode</dt>
  <dd lang="en">Firmware that turns a LoRa board into a Reticulum radio.</dd>
  <dt>signify</dt>
  <dd lang="en">OpenBSD's signing tool. Its update tools refuse any file whose signature doesn't check.</dd>
  <dt>sysupgrade</dt>
  <dd lang="en">The OpenWrt command that writes a new image to a running station. <code>-v</code> keeps the config; <code>-n</code> keeps nothing, so the image's first-boot defaults run again.</dd>
  <dt>RAUC</dt>
  <dd lang="en">An update tool for Linux devices. It keeps two system slots, writes a signed update bundle to the unused one, and switches to it; if it doesn't boot, the device goes back to the old slot.</dd>
  <dt>LuCI</dt>
  <dd lang="en">OpenWrt's web interface. Optional in Sparrows images, and reached only through SSH.</dd>
</dl>
<footer>
  <span lang="en">Sparrows-Network, village 1. Inspired by the Zen of Reticulum and by the Tor network; affiliated with neither. Contact: <a href="mailto:sparrows-network@riseup.net">sparrows-network@riseup.net</a></span>
</footer>
</div>
