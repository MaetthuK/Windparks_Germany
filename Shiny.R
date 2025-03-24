# app.R ------------------------------------------------------------------
library(shiny)
library(tidyverse)
library(leaflet)
library(stringr)
library(ggplot2)

# -----------------------------
# 1) Daten laden
# -----------------------------
my_data <- read.csv(
  "c:/Users/matth/OneDrive/AB1_R Projekte aktuell/Windparks_Germany/Stammdatensatz.csv",
  header = TRUE,
  sep = ",",
  quote = "\"",
  stringsAsFactors = FALSE
)

# 2) Lat/Lon extrahieren
my_data <- my_data %>%
  mutate(
    lat = as.numeric(str_extract(Geokoordinaten, "[0-9\\.]+(?=°\\sN)")),
    lon = as.numeric(str_extract(Geokoordinaten, "(?<=,\\s)[0-9\\.]+(?=°\\sE)"))
  )

# 3) Funktion fuer Leaflet-Kreisradius
#    Vectorisierte Variante mit ifelse()
calcRadius <- function(mw) {
  ifelse(is.na(mw) | mw <= 0, 2, sqrt(mw) * 2)
}

# -----------------------------
# UI
# -----------------------------
ui <- fluidPage(
  titlePanel("Windpark Dashboard - Gesamtes Shiny"),
  
  sidebarLayout(
    sidebarPanel(
      # Mehrfachauswahl fuer Windpark-IDs
      selectInput("selectedIDs", "Windpark-ID auswaehlen (mehrfach moeglich):",
                  choices = unique(my_data$Windpark.ID),
                  multiple = TRUE,
                  selected = unique(my_data$Windpark.ID)[1:30]),
      
      # Checkboxen fuer Features im Popup
      checkboxGroupInput("selectedFeatures", "Features im Popup anzeigen:",
                         choices = c("Betreiber" = "Betreiber",
                                     "Bundesland" = "Bundesland",
                                     "Baujahr" = "Baujahr",
                                     "Gesamtleistung (MW)" = "Gesamtleistung..MW.",
                                     "Verfuegbarkeitsquote (%)" = "Verfuefbarkeitsquote....",
                                     "Jahresertrag (MWh)" = "Produzierte.Jahresenergiemenge..MWh."
                         ),
                         selected = c("Betreiber", "Gesamtleistung..MW.")),
      
      # Checkboxen fuer Aggregation
      checkboxGroupInput("aggChoices", "Aggregation anzeigen:",
                         choices = c("Summe Gesamtleistung" = "sum_leistung",
                                     "Anzahl Windparks" = "count_parks",
                                     "Min/Max Baujahr" = "minmax_baujahr"))
    ),
    
    mainPanel(
      tabsetPanel(
        # TAB 1: Betreiber-Übersicht
        tabPanel("Betreiber-Übersicht",
                 plotOutput("plotBetreiber")
        ),
        
        # TAB 2: Windpark-Details
        tabPanel("Windpark-Details",
                 tableOutput("aggregatedTable"),
                 leafletOutput("mapPlot", height = 600)
        )
      )
    )
  )
)

# -----------------------------
# SERVER
# -----------------------------
server <- function(input, output, session) {
  
  # -----------------------------
  # 1) Betreiber-Übersicht
  # -----------------------------
  # Aggregation fuer alle Daten: Gesamtleistung pro Betreiber
  betreiber_data <- reactive({
    my_data %>%
      group_by(Betreiber) %>%
      summarise(
        Gesamtleistung_MW = sum(Gesamtleistung..MW., na.rm = TRUE),
        Anzahl_Windparks = n()
      )
  })
  
  # Balkendiagramm fuer Gesamtleistung pro Betreiber
  output$plotBetreiber <- renderPlot({
    ggplot(betreiber_data(), aes(x = reorder(Betreiber, -Gesamtleistung_MW),
                                 y = Gesamtleistung_MW)) +
      geom_col(fill = "steelblue") +
      coord_flip() +
      labs(
        title = "Gesamtleistung pro Betreiber (MW)",
        x = "Betreiber",
        y = "Gesamtleistung (MW)"
      ) +
      theme_minimal()
  })
  
  # -----------------------------
  # 2) Windpark-Details
  # -----------------------------
  # a) Gefilterte Daten (nur ausgewaehlte IDs)
  filteredData <- reactive({
    req(input$selectedIDs)
    my_data %>%
      filter(Windpark.ID %in% input$selectedIDs)
  })
  
  # b) Aggregationstabelle
  output$aggregatedTable <- renderTable({
    df <- filteredData()
    if(nrow(df) == 0) return(NULL)
    
    ergebnis <- list()
    
    # Summe Gesamtleistung
    if("sum_leistung" %in% input$aggChoices){
      ergebnis$SummeGesamtleistung <- sum(df$Gesamtleistung..MW., na.rm = TRUE)
    }
    
    # Anzahl Windparks
    if("count_parks" %in% input$aggChoices){
      ergebnis$AnzahlWindparks <- nrow(df)
    }
    
    # Min/Max Baujahr
    if("minmax_baujahr" %in% input$aggChoices){
      ergebnis$MinBaujahr <- min(df$Baujahr, na.rm = TRUE)
      ergebnis$MaxBaujahr <- max(df$Baujahr, na.rm = TRUE)
    }
    
    if(length(ergebnis) == 0) return(NULL)
    as.data.frame(ergebnis)
  })
  
  # c) Leaflet-Karte
  output$mapPlot <- renderLeaflet({
    df <- filteredData()
    if(nrow(df) == 0){
      return(leaflet() %>% addTiles())
    }
    
    # Dynamisches Popup
    popupContent <- apply(df, 1, function(row){
      txt <- ""
      for(colname in input$selectedFeatures){
        val <- row[[colname]]
        if(!is.null(val)){
          txt <- paste0(txt, "<b>", colname, ":</b> ", val, "<br>")
        }
      }
      # Name des Windparks (oben)
      title <- paste0("<b>", row[["Name.des.Windparks"]], "</b><br>")
      paste0(title, txt)
    })
    
    leaflet(df) %>%
      addTiles() %>%
      addCircleMarkers(
        lng = ~lon,
        lat = ~lat,
        radius = ~calcRadius(Gesamtleistung..MW.),
        fillColor = "red",
        fillOpacity = 0.5,
        stroke = FALSE,
        popup = popupContent
      )
  })
}

# App starten
shinyApp(ui, server)

