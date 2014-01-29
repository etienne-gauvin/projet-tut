local Entity = require 'core/entity'
local Block = Entity:subclass('Block')

-- Initialisation
function Block:initialize(x, y, solid)
  Entity.initialize(self, x, y)
  self.isSolid = solid
end

-- Mise à jour
function Block:update(dt)
  --Entity.update(self, dt)
end

-- Affichage
function Block:draw()
  --Entity.draw(self)
end

return Block
