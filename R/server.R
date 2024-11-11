library(shiny)
library(ggplot2)
library(dplyr)
library(sf) 

# Charger la carte de France en format GeoJSON
france_map <- st_read("https://france-geojson.gregoiredavid.fr/repo/departements.geojson")

# Serveur
server <- function(input, output, session) {
  
  # Carte des effectifs de police
  output$police_map <- renderPlot({
    ggplot() +
      geom_sf(data = france_map, fill = "grey90", color = "white") +
      geom_sf(data = france_map %>%
                left_join(effectifs_par_dept_annee %>% filter(Année == input$annee_effectifs),
                          # faire correspondre les numéros departement avec ceux de la map
                          by = c("code" = "Numero.Departement")), 
              aes(fill = somme_ligne)) +
      # choisir la couleur verte pour représenter les effectifs
      scale_fill_gradient(low = "lightgreen", high = "darkgreen", na.value = "grey90") +
      # titre
      labs(title = paste("Effectifs de Police par Département - Année", input$annee_effectifs),
           fill = "Effectifs de police") +
      theme_minimal()
  })
  
  # Carte des délits
  output$delits_map <- renderPlot({
    ggplot() +
      geom_sf(data = france_map, fill = "grey90", color = "white") +
      geom_sf(data = france_map %>%
                left_join(delits_par_dept_annee %>% filter(annee == input$annee_delits), 
                          by = c("code" = "departement")), 
              aes(fill = somme_ligne)) +
      scale_fill_gradient(low = "pink", high = "red", na.value = "grey90") +
      labs(title = paste("Délits par Département - Année", input$annee_delits),
           fill = "Délits") +
      theme_minimal()
  })
  
  # Graphique de l'évolution des effectifs dans un département
  output$evolution_graph <- renderPlot({
    dept_data <- effectifs_par_dept_annee %>% 
      filter(Numero.Departement == input$departement)
    
    ggplot(dept_data, aes(x = Année, y = somme_ligne)) +
      geom_bar(stat = "identity", fill = "skyblue") +
      labs(title = paste("Évolution des Effectifs de Police dans le", input$departement),
           x = "Année", y = "Nombre d'effectifs de police") +
      theme_minimal()
  })
  
  # Graphique des délits en fonction de la population
  output$delits_population_graph <- renderPlot({
    delits_filtered <- delits_par_commune_annee_sorted %>%
      filter(annee == input$annee_delits_population)
    
    ggplot(delits_filtered, aes(x = POP, y = somme_ligne)) +
      geom_histogram(stat = "identity", bins = 30, fill = "red", color = "blue") +
      labs(title = paste("Délits par Population des Communes - Année", input$annee_delits_population),
           x = "Population des Communes", y = "Nombre de Délits") +
      theme_minimal()
  })
  
  # Graphique des effectifs en fonction de la population
  output$effectifs_population_graph <- renderPlot({
    effectifs_filtered <- effectifs_par_commune_annee_sorted %>%
      filter(Année == input$annee_effectifs_population)
    
    ggplot(effectifs_filtered, aes(x = Nombre.d.habitants, y = somme_ligne)) +
      geom_histogram(stat = "identity", bins = 30, fill = "green", color = "blue") +
      labs(title = paste("Effectifs par Population des Communes - Année", input$annee_effectifs_population),
           x = "Population des Communes", y = "Nombre d'Effectifs") +
      theme_minimal()
  })
  
  # Graphique Effectifs vs Délits
  output$effectifs_vs_delits_graph <- renderPlot({
    # filtrer les données par année
    merged_data_filtered <- merged_data %>%
      filter(Année == input$annee_effectifs_vs_delits)
    # normaliser la taille des cercles en faisant le rapport du nb total d'habitants + x100 (= calcul taille cercle)
    merged_data_filtered$taille_cercle <- merged_data_filtered$Nombre.d.habitants / 
      max(merged_data_filtered$Nombre.d.habitants) * 100 
    
    ggplot(merged_data_filtered, aes(x = somme_ligne_effectifs, y = somme_ligne_delits)) +
      geom_point(aes(size = taille_cercle, color = CODGEO), alpha = 0.6) +
      scale_size_continuous(range = c(3, 30)) +
      labs(title = paste("Relation entre les Effectifs de Police et les Délits - Année", input$annee_effectifs_vs_delits),
           x = "Effectifs de Police", y = "Délits", size = "Taille du Cercle") +
      # ajoute titre de la légende pour les couleurs
      guides(color = guide_legend(title = "CODGEO")) +  
      theme_minimal() +
      # élargir la taille des axes pour avoir un effet plus "dézoomé" et plus agréable en regardant le graphique
      xlim(0, max(merged_data_filtered$somme_ligne_effectifs) * 1.2) +  
      ylim(0, max(merged_data_filtered$somme_ligne_delits) * 1.2)       
  })
  
}
