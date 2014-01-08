local Layer = require 'core/layer'

-- Calque d'affichage avec un effet parallax
-- en fonction d'un coefficient de déplacement et d'une caméra
local ParallaxLayer = Layer:subclass('ParallaxLayer')

-- Initialisation
function ParallaxLayer:initialize(name, hspeed, vspeed, image, color)
  Layer.initialize(self, name)
  self.hspeed = hspeed or 0
  self.vspeed = vspeed or 0
  self.image = image
  self.color = color or Color:new()
end

-- Affichage
function ParallaxLayer:draw(dt)
  if self.image then
    game.camera:attach()
    graphics.setColor(self.color:get())
    
    local screenW, screenH = screen.w(), screen.h()
    local imageW, imageH = self.image:getWidth(), self.image:getHeight()
    local cameraX, cameraY = game.camera.x, game.camera.y
    local x, y = cameraX * self.hspeed, cameraY * self.hspeed
    
    
    for ix = 0,0  do
      graphics.draw(self.image, x, y)
    end
    
    game.camera:detach()
  end
end

return ParallaxLayer