-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

Characters = {}

require("character")


function love.load()
    math.randomseed(os.time())
    Monitor_Widht = love.graphics.getWidth()
    Monitor_Height = love.graphics.getHeight()
    for i=0,10 do
        local speed = math.random(100,600)
        local x = math.random(0, Monitor_Widht)
        local y = math.random(0, Monitor_Height)
        local vx = math.random()
        local vy = math.random()
        local character = newCharacter(x, y, vx, vy, speed)
        table.insert(Characters, character)
    end
    
end

function love.update(dt)
    for i, character in ipairs(Characters) do
        character.update(dt)
        local other_characters = {}
        for j, box in ipairs(Characters) do
            if box ~= character then
                table.insert(other_characters, box)
            end
        end
        for _, otherBox in ipairs(other_characters) do
            local collisionFace, overlapX, overlapY = character.getCollisionFace(otherBox)
            if collisionFace then
                character.process_collision(collisionFace,overlapX, overlapY)
            end
        end
    end
    
end

function love.draw()
    for i, character in ipairs(Characters) do
        character.draw()
    end
end

function love.keypressed(key)
end
