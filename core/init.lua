-- Classes
local ConfigHandler = require 'core/config-handler'

-- Coeur du jeu
local core = {}

-- Gestionnaire de maps
core.atl = require 'core/libs/atl'

-- Gestionnaire d'animations
core.anim8 = require 'core/libs/anim8'

-- Charger le jeu dans une variable
core.load = require 'core/load'

-- Chargeur des resources
core.loadResources = require 'core/load-resources'

-- Gestionnaire de configuration
core.configHandler = ConfigHandler:new()
core.config = core.configHandler.config

-- Classe caméra
core.camera = require 'core/camera'

return core