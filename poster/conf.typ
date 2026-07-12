#let conf(
  title: none,
  subtitle: none,
  author: none,
  supervision: none,
  doc
) = {

  // GENERAL SETTINGS
  set text(lang: "de")
  // set text(font: "Linux Biolinum")
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
      left: 5.7cm, 
      right: 2.4cm, 
      top: 16.7cm, 
      bottom: 2.6cm
    ),
    footer: footer,
    footer-descent: 0cm,
    background: {
      // Blauer Balken
      place(dx: 2.1cm, dy: 6.8cm)[
        #rect(fill: thbBlue, height: 8.5cm, width: 39.9cm)
      ]
      // Titel im blauen Balken
      place(dx: 5.7cm, dy: 10.0cm)[
        #block(width: 33.9cm)[
          #set text(fill: white)
          #text(size: 32pt, weight: "bold")[#title]
          #v(-1.0em)
          #text(size: 18pt)[
            #author
            #linebreak()
            #subtitle
          ]
        ]
      ]
    },
    foreground: place(left + top)[#thbLogo],
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
