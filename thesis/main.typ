#import "conf.typ": conf

/* 
HINWEISE

- subtitle und abstracts können in der config einfach weggelassen werden, wenn sie nicht benötigt werden (dann werden sie nicht gerendert)

- Quellcode kann in Figuren verwendet werden
- Mit kind: "code" gekennzeichnet, erscheint er im Quellcodeverzeichnis

- Abbildungs-, Tabellen- und Quellcodeverzeichnisse werden ab vier Einträgen hinter dem Inhaltsverzeichnis generiert. 
*/

#show: conf.with(
  title: "TITEL",
  subtitle: [
    *Master-/Bachelorarbeit*

    zur Erlangung des Grades Master/Bachelor of XXX \
    des Fachbereichs Informatik und Medien der \
    Technischen Hochschule Brandenburg
  ],
  author: "AUTOR",
  matrikelNumber: 12345678,
  supervisor: "ERSTER",
  secondReviewer: "ZWEITER",
  place: "ORT",
  abstractGerman: lorem(70),
  abstractEnglish: lorem(70),
  bibliographyFile: "test.bib",
  citationStyle: "ieee"
)

= Einleitung

Dies ist ein Typoblindtext. @DUMMY:1 An ihm kann man sehen, ob alle Buchstaben da sind und wie sie aussehen. Manchmal benutzt man Worte wie Hamburgefonts, Rafgenduks oder Handgloves, um Schriften zu testen (Laugwitz, Held & Schrepp, 2006).

#figure(
  image("Bild1.png"),
  caption: [Beispielhafte Abbildung, modifiziert nach Liu, Long und Magerko (2020)]
)

Sehr bekannt ist dieser: The quick brown fox jumps over the lazy old dog. Oft werden in Typoblindtexte auch fremdsprachige Satzteile eingebaut, um die Wirkung in anderen Sprachen zu testen (Oberquelle, 1991). In Lateinisch sieht zum Beispiel fast jede Schrift gut aus. Quod erat demonstrandum. Seit 1975 fehlen in den meisten Testtexten die Zahlen, weswegen nach TypoGb. 204 §0 ab dem Jahr 2034 Zahlen in 86 der Texte zur Pflicht werden (vgl. DIN EN ISO 9241-110, 2006).

#figure(
  table(image("Bild2.png")),
  caption: "Beispielhafte Tabelle aus Borghoff und Schlichter (1998)"
)

Genauso wichtig in sind mittlerweile auch Âçcèñtë, die in neueren Schriften aber fast immer enthalten sind. Ein wichtiges aber schwierig zu integrierendes Feld sind OpenType-Funktionalitäten. Je nach Software und Voreinstellungen können eingebaute Kapitälchen, Kerning oder Ligaturen (sehr pfiffig) nicht richtig dargestellt werden (Friedrich et al. 1995).

Nach Raskin (1994) ist ein wichtiges aber schwierig zu integrierendes Feld die OpenType-Funktionalität. Je nach Software und Voreinstellungen können eingebaute Kapitälchen, Kerning oder Ligaturen (sehr pfiffig) nicht richtig dargestellt werden.

= Kapitel 2 (z.B. Analyse)

Dies ist ein Typoblindtext. An ihm kann man sehen, ob alle Buchstaben da sind und wie sie aussehen. #footnote[Merke: Kapitel sind inhaltlich zu benennen: z.B. Analyse]

== Erstes Unterkapitel (Ebene 2)

Dies ist ein Typoblindtext. An ihm kann man sehen, ob alle Buchstaben da sind und wie sie aussehen. Sehr bekannt ist dieser: The quick brown fox jumps over the lazy old dog. Oft werden in Typoblindtexte auch fremdsprachige Satzteile eingebaut, um die Wirkung in anderen Sprachen zu testen. 

=== Erstes Unterunterkapitel (Ebene 3)

Dies ist ein Typoblindtext. An ihm kann man sehen, ob alle Buchstaben da sind und wie sie aussehen. Sehr bekannt ist dieser: The quick brown fox jumps over the lazy old dog. Oft werden in Typoblindtexte auch fremdsprachige Satzteile eingebaut, um die Wirkung in anderen Sprachen zu testen.

=== Zweites Unterunterkapitel (Ebene 3)

Dies ist ein Typoblindtext. An ihm kann man sehen, ob alle Buchstaben da sind und wie sie aussehen. Sehr bekannt ist dieser: The quick brown fox jumps over the lazy old dog. Oft werden in Typoblindtexte auch fremdsprachige Satzteile eingebaut, um die Wirkung in anderen Sprachen zu testen.

== Zweites Unterkapitel (Ebene 2)

#lorem(10)

Merke: in der Regel gibt es kein Unterkapitel n.1, wenn es nicht auch ein Unterkapitel n.2 gibt. Falls doch, dann sollte das Unterkapitel n.1 aufgelöst werden sodass das Kap. n keine Unterkapitel mehr aufweist.

= Weiteres Kapitel (z B. Konzeption)

Dies ist ein Typoblindtext. An ihm kann man sehen, ob alle Buchstaben da sind und wie sie aussehen. Sehr bekannt ist dieser: The quick brown fox jumps over the lazy old dog. Oft werden in Typoblindtexte auch fremdsprachige Satzteile eingebaut, um die Wirkung in anderen Sprachen zu testen. 

==	Erstes Unterkapitel (Ebene 2)

#lorem(50)

=== Erstes Unterunterkapitel (Ebene 3)

#lorem(50)

===	Zweites Unterunterkapitel (Ebene 3)

#lorem(50)

== Zweites Unterkapitel (Ebene 2)

#lorem(50)

= Weiteres Kapitel (z.B. Implementierung)

#lorem(50)

#figure(
  ```js
  // Quellcode mit Syntaxhighlighting
  function helloWorld() {
      const text = "Hallo Welt"
      console.log(text) 
  }
  ```,
  caption: [Beschreibung vom Quellcode],
  kind: "code",
  supplement: [Quellcode]
)

== Erstes Unterkapitel (Ebene 2)

#lorem(50)

===	Erstes Unterunterkapitel (Ebene 3)

#lorem(50)

===	Zweites Unterunterkapitel (Ebene 3)

#lorem(50)

==	Zweites Unterkapitel (Ebene 2)

#lorem(50)

=	Letztes Kapitel

#lorem(50)

==	Zusammenfassung

#lorem(50)

==	Offene Punkte

#lorem(50)

==	Ausblick

#lorem(50)

// Glossar
#heading(
  "Glossar",
  numbering: none
)

/ Ligature: A merged glyph.
/ Kerning: A spacing adjustment
  between two adjacent letters.

// Anhang
#heading(
  "Anhang",
  numbering: none,
)
