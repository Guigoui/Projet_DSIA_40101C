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
                 h3("Effectifs de Police par Département")),
             div(style = "text-align: center;", 
                 plotOutput("police_map")),
             div(style = "text-align: center;", 
                 sliderInput("annee_effectifs", "Année pour les Effectifs de Police:", 
                             min = 2016, max = 2018, value = 2016, step = 1)),
             div(style = "text-align: center;", 
                 h3("Délits par Département")),
                 plotOutput("delits_map"),
                 sliderInput("annee_delits", "Année pour les Délits:", 
                             min = 2016, max = 2018, value = 2016, step = 1)),
    
    # Onglet Évolution des Effectifs
    tabPanel("Évolution des Effectifs",
             h3("Évolution des Effectifs de Police dans un Département"),
             selectInput("departement", "Choisir un département", 
                         choices = unique(effectifs_par_dept_annee$Numero.Departement), selected = "93"),
             plotOutput("evolution_graph")),
    
    # Onglet Délits et effectifs par Population
    tabPanel("Délits et effectifs par Population",
             sliderInput("annee_delits_population", "Année pour les Délits par Population:", 
                         min = 2017, max = 2018, value = 2017, step = 1),
             plotOutput("delits_population_graph"),
             sliderInput("annee_effectifs_population", "Année pour les effectifs par Population:", 
                         min = 2017, max = 2018, value = 2017, step = 1),
             plotOutput("effectifs_population_graph")),
    
    # Onglet Effectifs vs Délits
    tabPanel("Effectifs vs Délits",
             sliderInput("annee_effectifs_vs_delits", "Année pour les Effectifs vs Délits:", 
                         min = 2017, max = 2018, value = 2017, step = 1),
             plotOutput("effectifs_vs_delits_graph"))
  )
)