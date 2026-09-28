// =============================================================================
// THB-Vorlage für Abschlussposter (DIN A2, zweispaltig)
// Fachbereich Informatik und Medien – Technische Hochschule Brandenburg
//
// Diese Datei enthält nur das Layout. Deine Inhalte gehören in die main.typ.
// =============================================================================

// THB-Farben
#let thb-blue = rgb(0, 164, 193)
#let thb-red = rgb(204, 17, 50)

// Formatiert ein Datum auf Deutsch, z. B. "28. September 2026".
// `auto` = heutiges Datum, Inhalt wird unverändert ausgegeben.
#let format-date(date) = {
  if date == auto { date = datetime.today() }
  if type(date) != datetime { return date }

  let months = (
    "Januar", "Februar", "März", "April", "Mai", "Juni",
    "Juli", "August", "September", "Oktober", "November", "Dezember",
  )
  [#date.day(). #months.at(date.month() - 1) #date.year()]
}

#let poster(
  // max. zweizeilig
  title: [Titel der Arbeit],
  author: "Vorname Nachname",
  thesis-type: "Bachelorarbeit",
  study-program: "Informatik",
  department: "Informatik und Medien",
  // `auto` = heutiges Datum, sonst Text oder datetime(...)
  date: auto,
  // Eigene Zeile unter dem Namen. Bei `auto` wird sie aus thesis-type,
  // study-program, department und date zusammengesetzt.
  subtitle: auto,
  // Betreuung, erscheint in der Fußzeile
  supervision: none,
  font-size: 16pt,
  doc,
) = {
  set document(title: title, author: if type(author) == str { author } else { () })
  set text(lang: "de")
  set par(justify: true)

  let subtitle = if subtitle == auto {
    (
      thesis-type,
      [Studiengang #study-program],
      [Fachbereich #department],
      format-date(date),
    ).filter(x => x != none).join[ • ]
  } else { subtitle }

  set page(
    paper: "a2",
    margin: (left: 5.7cm, right: 2.4cm, top: 16.7cm, bottom: 2.6cm),
    footer: text(size: 12pt, supervision),
    footer-descent: 0cm,
    background: {
      // blauer Balken
      place(dx: 2.1cm, dy: 6.8cm, rect(fill: thb-blue, height: 8.5cm, width: 39.9cm))
      // Titel im blauen Balken
      place(dx: 5.7cm, dy: 10.0cm, block(width: 33.9cm)[
        #set text(fill: white)
        #text(size: 32pt, weight: "bold", title)
        #v(-1.0em)
        #text(size: 18pt)[
          #author \
          #subtitle
        ]
      ])
    },
    foreground: place(left + top, image("THB_Logo.png", height: 9cm)),
  )

  // Abbildungen
  show figure: it => {
    v(2em, weak: true)
    it
    v(2em, weak: true)
  }
  show figure.caption: align.with(left)

  // Überschriften
  set text(size: font-size)
  show heading.where(level: 1): set text(size: 18pt)
  show heading: it => {
    v(1.5em, weak: true)
    it
    v(0.6em, weak: true)
  }

  // zweispaltiges Layout; mit #colbreak() wechselst du in die rechte Spalte
  columns(2, gutter: 2cm, doc)
}
