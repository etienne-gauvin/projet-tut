-- Chargement des maps

-- Dossier des maps
local mapsPath = core.atl.Loader.path
local path = '.'

-- Fonction récursive de chargement
local function load(path)

  -- Tableau
  local res = {}
  
  -- Liste des dossiers
  local files = love.filesystem.getDirectoryItems(mapsPath .. '/' .. path)
  print(mapsPath .. '/' .. path, #files)  
  
  -- Charger tout le dossier
  for f, fileName in ipairs(files) do
    local filePath = string.gsub(mapsPath .. '/' .. path .. '/' .. fileName, '%./', '')
    local fileRelativePath = string.gsub(path .. '/' .. fileName, '%./', '')
    local name = string.match(fileName, '^[^.]+')
    
    -- Fichier
    if love.filesystem.isFile(filePath) and fileName ~= 'init.lua' then
      local map = core.atl.Loader.load('/' .. fileRelativePath)
      res[tonumber(name) or name] = map
    
    -- Dossier
    elseif love.filesystem.isDirectory(filePath) then
      res[tonumber(fileName) or fileName] = load(fileRelativePath)
    end
  end
  
  return res
end

return load(path)