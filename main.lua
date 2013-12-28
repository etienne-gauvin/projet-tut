-- Bibliothèques
require 'core/libs/middleclass'

-- Raccourcis accessibles sur toutes les pages
Vector = require 'core/libs/vector'
lg = love.graphics
lk = love.keyboard

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
  if key == 'escape' then
    love.event.quit()
  end
end
