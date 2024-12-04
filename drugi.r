# Instalacija i učitavanje igraph paketa
install.packages("igraph")
library(igraph)

# Definiranje čvorova (gradova)
gradovi <- c("Zagreb", "Karlovac", "Varaždin", "Rijeka", "Zadar", "Osijek", "Split", "Šibenik", "Sisak", "Slavonski Brod", "Vukovar")

# Definiranje veza (lukova) i njihovih kapaciteta
veze <- data.frame(
  from = c("Zagreb", "Zagreb", "Karlovac", "Karlovac","Varaždin", "Rijeka", "Zadar", "Osijek", "Split",     "Šibenik",      "Slavonski Brod", "Sisak",        "Varaždin"),
  to = c("Karlovac", "Varaždin", "Rijeka", "Zadar",  "Osijek",   "Split", "Šibenik", "Vukovar", "Šibenik", "Slavonski Brod", "Vukovar",     "Slavonski Brod", "Sisak"),
  kapacitet = c(12,     8,          6,       7,         9,         11,     5,           10,        8,        6,                 7,             5,               4)
)

# Stvaranje grafa
mreza <- graph_from_data_frame(d = veze, vertices = gradovi, directed = TRUE)

# Dodavanje kapaciteta kao atributa lukovima
E(mreza)$capacity <- E(mreza)$kapacitet

# Prikaz grafa
plot(mreza, vertex.label = V(mreza)$name, edge.label = E(mreza)$capacity,
     edge.arrow.size = 0.5, vertex.size = 15, vertex.color = "lightblue",
     main = "Mreža gradova i veza s kapacitetima")

# Definiranje kapaciteta za svaki luk (rub) u grafu
E(mreza)$capacity <- E(mreza)$kapacitet

# Izračun maksimalnog protoka od Zagreba do Vukovara
max_flow_value <- max_flow(mreza, source = "Zagreb", target = "Vukovar", capacity = E(mreza)$capacity)

# Prikaz rezultata
print(paste("Maksimalni protok od Zagreba do Vukovara je:", max_flow_value$value))

# Prikaz maksimalnog protoka kroz svaku vezu
print(max_flow_value$flow)
