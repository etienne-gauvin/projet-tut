-- Charger le jeu
return function()

  -- Données du jeu
  game = {}
  
  -- Paramétrage de la fenêtre
  screen = {}
  screen.w = graphics.getWidth -- Taille réelle de l'écran
  screen.h = graphics.getHeight
  
  -- Resources
  resources = require 'resources'
  
  -- Police par défaut
  graphics.setFont(resources.imagefonts.pixelNormal)
  
  -- Caméra
  game.camera = core.Camera(0, 0)
  
  -- States
  game.states = require 'scripts/states'
  
  -- Niveaux
  game.levels = require 'scripts/levels'
  
  -- Démarrage du jeu
  core.stateHandler.current = game.states.start
end