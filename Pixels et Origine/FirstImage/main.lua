local image
local x, y
local vitesse = 200
local rotation = 0
local vitesseRotation = 1 -- Radians par seconde

function love.load()
  image = love.graphics.newImage("images/personnage.png")
  x = 400
  y = 300
end

function love.update(dt)
  if love.keyboard.isDown("right") then
    x = x + vitesse * dt
  end
  if love.keyboard.isDown("left") then
    x = x - vitesse * dt
  end
  if love.keyboard.isDown("down") then
    y = y + vitesse * dt
  end
  if love.keyboard.isDown("up") then
    y = y - vitesse * dt
  end
  if love.keyboard.isDown("d") then
    rotation = rotation + vitesseRotation * dt
  end
  if love.keyboard.isDown("q") then
    rotation = rotation - vitesseRotation * dt
  end
end

function love.draw()
  love.graphics.draw(image, x, y, rotation, 1, 1, image:getWidth() / 2, image:getHeight() / 2)
end
