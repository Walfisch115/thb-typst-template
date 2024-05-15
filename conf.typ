#let conf(
  title: none,
  author: none,
  matrikelNumber: none,
  supervisor: none,
  secondReviewer: none,
  place: none,
  date: datetime.today().display(),
  abstract: [],
  doc
) = {

  // GENERAL SETTINGS
  set page(paper: "a4", numbering: "1", number-align: right)
  set text(lang: "de")
  set text(size: 12pt)
  set par(justify: true)

  // show outlines in table of contents
  show outline: set heading(outlined: true)

  // STYLING
  // increase font size for headings
  show heading.where(level: 1): set text(size: 18pt)
  show heading.where(level: 2): set text(size: 16pt)
  show heading.where(level: 3): set text(size: 14pt)
  
  // insert pagebreak before level 1 heading
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    it
  }

  // increase spacing between headings
  show heading: it => {
    v(2.5em, weak: true)
    it
    v(1.5em, weak: true)
  }

  // increase padding after figure
  show figure: it => {
    v(1.5em, weak: true)
    it
    v(1.5em, weak: true)
  }

  // style outline
  set outline(indent: auto, fill: repeat("  ."))

  // only apply styling if we are in the table of contents
  // (not list of figures or list of tables, etc.)
  show outline.entry: it => {
    if it.element.func() == heading {
      if it.level == 1 {
        v(1.5em, weak: true)
        strong(it)
      } else {
        it
      }
    } else {
      it
    }
  }

  // COVER PAGE
  {
    // remove page number
    set page(numbering: none)  

    image("THB_Logo.svg", width: 7cm)
    v(5em)

    align(center)[
      #text(size: 16pt)[
        *#title*
      ]

      #v(3em)
      *Master-/Bachelorarbeit*

      zur Erlangung des Grades Master/Bachelor of XXX \
      des Fachbereichs Informatik und Medien der \
      Technischen Hochschule Brandenburg

      #v(3em)
      vorgelegt von: \
      #author

      #v(1em)
      Matrikelnummer: \
      #matrikelNumber

      #v(5em)   
      Betreuer: #supervisor \
      Zweitgutachter: #secondReviewer
  
      #v(3em)
      #place, #date
    ]
  }

  // STATEMENT OF AUTHORSHIP
  {
    // remove page number
    set page(numbering: none)   
    
    heading("Selbstständigkeitserklärung", outlined: false)
    [
      Hiermit versichere ich, dass ich die vorliegende Arbeit selbstständig verfasst und keine anderen als die angegebenen Quellen oder Hilfsmittel benutzt habe und dass die Arbeit in gleicher oder ähnlicher Form noch keiner anderen Prüfungsbehörde vorgelegt wurde.
    ]
    v(3em)
    grid(
      columns: (1fr, 1fr),
      // maybe replace the signature with an image
      [#place, #date],[#author]
    )
  }

  // TABLE OF CONTENTS AND ABSTRACT
  {
    set page(numbering: "I")

    // dont show outline in table of contents
    show outline: set heading(outlined: false)

    // update page number
    counter(page).update(1)

    // ABSTRACT
    // show abstract if not empty
    if abstract != [] {
      heading("Abstract")
      abstract
    }

    // TABLE OF CONTENTS
    outline()
  }

  // DOCUMENT CONTENT
  {
    set heading(numbering: "1.")
    
    // update page number
    counter(page).update(1)
    
    doc 
  }

  // TABLE OF FIGURES
  let minEntries = 0
  
  // show if more than x entries
  context if query(figure.where(kind: image)).filter(f => f.caption != none).len() > minEntries {
    outline(
      title: [Abbildungsverzeichnis],
      target: figure.where(kind: image)
    )
  }

  // TABLE OF TABLES
  // show if more than x entries
  context if query(figure.where(kind: table)).filter(f => f.caption != none).len() > minEntries {
    outline(
      title: [Tabellenverzeichnis],
      target: figure.where(kind: table),
    )
  }
  
  // BIBLIOGRAPHY
  // include, if existing
  // bibliography()
}