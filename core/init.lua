---------------
---= Coeur =---
---------------


-- Coeur du jeu
local core = {}

-- Gestionnaire de maps
core.atl = require 'core/libs/atl'

-- Gestionnaire d'animations
core.anim8 = require 'core/libs/anim8'

-- Charger le jeu
core.load = require 'core/load'

-- Gestionnaire de configuration
core.config = (require 'core/config'):new()

-- Classe caméra
core.camera = require 'core/camera'

-- Calques d'affichage
core.layers = (require 'core/layer'):new('main')

-- Fonction de mise à jour
core.update = require 'core/update'

-- Fonction d'affichage
core.draw = require 'core/draw'

return core