#let conf(
  doc
) = {

  set page(paper: "presentation-16-9")
  set text(lang: "de")
  set text(font: "Linux Biolinum")
  
  doc
}

// SLIDES
#let thbBlue = rgb(0, 186, 229, 100%)
#let thbRed = rgb(204, 17, 50, 100%)

// normal slide
#let slide(
  title: [Titel hinzufügen],
  presentationTitle: none,
  date: none,
  body: [Text hinzufügen]
) = {

  // slide header
  let slideHeader = {

    // add THB logo in an inline container
    box()[
      #image("THB_Logo.svg", width: 1cm)
    ]

    // add horizontal padding
    h(1cm)
    
    text(size: 21pt, fill: thbRed, weight: "bold")[
      #title
    ]
  }
  
  let slideBody = {

    // add some vertical padding
    v(0.5cm)
    
    pad(left: 2cm)[
      #text(size: 18pt)[#body]
    ]
  }

  let slideFooter = {

    // change text size, weight and color
    set text(size: 8pt, fill: white, weight: "bold")
    
    box(
      fill: thbBlue, 
      height: 100%, 
      width: 100%, 
      outset: (x: 100%), 
    )[
      // center vertically
      #align(horizon)[
        
        #grid(
          columns: (1fr, 1fr),
          gutter: 0.75em,
          align: (left, right),
          [#presentationTitle],
          [#date],
          [Technische Hochschule Brandenburg • University of Applied Sciences],
          [#counter(page).display()]
        )
    ]]
  }
  
  page(
    margin: (top: 3cm, left: 1cm),
    header: slideHeader,
    footer: slideFooter
  )[
    #slideBody
  ]
}

// title slide
#let titleSlide(
  title: [Titel],
  supervisor: none,
  date: none
) = {

  let thbLogo = {
    place(left + top)[
      #image("THB_Logo_mit_Schrift.png", height: 5cm)
    ]
  }

  let slideBody = {

    set text(fill: white)

    box(
      fill: thbBlue,
      height: 100%,
      width: 100%,
      inset: (x: 2cm, y: 2cm)
    )[
      #align(top)[
        #text(size: 24pt, weight: "bold")[#title]
      ]
      #align(bottom)[
        #text(size: 14pt)[
          #supervisor \
          #date
      ]]
    ]
  }

  page(
    margin: (left: 1cm, top: 4cm, right: 0cm, bottom: 1cm),
    foreground: thbLogo
  )[
    #slideBody
  ]
}