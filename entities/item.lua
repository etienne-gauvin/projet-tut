local Entity = require 'core/entity'
local Item = Entity:subclass('Item')

-- Initialisation
function Item:initialize(x, y)
  Entity.initialize(self, x, y)
  
  -- Image de l'item
  --self.image = resources.images.coin
  --self.anim = resources.anims.coin:clone()
end

-- Mise à jour
function Item:update(dt)
  Entity.update(self, dt)
  
  --self.anim:update(dt)
end

-- Affichage
function Item:draw()
  Entity.draw(self)
  
  --self.anim:draw(self.image,
  --  math.floor(self.pos.x + self.origin.x - self.image:getWidth() / 2),
  --  math.floor(self.pos.y + self.origin.y - self.image:getWidth() / 2))
end

return Item