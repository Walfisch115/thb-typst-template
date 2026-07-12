#let myDate() = {
  
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