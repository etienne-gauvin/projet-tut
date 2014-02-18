local Entity = require 'core/entity'
local Block = Entity:subclass('Block')

-- Initialisation
function Block:initialize(x, y, tile)
  Entity.initialize(self, x, y)
  self.isSolid = tile.properties.solid
  
  if self.isSolid then
    self.body = physics.newBody(game.world, x * tile.width + tile.width / 2, y * tile.height + tile.height / 2)
    self.shape = physics.newRectangleShape(tile.width, tile.height)
    self.fixture = physics.newFixture(self.body, self.shape)
    self.fixture:setUserData({entity = self})
  end
end

return Block
