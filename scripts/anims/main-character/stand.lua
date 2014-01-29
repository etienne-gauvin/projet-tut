local image = resources.images.entities.mainCharacter.standSpriteSheet
local grid = core.anim8.newGrid(48, 96, image:getWidth(), image:getHeight())

local animationLeft = core.anim8.newAnimation(grid(1,1), 1)
local animationRight = core.anim8.newAnimation(grid(1,2), 1)

return {
  left = animationLeft,
  right = animationRight
}