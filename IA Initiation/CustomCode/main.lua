-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

-- divise taille ecran par deux car on a zoomé *2 dans le draw avec love.graphics.scale(2,2)
local screenWidth = love.graphics.getWidth() / 2
local screenHeight = love.graphics.getHeight() /2

local lstSprites = {}

local human = {}

local ZSTATES = {}
ZSTATES.NONE = ""
ZSTATES.WALK = "walk"
ZSTATES.ATTACK = "attack"
ZSTATES.BITE = "bite"
ZSTATES.CHANGEDIR = "changedir"

local imgAlert = love.graphics.newImage("images/alert.png")

function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

function math.angle(x1,y1, x2,y2) return math.atan2(y2-y1, x2-x1) end

function CreateZombie()
    local zombie = CreateSprite(lstSprites, "zombie", "monster_", 2)
    zombie.x = math.random(10, screenWidth-10)
    zombie.y = math.random(10, screenHeight/2-10)
    zombie.state = ZSTATES.NONE
    zombie.speed = math.random(5,50)*0.5
    zombie.range = math.random(10,150)
    zombie.target = nil
    zombie.bite_range = 5
    zombie.damage = 0.1

   
end

function UpdateZombie(pZombie, pEntities)
    if pZombie.state == ZSTATES.NONE then
        pZombie.state = ZSTATES.CHANGEDIR
    elseif pZombie.state == ZSTATES.WALK then
        local bCollide = false
        if pZombie.x < 0 then
            pZombie.x = 0
            bCollide = true
        end
        if pZombie.x > screenWidth then
            pZombie.x = screenWidth
            bCollide = true
        end
        if pZombie.y < 0 then
            pZombie.y = 0
            bCollide = true
        end
        if pZombie.y > screenHeight then
            pZombie.y = screenHeight
            bCollide = true
        end
        if bCollide then
            pZombie.state = ZSTATES.CHANGEDIR
        end

        --look for huumans
        for i, sprite in ipairs(pEntities) do
            if sprite.type == "human" then
                local distance = math.dist(pZombie.x, pZombie.y, sprite.x, sprite.y)
                if distance < pZombie.range and sprite.visible == true then
                    pZombie.state = ZSTATES.ATTACK
                    pZombie.target = sprite
                end
            end
        end
    elseif pZombie.state == ZSTATES.ATTACK then

        local destX, destY
        destX = math.random(pZombie.target.x - 10, pZombie.target.x + 10)
        destY = math.random(pZombie.target.y - 10, pZombie.target.y + 10)
        local angle = math.angle(pZombie.x, pZombie.y, destX,destY)

        pZombie.vx = pZombie.speed * math.cos(angle) * 2
        pZombie.vy = pZombie.speed * math.sin(angle) * 2

        if pZombie.target == nil then
            pZombie.state = ZSTATES.CHANGEDIR
        elseif math.dist(pZombie.x, pZombie.y, pZombie.target.x, pZombie.target.y) > pZombie.range and pZombie.target.type == "human" then
            pZombie.state = ZSTATES.CHANGEDIR
        elseif math.dist(pZombie.x, pZombie.y, pZombie.target.x, pZombie.target.y) < pZombie.bite_range then
            pZombie.vx = 0
            pZombie.vy = 0
            pZombie.state = ZSTATES.BITE
        end

    elseif pZombie.state == ZSTATES.BITE then
        if math.dist(pZombie.x, pZombie.y, pZombie.target.x, pZombie.target.y) > pZombie.bite_range then
            pZombie.state = ZSTATES.ATTACK
        else
            if pZombie.target.hurt then
                pZombie.target.hurt(pZombie.damage)
            end
            if pZombie.target.visible == false then
                pZombie.state = ZSTATES.CHANGEDIR
            end
        end
    elseif pZombie.state == ZSTATES.CHANGEDIR then
        local angle = math.angle(pZombie.x, pZombie.y, math.random(0, screenWidth), math.random(0, screenHeight))

        pZombie.vx = pZombie.speed * math.cos(angle)
        pZombie.vy = pZombie.speed * math.sin(angle)
        pZombie.state = ZSTATES.WALK
    end
end

function CreateSprite(pList, pType, psImageFile, pnFrame)
    local mySprite = {}
    mySprite.visible = true
    mySprite.type = pType
    mySprite.images =  {}
    mySprite.currentFrame = 1
    for i=1,pnFrame do
        local fileName = "images/"..psImageFile..tostring(i)..".png"
        mySprite.images[i] = love.graphics.newImage(fileName)
    end

    mySprite.x = 0
    mySprite.y = 0
    mySprite.vx = 0
    mySprite.vy = 0

    mySprite.width = mySprite.images[1]:getWidth()
    mySprite.height = mySprite.images[1]:getHeight()

    table.insert(pList, mySprite)
    return mySprite
end

function CreateHuman()
    local human = CreateSprite(lstSprites, "human", "player_", 4)
    human.x = screenWidth * 0.5
    human.y = screenHeight * 0.8
    human.speed = 100
    human.health = 100
    human.hurt = function(damage)
        human.health = human.health - damage
        if human.health <= 0 then
            human.health = 0
            human.visible = false
        end
    end
    return human
end


function love.load()
    math.randomseed(os.time())
    human = CreateHuman()

    for nZombie = 1,100 do
        CreateZombie()
    end
    
end

function love.update(dt)
    for i, sprite in ipairs(lstSprites) do
        sprite.currentFrame = sprite.currentFrame + 5*dt
        if sprite.currentFrame >= #sprite.images + 1 then
            sprite.currentFrame = 1
        end

        sprite.x = sprite.x + sprite.vx * dt
        sprite.y = sprite.y + sprite.vy * dt
        
        if sprite.type == "zombie" then
            UpdateZombie(sprite, lstSprites)
        end
    end

    if love.keyboard.isDown("d") then
        human.x = human.x + human.speed * dt
    end
    if love.keyboard.isDown("q") then
        human.x = human.x - human.speed * dt
    end
    if love.keyboard.isDown("z") then
        human.y = human.y - human.speed * dt
    end
    if love.keyboard.isDown("s") then
        human.y = human.y + human.speed * dt
    end
end

function love.draw()
    love.graphics.push()
    love.graphics.print("HEALTH: "..tostring(math.floor(human.health)), 1, 1)
    love.graphics.scale(2,2)
    for i, sprite in ipairs(lstSprites) do
        local frame = sprite.images[math.floor(sprite.currentFrame)]
        if sprite.visible == true then
            love.graphics.draw(frame, sprite.x, sprite.y, 0, 1, 1, sprite.width * 0.5, sprite.height * 0.5)

            if sprite.type == "zombie" then
                if sprite.state == ZSTATES.ATTACK then
                    love.graphics.draw(imgAlert, sprite.x-imgAlert:getWidth()*0.5, sprite.y-sprite.height-2)
                end
                if love.keyboard.isDown("f") then
                    love.graphics.print(sprite.state, sprite.x-10, sprite.y-sprite.height - 10)
                end
            end
        end
    end
    love.graphics.pop()
end

function love.keypressed(key)
end
