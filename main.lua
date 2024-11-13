-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

Pad = {}
Margin = 10
Pad.x = Margin
Pad.y = Margin
Pad.width = 20
Pad.height = 80
Pad.speed = 5
Pad.score = 0

Pad_2 = {}
Pad_2.x = Margin
Pad_2.y = Margin
Pad_2.width = 20
Pad_2.height = 80
Pad_2.speed = 5
Pad_2.score = 0

Ball = {}
Ball.x = 400
Ball.y = 300
Ball.width = 20
Ball.height = 20
Ball.vitesse_x = 10
Ball.vitesse_y = 10

Monitor_height = 0
Monitor_width = 0

function CentreBall()
    Ball.x = Monitor_width / 2
    Ball.x = Ball.x - Ball.width / 2
    Ball.y = Monitor_height / 2
    Ball.y = Ball.y - Ball.height / 2
    Ball.vitesse_x = 5
    Ball.vitesse_y = -5
end

function InitPads()
    Pad.x = Margin
    Pad.y = Margin
    Pad_2.x = Monitor_width - Margin - Pad_2.width
    Pad_2.y = Margin
end

function love.load()
    Monitor_height = love.graphics.getHeight()
    Monitor_width = love.graphics.getWidth()
    CentreBall()
    InitPads()
    Font = love.graphics.newFont(12)  -- Choose your font size
    love.graphics.setFont(Font)
end

function love.update(dt)
    if Ball.x < 0 then
        Pad_2.score = Pad_2.score + 1
        CentreBall()
        --Ball.vitesse_x = Ball.vitesse_x * -1
        -- ou : Ball.vitesse_x = -Ball.vitesse_x
    end
    if Ball.y < 0 then
        Ball.vitesse_y = Ball.vitesse_y * -1
    end
    if Ball.x > Monitor_width - Ball.width then
        Pad.score = Pad.score + 1
        CentreBall()
        --Ball.vitesse_x = Ball.vitesse_x * -1
    end
    if Ball.y > Monitor_height- Ball.height then
        Ball.vitesse_y = Ball.vitesse_y * -1
    end

    -- Check Left Pad
    if Ball.x < Pad.x + Pad.width and Pad.y < Ball.y + Ball.height and Ball.y < Pad.y + Pad.height then
        Ball.vitesse_x = Ball.vitesse_x * -1
        -- Positionne la balle au bord de la raquette
        Ball.x = Pad.x + Pad.width
    end

    -- Check Right Pad
    if Ball.x + Ball.width > Pad_2.x  and Pad_2.y < Ball.y + Ball.height and Ball.y < Pad_2.y + Pad_2.height then
        Ball.vitesse_x = Ball.vitesse_x * -1
        -- Positionne la balle au bord de la raquette
        Ball.x = Pad_2.x - Ball.width
    end


    if love.keyboard.isDown("down") and Pad.y < Monitor_height - Pad.height - Margin then
        Pad.y = Pad.y + Pad.speed
    end
    if love.keyboard.isDown("up") and Pad.y > Margin then
        Pad.y = Pad.y - Pad.speed
    end

    if love.keyboard.isDown("s") and Pad_2.y < Monitor_height - Pad_2.height - Margin then
        Pad_2.y = Pad_2.y + Pad_2.speed
    end
    if love.keyboard.isDown("z") and Pad_2.y > Margin then
        Pad_2.y = Pad_2.y - Pad_2.speed
    end



    Ball.x = Ball.x + Ball.vitesse_x
    Ball.y = Ball.y + Ball.vitesse_y
end

function love.draw()
    love.graphics.rectangle("fill", Pad.x, Pad.y, Pad.width, Pad.height)
    love.graphics.rectangle("fill", Pad_2.x, Pad_2.y, Pad_2.width, Pad_2.height)
    -- Dessin de la Ball
    love.graphics.rectangle("fill", Ball.x, Ball.y, Ball.width, Ball.height)
    love.graphics.line(Monitor_width/2, 0, Monitor_width/2, Monitor_height)
    local score = Pad.score.."   "..Pad_2.score
    local textWidth = Font:getWidth(score)
    love.graphics.print(score, Monitor_width/2-textWidth, 10, 0, 2)


end

function love.keypressed(key)
end
