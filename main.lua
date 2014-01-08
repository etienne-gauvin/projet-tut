-- Bibliothèques
require 'core/libs/middleclass'

-- Raccourcis accessibles sur toutes les pages
Vector = require 'core/libs/vector'
Color = require 'core/libs/color'
graphics = love.graphics
keyboard = love.keyboard
mouse = love.mouse

-- Coeur du jeu
core = require 'core'

-- Chargement initial
function love.load()
  
  -- Chargement des fichiers, et des variables globales game, resources et screen
  core.load()
  
  -- Démarrage du jeu
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

-- Gestion des clics
function love.mousepressed(x, y, button)
  core.mousepressed(x, y, button)
end