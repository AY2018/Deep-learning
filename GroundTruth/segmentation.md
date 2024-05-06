# Segmentation avec Kraken 

Pour segementer une image via Kraken (on utilise la version **4.3.12**): 

``` bash
kraken --alto  -i image.jpg -o output.xml segment -bl -i modele.mlmodel
```

Pour segmenter plusieurs images :

``` bash
kraken --alto  -I '*.jpg' -o '*.xml' segment -bl -i modele.mlmodel
```

Segmentation Baseline 
Output = XML Alto 


## Segmentation de Page dans Kraken

Kraken propose deux méthodes de segmentation de page : la segmentation Baseline et la segmentation Legacy Box.

### Segmentation Baseline
* Utilise un modèle de segmentation pour étiqueter chaque pixel, distinguant les lignes et les régions.
* Modèle par défaut adapté aux documents imprimés et manuscrits sur papier.
* Des modèles personnalisés peuvent être entraînés pour des types de documents spécifiques.
* Activée avec l'option `-bl`.

### Segmentation Legacy Box
* Produit des boîtes rectangulaires dans l'ordre de lecture.
* !!! Nécessite des images d'entrée binarisées
* Des paramètres spécifiques sont disponibles pour la personnalisation.

### Direction de Texte Principale
* Cruciale pour déterminer l'ordre des blocs de texte et des lignes `-d/–text-direction`
* Les options incluent `horizontal-lr`, `horizontal-rl``, vertical-lr` et `vertical-rl`.
* Dépend de l'orientation du script et de l'ordre de lecture.

### Masquage
* Permet de bloquer certaines zones de la segmentation en utilisant des images de masque binaires.
* Image de madque a la même taille que l'image + régions que l'on veut guarder sont blanches (noire pour reste)
```bash
kraken -i input.jpg segmentation.json segment -bl -m mask.png
```


# Fichier Alto 

Définition simple : ALTO aide à décrire comment un document est organisé. Cela inclut où les pages commencent et finissent, où se trouvent les lignes de texte, les colonnes, les blocs de texte, les images, et autres éléments graphiques. Cette structuration aide à comprendre le layout ou la mise en page originale du document.

