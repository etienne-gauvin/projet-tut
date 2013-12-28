-- Chargement des imagefonts

-- Dossier des images
local path = "resources/imagefonts/"

-- Liste des caractères
local chars = [=[
 ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,:;'"?/\[](){}<>1234567890!@#$%^&*_-+=~`|]=]

return {
  -- Font normale
  normal = lg.newImageFont(lg.newImage(path .. 'pixel-font.png'), chars),
  
  -- Font avec ombre
  shadowed = lg.newImageFont(lg.newImage(path .. 'pixel-font-shadowed.png'), chars)
}