library(shiny)

# Interface utilisateur
ui <- fluidPage(
  
  # Titre de l'application centré
  div(style = "text-align: center;", 
      titlePanel("Tableau de Bord des Effectifs de Police et des Actes de Délinquance (2016-2018)")),
  
  # Panneau avec onglets
  tabsetPanel(
    
    # Onglet Introduction
    tabPanel("Introduction", 
             div(style = "text-align: center;",  # Centrer le texte
                 h2("Bienvenue sur le tableau de bord"),
                 p("Ce tableau de bord présente les effectifs de police par département en France de 2016 à 2018."))),
    
    # Onglet Carte de France
    tabPanel("Carte de France",
             div(style = "text-align: center;", 
                 h3("Effectifs de Police par Département"),
                 plotOutput("police_map"),
                 # les sliders ne veulent pas se mettre au milieu je ne comprends pas pk
                 sliderInput("annee_effectifs", "Année pour les Effectifs de Police:", 
                             min = 2016, max = 2018, value = 2016, step = 1)),
             div(style = "text-align: center;", 
                 h3("Délits par Département"),
                 plotOutput("delits_map"),
                 sliderInput("annee_delits", "Année pour les Délits:", 
                             # min max etc doivent correspondre aux valeurs dans colonne annee sinon pas de fusion
                             min = 16, max = 18, value = 16, step = 1))),
             
     # Onglet Évolution des Effectifs
     tabPanel("Évolution des Effectifs",
             div(style = "text-align: center;", 
                 h2("Évolution des Effectifs de Police dans un Département"),
                 selectInput("departement", "Sélectionnez un département :", 
                             choices = sprintf("%02d", 1:95), selected = "93"),
                 plotOutput("evolution_graph")))
             )
    )
  

    