-- Classe Level
local Level = require('core/level')

-- Création du niveau
local CurrentLevel = Level:subclass('ForestLevel3')

-- Initialisation du niveau
function CurrentLevel:initialize()
  Level.initialize(self, 'ForestLevel3', resources.maps.forest[3])
  self.nextLevel = game.levels.forest[4]
end

return CurrentLevel