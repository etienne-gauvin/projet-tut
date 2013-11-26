local Entity = require 'core/entity'
local Ship = Entity:subclass('Ship')

-- Initialisation du vaisseau
function Ship:initialize(x, y)
  Entity.initialize(self, x, y)
  
  self.a = 0
  
  -- Taille du vaisseau
  self.width = 27
  self.height = 15
  
  -- Commandes
  self.prevControls = {
    up = false,
    down = false,
    left = false,
    right = false
  }
  
  self.controls = {
    up = false,
    down = false,
    left = false,
    right = false
  }
  
  -- Direction de déplacement
  self.deplacement = {vert = 0, horiz = 0}
  
  -- Animations vaisseau et du passager
  self.image = resources.objects.ship.images.default
  self.anim = resources.anims.ship
  
  -- Animation du passager selon la direction du vaisseau
  self.pimage = resources.images.passenger
  self.panims = {}
  
  for x = 1, 3 do
    self.panims[x] = {}
    for y = 1, 3 do
      self.panims[x][y] = resources.anims.passenger:clone()
      self.panims[x][y].frames = resources.grids.passenger(x, y)
    end
  end
end

-- Mise à jour
function Ship:update(dt)
  Entity.update(self, dt)
  
  self.a = self.a + dt * math.pi / 6
  
  local c, pc = self.controls, self.prevControls
  
  -- Mise à jour des commandes
  c.up, c.down, c.right, c.left = lk.isDown('up'), lk.isDown('down'), lk.isDown('right'), lk.isDown('left')

  -- Mise à jour du déplacement
  local dep = self.deplacement
  
  -- vertical
  if c.up and not pc.up then
    dep.vert = -1
  elseif c.down and not pc.down then
    dep.vert = 1
  elseif not c.up and not c.down then
    dep.vert = 0
  end
  
  -- horizontal
  if c.right and not pc.right then
    dep.horiz = 1
  end
  
  if c.left and not pc.left then
    dep.horiz = -1
  end
  
  if not c.right and not c.left then
    dep.horiz = 0
  end
  
  -- Mise à jour du déplacement
  game.ship.pos.y = game.ship.pos.y + dep.vert
  game.ship.pos.x = game.ship.pos.x + dep.horiz
  
  -- Mise à jour des animations
  self.anim:update(dt)
  self.panims[dep.horiz+2][dep.vert+2]:update(dt)
  
  -- Mise à jour des contrôles
  for c in pairs(self.prevControls) do
    self.controls[c] = self.prevControls[c]
  end
end

-- Affichage
function Ship:draw()
  Entity.draw(self)
  
  -- Affichage de l'animation du passager
  self.panims[self.deplacement.horiz+2][self.deplacement.vert+2]:draw(self.pimage,
    math.floor(self.pos.x + self.origin.x - self.width / 2),
    math.floor(self.pos.y + self.origin.y - self.height / 2), self.a)
  
  -- Affichage de l'animation du vaisseau
  self.anim:draw(self.image,
    math.floor(self.pos.x + self.origin.x - self.width / 2),
    math.floor(self.pos.y + self.origin.y - self.height / 2), self.a)
end



return Ship