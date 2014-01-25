---------------
---= Coeur =---
---------------


-- Coeur du jeu
local core = {}

-- Gestionnaire de maps
core.atl = require 'core/libs/atl'

-- Gestionnaire d'animations
core.anim8 = require 'core/libs/anim8'

-- Gestionnaire des états du jeu (states)
core.stateHandler = require 'core/state-handler'

-- Charger le jeu
core.load = require 'core/load'

-- Gestionnaire de configuration
core.config = (require 'core/config'):new()

-- Classe caméra
core.Camera = require 'core/libs/camera'

-- Calques d'affichage
core.layers = (require 'core/layer'):new('main')

-- Fonction de mise à jour
core.update = require 'core/update'

-- Fonction d'affichage
core.draw = require 'core/draw'

-- Fonction d'appui sur un bouton
core.keypressed = require 'core/keypressed'

-- Fonction de fin d'appui sur un bouton
core.keyreleased = function()
  core.stateHandler.current:keyreleased(key)
end

-- Propagation du clic avec la souris
core.mousepressed = function(x, y, button)
  core.stateHandler.current:mousepressed(x, y, button)
end

-- Propagation de la fin du clic avec la souris
core.mousereleased = function(x, y, button)
  core.stateHandler.current:mousereleased(x, y, button)
end

-- Fonctions de manipulation des répertoires
core.path = require 'core/path'

-- Déboguage
core.debug = {
  drawHitboxes = false,
  freeCamera = true,
  drawMapInfos = false,
  drawLevelSelectionPanel = true
}

return core
