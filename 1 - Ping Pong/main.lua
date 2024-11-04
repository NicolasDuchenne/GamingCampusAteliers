-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

Characters = {}

Image = love.graphics.newImage("images/marche1.png")


function CreateCharacter(y, speed)
    local character = {}
    character.speed = speed
    character.img = {}
    table.insert(character.img,love.graphics.newImage("images/marche1.png"))
    table.insert(character.img,love.graphics.newImage("images/marche2.png"))
    character.img_width = character.img[1]:getWidth()
    character.img_height = character.img[1]:getHeight()
    character.ox = character.img_width/2
    character.oy = character.img_height/2   
    character.img_index = 1
    character.x_dir = 1
    character.last_update = 0
    character.frame_per_seconds = 5
    character.x = character.ox
    character.y = y
    character.vx = 1
    character.vy = 0
    return character
end


function MoveCharacter(character, dt)
    character.x = character.x + character.vx * character.speed * dt
    if character.x < character.ox then
        character.x =  character.ox
        character.vx = - character.vx
        character.x_dir = - character.x_dir
    elseif character.x + character.ox > Monitor_widht then
        character.x = Monitor_widht - character.ox
        character.vx = - character.vx
        character.x_dir = - character.x_dir
    end

    character.last_update = character.last_update + dt
    if character.last_update > 1/character.frame_per_seconds then 
        character.img_index = character.img_index + 1
        character.last_update = 0
        if character.img_index > #character.img   then
            character.img_index = 1
        end
    end
end

function DrawCharacter(character)
    love.graphics.draw(character.img[character.img_index], character.x, character.y, 0, character.x_dir, 1, character.ox, character.oy)
end


function love.load()
    ImageHeight = Image:getHeight()
    y = ImageHeight/2
    Monitor_widht = love.graphics.getWidth()
    Monitor_Height = love.graphics.getHeight()
    while y < Monitor_Height do
        local speed = math.random(100,300)
        table.insert(Characters, CreateCharacter(y, speed))
        y = y + ImageHeight

    end
    
end

function love.update(dt)
    for i, character in ipairs(Characters) do
        MoveCharacter(character, dt)
    end
end

function love.draw()
    for i, character in ipairs(Characters) do
        DrawCharacter(character)
    end
end

function love.keypressed(key)
end
