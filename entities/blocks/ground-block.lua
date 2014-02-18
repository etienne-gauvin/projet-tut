local Block = require 'entities/block'
local GroundBlock = Block:subclass('GroundBlock')

-- Initialisation
function GroundBlock:initialize(x, y, tile)
  Block.initialize(self, x, y, tile)
end

return GroundBlock
