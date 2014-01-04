-- Chargement des imagefonts

-- Liste des caractères
local chars = [=[
 ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,:;'"?/\[](){}<>1234567890!@#$%^&*_-+=~`|]=]

local function load(filePath)
  return graphics.newImageFont(graphics.newImage(filePath), chars)
end

return core.path.load('resources/imagefonts', '%.png$', load)
