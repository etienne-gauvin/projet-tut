-- Bibliothèques
require 'core/libs/middleclass'

-- Raccourcis accessibles sur toutes les pages
Vector = require 'core/libs/vector'
lg = love.graphics
lk = love.keyboard

-- Coeur du jeu
core = require 'core'

-- Classes
local Item = require 'entities/item'
local Layer = require 'core/layer'

-- Chargement initial
function love.load()
  
  -- Chargement des fichiers, et des variables globales game, resources et screen
  core.load()
  
  game.layer = Layer:new('main')
  game.layer:addSubLayer('itemlayer')
  
  for i = 1, 10 do
    game.layer:addEntity(Item:new(150 + i * 12, 150), 'itemlayer')
  end
end

-- Mise à jour
function love.update(dt)
  -- Mis à jour du calque principal
  game.layer:update(dt)
  
  -- Camera sur le vaisseau
  game.camera:lookAt(0, 0)
end

-- Gestion des évènements clavier
function love.keypressed(key)
  local width, height, fullscreen, vsync, fsaa = lg.getMode()
  
  if key == 'f11' then
    if not fullscreen then
      local modes = love.graphics.getModes()
      local maxmode = {width = 0, height = 0}
      
      for m, mode in ipairs(modes) do
        if mode.width > maxmode.width or mode.height > maxmode.height then
          maxmode = mode
        end
      end
      
      lg.setMode(maxmode.width, maxmode.height, not fullscreen, vsync, fsaa)
    else
      lg.setMode(screen.windowedWidth, screen.windowedHeight, not fullscreen, vsync, fsaa)
    end
  end
  
  if key == 'escape' then
    love.event.quit()
  end
end

-- Affichage
function love.draw()
  
  -- Canvas d'affichage
  screen.canvas:clear(174, 208, 255)
  lg.setCanvas(screen.canvas)
  
  -- Affichage depuis la caméra
  game.camera:attach()
  
  game.layer:draw()
  
  -- Fin de l'affichage depuis la caméra
  game.camera:detach()
  
  -- Affichage de l'HUD
  lg.setColor(0, 0, 0, 128)
  lg.rectangle('fill', screen.sw() - 34, 2, 32, 24)
  
  lg.setColor(0, 0, 0, 192)
  lg.rectangle('fill', screen.sw() - 34, 26, 32, 1)
  
  lg.setColor(255, 255, 255)
  lg.setFont(resources.imagefonts.pixelShadowed)
  lg.printf(love.timer.getFPS() .. ' fps', screen.sw() - 84, 4, 80, 'right')
  lg.printf('x' .. screen.scale(), screen.sw() - 84, 16, 80, 'right')
  lg.setCanvas()
  
  lg.setColor(255, 255, 255)
  local scale = screen.scale()
  lg.draw(screen.canvas,
    screen.w() / 2 - screen.canvas:getWidth() * scale / 2,
    screen.h() / 2 - screen.canvas:getHeight() * scale / 2, 0, scale)
end