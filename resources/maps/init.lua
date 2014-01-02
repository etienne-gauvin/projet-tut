-- Chargement des maps

local function load(filePath)
  return core.atl.Loader.load(filePath)
end

return core.path.load('resources/maps', '%.tmx$', load)
