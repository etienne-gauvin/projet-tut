-- Gestionnaire de la configuration du jeu
local ConfigHandler = Object:subclass('ConfigHandler')

-- Constructeur
function ConfigHandler:initialize()
  self.file = 'config'
  
  -- Configuration par défaut
  self.defconfig = {
    width = love.graphics.getWidth,
    height = love.graphics.getHeight,
    fullscreen = function() local w, h, fs, vsync, fsaa = love.graphics.getMode(); return fs end,
    vsync = function() local w, h, fs, vsync, fsaa = love.graphics.getMode(); return vsync end,
    sensitivity = core and core.mouseSensivity or 1
  }
  
  -- Configuration actuelle
  self.config = {}
end

-- (Re)charger la configuration depuis le fichier
-- return true si la configuration a bien été chargée depuis le fichier
function ConfigHandler:load()
  
  -- Configuration par défaut
  for k, v in pairs(self.defconfig) do
    self.config[k] = (type(v) == 'function' and v() or v)
  end
  
  -- Configuration depuis le fichier
  if love.filesystem.exists(self.file) then
    -- Exécution de la configuration
    love.filesystem.load(configFile)()
  else
    print("Impossible de lire la configuration dans '" .. love.filesystem.getSaveDirectory() .. '/' .. self.file .. "' !")
  end
end

return ConfigHandler