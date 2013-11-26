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
  
  -- Lecture du fichier de ressources
  local restypes = resourceList or require('resources')
  
  -- Ouverture de toutes les ressources
  for restypei, resdirs in ipairs(restypes) do
    local restypename = resdirs.restypename
    resources[restypename] = {}
    
    print('-- Loading ' .. restypename)
    
    for resname, res in pairs(resdirs) do
      if resname ~= 'restypename' then
        if restypename == 'objects' then
          resources[restypename][resname] = loadResources(res)
          
        elseif resname ~= 'restypename' then
          resources[restypename][resname] = loaders[restypename](resources, type(res) == 'table' and unpack{res.path, res} or res)
          
          if not resources[restypename][resname] then
            print("[error]", 'Resource ' .. restypename .. '.' .. resname .. ' not loaded')
          else
            print("[res]", 'Resource ' .. restypename .. '.' .. resname .. ' loaded')
          end
        end
      end
    end
  end
  
  return resources
end

return loadResources