Dans notre cas, alto va nous permettre de localiser les lignes de textes (les polygones) = 
- permet de lire le texte (facilité pour l'OCR)
- de savoir exactement où la ligne est sur la page (ce qui aide à la création d'une version numérique du doc)

Utilisation dans la numérisation de bibliothèques : Les bibliothèques et les archives utilisent le format ALTO pour la numérisation de leurs collections car il aide à préserver les informations sur l'organisation originale des documents tout en fournissant un accès au texte via l'OCR.

Dans notre cas, le fichier alto est structuré de la manière suivante : 

```xml
<?xml version="1.0" encoding="UTF-8"?>
<alto xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xmlns="http://www.loc.gov/standards/alto/ns-v4#"
      xsi:schemaLocation="http://www.loc.gov/standards/alto/ns-v4# http://www.loc.gov/standards/alto/v4/alto-4-2.xsd">
  <Description>
    <MeasurementUnit>pixel</MeasurementUnit>
    <sourceImageInformation>
      <fileName>00073.jpg</fileName>
    </sourceImageInformation>
  </Description>
  
  <Tags>
    <OtherTag ID="BT1" LABEL="Title" DESCRIPTION="block type Title"/>
    <!-- D'autres balises OtherTag peuvent être incluses ici pour d'autres types de contenu -->
  </Tags>
  
  <Layout>
    <Page WIDTH="3840" HEIGHT="4900" PHYSICAL_IMG_NR="0" ID="eSc_dummypage_">
      <PrintSpace HPOS="0" VPOS="0" WIDTH="3840" HEIGHT="4900">
        <TextBlock HPOS="98" VPOS="228" WIDTH="3476" HEIGHT="4667" ID="eSc_textblock_de2d64cc" TAGREFS="BT1">
          <TextLine ID="eSc_line_2516d9d8" TAGREFS="LT15290" HPOS="1883" VPOS="1351" WIDTH="171" HEIGHT="359">
            <String CONTENT="Texte ici" HPOS="1883" VPOS="1351" WIDTH="171" HEIGHT="359"/>
          </TextLine>
          <!-- Autres balises TextLine -->
        </TextBlock>
        <!-- Autres balises TextBlock  -->
      </PrintSpace>
    </Page>
  </Layout>
</alto>

```

## Explication des balises principales :

#### `<alto>` 
La balise racine qui définit que le document est au format ALTO. Elle inclut des attributs pour l'espace de noms XML et la localisation du schéma XSD qui valide le format du document.

#### `<Description>`

`<MeasurementUnit>` : Définit l'unité de mesure utilisée dans le document, généralement des pixels pour les images numérisées.

`<sourceImageInformation>` : Contient des informations sur l'image source, y compris le nom du fichier de l'image qui a été traitée par OCR.

#### `<Tags>`

`<OtherTag>` : Utilisée pour définir des types de contenu spécifiques comme les titres, les illustrations, etc. Chaque tag peut être référencé plus tard dans le document pour marquer différents types de blocs ou de lignes.

#### `<Layout>`

`<Page>` : Représente une page du document numérisé, avec des attributs pour les dimensions et un identifiant unique.

`<PrintSpace>` : Définit l'espace imprimable de la page où le contenu peut être placé.

#### `<TextBlock>`

Spécifie un bloc de texte dans l'espace imprimable. Contient des coordonnées, dimensions, et peut-être référencé à un type spécifique défini dans `<Tags>`.

#### `<TextLine>`
Représente une ligne de texte individuelle dans un bloc de texte. Elle inclut aussi des coordonnées et des dimensions.

#### `<String>`
Contient le texte réel extrait par OCR pour une ligne donnée, avec ses propres coordonnées et dimensions pour permettre un positionnement précis.

# Fichier METS

Format de fichier utilisé pour coder les métadonnées descriptives, administratives et structurelles concernant un objet numérique

```xml
<mets xmlns="http://www.loc.gov/METS/" xmlns:xlink="http://www.w3.org/1999/xlink">

    <!-- Section des fichiers où tous les fichiers numériques associés à l'objet sont listés. -->
  <fileSec>

    <!-- Utilisé pour organiser les fichiers en catégories selon leur usage -->
    <fileGrp USE="image">
        
      <!-- Détaille un fichier individuel au sein d'un groupe de fichiers. -->
      <file ID="image1">
        <FLocat xlink:href="00054.jpg"/>
      </file>
    </fileGrp>

    <fileGrp USE="export">
      <file ID="export1">
        <FLocat xlink:href="00054.xml"/>
      </file>
    </fileGrp>
  </fileSec>

  <!-- Carte structurelle, décrit la structure physique et/ou logique de l'objet numérique.-->
  <structMap TYPE="physical">
  
    <!-- Division dans la carte structurelle, peut représenter des niveaux de structure comme un document, une page, un chapitre -->
    <div TYPE="document">
      <div TYPE="page">
        <fptr FILEID="image1"/>
        <fptr FILEID="export1"/>
      </div>
    </div>

  </structMap>
</mets>
```

***En Bref : Alto va permettre de structurer notre image (coordonnées des différentes régions, et inclut le contenu après OCR). C'est l'étiquette qu'on va utiliser pour entrainer notre modèle. Le fichier METS quant à lui permet de structuré les métadonnées de notre images (lié le code xml alto à l'image en question).***

# Corriger les polygones : quel outil ? 

Nous sommes en phase de préparation pour entrainer le modèle. Pour se faire, il nous faut une vérité de terrain que l'on va utiliser pour l'entrainer. 

Nous allons donc segmenter une trentaine d'image via Kraken pour récupérer une segmentation de base (ficher alto). Il faut ensuite corrigé cette segmentation pour chaque image. 

## Solution 1 : Utiliser escriptorium 

[https://escriptorium.readthedocs.io/en/latest/segment/]
Escriptorium permet de modifier les polygones après segmentation. 

## Solution 2 : Utiliser VIA (Oxford)

Avantage de VIA : Manipulation plus simple des polygones 

Désavantage : N'accepte que des fichiers de types JSON,CSV,COCO

Solution ? Transformer le fichier xml en json > faire la modification sur VIA > export en JSON > Convertir en Alto via mapping 