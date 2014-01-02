-- Quelques fonctions pour faciliter la navigation dans les fichiers et dossiers

local path = {}

-- Créer un joli chemin foo/bar/qwe à partir d'un chemin moche ./foo//bar/../bar/qwe/.
function path.beautifier(p)
  
  -- Replace \ by /
  p = string.gsub(p, '%\\', '/')
  
  -- Delete //
  p = string.gsub(p, '/+', '/')
  
  -- Delete .
  p = string.gsub(p, '([^.])/?%./?$', '%1')
  p = string.gsub(p, '/%./', '/')
  
  -- Delete ..
  p = string.gsub(p, '[^/^.]+/%.%./?', '')
  
  -- Delete the final /
  p = string.gsub(p, '(.)/$', '%1')
  
  return p
end

-- Retourne le nom du fichier/dossier pointé par le chemin
function path.filename(p)
  return string.match(path.beautifier(p), '([^/]+)/?$')
end

-- Supprime l'éventuelle extension
function path.removeExt(p)
  p = path.beautifier(p)
  return string.match(p, '([^/^.]+)%.[^/^.]+$') or p
end

-- Retourne le chemin du parent du dossier pointé
function path.parent(p)
  return path.beautifier(path.beautifier(p) .. '/..')
end

-- Colle des chemins
function path.join(...)
  local p, paths = '', {...}
  
  for i in ipairs(paths) do
     p = string.gsub(p, '/?$', '') .. (p == '' and '' or '/') .. string.gsub(paths[i], '^/?', '')
  end
  
  return p
end

-- Fonction récursive de chargement d'un dossier
function path.load(directory, capture, callback)

  -- Tableau
  local itemArray = {}
  
  -- Liste des dossiers
  local items = love.filesystem.getDirectoryItems(directory)
  
  -- Charger tout le dossier
  for i, itemName in ipairs(items) do
    -- Chemin complet de l'item
    local itemPath = path.join(directory, itemName)
    
    -- Nom sans extension
    print(itemName, path.removeExt(itemName))
    local name = path.removeExt(itemName)
    
    -- Fichier
    if love.filesystem.isFile(itemPath)
      and string.match(itemName, capture)
      and not string.match(itemName, '^init%.lua')
    then
    
      itemArray[tonumber(name) or name] = callback(itemPath)
    
    -- Dossier
    elseif love.filesystem.isDirectory(itemPath) then
      itemArray[tonumber(itemName) or itemName] = path.load(itemPath, capture, callback)
    end
  end
  
  return itemArray
end

return path
