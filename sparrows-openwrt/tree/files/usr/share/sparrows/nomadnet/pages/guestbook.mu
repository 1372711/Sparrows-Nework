#!/usr/bin/python3
# Sparrows-Network: "Leave a trace", the guestbook of the Sparrows page. Nomad Network runs this file
# (it is executable) each time someone opens it, and prints what it writes as a Micron page.
# A message comes in field_message (the form on index.mu, fr.mu, es.mu), the language in var_lang.
# Anonymous by design: only the words are kept. Never who sent them (remote_identity, link_id),
# never when (no date: and a Pi without Internet doesn't know the date anyway), never from where.
# Kept in guestbook.txt next to the page node's identity: /home/nomadnetwork on a Pi whose locked
# /home is open, /etc/nomadnetwork otherwise. One message per line, newest last, 300 kept.
# Status: NOT YET TESTED on a unit.
import os

LANG = os.environ.get("var_lang", "en")
if LANG not in ("en", "fr", "es"):
    LANG = "en"
DIR = "/home/nomadnetwork" if os.path.ismount("/home") else "/etc/nomadnetwork"
BOOK = os.path.join(DIR, "guestbook.txt")
MAX_LEN = 280
KEEP = 300

T = {
    "en": {
        "title": "Traces left here",
        "intro": "Words left by people who passed by. No name, no date, no address: only the words.",
        "thanks": "Thank you, your trace is here. Nothing else was kept: not who you are, not when, not from where.",
        "field": "Your words:",
        "send": "Leave it here",
        "warn": "What you write is public. Don't write a name, a place, or anything that points to you or someone else.",
        "none": "No trace yet. Be the first.",
        "back": "Back to the Sparrows page",
        "home": "/page/index.mu",
    },
    "fr": {
        "title": "Les traces laissées ici",
        "intro": "Des mots laissés par des gens de passage. Pas de nom, pas de date, pas d'adresse : seulement les mots.",
        "thanks": "Merci, votre trace est là. Rien d'autre n'a été gardé : ni qui vous êtes, ni quand, ni d'où.",
        "field": "Vos mots :",
        "send": "La laisser ici",
        "warn": "Ce que vous écrivez est public. N'écrivez ni nom, ni lieu, ni rien qui vous désigne, vous ou quelqu'un d'autre.",
        "none": "Pas encore de trace. Soyez le premier ou la première.",
        "back": "Retour à la page Sparrows",
        "home": "/page/fr.mu",
    },
    "es": {
        "title": "Las huellas dejadas aquí",
        "intro": "Palabras dejadas por gente de paso. Sin nombre, sin fecha, sin dirección: solo las palabras.",
        "thanks": "Gracias, su huella está aquí. No se guardó nada más: ni quién es, ni cuándo, ni desde dónde.",
        "field": "Sus palabras:",
        "send": "Dejarla aquí",
        "warn": "Lo que escribe es público. No escriba un nombre, un lugar ni nada que le señale a usted o a otra persona.",
        "none": "Todavía no hay huellas. Sea el primero o la primera.",
        "back": "Volver a la página Sparrows",
        "home": "/page/es.mu",
    },
}[LANG]


def clean(text):
    # One line, no Micron markup: a backtick would format the page, so it becomes a quote
    text = " ".join(text.split()).replace("`", "'").replace("\\", "/")
    return text[:MAX_LEN]


def read():
    try:
        with open(BOOK, encoding="utf-8") as f:
            return [l.rstrip("\n") for l in f if l.strip()]
    except OSError:
        return []


entries = read()
said = clean(os.environ.get("field_message", ""))
added = False
if len(said) >= 2 and (not entries or entries[-1] != said):
    entries = (entries + [said])[-KEEP:]
    try:
        tmp = BOOK + ".new"
        with open(tmp, "w", encoding="utf-8") as f:
            f.write("\n".join(entries) + "\n")
        os.replace(tmp, BOOK)
        added = True
    except OSError:
        pass

out = ["#!c=0", ">Sparrows-Network", "", ">>" + T["title"], "", T["intro"], ""]
if added:
    out += ["`!" + T["thanks"] + "`!", ""]
out += [
    T["field"],
    "`<60|message`>",
    "`[" + T["send"] + "`:/page/guestbook.mu`message|lang=" + LANG + "]",
    "",
    "`*" + T["warn"] + "`*",
    "",
    "-",
    "",
]
if entries:
    for e in reversed(entries):
        out += ["  " + e, ""]
else:
    out += [T["none"], ""]
out += ["-", "`[" + T["back"] + "`:" + T["home"] + "]"]
print("\n".join(out))
