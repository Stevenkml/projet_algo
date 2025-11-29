library(ggplot2)
data <- read.csv("resultats.csv")

# Fonction générant un zoom automatique
generer_zoom <- function(df, cas_type, p) {
  # seuil automatique basé sur les données (1% de la valeur max)
  seuil <- max(df$temps) * 0.05  

  df_zoom <- subset(df, temps <= seuil)

  if (nrow(df_zoom) < 5) {
    return()   # Rien à zoomer, on ne génère pas de fichier inutile
  }

  g_zoom <- ggplot(df_zoom, aes(x = taille, y = temps, color = tri, group = tri)) +
    geom_line(linewidth = 1.2) +
    geom_point(size = 2) +
    ggtitle(paste("ZOOM —", cas_type, "-", p)) +
    xlab("Taille du tableau") +
    ylab(paste("Temps d'exécution (s) — zoom ( < ", round(seuil, 4), "s )")) +
    theme_minimal(base_size = 14) +
    theme(legend.title = element_blank())

  ggsave(paste0("zoom_", cas_type, "_", p, ".png"), g_zoom, width = 7, height = 5)
}

# 1️⃣ Comparaison globale pour chaque combinaison (cas, plage)
for (cas_type in unique(data$cas)) {
  for (p in unique(data$plage)) {

    subset_data <- subset(data, cas == cas_type & plage == p)

    # ---- Graphique principal ----
    g <- ggplot(subset_data, 
                aes(x = taille, y = temps, color = tri, group = tri)) +
      geom_line(linewidth = 1.2) +
      geom_point(size = 2) +
      ggtitle(paste("Comparaison des tris —", cas_type, "-", p)) +
      xlab("Taille du tableau") +
      ylab("Temps d'exécution (s)") +
      theme_minimal(base_size = 14) +
      theme(legend.title = element_blank())

    ggsave(paste0("comparaison_", cas_type, "_", p, ".png"), g, width = 7, height = 5)

    # ---- Graphique zoomé ----
    generer_zoom(subset_data, cas_type, p)
  }
}

# 2️⃣ Courbe par tri (tous cas + plages)
for (t in unique(data$tri)) {
  g <- ggplot(subset(data, tri == t),
              aes(x = taille, y = temps, color = interaction(cas, plage), group = interaction(cas, plage))) +
    geom_line(linewidth = 1.3) +
    geom_point(size = 2) +
    ggtitle(paste("Performance du tri :", t)) +
    xlab("Taille du tableau") +
    ylab("Temps d'exécution (s)") +
    theme_minimal(base_size = 14) +
    theme(legend.title = element_blank())
  ggsave(paste0("courbe_", t, ".png"), g, width = 7, height = 5)
}

cat("✅ Tous les graphiques + ZOOMS ont été générés !\n")
