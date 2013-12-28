-- Chargement des images

-- Dossier des images
local path = 'resources/images'

-- Fonction récursive de chargement
local function load(path)

  -- Tableau des ressources
  local res = {}
  
  -- Liste des dossiers
  local files = love.filesystem.getDirectoryItems(path)

  -- Charger image du dossier
  for f, fileName in ipairs(files) do
    if love.filesystem.isFile(path .. fileName) and fileName ~= 'init.lua' then
      res[string.match(fileName, '^[^.]+')] = lg.newImage(path .. fileName)
    elseif love.filesystem.isDirectory(path .. fileName) then
      res[fileName] = load(path .. '/' .. fileName)
    end
  end
  
  return res
end

return load(path)