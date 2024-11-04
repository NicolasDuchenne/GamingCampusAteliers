-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf('no')

local Lander = {}
Lander.vx = 0
Lander.vy = 0
Lander.x = 0
Lander.y = 0
Lander.angle = -90
Lander.engineOn = false
Lander.img = love.graphics.newImage("ship.png")
Lander.imgEngine = love.graphics.newImage("engine.png")

function love.load()
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  
  Lander.x = largeur/2
  Lander.y = hauteur/2
end

function love.update(dt)
  Lander.vy = Lander.vy + 0.001*60*dt
  if love.keyboard.isDown("right") then
    Lander.angle = Lander.angle + 90 * dt
  end
  if love.keyboard.isDown("left") then
    Lander.angle = Lander.angle - 90 * dt
  end
  if love.keyboard.isDown("up") then
    local angle_radians = math.rad(Lander.angle)
    local force_x = math.cos(angle_radians) * (1 * dt)
    local force_y = math.sin(angle_radians) * (1 * dt)
    Lander.vx = Lander.vx + force_x
    Lander.vy = Lander.vy + force_y
    Lander.engineOn = true
  else
    Lander.engineOn = false
  end
  Lander.x = Lander.x + Lander.vx
  Lander.y = Lander.y + Lander.vy
end

function love.draw()
  love.graphics.draw(Lander.img, Lander.x, Lander.y, math.rad(Lander.angle), 1, 1, Lander.img:getWidth()/2, Lander.img:getHeight()/2)
  if Lander.engineOn then
    love.graphics.draw(Lander.imgEngine, Lander.x, Lander.y, math.rad(Lander.angle), 1, 1, Lander.imgEngine:getWidth()/2, Lander.imgEngine:getHeight()/2)
  end
end