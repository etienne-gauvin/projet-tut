-- Raccourcis
local physics = love.physics
local graphics = love.graphics

-- Un niveau du jeu
local Level = Object:subclass('Level')

-- Initialisation
function Level:initialize(name, map)
  self.name = name
  self.map = map
  
  -- Création du monde
  physics.setMeter(64)
  self.world = physics.newWorld(0, 9.81 * physics.getMeter(), true)
  
  -- Tableau des boîtes de collision statiques
  self.staticHitboxes = {}
  
  for i, obj in pairs(self.map.layers.staticHitboxes.objects) do
    
    local hitBox = {}
    hitBox.body = physics.newBody(self.world, obj.x + obj.width / 2, obj.y + obj.height / 2)
    hitBox.shape = physics.newRectangleShape(obj.width, obj.height)
    hitBox.fixture = physics.newFixture(hitBox.body, hitBox.shape)
    
    table.insert(self.staticHitboxes, hitBox)
  end
end

-- Démarrage
function Level:levelStart()
end

-- Lorsque le joueur entre dans la zone de fin de niveau
function Level:levelEnd()
  
  -- Avertir la PlayState de la fin du niveau
  core.states.play:levelEnd()
end

-- Arrêt
function Level:stop()
end

-- Mise à jour
function Level:update(dt)
  self.world:update(dt)
end

-- Affichage
function Level:draw()
  
  self.map:draw()
  
  if core.debug.drawHitboxes then
    
    -- Affichage des hitboxes
    for i, hitBox in ipairs(self.staticHitboxes) do
      print(hitBox.shape:getPoints())
      graphics.setColor(128, 96, 192, 48)
      graphics.polygon("fill", hitBox.body:getWorldPoints(hitBox.shape:getPoints()))
    end
  end
end

return Level