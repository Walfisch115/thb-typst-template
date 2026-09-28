// =============================================================================
// THB-Vorlage für Präsentationen (16:9)
// Fachbereich Informatik und Medien – Technische Hochschule Brandenburg
//
// Diese Datei enthält nur das Layout. Deine Folien gehören in die main.typ.
// =============================================================================

// THB-Farben
#let thb-blue = rgb(0, 186, 229)
#let thb-red = rgb(204, 17, 50)

// Globale Angaben der Präsentation (werden von `presentation` gesetzt und
// von den Folien automatisch in Titelfolie und Fußzeile verwendet)
#let _info = state("thb-presentation-info", (:))

// Formatiert ein Datum als TT.MM.JJJJ. `auto` = heute, Inhalt bleibt unverändert.
#let _format-date(date) = {
  if date == auto { date = datetime.today() }
  if type(date) == datetime { date.display("[day].[month].[year]") } else { date }
}

// -----------------------------------------------------------------------------
// Grundeinstellungen – Verwendung: #show: presentation.with(title: [...], ...)
// -----------------------------------------------------------------------------
#let presentation(
  title: [Titel der Präsentation],
  // Name(n) der Vortragenden, erscheint auf der Titelfolie
  author: none,
  // z. B. Betreuung, Veranstaltung oder Anlass; erscheint auf der Titelfolie
  subtitle: none,
  // `auto` = heutiges Datum, sonst Text oder datetime(...)
  date: auto,
  // Seitenzahlen als "3 / 12" anzeigen
  show-total-pages: false,
  // Schriftart (wird ignoriert, falls nicht installiert)
  font: "Linux Biolinum",
  body,
) = {
  set document(title: title)
  set page(paper: "presentation-16-9")
  set text(lang: "de", font: font)

  _info.update((
    title: title,
    author: author,
    subtitle: subtitle,
    date: _format-date(date),
    show-total-pages: show-total-pages,
  ))

  body
}

// -----------------------------------------------------------------------------
// Titelfolie
// Ohne Angaben werden Titel, Autor:in, Untertitel und Datum aus
// `presentation` übernommen. Einzelne Werte lassen sich überschreiben:
//   #title-slide(title: [Vielen Dank für Ihre Aufmerksamkeit!])
// -----------------------------------------------------------------------------
#let title-slide(
  title: auto,
  author: auto,
  subtitle: auto,
  date: auto,
) = {
  let logo = place(left + top, image("THB_Logo_mit_Schrift.png", height: 5cm))

  page(
    margin: (left: 1cm, top: 4cm, right: 0cm, bottom: 1cm),
    foreground: logo,
    context {
      let info = _info.get()
      let pick(value, key) = if value == auto { info.at(key, default: none) } else { value }

      set text(fill: white)
      box(fill: thb-blue, height: 100%, width: 100%, inset: 2cm)[
        #align(top, text(size: 24pt, weight: "bold", pick(title, "title")))
        #align(bottom, text(size: 14pt)[
          #for line in (pick(author, "author"), pick(subtitle, "subtitle"), pick(date, "date")) {
            if line != none [#line \ ]
          }
        ])
      ]
    },
  )
}

// -----------------------------------------------------------------------------
// Inhaltsfolie
//   #slide(title: [Folientitel])[
//     Inhalt der Folie
//   ]
// -----------------------------------------------------------------------------
#let slide(
  title: none,
  body,
) = {
  let header = {
    box(image("THB_Logo.svg", width: 1cm))
    h(1cm)
    text(size: 21pt, fill: thb-red, weight: "bold", title)
  }

  let footer = context {
    let info = _info.get()
    set text(size: 8pt, fill: white, weight: "bold")

    let page-number = if info.at("show-total-pages", default: false) [
      #counter(page).display() / #counter(page).final().first()
    ] else {
      counter(page).display()
    }

    box(fill: thb-blue, height: 100%, width: 100%, outset: (x: 100%), align(horizon, grid(
      columns: (1fr, 1fr),
      gutter: 0.75em,
      align: (left, right),
      info.at("title", default: none), info.at("date", default: none),
      [Technische Hochschule Brandenburg • University of Applied Sciences], page-number,
    )))
  }

  page(
    margin: (top: 3cm, left: 1cm),
    header: header,
    footer: footer,
    {
      v(0.5cm)
      pad(left: 2cm, text(size: 18pt, body))
    },
  )
}

// -----------------------------------------------------------------------------
// Zweispaltiger Inhalt, z. B. Text links und Bild rechts
//   #slide(title: [Titel])[
//     #two-columns[Text][#image("bild.png")]
//   ]
// -----------------------------------------------------------------------------
#let two-columns(left, right, gutter: 1cm, columns: (1fr, 1fr)) = grid(
  columns: columns,
  gutter: gutter,
  left, right,
)
