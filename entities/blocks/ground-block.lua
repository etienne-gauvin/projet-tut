local Block = require 'entities/block'
local GroundBlock = Block:subclass('GroundBlock')

-- Initialisation
function GroundBlock:initialize(x, y, solid)
  Block.initialize(self, x, y, solid)
end

-- Mise à jour
function GroundBlock:update(dt)
  -- Block.update(self, dt)
end

-- Affichage
function GroundBlock:draw()
  -- Block.draw(self)
end

return GroundBlock
