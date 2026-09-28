# THB Typst-Vorlagen

Adaption der [THB-Vorlagen](https://informatik.th-brandenburg.de/studium/abschlussarbeiten/) des Fachbereichs Informatik und Medien für [Typst](https://typst.app/).

| Vorlage | Ordner | Vorschau |
| --- | --- | --- |
| Abschlussarbeit (Bachelor/Master) | [`thesis/`](thesis) | [PDF](thesis/Vorlage%20Thesis.pdf) |
| Abschlussposter (A2) | [`poster/`](poster) | [PDF](poster/Vorlage%20Abschlussposter.pdf) |
| Präsentation (16:9) | [`presentation/`](presentation) | [PDF](presentation/Vorlage%20Präsentation.pdf) |

## Schnellstart

Jeder Ordner ist in sich abgeschlossen. Du brauchst nur den Ordner der Vorlage, die du verwenden willst.

**In der Typst-Web-App ([typst.app](https://typst.app))**

1. Repository als ZIP herunterladen (*Code → Download ZIP*) und entpacken.
2. In der Web-App ein leeres Projekt anlegen.
3. Alle Dateien aus dem gewünschten Ordner (z. B. `thesis/`) per Drag & Drop in die Dateiliste ziehen.
4. `main.typ` öffnen und loslegen.

**Lokal mit der [Typst CLI](https://github.com/typst/typst)**

```sh
git clone https://github.com/Walfisch115/thb-typst-template.git
cd thb-typst-template/thesis
typst watch main.typ
```

In jedem Ordner gilt: **`main.typ` ist deine Datei**, `conf.typ` enthält das Layout und muss normalerweise nicht angepasst werden.

## Abschlussarbeit (`thesis/`)

Alle Angaben stehen am Anfang der `main.typ`:

```typ
#import "conf.typ": thesis, appendix, flex-caption

#show: thesis.with(
  title: [Titel der Arbeit],
  thesis-type: "Bachelorarbeit",
  degree: "Bachelor of Science (B.Sc.)",
  author: "Vorname Nachname",
  matriculation-number: "12345678",
  first-reviewer: "Prof. Dr. Erika Musterfrau",
  second-reviewer: "Dr. Max Mustermann",
  abstract-de: [...],
  abstract-en: [...],
)

= Einleitung
...
```

| Option | Standard | Beschreibung |
| --- | --- | --- |
| `title` | – | Titel der Arbeit |
| `thesis-type` | `"Bachelorarbeit"` | Art der Arbeit, z. B. `"Masterarbeit"` |
| `degree` | `none` | angestrebter Grad, z. B. `"Master of Science (M.Sc.)"` |
| `department` | `"Informatik und Medien"` | Fachbereich |
| `subtitle` | `auto` | eigener Untertitel statt des automatisch erzeugten; `none` blendet ihn aus |
| `author` | – | dein Name |
| `matriculation-number` | `none` | Matrikelnummer |
| `first-reviewer`, `second-reviewer` | `none` | Erst- und Zweitgutachter:in |
| `first-reviewer-label`, `second-reviewer-label` | `"Erstgutachter:in"`, `"Zweitgutachter:in"` | Beschriftung auf dem Deckblatt |
| `place` | `"Brandenburg an der Havel"` | Ort für Deckblatt und Erklärung |
| `date` | `auto` (heute) | Abgabedatum, z. B. `datetime(year: 2026, month: 9, day: 30)` |
| `confidential` | `false` | Sperrvermerk: `true` für den Standardtext oder eigener Text |
| `company` | `none` | Firma für den Standardtext des Sperrvermerks |
| `ai-statement` | `none` | Angaben zur Nutzung von KI-Werkzeugen unter der Selbstständigkeitserklärung |
| `signature` | `none` | Bild der Unterschrift, z. B. `image("unterschrift.png", height: 1.5cm)` |
| `abstract-de`, `abstract-en` | `none` | Kurzfassung und Abstract |
| `abbreviations` | `none` | Abkürzungsverzeichnis, z. B. `("API": [Application Programming Interface])` |
| `outline-min-entries` | `4` | Abbildungs-, Tabellen- und Quellcodeverzeichnis erscheinen ab so vielen Einträgen |
| `font-size` | `12pt` | Schriftgröße des Fließtexts |

Weitere Funktionen:

- **Verweise:** Abbildungen, Tabellen und Kapitel mit `<label>` markieren und mit `@label` referenzieren.
- **Quellcode:** Code in einem `#figure(...)` landet automatisch im Quellcodeverzeichnis.
- **Kurze Bildunterschriften im Verzeichnis:** `caption: flex-caption([Kurz], [Lange Bildunterschrift])`.
- **Literatur:** Quellen in `literatur.bib` pflegen und mit `@schlüssel` zitieren. Den Zitierstil stellst du beim `#bibliography(...)` am Ende der `main.typ` ein.
- **Anhang:** Nach `#show: appendix` werden Kapitel mit A, B, C … nummeriert.

## Poster (`poster/`)

```typ
#show: poster.with(
  title: [Titel der Arbeit],
  author: "Max Mustermann",
  thesis-type: "Bachelorarbeit",
  study-program: "Informatik",
  supervision: [Betreuung: Prof. Dr. John Doe • Technische Hochschule Brandenburg],
)
```

Die Zeile unter dem Namen (Art der Arbeit • Studiengang • Fachbereich • Datum) wird automatisch erzeugt und kann mit `subtitle` ersetzt werden. Der Inhalt fließt zweispaltig, mit `#colbreak()` wechselst du in die rechte Spalte.

## Präsentation (`presentation/`)

```typ
#show: presentation.with(
  title: [Aufregender Präsentationstitel],
  author: [Max Mustermann],
  subtitle: [Betreuung: Prof. Dr. Erika Musterfrau],
  date: auto,
)

#title-slide()

#slide(title: [Folientitel])[
  - Punkt
  - Punkt
]

#slide(title: [Zwei Spalten])[
  #two-columns[Text links][#image("bild.png")]
]

#title-slide(title: [Vielen Dank für Ihre Aufmerksamkeit!])
```

Titel und Datum erscheinen automatisch in der Fußzeile jeder Folie. Mit `show-total-pages: true` werden die Seitenzahlen als „3 / 12“ angezeigt.
