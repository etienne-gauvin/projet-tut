-- Chargement des states
local function load(filePath)
  return require(core.path.removeExt(filePath)):new()
end

return core.path.load('scripts/states', '%.lua$', load)
