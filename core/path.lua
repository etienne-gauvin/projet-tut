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
  return string.match(p, '(.*[^/^.]+)%.[^/^.]+$') or p
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

-- Retourne le nom de fichier sous la forme camel case (et sans extension)
function path.camelcase(p)
  p = path.removeExt(path.filename(p))
  
  for c in string.gmatch(p, "[-.][a-z0-9]") do
    p = string.gsub(p, c, string.sub(string.upper(c), 2))
  end
  
  return string.gsub(p, '[-.]', '')
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
    local name = path.removeExt(itemName)
    
    -- Fichier
    if love.filesystem.isFile(itemPath)
      and string.match(itemName, capture)
      and not string.match(itemName, '^init%.lua')
    then
      
      local value = callback(itemPath)
      itemArray[name] = value
      itemArray[tonumber(name) or path.camelcase(name)] = value
    
    -- Dossier
    elseif love.filesystem.isDirectory(itemPath) then
      itemArray[tonumber(itemName) or path.camelcase(itemName)] = path.load(itemPath, capture, callback)
    end
  end
  
  return itemArray
end

return path
