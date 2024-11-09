# Charger les données
effectifs_2016 <- read.csv("C:/Users/Guillaume/Desktop/Projet_DSIA_40101C/data/processed/effectifs_2016.csv")
effectifs_2017 <- read.csv("C:/Users/Guillaume/Desktop/Projet_DSIA_40101C/data/processed/effectifs_2017.csv")
effectifs_2018 <- read.csv('C:/Users/Guillaume/Desktop/Projet_DSIA_40101C/data/processed/effectifs_2018.csv')
effectifs_total <- read.csv('C:/Users/Guillaume/Desktop/Projet_DSIA_40101C/data/processed/effectifs_total.csv')
effectifs_par_dept_annee <- read.csv('C:/Users/Guillaume/Desktop/Projet_DSIA_40101C/data/processed/effectifs_par_dept_annee.csv')

delits_2016 <- read.csv('C:/Users/Guillaume/Desktop/Projet_DSIA_40101C/data/processed/delits_2016.csv')
delits_2017 <- read.csv('C:/Users/Guillaume/Desktop/Projet_DSIA_40101C/data/processed/delits_2017.csv')
delits_2018 <- read.csv('C:/Users/Guillaume/Desktop/Projet_DSIA_40101C/data/processed/delits_2018.csv')
delits_total <- read.csv('C:/Users/Guillaume/Desktop/Projet_DSIA_40101C/data/processed/delits_total.csv')
delits_par_dept_annee <- read.csv('C:/Users/Guillaume/Desktop/Projet_DSIA_40101C/data/processed/delits_par_dept_annee.csv')

# Reformater les numéros de département si nécessaire
effectifs_par_dept_annee$Numero.Departement <- sprintf("%02d", as.numeric(effectifs_par_dept_annee$Numero.Departement))
delits_par_dept_annee$departement <- sprintf("%02d", as.numeric(delits_par_dept_annee$departement))

delits_par_dept_annee$somme_ligne <- as.numeric(delits_par_dept_annee$somme_ligne)

