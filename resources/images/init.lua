-- Chargement des images
local function load(filePath)
  local image = graphics.newImage(filePath)
  image:setFilter('nearest', 'nearest')
  
  return image
end

return core.path.load('resources/images', '%.png$', load)
