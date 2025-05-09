#let conf(
  title: none,
  subtitle: none,
  author: none,
  matrikelNumber: none,
  supervisor: none,
  secondReviewer: none,
  place: none,
  date: none,
  abstractGerman: none,
  abstractEnglish: none,
  bibliographyFile: none,
  citationStyle: "ieee",
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
  
  show heading: set block(above: 2.5em, below: 1.5em)
  
  set par(leading: 0.8em)
  
  set figure(
    gap: 1.5em,
  )
  
  // insert pagebreak before level 1 heading
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    it
  }
  
  // increase padding after figure
  show figure: it => {
    v(2.5em, weak: true)
    it
    v(2.5em, weak: true)
  }
  
  // style outline
  set outline(indent: auto)
  
  set outline.entry(
    fill: pad(
      repeat([.], gap: 0.3em),
      left: 0.15em,
      right: 0.6em
    )
  )

  // style level 1 headings in regular outline
  show outline.where(target: selector(heading)): it => {
    show outline.entry.where(level: 1): set outline.entry(fill: none)
    show outline.entry.where(level: 1): it => {
      strong(it)
    }
    it
  }

  let myDate() = {
    
    let monthsDe = (
      "Januar",
      "Februar",
      "März",
      "April",
      "Mai",
      "Juni",
      "Juli",
      "August",
      "September",
      "Oktober",
      "November",
      "Dezember",
    )

    let date = datetime.today()
    let month = date.month()

    date.display("[day]. " + monthsDe.at(month - 1) + " [year]")
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

      #if subtitle != none [     
        #v(3em)
        #subtitle
      ]

      #v(5em)
      vorgelegt von: \
      #author

      #v(1em)
      Matrikelnummer: 
      #matrikelNumber

      #v(8em)
      
      betreut durch: #secondReviewer \
      vorgelegt bei: #supervisor
  
      #v(5em)
      
      #place, #myDate()

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
      row-gutter: 0.8em,
      // maybe replace the signature with an image
      // [Ort, Datum], [Unterschrift],
      [#place, #myDate()],[#author]
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
    if abstractGerman != none {
      heading("Kurzfassung")
      abstractGerman
    }

    if abstractEnglish != none {
      heading("Abstract")
      abstractEnglish
    }

    // TABLE OF CONTENTS
    // increase padding above level 1 headings
    show outline.entry.where(level: 1): set block(above: 1.5em)
    outline()
  }
 
  // TABLE OF FIGURES
  // TABLE OF TABLES
  {
    set page(numbering: "I")
    let minEntries = 3 // show if 4 or more entries

    // show if more than x entries
    context if query(figure.where(kind: image)).filter(f => f.caption != none).len() > minEntries {
      outline(
        title: [Abbildungsverzeichnis],
        target: figure.where(kind: image)
      )
    }
      
    // show if more than x entries
    context if query(figure.where(kind: table)).filter(f => f.caption != none).len() > minEntries {
      outline(
        title: [Tabellenverzeichnis],
        target: figure.where(kind: table),
      )
    }

    // show if more than x entries
    context if query(figure.where(kind: "code")).filter(f => f.caption != none).len() > minEntries {
      outline(
        title: [Quellcodeverzeichnis],
        target: figure.where(kind: "code")
      )
    }
  }

  // DOCUMENT CONTENT
  {
    set heading(numbering: "1.")
    
    // update page number
    counter(page).update(1)
    
    doc 
  }

  // BIBLIOGRAPHY
  if bibliographyFile != none {
    bibliography(
      bibliographyFile,
      title: "Literaturverzeichnis",
      style: citationStyle
    )
  }
}