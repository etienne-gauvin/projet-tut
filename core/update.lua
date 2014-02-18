-- Mise à jour principale
return function(dt)
  
  -- Nettoyage des variables de déboguage
  core.debug.debugVars = {}

  -- Mise à jour de la state
  core.stateHandler.current:update(dt)
  
end