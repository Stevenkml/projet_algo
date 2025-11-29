library(ggplot2)

# Charger les données du CSV généré par ton programme C
data <- read.csv("resultats.csv")

# Graphique comparatif global
ggplot(data, aes(x = taille, y = temps, color = tri)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 2) +
  ggtitle("Comparaison des temps d'exécution des tris") +
  xlab("Taille du tableau") +
  ylab("Temps (secondes)") +
  theme_minimal(base_size = 14) +
  theme(legend.title = element_blank())

# (Optionnel) Enregistrer automatiquement le graphique
ggsave("comparaison_globale.png", width = 7, height = 5)
