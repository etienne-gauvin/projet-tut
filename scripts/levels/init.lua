-- Chargement des niveaux

-- Dossier des niveaux
local path = 'scripts/levels'

-- Fonction récursive de chargement
local function load(path)

  -- Tableau des niveaux
  local levels = {}
  
  -- Liste des dossiers
  local files = love.filesystem.getDirectoryItems(path)

  -- Charger tous les niveaux du dossier
  for f, fileName in ipairs(files) do
    local filePath = path .. '/' .. fileName
    local name = string.match(fileName, '^[^.]+')
    
    -- Fichier
    if love.filesystem.isFile(filePath) and fileName ~= 'init.lua' then
      levels[tonumber(name) or name] = require(path .. '/' .. name)
    
    -- Dossier
    elseif love.filesystem.isDirectory(filePath) then
      levels[tonumber(fileName) or fileName] = load(filePath)
    end
  end
  
  return levels
end

return load(path)