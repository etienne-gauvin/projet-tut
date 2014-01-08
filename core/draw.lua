-- Affichage principal
return function()

  -- Affichage de la state
  core.stateHandler.current:draw()
  
  -- Affichage d'informations de déboguage
  if core.debug.drawMapInfos then
    
    -- Affichage des lignes centrales
    graphics.setLineWidth(1)
    graphics.line(0, screen.h() / 2 - 0.5, screen.w(), screen.h() / 2 - 0.5)
    graphics.line(screen.w() / 2 - 0.5, 0, screen.w() / 2 - 0.5, screen.h())
    
    -- Affichage du panneau de données
    local panel = {x = 20, h = 60}
    panel.y = screen.h() - panel.h - 20
    local mc = Vector(game.camera:mousepos())
    local c = game.camera
    
    graphics.push()
    graphics.translate(panel.x, panel.y)
    
    graphics.setFont(resources.imagefonts.pixelShadowed)
    graphics.setColor(16, 16, 16, 192)
    graphics.rectangle('fill', -20, -20, screen.w(), panel.h + 40)
    graphics.setColor(255, 255, 255)
    
    graphics.print("Souris", 0, 0)
    graphics.print("x = " .. math.floor(mc.x), 100, 0)
    graphics.print("y = " .. math.floor(mc.y), 200, 0)
    
    graphics.print("Camera", 0, 20)
    graphics.print("x = " .. math.floor(c.x), 100, 20)
    graphics.print("y = " .. math.floor(c.y), 200, 20)
    
    graphics.print("FPS", 0, 40)
    graphics.print(love.timer.getFPS(), 100, 40)
    
    graphics.pop()
    
    graphics.setFont(resources.imagefonts.pixelNormal)
  end
end