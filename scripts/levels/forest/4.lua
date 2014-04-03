-- Classe Level
local Level = require('core/level')

-- Création du niveau
local CurrentLevel = Level:subclass('ForestLevel4')

-- Initialisation du niveau
function CurrentLevel:initialize()
  Level.initialize(self, 'ForestLevel4', resources.maps.forest[4])
  self.nextLevel = game.levels.forest[5]
end

return CurrentLevel