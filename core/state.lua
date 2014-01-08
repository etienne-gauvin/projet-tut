-- Un état du jeu
local State = Object:subclass('State')

-- Initialisation
function State:initialize(name)
  self.name = name
end

-- Démarrage
function State:start()
end

-- Arrêt
function State:stop()
end

-- Mise à jour
function State:update(dt)
end

-- Affichage
function State:draw()
end

-- Touche pressée
function State:keypressed(key)
end

-- Touche pressée
function State:mousepressed(x, y, button)
end

return State