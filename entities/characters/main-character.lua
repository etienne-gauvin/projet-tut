local Character = require 'entities/character'
local MainCharacter = Character:subclass('MainCharacter')

-- Initialisation
function MainCharacter:initialize(x, y)
  Character.initialize(self, x, y)
  
  -- Dimensions du perso principal
  self.width = 38
  self.height = 88
  
  -- Vitesse
  self.walkAcceleration = 400
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
  self.hitbox = {}
  self.hitbox.body = physics.newBody(game.world, self.pos.x + self.width / 2, self.pos.y + self.height / 2, 'dynamic')
  self.hitbox.body:setFixedRotation(true)
  
  local w, h = self.width, self.height
  local pts = {0,0, w,0, w,h-1, w-4,h, 4,h, 0,h-1}
  
  for i = 1, #pts, 2 do
    pts[i] = pts[i] - w / 2
    pts[i + 1] = pts[i + 1] - h / 2
  end
  
  self.hitbox.shape = physics.newPolygonShape(unpack(pts))
  self.hitbox.fixture = physics.newFixture(self.hitbox.body, self.hitbox.shape)
  self.hitbox.fixture:setFriction(0)
  
end

-- Mise à jour
function MainCharacter:update(dt)
  Character.update(self, dt)
  
  self.anims[self.anim][self.direction]:update(dt)
  
  local body = self.hitbox.body
  local velx, vely = body:getLinearVelocity()
  print(math.floor(velx), math.floor(vely))
  
  -- Aller à droite
  if keyboard.isDown('right') then
    velx = velx + self.walkAcceleration * dt
  
  -- Aller à gauche
  elseif keyboard.isDown('left') then
    velx = velx - self.walkAcceleration * dt
  
  -- Ralentissement
  else
    velx = velx / 1.2
  end
  
  if velx > self.walkSpeed then
    velx = self.walkSpeed
  elseif velx < - self.walkSpeed then
    velx = - self.walkSpeed
  end
  
  -- Application de la vélocité
  self.hitbox.body:setLinearVelocity(velx, vely)
  
  -- Saut
  if keyboard.isDown('up') then
    body:applyLinearImpulse(0, -20)
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