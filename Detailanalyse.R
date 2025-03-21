# Kapitel 1: Pakete laden ----
# ------------------------
# Wir benutzen tidyverse fuer Datenmanipulation und ggplot2,
# leaflet fuer interaktive Karten, und shiny/flexdashboard
# fuer das Dashboard.

library(tidyverse)
library(leaflet)
library(shiny)           # Nur notwendig, falls du ein Shiny-Dashboard machst
# library(flexdashboard) # Oder alternativ flexdashboard

# Kapitel 2: CSV einlesen ----
# ------------------------
# Achtung: Passe Pfad und Dateinamen an.
# sep="," und quote="\"" fuer Komma-getrennte Felder in Anfuehrungszeichen.

my_data <- read.csv(
  "c:/Users/matth/OneDrive/AB1_R Projekte aktuell/Windparks_Germany/Stammdatensatz.csv",
  header = TRUE,
  sep = ",",
  quote = "\"",
  stringsAsFactors = FALSE
)


## Kapitel 2.1 Gesamte Leistung pro Betreiber summieren ----
# Wir nehmen an, die Spalte mit der Gesamtleistung (MW) heisst
# 'Gesamtleistung..MW.' und der Betreiber ist in 'Betreiber'.
# Anschliessend erzeugen wir eine Summen-Tabelle.

leistung_betreiber <- my_data %>%
  group_by(Betreiber) %>%
  summarise(
    Gesamtleistung_MW = sum(Gesamtleistung..MW., na.rm = TRUE),
    Anzahl_Windparks = n()
  )

# Ausgabe
leistung_betreiber


## 2.2 Balkendiagramm: Gesamte Leistung pro Betreiber ----
# Einfaches Balkendiagramm mit ggplot2

library(ggplot2)

ggplot(leistung_betreiber, aes(x = reorder(Betreiber, -Gesamtleistung_MW),
                               y = Gesamtleistung_MW)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(
    title = "Gesamtleistung pro Betreiber (MW)",
    x = "Betreiber",
    y = "Gesamtleistung (MW)"
  ) +
  theme_minimal()


#Kapitel 3: Geokoordinaten verarbeiten und Karte erstellen ----
# Kapitel 3.1: Lat und Lon aus Geokoordinaten extrahieren ----
# -------------------------------------------------------
# Wir nutzen einen einfachen Regex-Ansatz: 
#   - lat steht vor "° N,"
#   - lon steht nach ", " und vor "° E"

library(stringr)

my_data <- my_data %>%
  mutate(
    lat = as.numeric(str_extract(Geokoordinaten, "[0-9\\.]+(?=°\\sN)")),
    lon = as.numeric(str_extract(Geokoordinaten, "(?<=,\\s)[0-9\\.]+(?=°\\sE)"))
  )

# Kontrolle: 
head(my_data[c("Windpark.ID", "Geokoordinaten", "lat", "lon")], 5)


## 3.2 Interaktive Karte mit leaflet ----
# Wir verwenden die soeben erzeugten lat/lon-Spalten,
# um Marker fuer jeden Windpark auf der Karte zu setzen.

leaflet(data = my_data) %>%
  addTiles() %>%
  addMarkers(
    ~lon, 
    ~lat,
    popup = ~paste0("<b>", Name.des.Windparks, "</b><br>",
                    "Betreiber: ", Betreiber, "<br>",
                    "Gesamtleistung (MW): ", Gesamtleistung..MW.)
  )



