-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

img = {}
listePersos = {}

function love.load()
    img[1] = love.graphics.newImage("images/marche1.png")
    img[2] = love.graphics.newImage("images/marche2.png")
    for n = 1, 10 do
        local p = {}
        p.x = img[1]:getWidth() / 2
        p.y = n * 50
        p.direction = 1
        p.frame = 1
        p.vitesse = love.math.random(40, 80)
        print(p.y)
        table.insert(listePersos, p)
    end
end

function love.update(dt)
    for n = 1, #listePersos do
        local p = listePersos[n]
        if p.direction == 1 then
            p.x = p.x + p.vitesse * dt
        else
            p.x = p.x - p.vitesse * dt
        end
        if p.x + img[1]:getWidth() / 2 >= love.graphics.getWidth() then
            p.direction = 2
        end
        if p.x <= img[1]:getWidth() / 2 then
            p.direction = 1
        end
        p.frame = p.frame + dt * 4
        if p.frame > 3 then
            p.frame = 1
        end
        print(p.frame)
    end
end

function love.draw()
    for n = 1, #listePersos do
        local p = listePersos[n]
        local sens = 1
        if p.direction == 2 then
            sens = -1
        end
        local i = math.floor(p.frame)
        love.graphics.draw(img[i], p.x, p.y, 0, sens, 1, img[1]:getWidth() / 2)
    end
end

function love.keypressed(key)
end
