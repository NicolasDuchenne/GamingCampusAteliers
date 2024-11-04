-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

listeRect = {}
nombre = 1000

-- Collision detection function;
-- Returns true if two boxes overlap, false if they don't;
-- x1,y1 are the top-left coords of the first box, while w1,h1 are its width and height;
-- x2,y2,w2 & h2 are the same, but for the second box.
function CheckCollision(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + h1
end

function GenereRectangles(pNombre)
    local largeur = love.graphics.getWidth()
    local hauteur = love.graphics.getHeight()

    local compteur = 0
    local tentatives = 0
    while compteur ~= pNombre do
        local bValide = false
        local nbEssai = 0
        local essaisMax = 500
        while bValide == false do
            nbEssai = nbEssai + 1
            tentatives = tentatives + 1
            if nbEssai > essaisMax then
                print("Erreur nombre d'essais trop élevé ")
                break
            end
            local r = {}
            r.x = love.math.random(largeur)
            r.y = love.math.random(hauteur)
            r.l = love.math.random(1, 50)
            r.h = love.math.random(1, 50)
            r.color_r = love.math.random()
            r.color_v = love.math.random()
            r.color_b = love.math.random()
            bValide = true
            if r.x + r.l >= largeur then
                bValide = false
            end
            if r.y + r.h >= hauteur then
                bValide = false
            end
            for k, v in pairs(listeRect) do
                if CheckCollision(r.x, r.y, r.l, r.h, v.x, v.y, v.l, v.h) then
                    bValide = false
                end
            end
            if bValide then
                table.insert(listeRect, r)
                compteur = compteur + 1
            end
        end
        if nbEssai > essaisMax then
            print("Abandon")
            break
        end
    end
    print("Nombre de tentatives ", tentatives)
    print("Nombre de rectangles ", #listeRect)
end

function love.load()
    GenereRectangles(nombre)
end

function love.update(dt)
end

function love.draw()
    for k, v in pairs(listeRect) do
        love.graphics.setColor(v.color_r, v.color_v, v.color_b)
        love.graphics.rectangle("fill", v.x, v.y, v.l, v.h)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(k, v.x, v.y)
    end
end

function love.keypressed(key)
end

function love.mousepressed(x, y, b)
    for k, v in pairs(listeRect) do
        if x >= v.x and x <= v.x + v.l and y >= v.y and y <= v.y + v.h then
            print("Je clique sur le rectangle ", k)
        end
    end
end
