
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
  
  -- Point de la caméra
  self.cameraFocus = false
end

-- Démarrage d'un niveau
function PlayState:start(Level)
  -- Démarrage du niveau
  self.level = Level:new()
  
  -- Centrer la caméra sur le personnage principal
  self.cameraFocus = self.level.mainCharacter
end

-- Arrêt
function PlayState:stop()
end

-- Mise à jour
function PlayState:update(dt)
  self.level:update(dt)
  
  -- Mise à jour de la caméra
  local focus = self.cameraFocus and Vector(self.cameraFocus.pos.x, self.cameraFocus.pos.y) or Vector(0, 0)
  local map = self.level.map
  
  -- Caméra libre
  if core.debug.freeCamera then
    focus = Vector(
      map.width * map.tileWidth * mouse.getX() / screen.w(),
      map.height * map.tileHeight * mouse.getY() / screen.h())
  end
  
  -- Limite à gauche
  if focus.x - screen.w() / 2 < 0 then
    focus.x = screen.w() / 2
  end
  
  -- Limite à droite
  if focus.x + screen.w() / 2 > map.width * map.tileWidth then
    focus.x = map.width * map.tileWidth - screen.w() / 2
  end
  
  -- Limite à gauche
  if focus.y - screen.h() / 2 < 0 then
    focus.y = screen.h() / 2
  end
  
  -- Limite en bas
  if focus.y + screen.h() / 2 > map.height * map.tileHeight then
    focus.y = map.height * map.tileHeight - screen.h() / 2
  end
    
  -- Centrer la caméra
  game.camera:lookAt(math.floor(focus.x), math.floor(focus.y))
  
  -- Mettre à jour la zone affichée de la map
  map:setDrawRange(focus.x - screen.w() / 2, focus.y - screen.h() / 2, screen.w(), screen.h())
  
end

-- Affichage
function PlayState:draw()
  self.level:draw()
end

return PlayState