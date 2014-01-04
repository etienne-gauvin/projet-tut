-- Chargement des niveaux
local function load(filePath)
  return require(core.path.removeExt(filePath))
end

return core.path.load('scripts/levels', '%.lua$', load)
