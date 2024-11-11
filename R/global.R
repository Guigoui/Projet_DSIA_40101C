library(here)

# Charger les données depuis le chemin du projet (avec here)
effectifs_total <- read.csv(here("data", "processed", "effectifs_total.csv"))
effectifs_par_dept_annee <- read.csv(here("data", "processed", "effectifs_par_dept_annee.csv"))
effectifs_par_commune_annee_sorted<- read.csv(here("data", "processed", "effectifs_par_commune_annee_sorted.csv"))

delits_total <- read.csv(here("data", "processed", "delits_total.csv"))
delits_par_dept_annee <- read.csv(here("data", "processed", "delits_par_dept_annee.csv"))
delits_par_commune_annee <- read.csv(here("data", "processed", "delits_par_commune_annee.csv"))
delits_par_commune_annee_sorted <- read.csv(here("data", "processed", "delits_par_commune_annee_sorted.csv"))

merged_data <- read.csv(here("data", "processed", "merged_data.csv"))



# Reformater les numéros de département si nécessaire
effectifs_par_dept_annee$Numero.Departement <- sprintf("%02d", as.numeric(effectifs_par_dept_annee$Numero.Departement))
delits_par_dept_annee$departement <- sprintf("%02d", as.numeric(delits_par_dept_annee$departement))

delits_par_dept_annee$somme_ligne <- as.numeric(delits_par_dept_annee$somme_ligne)

