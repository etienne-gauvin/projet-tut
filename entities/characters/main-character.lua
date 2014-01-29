local Character = require 'entities/character'
local MainCharacter = Character:subclass('MainCharacter')

-- Initialisation
function MainCharacter:initialize(x, y)
  Character.initialize(self, x, y)
  
  -- Dimensions du perso principal
  self.width = 38
  self.height = 88
  
  -- Vitesse
  self.walkSpeed = 150
  
  -- Raccourci vers les images
  self.images = {
    stand = resources.images.entities.mainCharacter.standSpriteSheet
  }
  
  -- Copie des animations nécessaires
  self.anims = {
    stand = {
      left = game.anims.mainCharacter.stand.left:clone(),
      right = game.anims.mainCharacter.stand.right:clone()
    }
  }
  
  -- hitbox
  self.hitbox = {}
  self.hitbox.body = physics.newBody(game.world, self.pos.x + self.width / 2, self.pos.y + self.height / 2, 'dynamic')
  self.hitbox.body:setFixedRotation(true)
  self.hitbox.shape = physics.newRectangleShape(self.width, self.height)
  self.hitbox.fixture = physics.newFixture(self.hitbox.body, self.hitbox.shape)
  
end

-- Mise à jour
function MainCharacter:update(dt)
  Character.update(self, dt)
  
  self.anims[self.anim][self.direction]:update(dt)
  
  local body = self.hitbox.body
  
  if keyboard.isDown('right') then
    body:setPosition(body:getX() + self.walkSpeed * dt, body:getY())
  end

  if keyboard.isDown('left') then
    body:setPosition(body:getX() - self.walkSpeed * dt, body:getY())
  end
end

-- Affichage
function MainCharacter:draw()
  Character.draw(self)
  
  -- Afficher l'animation en bas et centré en largeur
  graphics.setColor(255, 255, 255)
  self.anims[self.anim][self.direction]:draw(self.images[self.anim],
    self.pos.x + self.width / 2 - 48 / 2, self.pos.y + self.height - 96)
  
end

return MainCharacter