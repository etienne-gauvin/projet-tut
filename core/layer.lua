-- Joue le rôle d'un calque pouvant contenir des entités ou d'autres calques.
local Layer = Object:subclass('EntityListHandler')

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

-- Ajouter une entité au calque ou à un sous-calque.
-- entity : l'entité en question
-- [layername='base'] : le calque
-- [...] = sous-calques
function Layer:addEntity(entity, layername, ...)
  if not layername or layername == 'base' then
    self.entities[entity.id] = entity
  else
    local sublayer = self:getSubLayer(layername)
    
    if sublayer then
      sublayer:addEntity(entity, ...)
    else
      print("[err] Impossible d'associer l'entité " .. entity.id .. " au calque " .. layername .. ", celui-ci n'existe pas.")
    end
  end
end

-- Retirer une entité du calque ou d'un sous-calque
-- Attention, seule la référence est supprimée.
-- entityid : l'id de l'entité
-- [layername='base'] : le calque
-- [...] = sous-calques
function Layer:removeEntity(entityid, layername, ...)
  if not layername or layername == 'base' then
    self.entities[entityid] = nil
  else
    local sublayer = self:getSubLayer(layername)
    
    if sublayer then
      sublayer:removeEntity(entityid, ...)
    end
  end
end

-- Ajouter un sous-calque dans le calque actuel ou un sous-calque
-- Les calques sont affichés dans l'ordre de leur création
-- newlayername
-- [layername='base'] : le calque dans lequel ajouter le nouveau calque
-- [...] = sous-calques
function Layer:addSubLayer(newlayername, newlayerid, layername, ...)
  if not layername or layername == 'base' then
    self.layers[#self.layers + 1] = Layer:new(newlayername)
  else
    local sublayer = self:getSubLayer(layername)
    
    if sublayer then
      sublayer:addSubLayer(newlayername, ...)
    else
      print("[err] Impossible de créer le calque " .. newlayername .. " dans le calque " .. layername .. ", celui-ci n'existe pas.")
    end
  end
end

-- Retirer un sous-calque du calque ou d'un sous-calque
-- layerToRemoveName : nom du calque à supprimer
-- [layerid='base'] : le calque
-- [..] = sous-calques
function Layer:removeSubLayer(layerToRemoveName, layername, ...)
  if not layername or layername == 'base' then
    local sublayer, sublayerid = self:getSubLayer(layerToRemoveName)
    
    self.layers[sublayerid] = nil
  else
    local sublayer = self:getSubLayer(layername)
    
    if sublayer then
      sublayer:removeEntity(entityid, ...)
    end
  end
end

return Layer