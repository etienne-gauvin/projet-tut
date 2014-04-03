local Entity = require 'core/entity'
local Feet = Entity:subclass('Feet')

-- Initialisation
function Feet:initialize(parent)
  Entity.initialize(self)
  
  self.parent = parent
  self.collisions = {}
  
  self.shape = physics.newRectangleShape(2, self.parent.height / 2 + 1, self.parent.width - 8, 1)
  self.fixture = physics.newFixture(self.parent.body, self.shape)
  self.fixture:setUserData({entity = self})
  self.fixture:setSensor(true)
end

-- Lors d'une collision
function Feet:beginContact(entity, contact, velocity)
  Entity.beginContact(self, entity, contact, velocity)
end

-- À la fin d'une collision
function Feet:endContact(entity, contact, velocity)
  Entity.endContact(self, entity, contact, velocity)
end

return Feet