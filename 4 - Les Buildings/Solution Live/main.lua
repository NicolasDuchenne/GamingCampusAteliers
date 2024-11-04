-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

listeBuildings = {}
imgBuilding = nil

function GenereBuildings()
    for n = 1, 10 do
        local nombre = love.math.random(1, 40)
        local b = {}
        b.nombre = nombre
        b.offset = 0
        table.insert(listeBuildings, b)
    end
end

function love.load()
    imgBuilding = love.graphics.newImage("images/etage.png")
    GenereBuildings()
end

function love.update(dt)
    for n = 1, #listeBuildings do
        local b = listeBuildings[n]
        if b.offset < 10 then
            b.offset = b.offset + (dt * 100) / b.nombre
        else
            b.offset = 10
        end
    end
end

function love.draw()
    local x = 50
    local y = 0
    for n = 1, #listeBuildings do
        y = 550
        for e = 1, listeBuildings[n].nombre do
            love.graphics.draw(imgBuilding, x, y)
            y = y - listeBuildings[n].offset
        end
        love.graphics.print(listeBuildings[n].offset, x, y - 20)
        x = x + 70
    end
end

function love.keypressed(key)
end
