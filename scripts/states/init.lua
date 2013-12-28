-- Chargement des states

-- Dossier des states
local path = 'scripts/states'

-- Fonction récursive de chargement
local function load(path)

  -- Tableau des states
  local states = {}
  
  -- Liste des dossiers
  local files = love.filesystem.getDirectoryItems(path)

  -- Charger toutes les states du dossier
  for f, fileName in ipairs(files) do
    local filePath = path .. '/' .. fileName
    local name = string.match(fileName, '^[^.]+')
    
    -- Fichier
    if love.filesystem.isFile(filePath) and fileName ~= 'init.lua' then
      states[name] = require(path .. '/' .. name):new()
    
    -- Dossier
    elseif love.filesystem.isDirectory(filePath) then
      states[fileName] = load(filePath)
    end
  end
  
  return states
end

return load(path)