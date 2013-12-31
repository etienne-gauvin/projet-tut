-- Lorsqu'une touche est appuyée
return function(key)
  
  if key == 'escape' then
    love.event.quit()
  end
  
  if key == 'f1' then
    core.debug.drawHitboxes = not core.debug.drawHitboxes
  end
  
  if key == 'f2' then
    core.debug.freeCamera = not core.debug.freeCamera
  end
  
  if key == 'f3' then
    core.debug.drawMapInfos = not core.debug.drawMapInfos
  end
end