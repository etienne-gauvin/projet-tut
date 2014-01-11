Projet tuteuré _(2ème année de SRC)_
====================================

Présentation
------------

Notre projet consiste en l’élaboration et développement d’un petit jeu vidéo de 
type plate-forme en 2 dimensions qui revisitera de manière originale Le Petit 
Chaperon Rouge. L’objectif et de créer un petite expérience simple et 
divertissante sous une vision plus sombre de ce conte.

Le joueur évoluera dans un univers de plus en plus menaçant à mesure qu’il 
avancera dans le jeu.

En complément du jeu nous créerons un site internet (une page web simple) afin 
de le distribuer et de communiquer avec les (futurs) joueurs.


Guide de démarrage
------------------

Pour essayer la version de développement de ce jeu, il est nécessaire 
d'installer [le moteur de jeu LÖVE 2D](http://love2d.org/).

Télécharger le fichier [projet-tut.love](https://raw.github.com/etienne-gauvin/projet-tut/master/projet-tut.love).

Le jeu peut être démarré en ouvrant le fichier _projet-tut.love_ avec LÖVE 2D 
(double-clic).


La version finale ne nécessitera pas d'installer le moteur de jeu et pourra 
donc fonctionner en standalone.


Il y a quelques fonctionnalités accessibles par le clavier, et utiles pour le développement :

* f1 : Afficher ou masquer les boîtes de collision sur la map ;

* f2 : Basculer entre la vue libre (à la souris) et la vue normale ;

* f3 : Afficher ou masquer des informations de développement (position de la souris, de la caméra, FPS, lignes centrales).

* f4 : Aller à l'écran de choix du niveau

À faire :
---------

(_cette liste n'est pas exhaustive_)

+ Créer les personnages et leurs animations

+ Compléter et améliorer les tilesets de terrain


Fait :
------

- Écran de choix de la map

- Chargement et afficher les maps

- Créer le système de gestion des états du jeu

- Créer le système de chargement du jeu
