# Réseau de neuronne

## Classification binaire 
### Activation : Sigmoid (dans la couche de sortie)
### Perte : Binary Crossentropy
### Optimiseur : Adam



## Classification multiclasse
### Activation : Softmax (dans la couche de sortie)
### Perte : Categorical Crossentropy
### Optimiseur : Adam ou SGD (Gradient Descent Stochastique)



## Régression 
### Activation : Aucune ou ReLU (dans la couche de sortie, selon le cas si les valeurs cibles sont toujours positives)
### Perte : Mean Squared Error (MSE) ou Mean Absolute Error (MAE)
### Optimiseur : Adam ou RMSprop