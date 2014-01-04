-- Chargement des shaders

local function load(filePath)
  return graphics.newShader(filePath)
end

return core.path.load('resources/shaders/', '%.glsl$', load)
