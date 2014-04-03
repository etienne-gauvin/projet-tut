-- Raccourcis
local physics = love.physics
local graphics = love.graphics
local Layer = require 'core/layer'
local ParallaxLayer = require 'core/parallax-layer'
local MainCharacter = require 'entities/characters/main-character'
local Block = require 'entities/block'

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
  
  self.world:setCallbacks(
    function(a, b, c) Level.beginContact(self, a, b, c) end,
    function(a, b, c) Level.endContact(self, a, b, c) end,
    function(a, b, c) Level.preSolve(self, a, b, c) end,
    function(a, b, c) Level.postSolve(self, a, b, c) end
  )
  
  -- Chargement des boîtes de collision statiques
  self.blocks = self:loadBlocks()
  
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
function Level:loadBlocks()
  local blocks = {}
  
  for x, y, tile in self.map.layers.ground:rectangle(0, 0, self.map.width - 1, self.map.height - 1) do
    table.insert(blocks, Block:new(x, y, tile))
  end
  
  return blocks
end

-- Mise à jour
function Level:update(dt)
  
  local map = self.map
  
  -- Mise à jour du moteur physique
  self.world:update(dt)
  
  -- Mise à jour de tous les personnages et objets
  self.layer:sub('objects'):update(dt)
  
  -- Fin de niveau
  local mc = self.mainCharacter
  local le = self.levelEndArea
  
  if mc.pos.x > le.x then
    self:levelEnd()
  end
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
    for i, block in ipairs(self.blocks) do
      if block.isSolid then
        graphics.setColor(96, 196, 0, 96)
        graphics.setLineWidth(1)
        graphics.polygon("fill", block.body:getWorldPoints(block.shape:getPoints()))
        graphics.setColor(96, 196, 0, 192)
        graphics.polygon("line", block.body:getWorldPoints(block.shape:getPoints()))
      end
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
  
  -- Changement de niveau
  if self.nextLevel then
    core.stateHandler:switchTo(game.states.play, self.nextLevel)
    
  -- Retour au menu si aucun niveau suivant n'a été défini
  else
    core.stateHandler:switchTo(game.states.levelSelection)
  end
end

-- Retourne les paramètres utiles de la collision entre objets
-- return : entityA, entityB, contact, velocity
function getContactParams(fixtureA, fixtureB, contact)
  local x1, y1 = fixtureA:getBody():getLinearVelocity()
  local x2, y2 = fixtureB:getBody():getLinearVelocity()

  return
    fixtureA:getUserData().entity,
    fixtureB:getUserData().entity,
    contact,
    math.sqrt(math.pow(x2 - x1, 2) + math.pow(y2 - y1, 2))
end

-- Début de la collision de deux objets
function Level:beginContact(fixtureA, fixtureB, contact)
  local entityA, entityB, contact, velocity = getContactParams(fixtureA, fixtureB, contact)
  print("[coll] (" .. entityA.id .. ", " .. entityB.id .. ")")

  entityA:beginContact(entityB, contact, velocity, fixtureB, fixtureA)
  entityB:beginContact(entityA, contact, velocity, fixtureA, fixtureB)
end

-- Fin de la collision de deux objets
function Level:endContact(fixtureA, fixtureB, contact)
  local entityA, entityB, contact, velocity = getContactParams(fixtureA, fixtureB, contact)
  
  entityA:endContact(entityB, contact, velocity, fixtureB, fixtureA)
  entityB:endContact(entityA, contact, velocity, fixtureA, fixtureB)
end

-- Début du calcul de la collision de deux objets
function Level:preSolve(fixtureA, fixtureB, contact)
  local entityA, entityB, contact, velocity = getContactParams(fixtureA, fixtureB, contact)
  
  entityA:preSolve(entityB, contact, velocity, fixtureB, fixtureA)
  entityB:preSolve(entityA, contact, velocity, fixtureA, fixtureB)
end

-- Fin du calcul de la collision de deux objets
function Level:postSolve(fixtureA, fixtureB, contact)
  local entityA, entityB, contact, velocity = getContactParams(fixtureA, fixtureB, contact)
  
  entityA:postSolve(entityB, contact, velocity, fixtureB, fixtureA)
  entityB:postSolve(entityA, contact, velocity, fixtureA, fixtureB)
end

return Level