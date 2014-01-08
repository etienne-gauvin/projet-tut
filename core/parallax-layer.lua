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
    
    local screenW, screenH, imageW, imageH = screen.w(), screen.h(), self.image:getWidth(), self.image:getHeight()
    local x, y =
      game.camera.x * self.hspeed,
      game.camera.y * self.vspeed
    
    x = x % (screenW * x / math.abs(x))
    
    local tx = math.floor((game.camera.x + game.camera.x * self.hspeed) / imageW)
    
    graphics.setColor(self.color:get())
    
    for ix = -1, 1  do
      graphics.draw(self.image, (tx + ix) * imageW + x, y)
    end
    
    game.camera:detach()
  end
end

return ParallaxLayer