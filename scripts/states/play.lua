
-- Classes
local Item = require 'entities/item'
local Layer = require 'core/layer'
local WorldLayer = require 'core/world-layer'
local State = require 'core/state'

-- Un état du jeu
local PlayState = State:subclass('PlayState')

-- Démarrage d'un niveau
function PlayState:initialize(levelName)

  -- Tableau des calques
  self.layers = {}
end

-- Démarrage d'un niveau
function PlayState:start(levelName)

  -- Création des calques
  self.layers = {
    world = WorldLayer:new('world', game.camera),
    hud = Layer:new('hud')
  }
  
  -- Ajout des calques
  core.layers:addSubLayer(self.layers.world)
  core.layers:addSubLayer(self.layers.hud)
end

-- Arrêt
function PlayState:stop()
  
  -- Suppression des calques
  core.layers:removeSubLayer(self.layers.world)
  core.layers:removeSubLayer(self.layers.hud)
  self.layers.world = nil
  self.layers.hud = nil
end

-- Mise à jour
function PlayState:update(dt)
end

return PlayState