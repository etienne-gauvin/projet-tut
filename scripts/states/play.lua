
-- Classes
local Item = require 'entities/item'
local Layer = require 'core/layer'
local WorldLayer = require 'core/world-layer'
local State = require 'core/state'

-- Un état du jeu
local PlayState = State:subclass('PlayState')

-- Démarrage d'un niveau
function PlayState:initialize()

  -- Niveau actuel
  self.level = false
end

-- Démarrage d'un niveau
function PlayState:start(Level)
  -- Démarrage du niveau
  self.level = Level:new()
  
  -- Personnage
  --self.level:getCharacter('main-character')
end

-- Arrêt
function PlayState:stop()
end

-- Mise à jour
function PlayState:update(dt)
  self.level:update(dt)
  
end

-- Affichage
function PlayState:draw()
  self.level:draw()
end

return PlayState