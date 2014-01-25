-- Raccourcis
local physics = love.physics
local graphics = love.graphics
local Layer = require 'core/layer'
local ParallaxLayer = require 'core/parallax-layer'

-- Un niveau du jeu
local Level = Object:subclass('Level')

-- Initialisation
function Level:initialize(name, map, cameraFocus)
  self.name = name
  self.map = map
  self.playState = game.states.play
  self.layer = Layer:new('level-layer')
  self.layer:addSubLayer(Layer:new('background'))
  
  -- Couleur de fond de la map
  self.backgroundColor = Color:new(self.map.backgroundColor)
  
  -- Ajout des calques de fond
  local i, props = 1, self.map.properties
  
  while map.properties['background-' .. i .. '-image'] do
    local hspeed, vspeed =
      tonumber(props['background-' .. i .. '-hspeed']) or (-0.3 * i),
      tonumber(props['background-' .. i .. '-vspeed']) or (-0.1 * i)
    
    local image = resources.images.backgrounds[props['background-' .. i .. '-image']]
    local color = props['background-' .. i .. '-color'] or self.backgroundColor:clone():darken(0.2 * i)
    
    if not image then
      local imageName = props['background-' .. i .. '-image']
      error("Erreur : l'image de fond '" .. imageName .. "' est introuvable "
          .."à l'emplacement 'resources/backgrounds/" .. imageName .. ".png'\n"
          .."Voir dans les propriétés de la carte '" .. map.properties.filePath .. "'")
    end
    
    self.layer:sub('background'):addSubLayer(ParallaxLayer:new(i, hspeed, vspeed, image, color))
    
    i = i + 1
  end
  
  -- Création du monde
  physics.setMeter(64)
  self.world = physics.newWorld(0, 9.81 * physics.getMeter(), true)
  game.world = self.world
  
  -- Chargement des boîtes de collision statiques
  self.staticHitboxes = self:loadStaticHitBoxes()
end

-- Chargement des boîtes de collision statiques
function Level:loadStaticHitBoxes()
  local staticHitboxes = {}
  
  for x, y, tile in self.map.layers.ground:rectangle(0, 0, self.map.width - 1, self.map.height - 1) do
    if tile.properties.solid then
      local hitBox = {}
      hitBox.body = physics.newBody(self.world, x * tile.width + tile.width / 2, y * tile.height + tile.height / 2)
      hitBox.shape = physics.newRectangleShape(tile.width, tile.height)
      hitBox.fixture = physics.newFixture(hitBox.body, hitBox.shape)
      
      table.insert(staticHitboxes, hitBox)
    end
  end
  
  return staticHitboxes
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
  graphics.setColor(self.backgroundColor:get())
  graphics.rectangle('fill', 0, 0, screen.w(), screen.h())
  self.layer:sub('background'):draw()
  
  -- Caméra
  game.camera:attach()
  
  -- Affichage de la map
  self.map:draw()
  
  if core.debug.drawHitboxes then
    
    -- Affichage des hitboxes
    for i, hitBox in ipairs(self.staticHitboxes) do
      graphics.setColor(96, 196, 0, 96)
      graphics.setLineWidth(1)
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