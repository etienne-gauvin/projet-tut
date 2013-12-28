-- Gestionnaire de la configuration du jeu
local Config = Object:subclass('Config')

-- Constructeur
function Config:initialize()
  self.file = 'config'
  
  -- Configuration par défaut
  self.default = {
    width = love.graphics.getWidth,
    height = love.graphics.getHeight,
    fullscreen = love.window.getFullscreen,
  }
  
  for key, value in pairs(self.default) do
    self[key] = (type(value) == 'function' and value() or value)
  end
end

-- (Re)charger la configuration depuis le fichier
function Config:load()
  
  -- Configuration depuis le fichier
  if love.filesystem.exists(self.file) then
    -- Exécution de la configuration
    local config = require(configFile)
    
    for key, value in pairs(config) do
      self[key] = (type(value) == 'function' and value() or value)
    end
  else
    print("Impossible de charger la configuration depuis '" .. love.filesystem.getSaveDirectory() .. '/' .. self.file .. "' !")
  end
end

-- Sauvegarder la configuration
function Config:save()
  
  local configText =
     "return {\n"
  .. "  width = " .. self.width .. ",\n"
  .. "  height = " .. self.height .. ",\n"
  .. "  fullscreen = " .. self.fullscreen .. ",\n"
  .. "}"
  
  
  -- Configuration depuis le fichier
  if not love.filesystem.write(self.file, configText) then
    print("Impossible d'enregistrer la configuration dans '" .. love.filesystem.getSaveDirectory() .. '/' .. self.file .. "' !")
  else
    print("Configuration sauvegardée !")
  end
end

return Config