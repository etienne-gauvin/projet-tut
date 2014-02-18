local image = resources.images.entities.mainCharacter.walkSpriteSheet
local grid = core.anim8.newGrid(48, 96, image:getWidth(), image:getHeight())

local animationLeft = core.anim8.newAnimation(grid('6-1',1), 0.15)
local animationRight = core.anim8.newAnimation(grid('1-6',2), 0.15)

return {
  left = animationLeft,
  right = animationRight
}
