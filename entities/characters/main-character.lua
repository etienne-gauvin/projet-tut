local Character = require 'entities/character'
local Feet = require 'entities/feet'
local Block = require 'entities/block'
local MainCharacter = Character:subclass('MainCharacter')

-- Initialisation
function MainCharacter:initialize(x, y)
  Character.initialize(self, x, y)
  
  -- Dimensions du perso principal
  self.width = 32
  self.height = 88
  
  -- Vitesse
  self.walkAcceleration = 800
  self.walkSpeed = 300
  
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
  self.body = physics.newBody(game.world, self.pos.x + self.width / 2, self.pos.y + self.height / 2, 'dynamic')
  self.body:setFixedRotation(true)
  
  local w, h = self.width, self.height
  local pts = {0,0, w,0, w,h-1, w-4,h, 4,h, 0,h-1}
  
  for i = 1, #pts, 2 do
    pts[i] = pts[i] - w / 2
    pts[i + 1] = pts[i + 1] - h / 2
  end
  
  self.shape = physics.newPolygonShape(unpack(pts))
  self.fixture = physics.newFixture(self.body, self.shape)
  self.fixture:setUserData({entity = self})
  
  self.feet = Feet:new(self)
end

-- Mise à jour
function MainCharacter:update(dt)
  Character.update(self, dt)
  
  self.anims[self.anim][self.direction]:update(dt)
  
  local body = self.body
  local velx, vely = body:getLinearVelocity()
  
  -- Aller à droite
  if keyboard.isDown('right') then
    velx = velx + self.walkAcceleration * dt
  
  -- Aller à gauche
  elseif keyboard.isDown('left') then
    velx = velx - self.walkAcceleration * dt
  
  -- Ralentissement
  else
    velx = velx / 1.5
  end
  
  if velx > self.walkSpeed then
    velx = self.walkSpeed
  elseif velx < - self.walkSpeed then
    velx = - self.walkSpeed
  end
  
  -- Application de la vélocité
  self.body:setLinearVelocity(velx, vely)
  
  -- Saut
  if keyboard.isDown('up') then
    if not self.isJumping and self.feet:collidesWithA(Block) then
      body:applyLinearImpulse(0, -100)
    end
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