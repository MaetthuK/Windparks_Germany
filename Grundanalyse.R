my_data <- read.csv(
  "c:/Users/matth/OneDrive/AB1_R Projekte aktuell/Windparks_Germany/Stammdatensatz.csv",
  header = TRUE, 
  sep = ",", 
  stringsAsFactors = FALSE
)

nrow(my_data)
ncol(my_data)
colnames(my_data)
str(my_data)
summary(my_data)
class(my_data)
colnames(my_data)





# Anzahl Anlagen + Summe Leistung pro Budesland aggregiert
aggregate(cbind(Anzahl.WEA, Gesamtleistung..MW.) ~ Bundesland,
          data = my_data,
          FUN = sum)



#colnames 1-35 nur in einer Spalte
colnames(my_data)[1:35]
my_data[, c(1, 5, 35)]

# distinct values in column "Bundesland"
unique(my_data[[1]])
# Spalte "Windpark.ID" sortiert aufsteigen wiedergeben
sort(my_data$Windpark.ID)

spalte_nr <- c(19)
unique(my_data[[spalte_nr]])
my_data[, c(spalte_nr)]



my_data[, c(1, 5, 35)]





unique(my_data[["Betreiber"]])
unique(my_data[[4]])

# Gesamtleistung in MW Total
sum(my_data$Gesamtleistung..MW., na.rm = TRUE)







View(my_data[order(my_data$Name.des.Windparks),])

my_data[order(my_data$Windpark.ID),]



# Nur bestimmte Spalten anzeigen


my_data[, c(1, 5, 35)]