-- resources/init.lua

-- Dossier des ressources
local resourcesPath = 'resources/'

-- Tableau des ressources
local resources = {}

-- Liste des dossiers
local files = love.filesystem.getDirectoryItems(resourcesPath)

-- Charger chaque type de ressource
for f, fileName in ipairs(files) do
  if love.filesystem.isDirectory(resourcesPath .. fileName) then
    resources[fileName] = require(resourcesPath .. fileName)
  end
end

return resources