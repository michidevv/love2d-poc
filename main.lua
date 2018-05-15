require('lib/Utils')
require('src/Animation')

function love.load()
  love.graphics.setDefaultFilter('nearest')

  image = love.graphics.newImage('res/noether.png')
  characterSprite = {
    up = GenerateQuads(image, 4, {x = 0, y = 0, w = 16, h = 16,}),
    right = GenerateQuads(image, 4, {x = 0, y = 16, w = 16, h = 16,}),
    down = GenerateQuads(image, 4, {x = 0, y = 32, w = 16, h = 16,}),
    left = GenerateQuads(image, 4, {x = 0, y = 48, w = 16, h = 16,}),
  }
  direction = 'up'
  characterX = 300
  characterY = 300
  characterVelocity = 60

  characterStates = {
    up = 'walk',
    right = 'walk',
    down = 'walk',
    left = 'walk',
    space = 'attack',
  }

  characterState = 'idle'

  characterAnimation = {
    idle = Animation {
      frames = {1},
      delay = 0,
    },
    walk = Animation {
      frames = {1, 2, 3, 4},
      delay = 0.3,
    },
    attack = nil, -- TODO: Implement.
  }

  love.keyboard.keypressed = {}
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end

  local s = characterStates[key]
  characterState = s ~= nil and s or characterState

  love.keyboard.keypressed[key] = true
end

function love.keyboard.isKeyPressed(key)
  return love.keyboard.keypressed[key]
end

function love.update(dt)
  characterAnimation[characterState]:update(dt)


  if love.keyboard.isDown('up') then
    direction = 'up'
    characterY = characterY - characterVelocity * dt
  elseif love.keyboard.isDown('right') then
    direction = 'right'
    characterX = characterX + characterVelocity * dt
  elseif love.keyboard.isDown('down') then
    direction = 'down'
    characterY = characterY + characterVelocity * dt
  elseif love.keyboard.isDown('left') then
    direction = 'left'
    characterX = characterX - characterVelocity * dt
  else
    characterState = 'idle'
  end

  love.keyboard.keypressed = {}
end

function love.draw()
  love.graphics.draw(
    image,
    characterSprite[direction][characterAnimation[characterState]:getFrame()],
    math.floor(characterX),
    math.floor(characterY),
    0, 3, 3)
end
