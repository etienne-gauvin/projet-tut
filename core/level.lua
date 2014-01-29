-- Raccourcis
local physics = love.physics
local graphics = love.graphics
local Layer = require 'core/layer'
local ParallaxLayer = require 'core/parallax-layer'
local MainCharacter = require 'entities/characters/main-character'

-- Un niveau du jeu
local Level = Object:subclass('Level')

-- Initialisation
function Level:initialize(name, map, cameraFocus)
  
  print("---- Chargement du niveau " .. map.name)
  local stime = love.timer.getTime()
  
  self.name = name
  self.map = map
  self.playState = game.states.play
  
  -- Calques d'affichage
  self.layer = Layer:new('level-layer')
  self.layer:addSubLayer(Layer:new('objects'))
  self.layer:addSubLayer(Layer:new('background'))
  
  -- Chargement du fond
  self:loadBackground()
  
  -- Création du monde
  physics.setMeter(64)
  self.world = physics.newWorld(0, 9.81 * physics.getMeter(), true)
  game.world = self.world
  
  -- Chargement des boîtes de collision statiques
  self.staticHitboxes = self:loadStaticHitBoxes()
  
  -- Chargement du personnage principal
  self.mainCharacter = false
  
  -- Chargement des zones particulières (début de niveau, fin, etc.)
  self:loadControls()
  
  -- Chargement des objets dynamiques (personnages, etc.)
  self:loadObjects()
  
  -- Chargement terminé
  local etime = love.timer.getTime()
  print(string.format("---- Chargement du niveau terminé (%.3fs)", etime - stime))
end

-- Chargement des objets dynamiques (personnages, etc.)
function Level:loadObjects()
end

-- Chargement des zones particulières (début de niveau, fin, etc.)
function Level:loadControls()
  self.levelEndArea = false
  
  if self.map.layers.controls then
    self.map.layers.controls.visible = false
    
    for i, controlArea in ipairs(self.map.layers.controls.objects) do
      
      -- Position du personnage principal
      if controlArea.name == 'level-start' then
        self.mainCharacter = MainCharacter:new(controlArea.x, controlArea.y - 48 / 2)
        self.layer:sub('objects'):addEntity(self.mainCharacter)
      
      -- Position de la zone de fin
      elseif controlArea.name == 'level-end' then
        self.levelEndArea = controlArea
      end
    end
  end
end

-- Chargement du fond du niveau
function Level:loadBackground()
  -- Couleur de fond de la map
  self.backgroundColor = Color:new(self.map.backgroundColor)
  
  -- Ajout des calques de fond
  local i, props = 1, self.map.properties
  
  while self.map.properties['background-' .. i .. '-image'] do
    local hspeed, vspeed =
      tonumber(props['background-' .. i .. '-hspeed']) or (-0.3 * i),
      tonumber(props['background-' .. i .. '-vspeed']) or (-0.1 * i)
    
    local image = resources.images.backgrounds[props['background-' .. i .. '-image']]
    local color = props['background-' .. i .. '-color'] or self.backgroundColor:clone():darken(0.2 * i)
    
    if not image then
      local imageName = props['background-' .. i .. '-image']
      error("Erreur : l'image de fond '" .. imageName .. "' est introuvable "
          .."à l'emplacement 'resources/backgrounds/" .. imageName .. ".png'\n"
          .."Voir dans les propriétés de la carte '" .. self.map.properties.filePath .. "'")
    end
    
    self.layer:sub('background'):addSubLayer(ParallaxLayer:new(i, hspeed, vspeed, image, color))
    
    i = i + 1
  end
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
  
  -- Mise à jour de tous les personnages et objets
  self.layer:sub('objects'):update(dt)
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
  graphics.setColor(255, 255, 255)
  self.map:draw()
  
  -- Affichage des personnages et objets
  graphics.setColor(255, 255, 255)
  self.layer:sub('objects'):draw()
  
  -- Affichage du personnage principal
  graphics.setColor(255, 255, 255)
  self.mainCharacter:draw()
  
  -- Affichage des hitboxes
  if core.debug.drawHitboxes then
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