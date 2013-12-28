local Layer = require 'core/layer'

-- Calque d'affichage du monde (position relative à la caméra)
local WorldLayer = Layer:subclass('WorldLayer')

-- Initialisation
function WorldLayer:initialize(name, camera)
  Layer.initialize(self, name)
  
  -- Caméra liée au calque
  self.camera = camera
end

-- Affichage de toutes les entités
function WorldLayer:draw(dt)
  self.camera:attach()
  Layer.draw(self)
  self.camera:detach()
end

return WorldLayer