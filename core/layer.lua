-- Joue le rôle d'un calque pouvant contenir des entités ou d'autres calques.
local Layer = Object:subclass('Layer')

-- Incrémentation à chaque nouveau calque
local layercounter = 1

-- Initialisation
function Layer:initialize(name)
  self.name = name or 'Layer' .. layercounter
  layercounter = layercounter + 1
  
  self.entities = {}
  self.layers = {}
end

-- Mise à jour de toutes les entités
function Layer:update(dt)
  
  -- Mise à jour des entités dans le calque de base
  for e in pairs(self.entities) do
    self.entities[e]:update(dt)
  end
  
  -- Mise à jour des calques
  for l in ipairs(self.layers) do
    self.layers[l]:update(dt)
  end
end

-- Affichage de toutes les entités
function Layer:draw(dt)
  
  -- Affichage des entités dans le calque de base
  for e in pairs(self.entities) do
    self.entities[e]:draw()
  end
  
  -- Affichage des calques
  for l in ipairs(self.layers) do
    self.layers[l]:draw()
  end
end

-- Retourne un sous-calque d'après son nom
function Layer:getSubLayer(name)
  for l in ipairs(self.layers) do
    if self.layers[l].name == name then 
      return self.layers[l], l
    end
  end
end

-- Alias de Layer:getSubLayer
function Layer:sub(name)
  return self:getSubLayer(name)
end

-- Ajouter une entité au calque ou à un sous-calque.
-- entity : l'entité en question
function Layer:addEntity(entity)
  self.entities[entity.id] = entity
end

-- Retirer une entité du calque ou d'un sous-calque
-- Attention, seule la référence est supprimée.
-- entityid : l'id de l'entité
function Layer:removeEntity(entityid)
  self.entities[entityid] = nil
end

-- Ajouter un sous-calque dans le calque actuel ou un sous-calque
-- Les calques sont affichés dans l'ordre de leur création
-- newlayername
function Layer:addSubLayer(layer)
  self.layers[#self.layers + 1] = layer
end

-- Retirer un sous-calque du calque ou d'un sous-calque
-- layerToRemoveName : nom du calque à supprimer
function Layer:removeSubLayer(layer)
 local sublayer, sublayerid = self:getSubLayer(layer.name)
  self.layers[sublayerid] = nil
end

return Layer