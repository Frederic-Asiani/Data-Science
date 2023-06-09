# IDS_09_05_ANN

# ==========================================================
# Installer et charger les packages dont tu as besoin
# ==========================================================

install.packages('neuralnet')  # Installer neuralnet
library(neuralnet)             # Charger neuralnet

# ==========================================================
# Preparer les donn�es
# ==========================================================

# Prendre 30 nombres entiers al�atoires entre 1 et 50
set.seed(1202)                             # D�finir le grain
train.x <- sample(1:100, 50, replace = T)  # Obtenir les nombres
head(train.x)                              # voir les nombres
train.y <- sqrt(train.x)                   # Obtenir les racines carr�es
head(train.y)                              # voir les racines

# Joindre les colonnes et contraindre au cadre des donn�es
train.xy <- as.data.frame(cbind(train.x, train.y))
head(train.xy)

# ==========================================================
# Entrainer le r�seau de neurones
# ==========================================================

# Utiliser  10 couches cach�es
# Seuil = La d�rive� partielle de la fonction d'erreur,
#             utilis�e comme crit�re d'arr�t.
net.sqrt <- neuralnet(train.y ~ train.x, 
                      train.xy,
                      hidden = 10, 
                      threshold = 0.01)

# Tracer le r�seau de neurons r�sultant
plot(net.sqrt)

# ==========================================================
# Tester le r�seau de neurones r�sultant
# ==========================================================

test.x <- as.data.frame((1:10)^2)    # Nombres au carr�
test.y <- compute(net.sqrt, test.x)  # Passer dans le r�seau de neuronnes (ANN)
test.y                               # Afficher la sortie du r�seau (ANN)

# Cr�er un tableau avec les entr�es, les r�sultats sttendus,
# et les r�sultats r�els depuis le r�seau de neuronnes
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
