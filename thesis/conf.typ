// =============================================================================
// THB-Vorlage für Abschlussarbeiten (Bachelor/Master)
// Fachbereich Informatik und Medien – Technische Hochschule Brandenburg
//
// Diese Datei enthält nur das Layout. Deine Angaben und dein Text gehören in
// die main.typ. Eine Beschreibung aller Optionen findest du dort und in der
// README.md des Repositorys.
// =============================================================================

// Farbe aus dem THB-Logo (für eigene Hervorhebungen nutzbar)
#let thb-red = rgb(204, 17, 50)

// -----------------------------------------------------------------------------
// Hilfsfunktionen
// -----------------------------------------------------------------------------

// Formatiert ein Datum auf Deutsch, z. B. "28. September 2026".
// `date` kann ein `datetime`, beliebiger Inhalt (wird unverändert ausgegeben)
// oder `auto` (= heutiges Datum) sein.
#let format-date(date) = {
  if date == auto { date = datetime.today() }
  if type(date) != datetime { return date }

  let months = (
    "Januar", "Februar", "März", "April", "Mai", "Juni",
    "Juli", "August", "September", "Oktober", "November", "Dezember",
  )
  [#date.day(). #months.at(date.month() - 1) #date.year()]
}

// Zustand, ob gerade ein Verzeichnis (Inhalts-, Abbildungsverzeichnis …)
// gesetzt wird. Wird von `flex-caption` verwendet.
#let _in-outline = state("thb-in-outline", false)

// Bildunterschrift mit Kurzform für die Verzeichnisse.
// Beispiel:
//   #figure(image("bild.png"), caption: flex-caption(
//     [Kurzer Titel],
//     [Kurzer Titel, gefolgt von einer langen Erklärung mit Quellenangabe],
//   ))
#let flex-caption(short, long) = context if _in-outline.get() { short } else { long }

// Leitet den Anhang ein. Verwendung in der main.typ:
//   #show: appendix
//   = Fragebogen        -> erscheint als "A Fragebogen"
//   == Auswertung       -> erscheint als "A.1 Auswertung"
// Verweise (@label) auf Anhangskapitel lauten dann "Anhang A".
#let appendix(body) = {
  counter(heading).update(0)
  set heading(numbering: "A.1", supplement: [Anhang])
  body
}

// -----------------------------------------------------------------------------
// Hauptfunktion
// -----------------------------------------------------------------------------

