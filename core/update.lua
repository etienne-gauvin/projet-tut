-- Mise à jour principale
return function(dt)

  -- Mise à jour de la state
  core.stateHandler.current:update(dt)

  -- Mise à jour des calques
  core.layers:update(dt)
end