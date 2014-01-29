local Character = require 'entities/character'
local Enemy = Character:subclass('Enemy')

-- Initialisation
function Enemy:initialize(x, y)
  Character.initialize(self, x, y)
  
  -- Image
  --self.image = resources.images.coin
  --self.anim = resources.anims.coin:clone()
end

-- Mise à jour
function Enemy:update(dt)
  Character.update(self, dt)
  
  --self.anim:update(dt)
end

-- Affichage
function Enemy:draw()
  Character.draw(self)
  
  --self.anim:draw(self.image,
  --  math.floor(self.pos.x + self.origin.x - self.image:getWidth() / 2),
  --  math.floor(self.pos.y + self.origin.y - self.image:getWidth() / 2))
end

return Enemy