#let thesis(
  // --- Deckblatt ---
  title: [Titel der Arbeit],
  // "Bachelorarbeit" oder "Masterarbeit" (oder anderer Text)
  thesis-type: "Bachelorarbeit",
  // angestrebter Grad, z. B. "Bachelor of Science"; `none` blendet die Zeile aus
  degree: none,
  department: "Informatik und Medien",
  // Eigener Untertitel. Bei `auto` wird er aus thesis-type, degree und
  // department zusammengesetzt.
  subtitle: auto,
  author: "Vorname Nachname",
  matriculation-number: none,
  // Erstgutachter:in bzw. Erstbetreuer:in (in der Regel Professor:in)
  first-reviewer: none,
  // Zweitgutachter:in bzw. Zweitbetreuer:in; `none` blendet die Zeile aus
  second-reviewer: none,
  // Bezeichnungen auf dem Deckblatt, falls dein Fachbereich andere nutzt
  first-reviewer-label: "Erstgutachter:in",
  second-reviewer-label: "Zweitgutachter:in",
  place: "Brandenburg an der Havel",
  // `auto` = heutiges Datum, sonst z. B. datetime(year: 2026, month: 9, day: 30)
  date: auto,

  // --- Erklärungen ---
  // Sperrvermerk für Arbeiten mit vertraulichen Firmendaten.
  // `false`, `true` (Standardtext) oder eigener Text als Inhalt.
  confidential: false,
  // Firma/Organisation für den Standardtext des Sperrvermerks
  company: none,
  // Angaben zur Nutzung von KI-Werkzeugen (unter der
  // Selbstständigkeitserklärung). `none` = keine Angaben.
  ai-statement: none,
  // Bild der Unterschrift, z. B. image("unterschrift.png", height: 1.5cm)
  signature: none,

  // --- Verzeichnisse ---
  abstract-de: none,
  abstract-en: none,
  // Abkürzungen als Dictionary, z. B. ("API": [Application Programming Interface])
  // Sie werden alphabetisch sortiert. `none` = kein Abkürzungsverzeichnis.
  abbreviations: none,
  // Abbildungs-, Tabellen- und Quellcodeverzeichnis erscheinen erst ab
  // dieser Anzahl an Einträgen. 0 = immer anzeigen (sofern Einträge vorhanden).
  outline-min-entries: 4,

  // --- Sonstiges ---
  font-size: 12pt,
  doc,
) = {
  // Metadaten der PDF-Datei
  set document(
    title: title,
    author: if type(author) == str { author } else { () },
  )

  // ---------------------------------------------------------------------------
  // ALLGEMEINE EINSTELLUNGEN
  // ---------------------------------------------------------------------------
  set page(paper: "a4", numbering: "1", number-align: right)
  set text(lang: "de", size: font-size)
  set par(justify: true, leading: 0.8em)

  // Überschriften
  show heading.where(level: 1): set text(size: 18pt)
  show heading.where(level: 2): set text(size: 16pt)
  show heading.where(level: 3): set text(size: 14pt)
  show heading.where(level: 4): set heading(numbering: none, outlined: false)
  show heading: set block(above: 2.5em, below: 1.5em)

  // jedes Kapitel beginnt auf einer neuen Seite
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    it
  }

  // Abbildungen, Tabellen, Quellcode
  set figure(gap: 1.5em)
  show figure: it => {
    v(2.5em, weak: true)
    it
    v(2.5em, weak: true)
  }
  // Tabellenbeschriftung wie üblich über der Tabelle
  show figure.where(kind: table): set figure.caption(position: top)
  // Code in einer Abbildung heißt "Quellcode" (statt "Auflistung")
  show figure.where(kind: raw): set figure(supplement: [Quellcode])

  // Verzeichnisse
  show outline: set heading(outlined: true)
  show outline: it => {
    _in-outline.update(true)
    it
    _in-outline.update(false)
  }
  set outline(indent: auto)
  set outline.entry(fill: pad(repeat([.], gap: 0.3em), left: 0.15em, right: 0.6em))
  // Kapitel im Inhaltsverzeichnis fett und ohne Punkte
  show outline.where(target: selector(heading)): it => {
    show outline.entry.where(level: 1): set outline.entry(fill: none)
    show outline.entry.where(level: 1): set block(above: 1.5em)
    show outline.entry.where(level: 1): strong
    it
  }

  let date = format-date(date)

  // ---------------------------------------------------------------------------
  // DECKBLATT
  // ---------------------------------------------------------------------------
  {
    set page(numbering: none)

    image("THB_Logo.svg", width: 7cm)
    v(4em)

    align(center)[
      #text(size: 16pt, strong(title))

      #v(3em)
      #if subtitle == auto [
        *#thesis-type*

        #if degree != none [zur Erlangung des Grades #degree \ ]
        des Fachbereichs #department der \
        Technischen Hochschule Brandenburg
      ] else if subtitle != none {
        subtitle
      }

      #v(5em)
      vorgelegt von: \
      #author

      #if matriculation-number != none [
        #v(1em)
        Matrikelnummer: #matriculation-number
      ]

      #v(5em)
      #if first-reviewer != none [#first-reviewer-label: #first-reviewer \ ]
      #if second-reviewer != none [#second-reviewer-label: #second-reviewer]

      #v(5em)
      #place, #date
    ]
  }

  // ---------------------------------------------------------------------------
  // SPERRVERMERK (optional)
  // ---------------------------------------------------------------------------
  if confidential != false {
    set page(numbering: none)
    heading(outlined: false)[Sperrvermerk]
    if confidential == true [
      Die vorliegende Arbeit enthält vertrauliche Daten und Informationen
      #if company != none [der Firma #company]. Sie darf nur den
      Gutachter:innen sowie befugten Mitgliedern des Prüfungsausschusses
      zugänglich gemacht werden. Veröffentlichungen, Vervielfältigungen und
      Einsichtnahme durch Dritte – auch in Auszügen – sind ohne ausdrückliche
      Genehmigung #if company != none [der Firma #company] else [des Verfassers
      bzw. der Verfasserin] nicht gestattet.
    ] else {
      confidential
    }
  }

  // ---------------------------------------------------------------------------
  // SELBSTSTÄNDIGKEITSERKLÄRUNG
  // ---------------------------------------------------------------------------
  {
    set page(numbering: none)
    heading(outlined: false)[Selbstständigkeitserklärung]

    [
      Hiermit versichere ich, dass ich die vorliegende Arbeit selbstständig
      verfasst und keine anderen als die angegebenen Quellen oder Hilfsmittel
      benutzt habe und dass die Arbeit in gleicher oder ähnlicher Form noch
      keiner anderen Prüfungsbehörde vorgelegt wurde.
    ]

    if ai-statement != none {
      v(1.5em)
      emph[Angaben zur Verwendung KI-basierter Hilfsmittel]
      v(0.5em)
      ai-statement
    }

    v(3em)
    let signature-line = line(length: 100%, stroke: 0.5pt)
    set par(justify: false)
    grid(
      columns: (3fr, 2fr),
      column-gutter: 2em,
      row-gutter: 0.6em,
      align: bottom,
      [#place, #date], if signature != none { signature },
      signature-line, signature-line,
      text(size: 0.8em)[Ort, Datum], text(size: 0.8em)[#author],
    )
  }

  // ---------------------------------------------------------------------------
  // KURZFASSUNG, VERZEICHNISSE (römische Seitenzahlen)
  // ---------------------------------------------------------------------------
  set page(numbering: "I")
  counter(page).update(1)

  if abstract-de != none {
    heading[Kurzfassung]
    abstract-de
  }
  if abstract-en != none {
    heading[Abstract]
    abstract-en
  }

  {
    // das Inhaltsverzeichnis selbst nicht im Inhaltsverzeichnis aufführen
    show outline: set heading(outlined: false)
    outline()
  }

  // Abbildungs-, Tabellen- und Quellcodeverzeichnis ab `outline-min-entries`
  let code-figures = figure.where(kind: raw).or(figure.where(kind: "code"))
  for (title, target) in (
    ([Abbildungsverzeichnis], figure.where(kind: image)),
    ([Tabellenverzeichnis], figure.where(kind: table)),
    ([Quellcodeverzeichnis], code-figures),
  ) {
    context {
      let count = query(target).filter(f => f.caption != none).len()
      if count > 0 and count >= outline-min-entries {
        outline(title: title, target: target)
      }
    }
  }

  if abbreviations != none and abbreviations.len() > 0 {
    heading[Abkürzungsverzeichnis]
    let entries = abbreviations.pairs().sorted(key: p => lower(p.at(0)))
    grid(
      columns: (auto, 1fr),
      column-gutter: 2em,
      row-gutter: 1em,
      ..entries.map(((short, long)) => (strong(short), long)).flatten(),
    )
  }

  // ---------------------------------------------------------------------------
  // INHALT (arabische Seitenzahlen)
  // ---------------------------------------------------------------------------
  set page(numbering: "1")
  set heading(numbering: "1.")
  counter(page).update(1)

  doc
}
