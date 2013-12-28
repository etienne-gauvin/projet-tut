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
local WorldLayer = require 'core/world-layer'

-- Chargement initial
function love.load()
  
  -- Chargement des fichiers, et des variables globales game, resources et screen
  core.load()
  
  -- Calques du jeu
  game.l = {
    world = WorldLayer:new('world', game.camera),
    hud = Layer:new('hud')
  }
  
  -- Ajout des calques
  core.layers:addSubLayer(game.l.world)
  core.layers:addSubLayer(game.l.hud)
  
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
  if key == 'escape' then
    love.event.quit()
  end
end
