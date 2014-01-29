-- Bibliothèques & raccoucis
local class = require 'core/libs/middleclass'
Object = class.Object
Vector = require 'core/libs/vector'
Color = require 'core/libs/color'
graphics = love.graphics
keyboard = love.keyboard
physics = love.physics
mouse = love.mouse

-- Coeur du jeu
core = require 'core'

-- Chargement initial
function love.load()
  
  -- Chargement des fichiers, et des variables globales game, resources et screen
  print('-- Chargement...')
  local stime = love.timer.getTime()
  core.load()
  
  -- Affichage du temps de chargement
  local etime = love.timer.getTime()
  print(string.format("-- Chargement terminé (%.3fs)", etime - stime))
  print("")
  
  -- Démarrage du jeu
  print("-- Démarrage du jeu")
  core.stateHandler.current:start()
end

-- Mise à jour
function love.update(dt)
  core.update(dt)
end

-- Affichage
function love.draw()
  core.draw()
end

-- Gestion des évènements clavier
function love.keypressed(key)
  core.keypressed(key)
end

-- Gestion des évènements clavier
function love.keyreleased(key)
  core.keyreleased(key)
end

-- Gestion des clics
function love.mousepressed(x, y, button)
  core.mousepressed(x, y, button)
end

-- Gestion des clics
function love.mousereleased(x, y, button)
  core.mousereleased(x, y, button)
end