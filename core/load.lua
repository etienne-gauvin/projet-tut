-- Charger le jeu
return function()

  -- Données du jeu
  game = {}
  
  -- Paramétrage de la fenêtre
  screen = {}
  screen.w = lg.getWidth -- Taille réelle de l'écran
  screen.h = lg.getHeight
  
  -- Resources
  resources = require 'resources'
  
  -- Police par défaut
  lg.setFont(resources.imagefonts.normal)
  
  -- Caméra
  game.camera = core.camera(0, 0)
  
end