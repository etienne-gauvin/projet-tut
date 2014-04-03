-- Classe Level
local Level = require('core/level')

-- Création du niveau
local CurrentLevel = Level:subclass('ForestLevel5')

-- Initialisation du niveau
function CurrentLevel:initialize()
  Level.initialize(self, 'ForestLevel5', resources.maps.forest[5])
end

return CurrentLevel