local State = require 'core/state'

-- État de démarrage du jeu
local StartState = State:subclass('StartState')

-- Lancement du jeu
function StartState:start()
  print("Démarrage du jeu")
  core.stateHandler:switchTo(game.states.play)
end

return StartState