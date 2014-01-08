-- Classe Level
local Level = require('core/level')

-- Création du niveau
local CurrentLevel = Level:subclass('ForestLevel1')

-- Initialisation du niveau
function CurrentLevel:initialize()
  Level.initialize(self, 'ForestLevel1', resources.maps.forest[2])
end

return CurrentLevel