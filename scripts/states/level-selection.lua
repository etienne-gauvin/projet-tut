local State = require 'core/state'

-- État de démarrage du jeu
local LevelSelectionState = State:subclass('StartState')

-- Constructeur
function LevelSelectionState:initialize()
  self.levelSelected = false
  self.hitBoxes = {}
end

-- Lancement
function LevelSelectionState:start()
  self.levelSelected = false
  self.hitBoxes = {}
  
  local y = 0
  local function loadLevelNames(levels)
    for key, value in pairs(levels) do
      if string.match(tostring(value), "class") then
        if type(key) ~= 'number' and not string.match(key, "[-.]")  then
          if not self.levelSelected then 
            self.levelSelected = value
          end
          
          table.insert(self.hitBoxes, {
            level = value,
            y = 60 + 20 * y
          })
          
          y = y + 1
        end
      else
        y = y + 1
        loadLevelNames(value)
      end
    end
  end
  
  loadLevelNames(game.levels)
end

-- Mise à jour
function LevelSelectionState:update(dt)
  local mx, my = love.mouse.getPosition()
  
  for h, hitBox in ipairs(self.hitBoxes) do
    if my >= hitBox.y and my < hitBox.y + 20 then
      print(hitBox.level)
      self.levelSelected = hitBox.level
    end
  end
end

-- Affichage
function LevelSelectionState:draw()
  
  -- Fond
  graphics.setColor(36, 36, 36)
  graphics.rectangle('fill', 0, 0, screen.w(), 60)
  
  for n = 60, screen.h(), 20 do
    if n % 40 == 0 then
      graphics.setColor(32, 32, 32)
    else
      graphics.setColor(36, 36, 36)
    end
    
    graphics.rectangle('fill', 0, n - 1, screen.w(), 20)
  end
  
  -- En-tête
  graphics.setColor(255, 255, 255)
  graphics.setFont(resources.imagefonts.pixelShadowedLarge)
  graphics.printf("Selectionner un niveau", 0, 20, screen.w(), 'center')
  
  -- Affichage de tous les noms de map
  graphics.setFont(resources.imagefonts.pixelShadowed)
  
  local y = 0
  local function drawLevelNames(levels, x)
    for key, value in pairs(levels) do
      
      -- Dossier
      if not string.match(tostring(value), "class") then
        graphics.setColor(128, 255, 128)
        graphics.print('/ ' .. key, x * 30, 60 + 20 * y)
        y = y + 1
        drawLevelNames(value, x + 1)
      
      -- Map
      elseif type(key) ~= 'number' and not string.match(key, "[-.]")  then
        
        -- Map sélectionnée
        if value == self.levelSelected then
          graphics.setColor(255, 255, 255)
        else
          graphics.setColor(96, 96, 96)
        end
        
        graphics.print('| ' .. key, x * 30, 60 + 20 * y)
        y = y + 1
      end
    end
  end
  
  drawLevelNames(game.levels, 1)
end

-- Touche pressée
function LevelSelectionState:keypressed(key)
end

-- Clic
function LevelSelectionState:mousepressed(x, y, button)
  if self.levelSelected then
    core.stateHandler:switchTo(game.states.play, self.levelSelected)
  end
end

return LevelSelectionState