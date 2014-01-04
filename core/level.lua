-- Raccourcis
local physics = love.physics
local graphics = love.graphics

-- Un niveau du jeu
local Level = Object:subclass('Level')

-- Initialisation
function Level:initialize(name, map, cameraFocus)
  self.name = name
  self.map = map
  
  -- Création du monde
  physics.setMeter(64)
  self.world = physics.newWorld(0, 9.81 * physics.getMeter(), true)
  
  -- Tableau des boîtes de collision statiques
  self.staticHitboxes = {}
  
  for x, y, tile in self.map.layers.ground:rectangle(0, 0, self.map.width - 1, self.map.height - 1) do
    
    if tile.properties.solid then
      local hitBox = {}
      hitBox.body = physics.newBody(self.world, x * tile.width + tile.width / 2, y * tile.height + tile.height / 2)
      hitBox.shape = physics.newRectangleShape(tile.width, tile.height)
      hitBox.fixture = physics.newFixture(hitBox.body, hitBox.shape)
      
      table.insert(self.staticHitboxes, hitBox)
    end
  end
end

-- Mise à jour
function Level:update(dt)
  
  local map = self.map
  
  -- Mise à jour du moteur physique
  self.world:update(dt)
  
  
  -- Mise à jour de la position de la caméra
  local focus = self.cameraFocus and Vector(self.cameraFocus.pos.x, self.cameraFocus.pos.y) or Vector(0, 0)
  
  if focus.x < screen.w() / 2 then
    focus.x = screen.w() / 2
  elseif focus.x > map.width * map.tileWidth - screen.w() / 2 then
    focus.x = map.width * map.tileWidth - screen.w() / 2
  end
  
  if focus.y < screen.h() / 2 then
    focus.y = screen.h() / 2
  elseif focus.y > map.height * map.tileHeight - screen.h() / 2 then
    focus.y = map.height * map.tileHeight - screen.h() / 2
  end
  
  -- Centrer la caméra
  game.camera:lookAt(focus.x, focus.y)
  
  -- Mettre à jour la zone affichée de la map
  map:autoDrawRange(focus.x, focus.y, 1)
end

-- Affichage
function Level:draw()
  
  -- Fond
  graphics.setColor(155, 194, 140)
  graphics.rectangle('fill', 0, 0, screen.w(), screen.h())
  
  -- Caméra
  game.camera:attach()
  
  -- Affichage de la map
  self.map:draw()
  
  if core.debug.drawHitboxes then
    
    -- Affichage des hitboxes
    for i, hitBox in ipairs(self.staticHitboxes) do
      graphics.setColor(96, 196, 0, 96)
      graphics.polygon("fill", hitBox.body:getWorldPoints(hitBox.shape:getPoints()))
      graphics.setColor(96, 196, 0, 192)
      graphics.polygon("line", hitBox.body:getWorldPoints(hitBox.shape:getPoints()))
    end
  end
  
  -- Caméra
  game.camera:detach()
end

-- Arrêt
function Level:stop()
end

-- Démarrage
function Level:levelStart()
end

-- Lorsque le joueur entre dans la zone de fin de niveau
function Level:levelEnd()
  
  -- Avertir la PlayState de la fin du niveau
  core.states.play:levelEnd()
end

return Level