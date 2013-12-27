

-- Fonctions de chargement de chaque ressource
local loaders = {
  
  -- Charger une image
  images = function(resources, res)
    local img = lg.newImage('resources/images/' .. res)
    --img:setFilter('nearest', 'nearest')
    return img
  end,
  
  -- Charger une ImageFont
  imagefonts = function(resources, res)
    return lg.newImageFont(lg.newImage('resources/imagefonts/' .. res.image), res.chars)
  end,
  
  -- Charger un shader GLSL
  shaders = function(resources, res)
    return lg.newPixelEffect('resources/shaders/' .. res)
  end,
  
  -- Charger une animation (https://github.com/kikito/anim8)
  anims = function(resources, res)
    return core.anim8.newAnimation(resources.grids[res.gridName](res.gridFramesX, res.gridFramesY), res.durations)
  end,
  
  -- Charger une grille d'animation
  -- Déclarer les grilles AVANT les animations
  grids = function(resources, res)
    return core.anim8.newGrid(
      res.frameW, res.frameH,
      res.imageW, res.imageH,
      res.top or 0, res.left or 0,
      res.border or 0)
  end
}

-- Charger toutes les ressources demandées dans un tableau
local function loadResources(resourceList)
  
  local resources = {}
  
  -- Liste des types de ressources
  local resTypes = love.filesystem.enumerate('resources')
  
  -- Pour chaque type de ressource
  for i, resType in ipairs(resTypes) do
    local resFiles = love.filesystem.enumerate('resources/' .. resType)
    
    for j, resFile in resFiles do
      resources[resType][resFile] = loaders[resType]('resources/' .. resType .. '/' .. resFile)
      
      if not resources[resType][resFile] then
        print("Erreur lors du chargement de la ressource " .. resType .. '/' .. resFile)
      end
    end
  end
  
  return resources
end

return loadResources