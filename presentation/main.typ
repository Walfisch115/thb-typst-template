#import "conf.typ": *

// =============================================================================
// KURZANLEITUNG
//
// - Titel, Name und Datum werden einmal unten festgelegt und erscheinen
//   automatisch auf der Titelfolie und in der Fußzeile jeder Folie.
// - Neue Folie:   #slide(title: [Folientitel])[ Inhalt ]
// - Titelfolie:   #title-slide()  (einzelne Werte überschreibbar)
// - Zwei Spalten: #two-columns[links][rechts]
// =============================================================================

#show: presentation.with(
  title: [Aufregender Präsentationstitel],
  author: [Max Mustermann],
  subtitle: [Betreuung: Prof. Dr. Erika Musterfrau],
  date: datetime(year: 2026, month: 4, day: 21), // oder auto für heute
  // show-total-pages: true,                     // Seitenzahl als "3 / 12"
)

#title-slide()

#slide(title: [Ich bin ein Folientitel])[
  #lorem(30)

  - Punkt
  - Punkt
  - Punkt
]

#slide(title: [Zwei Spalten])[
  #two-columns[
    - Text links
    - noch ein Punkt
    - und noch einer
  ][
    #rect(width: 100%, height: 5cm, fill: luma(230))[
      #align(center + horizon)[Platz für ein Bild, z. B. \ `image("bild.png")`]
    ]
  ]
]

#title-slide(title: [Vielen Dank für Ihre Aufmerksamkeit!])
