-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

local Lander =  {}
Lander.x = 0
Lander.y = 0
Lander.angle = -90
Lander.vx = 0
Lander.vy = 0
Lander.speed = 3
Lander.img = love.graphics.newImage("images/ship.png")
Lander.imgEngine = love.graphics.newImage("images/engine.png")
Lander.engineOn = false
function love.load()
    Largeur = love.graphics.getWidth()
    Hauteur = love.graphics.getHeight()
    Lander.x = Largeur/2
    Lander.y = Hauteur / 2
end

function love.update(dt)
    -- Vertical Gravity
    Lander.vy = Lander.vy + 0.6 * dt

    if love.keyboard.isDown("d") then
        Lander.angle = Lander.angle + 100 * dt
    end
    if love.keyboard.isDown("q") then
        Lander.angle = Lander.angle - 100* dt
    end
    if love.keyboard.isDown("z") then
        Lander.engineOn = true
        local angle_radian = math.rad(Lander.angle)
        local force_x = math.cos(angle_radian) * Lander.speed * dt
        local force_y = math.sin(angle_radian) * Lander.speed * dt
        Lander.vx = Lander.vx + force_x
        Lander.vy = Lander.vy + force_y
        --Lander.vx = Lander.vx + math.cos(math.rad(Lander.angle)) * 2 * dt
        --Lander.vy = Lander.vy + math.sin(math.rad(Lander.angle)) * 2 * dt
    else
        --if Lander.vx > 0 then
        --    Lander.vx = math.max(Lander.vx - 0.2 * dt,0)
        --else
        --    Lander.vx = math.min(Lander.vx + 0.2 * dt,0)
        --end
        Lander.engineOn = false
    end
    if love.keyboard.isDown("w") then
        
    end


    Lander.x = Lander.x + Lander.vx
    Lander.y = Lander.y + Lander.vy
end

function love.draw()
    love.graphics.draw(Lander.img, Lander.x, Lander.y,
        math.rad(Lander.angle), 1, 1, Lander.img:getWidth()/2, Lander.img:getHeight()/2)
    if Lander.engineOn == true then
        love.graphics.draw(Lander.imgEngine, Lander.x, Lander.y,
        math.rad(Lander.angle), 1, 1, Lander.imgEngine:getWidth()/2, Lander.imgEngine:getHeight()/2)
    end
end

function love.keypressed(key)
end
