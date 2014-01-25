local State = require 'core/state'

-- État de démarrage du jeu
local StartState = State:subclass('StartState')

-- Lancement du jeu
function StartState:start()
  
  -- Switcher directement sur une map
  --core.stateHandler:switchTo(game.states.play, game.levels.forest[1])
  
  -- Afficher la liste des maps
  core.stateHandler:switchTo(game.states.levelSelection)
end

return StartState