-- Chargement des shaders

-- Dossier des shaders
local path = 'resources/shaders/'

-- Tableau des ressources
local shaders = {}

-- Liste des dossiers
local files = love.filesystem.getDirectoryItems(path)

-- Charger image du dossier
for f, fileName in ipairs(files) do
  if love.filesystem.isFile(path .. fileName) and fileName ~= 'init.lua' then
    shaders[string.match(fileName, '^[^.]+')] = graphics.newShader(path .. fileName)
  end
end

return shaders