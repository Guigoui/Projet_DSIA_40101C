library(shiny)
library(ggplot2)
library(dplyr)
library(sf)  # Pour charger les données GeoJSON

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
                          by = c("code" = "Numero.Departement")), 
              aes(fill = somme_ligne)) +
      scale_fill_gradient(low = "lightblue", high = "darkblue", na.value = "grey90") +
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
}