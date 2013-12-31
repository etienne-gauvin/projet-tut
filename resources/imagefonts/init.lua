-- Chargement des imagefonts

-- Dossier des images
local path = "resources/imagefonts/"

-- Liste des caractères
local chars = [=[
 ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,:;'"?/\[](){}<>1234567890!@#$%^&*_-+=~`|]=]

return {
  -- Font normale
  normal = graphics.newImageFont(graphics.newImage(path .. 'pixel-font.png'), chars),
  
  -- Font avec ombre
  shadowed = graphics.newImageFont(graphics.newImage(path .. 'pixel-font-shadowed.png'), chars)
}