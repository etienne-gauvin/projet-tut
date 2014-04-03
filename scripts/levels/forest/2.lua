-- Classe Level
local Level = require('core/level')

-- Création du niveau
local CurrentLevel = Level:subclass('ForestLevel2')

-- Initialisation du niveau
function CurrentLevel:initialize()
  Level.initialize(self, 'ForestLevel2', resources.maps.forest[2])
  self.nextLevel = game.levels.forest[3]
end

return CurrentLevel