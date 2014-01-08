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

-- Fonction de clic avec la souris
core.mousepressed = require 'core/mousepressed'

-- Fonctions de manipulation des répertoires
core.path = require 'core/path'

-- Déboguage
core.debug = {
  drawHitboxes = false,
  freeCamera = true,
  drawMapInfos = true,
  drawLevelSelectionPanel = true
}

return core
