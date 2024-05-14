# Comment entrainer un modèle via Kraken 

## 1. Préparer nos données (vérité de terrain)

Structure du dossier
```bash
Projet/
│
├── images/                # Dossier contenant Images
│   ├── 00001.jpg
│   ├── 00002.jpg
│   ├── ...
│
├── xml/                   # Dossier contenant XML ALTO
│   ├── 00001.xml
│   ├── 00002.xml
│   ├── ...
│
├── models/                # Directory to store trained models
│   ├── model_47.mlmodel
```

Le fichier xml doit référencé l'image associée (pas nécessaire que les deux fichiers aient le même nom): 

```xml
<alto xmlns="http://www.loc.gov/standards/alto/ns-v4#">
    <Description>
        <sourceImageInformation>
            <fileName>images/000001.jpg</fileName>
        </sourceImageInformation>
    </Description>
    ...
</alto>
```

# 2. Entrainer le modèle 

### À partir d'un modèle existant

```bash
ketos segtrain -i modele_47.mlmodel -f xml -d cuda --logger tensorboard xml/*.xml
``` 

- `-i modele_47.mlmodel ` => On commence à partir d'un modèle pré-entrainée.  

- `--logger tensorboard` => permet de suivre le processus sur tensorboard. 


### From scratch 

```bash
ketos train -f xml xml/*.xml
```