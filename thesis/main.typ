#import "conf.typ": thesis, appendix, flex-caption

// =============================================================================
// KURZANLEITUNG
//
// 1. Trage unten in `thesis.with(...)` deine Angaben ein.
//    Optionen, die du nicht brauchst, kannst du einfach löschen –
//    sie werden dann nicht angezeigt.
// 2. Schreibe deinen Text ab der ersten Überschrift (= Einleitung).
// 3. Quellen kommen in die Datei literatur.bib (BibTeX-Format) und werden
//    mit @schlüssel zitiert, z. B. @DUMMY:1.
//
// Kapitel:       = Kapitel, == Unterkapitel, === Unterunterkapitel
//                (==== erzeugt eine Überschrift ohne Nummer)
// Verweise:      Abbildung mit <label> versehen, dann @label schreiben
// Verzeichnisse: Abbildungs-, Tabellen- und Quellcodeverzeichnis erscheinen
//                automatisch ab 4 Einträgen (siehe `outline-min-entries`).
// =============================================================================

#show: thesis.with(
  title: [Titel der Arbeit],
  thesis-type: "Bachelorarbeit",            // oder "Masterarbeit"
  degree: "Bachelor of Science (B.Sc.)",    // angestrebter Grad
  // department: "Informatik und Medien",   // Fachbereich (Standard)
  // subtitle: [Eigener Untertitel],        // ersetzt den automatischen Untertitel

  author: "Vorname Nachname",
  matriculation-number: "12345678",
  first-reviewer: "Prof. Dr. Erika Musterfrau",
  second-reviewer: "Dr. Max Mustermann",
  place: "Brandenburg an der Havel",
  // date: datetime(year: 2026, month: 9, day: 30), // Standard: heutiges Datum

  // Sperrvermerk (nur bei vertraulichen Firmendaten):
  // confidential: true,
  // company: "Musterfirma GmbH",

  // Angaben zur Nutzung von KI-Werkzeugen – nur falls von deiner
  // Betreuung gefordert. Umfang und Form bitte mit ihr absprechen.
  ai-statement: [
    Zur sprachlichen Überarbeitung wurden KI-basierte Werkzeuge eingesetzt.
    Die inhaltliche Ausarbeitung und Argumentation erfolgten eigenständig.
  ],
  // signature: image("unterschrift.png", height: 1.5cm),

  abstract-de: lorem(70),
  abstract-en: lorem(70),

  abbreviations: (
    "THB": [Technische Hochschule Brandenburg],
    "API": [Application Programming Interface],
    "PDF": [Portable Document Format],
  ),
)

= Einleitung <einleitung>

Dies ist ein Typoblindtext @DUMMY:1. An ihm kann man sehen, ob alle Buchstaben da sind und wie sie aussehen. Manchmal benutzt man Worte wie Hamburgefonts, Rafgenduks oder Handgloves, um Schriften zu testen. Wie in @abb-beispiel zu sehen ist, lassen sich Abbildungen im Text referenzieren.

#figure(
  image("Bild1.png", width: 40%),
  caption: flex-caption(
    // Kurzform für das Abbildungsverzeichnis
    [Beispielhafte Abbildung],
    // vollständige Bildunterschrift im Text
    [Beispielhafte Abbildung, modifiziert nach Liu, Long und Magerko (2020)],
  ),
) <abb-beispiel>

Sehr bekannt ist dieser: The quick brown fox jumps over the lazy old dog. Oft werden in Typoblindtexte auch fremdsprachige Satzteile eingebaut, um die Wirkung in anderen Sprachen zu testen. In Lateinisch sieht zum Beispiel fast jede Schrift gut aus. Quod erat demonstrandum. @tab-beispiel zeigt eine Tabelle.

#figure(
  table(
    columns: 3,
    align: (center, right, left),
    stroke: none,
    table.hline(),
    table.header[*Zeichen*][*Häufigkeit*][*Kommentar*],
    table.hline(stroke: 0.5pt),
    [$emptyset$], [1 in 1.000], [Für schwedische Namen],
    [$pi$], [1 in 5], [Häufig in der Mathematik],
    [\$], [4 in 5], [Häufig im Geschäftsleben],
    [$Psi_1^2$], [1 in 40.000], [Ungeklärte Verwendung],
    table.hline(),
  ),
  caption: [Beispielhafte Tabelle nach Borghoff und Schlichter (1998)],
) <tab-beispiel>

Genauso wichtig sind mittlerweile auch Âçcèñtë, die in neueren Schriften aber fast immer enthalten sind. Ein wichtiges aber schwierig zu integrierendes Feld sind OpenType-Funktionalitäten. Je nach Software und Voreinstellungen können eingebaute Kapitälchen, Kerning oder Ligaturen (sehr pfiffig) nicht richtig dargestellt werden.

= Kapitel 2 (z. B. Analyse)

Dies ist ein Typoblindtext. An ihm kann man sehen, ob alle Buchstaben da sind und wie sie aussehen.#footnote[Merke: Kapitel sind inhaltlich zu benennen, z. B. Analyse.] Wie in @einleitung beschrieben, …

== Erstes Unterkapitel (Ebene 2)

Dies ist ein Typoblindtext. An ihm kann man sehen, ob alle Buchstaben da sind und wie sie aussehen. Sehr bekannt ist dieser: The quick brown fox jumps over the lazy old dog.

=== Erstes Unterunterkapitel (Ebene 3)

#lorem(40)

=== Zweites Unterunterkapitel (Ebene 3)

#lorem(40)

== Zweites Unterkapitel (Ebene 2)

#lorem(10)

Merke: In der Regel gibt es kein Unterkapitel n.1, wenn es nicht auch ein Unterkapitel n.2 gibt. Falls doch, sollte das Unterkapitel n.1 aufgelöst werden, sodass Kapitel n keine Unterkapitel mehr aufweist.

= Weiteres Kapitel (z. B. Konzeption)

#lorem(50)

== Erstes Unterkapitel (Ebene 2)

#lorem(50)

== Zweites Unterkapitel (Ebene 2)

#lorem(50)

= Weiteres Kapitel (z. B. Implementierung)

#lorem(30) @lst-beispiel zeigt Quellcode mit Syntaxhervorhebung.

// Code in einer figure landet automatisch im Quellcodeverzeichnis.
#figure(
  ```js
  function helloWorld() {
    const text = "Hallo Welt"
    console.log(text)
  }
  ```,
  caption: [Beschreibung des Quellcodes],
) <lst-beispiel>

== Erstes Unterkapitel (Ebene 2)

#lorem(50)

== Zweites Unterkapitel (Ebene 2)

#lorem(50)

= Fazit

== Zusammenfassung

#lorem(50)

== Ausblick

#lorem(50)

// -----------------------------------------------------------------------------
// LITERATURVERZEICHNIS
// Zitierstil ändern mit style:, z. B. "apa", "ieee", "chicago-author-date"
// -----------------------------------------------------------------------------
#bibliography("literatur.bib", title: "Literaturverzeichnis", style: "ieee")

// -----------------------------------------------------------------------------
// GLOSSAR (optional, ohne Nummerierung)
// -----------------------------------------------------------------------------
#heading(numbering: none)[Glossar]

/ Ligatur: Verschmelzung zweier oder mehrerer Buchstaben zu einer Glyphe.
/ Kerning: Anpassung des Abstands zwischen zwei benachbarten Buchstaben.

// -----------------------------------------------------------------------------
// ANHANG (optional) – Kapitel werden mit A, B, C … nummeriert
// -----------------------------------------------------------------------------
#show: appendix

= Beispielanhang

#lorem(30)
