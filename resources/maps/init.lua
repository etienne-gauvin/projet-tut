-- Chargement des maps

local function load(filePath)
  local map = core.atl.Loader.load(filePath)
  map.properties.filePath = filePath
  return map
end

return core.path.load('resources/maps', '%.tmx$', load)
