-- Lorsqu'une touche est appuyée
return function(x, y, button)
  
  -- Propagation
  core.stateHandler.current:mousepressed(x, y, button)
end