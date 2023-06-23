# IDS_09_05_ANN

# ==========================================================
# Installer et charger les packages dont tu as besoin
# ==========================================================

install.packages('neuralnet')  # Installer neuralnet
library(neuralnet)             # Charger neuralnet

# ==========================================================
# Preparer les données
# ==========================================================

# Prendre 30 nombres entiers aléatoires entre 1 et 50
set.seed(1202)                             # Définir le grain
train.x <- sample(1:100, 50, replace = T)  # Obtenir les nombres
head(train.x)                              # voir les nombres
train.y <- sqrt(train.x)                   # Obtenir les racines carrées
head(train.y)                              # voir les racines

# Joindre les colonnes et contraindre au cadre des données
train.xy <- as.data.frame(cbind(train.x, train.y))
head(train.xy)

# ==========================================================
# Entrainer le réseau de neurones
# ==========================================================

# Utiliser  10 couches cachées
# Seuil = La dériveé partielle de la fonction d'erreur,
#             utilisée comme critère d'arrêt.
net.sqrt <- neuralnet(train.y ~ train.x, 
                      train.xy,
                      hidden = 10, 
                      threshold = 0.01)

# Tracer le réseau de neurons résultant
plot(net.sqrt)

# ==========================================================
# Tester le réseau de neurones résultant
# ==========================================================

test.x <- as.data.frame((1:10)^2)    # Nombres au carré
test.y <- compute(net.sqrt, test.x)  # Passer dans le réseau de neuronnes (ANN)
test.y                               # Afficher la sortie du réseau (ANN)

# Créer un tableau avec les entrées, les résultats sttendus,
# et les résultats réels depuis le réseau de neuronnes
net.table <- cbind(test.x,
                   sqrt(test.x),
                   round(test.y$net.result, 2))
colnames(net.table) <- c("X","Y-Exp","Y-ANN")
net.table  # Afficher le tableau

# ==========================================================
# Nettoyer
# ==========================================================

# Nettoyer l'espace de Travail
rm(list = ls()) 

# Unload packages
detach("package:neuralnet", unload = TRUE)

# Nettoyer les graphiques
dev.off()

# Nettoyer la console
cat("\014")  # ctrl+L
