-- Chargement des maps

-- Dossier des maps
local path = 'resources/maps/'

-- Tableau des ressources
local maps = {}

-- Liste des dossiers
local files = love.filesystem.getDirectoryItems(path)

-- Charger image du dossier
for f, fileName in ipairs(files) do
  if love.filesystem.isFile(path .. fileName) and fileName ~= 'init.lua' then
    maps[string.match(fileName, '^[^.]+')] = lg.newImage(path .. fileName)
  end
end

return maps