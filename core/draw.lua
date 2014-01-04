-- Affichage principal
return function()

  -- Affichage de la state
  core.stateHandler.current:draw()
  
  -- Affichage d'informations de déboguage
  if core.debug.drawMapInfos then
    local mc = Vector(game.camera:mousepos())
    graphics.setFont(resources.imagefonts.pixelShadowed)
    graphics.setColor(16, 32, 16, 192)
    graphics.rectangle('fill', screen.w() / 2 - 40, screen.h() - 80, 80, 80)
    graphics.setColor(255, 255, 255)
    graphics.printf(mc.x .. '\n' .. mc.y, screen.w() / 2 - 40, screen.h() - 60, 80, 'center')
    graphics.setFont(resources.imagefonts.pixelNormal)
  end
end