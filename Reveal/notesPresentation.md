(Pour les slides que je prépare pour la séance avec Adam, est ce que je dois aller en détail sur le chapitre 4 ? Quel est le but de ces slides ? Présenter le sujet à Adam ? Est ce que dans ce cas, je n'entre pas dans les détails et lui présente simplement comment cela fonctionne de manière générale ?)


# 1. Prétraitement des images (steles)

- Standardiser (pour que les images aient la même taille)
- Nettoyage (élimination du bruit : différence de Gaussien + erosion/dilatation)
- Segmentation de l'image (ce qu'on cherche à récupérer)

- Dupliquation des images en plusieurs couleurs pour avoir un dataset plus varié et avoir plus de données d'entrainement 


# 2. Déroulement universel des tâches d’apprentissage

- Comment ca se passe (on donne input  + étiquettes et on veut que le modèle puisse prédire. Ensemble d'entraînement + ensemble de test)

- Fonctionnement de l'apprentissage (Figure 3.1)
    - Input 
    - Hidden Layers (évoquer le poids, le biais et la fonction d'activation)
    - Output 
    - Fonction de perte 
    - Optimiseur (impact sur les poids)


# 3. Protocole d’évaluation

- Tests sur l'ensemble de validation 
- Tests sur l'ensemble de test
- Métriques de validations (accuracy, loss)
- Feedback et itération 