-- Gestionnaire des états du jeu
local StateHandler = Object:subclass('StateHandler')

-- Constructeur
function StateHandler:initialize()
  self.current = false
end

-- Changer de state
function StateHandler:switchTo(state, ...)
  
  if self.current then
    self.current:stop()
  end
  
  self.current = state
  self.current:start(...)
end

return StateHandler