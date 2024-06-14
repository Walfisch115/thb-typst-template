#import "conf.typ": *

#show: conf

// set global values
#let presentationTitle = [Aufregender Präsentationstitel]
#let supervisor = [Dr. rer. pol. Max Mustermann]
#let date = [21.04.2014]

#titleSlide(
  title: presentationTitle,
  supervisor: supervisor,
  date: date
)

#slide(
  presentationTitle: presentationTitle,
  date: date,
  title: [Ich bin ein Folientitel],
  body: [
    #lorem(30)
    
    - Punkt
    - Punkt
    - Punkt
  ]
)

#slide()

#titleSlide(
  title: [Vielen Dank für Ihre Aufmerksamkeit!],
  supervisor: supervisor,
  date: date
)