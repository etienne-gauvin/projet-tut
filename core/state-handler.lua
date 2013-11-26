-- Gestionnaire des états du jeu
local StateHandler = Object:subclass('StateHandler')

-- Constructeur
function StateHandler:initialize()
  self.states = {}
  self.current = false
end

return StateHandler