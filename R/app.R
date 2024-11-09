# Lancement de l'application Shiny
library(shiny)

# Charger les fichiers global, UI, et serveur
source("R/global.R")
source("R/ui.R")
source("R/server.R")

# Exécution de l'application
shinyApp(ui = ui, server = server)

