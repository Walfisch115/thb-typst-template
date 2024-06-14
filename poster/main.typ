#import "conf.typ": conf

#show: conf.with(
  title: [
    Max. Schriftgröße 32, max. 2-zeilig, ZA Schriftgröße +4 Kameragestützte Feinpositionierung eines Quadrokopters
  ],
  author: "Max Mustermann",
  date: "HEUTE",
  supervision: [
    Betreuung Prof. Dr. sc. techn. John Doe • Technische Hochschule Brandenburg • Dr. Michael Mustermann • Stadtwerke Brandenburg an der Havel
  ],
)

= Aufgabenstellung
Ziel der Arbeit ist es einen Quadrokopter vom Typ MikroKopter autonom, mit Hilfe einer On-Board-Kamera und bildverarbei-tenden Verfahren, möglichst genauer einem Objekt zu positionieren. Zuvor soll eine GPS-gestützte Grobpositionierung des MikroKopters in der Nähe des gesuchten Objektes erfolgen.

= Konzept
Die beiden Aufgaben werden teilweise mit On-Board Mitteln und teilweise mit Hilfe einer Bodenstation (am Boden befindliches Notebook) abgearbeitet. 

#figure(
  image("Bild1.png"),
  caption: [Wegpunktliste und resultierendes Suchgebiet]
)

Während des Wegpunktefluges werden die Videodaten der On-Board-Kamera und die Sensordaten des MikroKopters an die Bodenstation übertragen. Mit bildverarbeitenden Verfahren wird das Objekt im Videobild gesucht. Sobald das Objekt detektiert wurde, wird der GPS-Flug gestoppt und die Kontrolle an die Bodenstation übergeben. 

- Bodenstation
- Objektposition im Videobild und der empfangenen Sensordaten, die Abweichung von der Sollposition

Die Bodenstation berechnet fortlaufend, unter Verwendung der detektierten Objektposition im Videobild und der empfangenen Sensordaten, die Abweichung von der Sollposition (Regelabweichung). Aus dieser Abweichung werden Steuerkommandos generiert und an den MikroKopter zurück gesendet, mit dem Ziel die Regelabweichung zu minimieren.

= Bildverarbeitung
Die Bildverarbeitung ist darauf ausgelegt ein einfaches, einfarbiges Objekt zu erkennen. Als erstes wird die durch das Weitwinkelobjektiv hervorgerufene Verzerrung beseitigt und Kompressionsartefakte sowie Bildrauschen durch einen Gaußfilter entfernt. Um das einfarbige Objekt zu finden, wird eine Transformation in einen HSI-Farbraum mit den Anteilen Farbton, Sättigung und Helligkeit vorgenommen. Das Objekt kann durch Wählen passender Intervalle der HSI-Anteile herausgefiltert werden @boersch2007. Anschließend wird eine Blobsuche durchgeführt, mit deren Hilfe zusammenhängende Bildpunkte ermittelt werden. Der Mittelpunkt des größten gefundenen Blobs wird für die Berechnung der Regelabweichung verwendet.

= Regelung
Aus der ermittelten Abweichung von der Sollposition werden Steuerkommandos für den MikroKopter berechnet, die der Abweichung entgegenwirken. Diese Aufgabe übernimmt ein Proportional-Differential-Integral-Regler (PID-Regler).Der P-Regler generiert Steuerkommandos proportional zu der Größe der Regelabweichung. Der D-Regler erzeugt Kommandos, welche einer Änderung der Regelabweichung entgegenwirken.

= Testsystem
Die Auswertung der Positionsregelung erfolgt mit Hilfe einer Bodenkamera, die die Bewegung des MikroKopter entlang einer genau definierten Fluglinie aufzeichnet. Mit einem Bewertungstool wird die Position des MikroKopters im aufgezeichneten Video frameweise markiert und in metrische Werte umgerechnet.

= Ergebnisse
Das linke Diagramm zeigt die Abweichung des MikroKopters von der Sollposition mit und ohne Störgröße. Die Störgröße wurde mit einem Standventilator mit eingeschalteter Schwenkfunktion erzeugt. Es ist zu sehen, dass die Position ohne eine Störgröße auf ±20 cm genau gehalten wird. Wird der Ventilator eingeschaltet vergrößert sich die Abweichung auf ±40 cm. Im rechten Diagramm wurde der MikroKopter mit zwei verschiedenen Geschwindigkeiten in den Bereich des zu suchenden Objektes geflogen. Dem Diagramm ist zu entnehmen, dass der MikroKopter abbremst und nach ca. 10 Sekunden seine Position über dem Objekt stabilisiert hat.

#figure(
  image("Bild2.png"),
  caption: [Diagramm]
)

= Fazit
In dieser Arbeit wurde gezeigt, dass eine autonome kameragestützte Positionierung des MikroKopters möglich ist. Die Genauigkeit der Positionierung, die mit dem entwickelten System erreicht wurde, übersteigt die Möglichkeiten einer reinen GPS-basierten Lösung deutlich.

#bibliography(
  "bibliography.bib",
  title: "Quellen",
)