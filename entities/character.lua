local Entity = require 'core/entity'
local Character = Entity:subclass('Character')

-- Initialisation
function Character:initialize(x, y)
  Entity.initialize(self, x, y)
  
  -- Direction du personnage (right|left)
  self.direction = "right"
  
  -- Animation
  self.anim = "stand"
  
  -- Témoins
  self.isJumping = false
  self.isFalling = false
  self.isMoving = false -- right|left
  
  -- Boîte de collisions
  self.hitbox = false
end

-- Mise à jour
function Character:update(dt)
  Entity.update(self, dt)
  
  if self.hitbox then
    self.pos.x, self.pos.y =
      self.hitbox.body:getX() - self.width / 2,
      self.hitbox.body:getY() - self.height / 2
  end
  
  
  --self.anim:update(dt)
end

-- Affichage
function Character:draw()
  Entity.draw(self)
  
  --self.anim:draw(self.image,
  --  math.floor(self.pos.x + self.origin.x - self.image:getWidth() / 2),
  --  math.floor(self.pos.y + self.origin.y - self.image:getWidth() / 2))
  
  if self.hitbox and core.debug.drawHitboxes then
    graphics.setColor(0, 0, 255, 32)
    love.graphics.polygon("fill", self.hitbox.body:getWorldPoints(self.hitbox.shape:getPoints()))
    graphics.setColor(0, 0, 255, 128)
    love.graphics.polygon("line", self.hitbox.body:getWorldPoints(self.hitbox.shape:getPoints()))
  end
end

return Character