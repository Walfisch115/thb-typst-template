#let conf(
  title: none,
  author: none,
  date: none,
  supervision: none,
  doc
) = {

  // GENERAL SETTINGS
  set text(lang: "de")
  set text(font: "Linux Biolinum")
  set par(justify: true)
  
  // THB Assets
  let thbBlue = rgb(0, 164, 193, 100%)
  let thbLogo = image("THB_Logo.png", height: 9cm)

  // Footer
  let footer = {
    text(size: 12pt)[#supervision]
  }

  // Page Settings
  set page(
    paper: "a2",
    margin: (
      left: 5cm, 
      right: 3cm, 
      top: 10cm, 
      bottom: 5cm
    ),
    footer: footer,
    footer-descent: 2.5cm,
    background: place(dx: 2cm, dy: 7cm)[
      #rect(fill: thbBlue, height: 9cm, width: 100%)
    ],
    foreground: align(left + top)[#thbLogo]
  )

  // increase padding after figure
  show figure: it => {
    v(2em, weak: true)
    it
    v(2em, weak: true)
  }
  
  // align caption of figure left
  show figure.caption: it => {
    align(left)[#it]
  }

  // HEADING
  {
    set text(fill: white, weight: "bold")
    
    text(size: 32pt)[#title]
    
    par()[
      #text(size: 18pt)[
        #author
        #linebreak()
        Bachelorarbeit • Studiengang Informatik • Fachbereich Informatik und Medien • #date
    ]]
  }

  // padding between heading and content
  v(5em)

  // CONTENT BODY
  {
    set text(size: 16pt)

    // change text size for headings
    show heading.where(level: 1): set text(size: 18pt)

    // increase spacing between headings
    show heading: it => {
      v(1.5em, weak: true)
      it
      v(0.6em, weak: true)
    }

    // separate page into two columns
    columns(2, gutter: 2cm)[#doc]
  }
}