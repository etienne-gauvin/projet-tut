-- Chargement des animations
local function load(filePath)
  return require(core.path.removeExt(filePath))
end

return core.path.load('scripts/anims', '%.lua$', load)
