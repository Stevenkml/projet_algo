library(ggplot2)

# Charger les données
data <- read.csv("resultats.csv")

# Graphique pour chaque tri
tris <- unique(data$tri)

for (t in tris) {
  g <- ggplot(subset(data, tri == t), aes(x = taille, y = temps)) +
    geom_line(color = "steelblue", linewidth = 1.3) +
    geom_point(color = "darkred", size = 3) +
    ggtitle(paste("Performance du tri :", t)) +
    xlab("Taille du tableau") +
    ylab("Temps d'exécution (secondes)") +
    theme_minimal(base_size = 14)
  ggsave(paste0("graphique_", t, ".png"), g, width = 6, height = 4)
}
