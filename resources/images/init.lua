-- Chargement des images
local function load(filePath)
  return graphics.newImage(filePath)
end

return core.path.load('resources/images', '%.png$', load)
