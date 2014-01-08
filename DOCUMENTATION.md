# Documentation

Informations utiles au développement.

## Ressources et scripts

Les ressources sont automatiquement chargés lors du démarrage du jeu dans la variable globale _resources_.
Les scripts sont utilisés ponctuellement dans le code.

Ces données sont organisées d'après les noms de répertoires et les noms des fichiers, avec quelques traitements. Les extensions des fichiers sont enlevées. Les fichiers peuvent être retrouvés sous leur nom original ou leur nom au format camel case. Par exemple le fichier "_resources/images/backgrounds/trees-silhouette.png_" peut-être trouvé dans les variables _resources.images.backgrouds["trees-silhouette"]_ et _resources.images.backgrouds.treesSilhouette_.

Les fichiers _init.lua_ permettent de charger les données automatiquement de chaque répertoire. Tous les fichiers qui ne correspondent pas au format donné dans _init.lua_ sont ignorés et ne sont pas chargés.

Informations spécifiques à chaque type de ressource :

+ **imagefonts** : au format PNG, le charset se trouve dans le _init.lua_ ;

+ **images** : au format PNG ;

+ **maps** : au format TMX ;

+ **shaders** : au format GLSL ;

+ **tilesets** : au format TSX, mais ceux-ci sont ignorés et chargés par les maps.


## Création d'une map

* Dans Tiled, créer une nouvelle map d'au minimum 24x16 tiles (pour remplir la fenêtre) et d'une taille de tile de 48x48 pixels.

* Ajouter le(s) tileset(s) nécessaire dans **Cartes > Ajouter un tileset externe**. Ceux-ci peuvent ensuite être utilisés avec l'outil brosse de terrain, afin de créer les maps plus rapidement.

* Dans **Cartes > Propriétés** les paramètres suivants peuvent être définis :
    
    + Définir une couleur de fond pour la map
    
    + Pour un (ou des) arrière-plan(s) avec effet parallaxe, créer autant de fois que nécessaire (en remplaçant  **x** par le numéro de l'arrière-plan) :
      
        - _background-**x**-image_ : le nom de l'image d'arrière plan, se trouvant dans le répertoire _resources/maps/backgrounds_, par exemple _"trees-2"_ pour le fichier _resources/maps/backgrounds/trees-2.png_
        
        - [optionnel] _background-**x**-hspeed_ : la vitesse de défilement horizontal du plan par rapport à la caméra, par exemple _-0.3_ ; par défaut celle-ci est _-0.3 * **x**_
        
        - [optionnel] _background-**x**-vspeed_ : la vitesse de défilement verticale du plan par rapport à la caméra, par exemple _-0.3_ ; par défaut celle-ci est _-0.1 * **x**_
        
        - [optionnel] _background-**x**-color_ : la couleur du plan ; par défaut celle-ci est la couleur de fond de la map plus sombre de _**x** * 20%_
    
* Créer les calques et leur contenu :
    
    + **controls** : calque d'objets, où se trouvent les zones de "contrôle" du niveau :
    
        - _level-start_ (rectangle de 1x1) : Emplacement de départ du joueur ;
        
        - _level-end_ (rectangle) : Zone de fin du niveau où doit aller le joueur ;
    
    + **ground** : calque des tiles "dures".

* Sauvegarder le fichier de map _.tmx_ dans le répertoire _resources/maps_ (ou l'un de ses sous-dossiers).

* Créer un fichier _.lua_ correspondant à la map dans le répertoire _scripts/levels_ (ou l'un de ses sous-dossiers), et en s'inspirant du modèle _scripts/levels/base.lua_. Il est notamment nécessaire d'y renseigner le fichier de map utilisé.

* Pour l'instant, le niveau peut seulement être testé en le chargeant directement au démarrage du jeu, ce qui doit-être spécifié dans le fichier _scripts/states/start.lua_. Dans le futur sera ajouté une fonctionnalité pour lancer le niveau plus facilement.