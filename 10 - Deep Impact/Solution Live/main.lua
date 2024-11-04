-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

gameover = false

ship = {}
meteores = {}
images_meteores = {}
timer_meteores = 0
frequence_meteores = 5
timer_difficulte = 0

function CheckCollision(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + h1
end

-- Returns the distance between two points.
function math.dist(x1, y1, x2, y2)
    return ((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ^ 0.5
end

function drawImage(pImg, pX, pY)
    local ox = pImg:getWidth() / 2
    local oy = pImg:getHeight() / 2
    love.graphics.draw(pImg, pX, pY, 0, 1, 1, ox, oy)
end

function Init()
    gameover = false

    frequence_meteores = 5

    ship.image = love.graphics.newImage("images/ship.png")
    ship.imgLaser = love.graphics.newImage("images/laser.png")
    ship.energie = 10
    ship.vies = 3
    ship.tirs = {}
    ship.x = love.graphics.getWidth() / 2
    ship.y = love.graphics.getHeight() - ship.image:getHeight() / 2

    images_meteores[1] = love.graphics.newImage("images/meteor1.png")
    images_meteores[2] = love.graphics.newImage("images/meteor2.png")
    images_meteores[3] = love.graphics.newImage("images/meteor3.png")

    meteores = {}
end

function PerdEnergie()
    ship.energie = ship.energie - 1
    if ship.energie == 0 then
        ship.energie = 10
        PerdVie()
    end
end

function PerdVie()
    ship.vies = ship.vies - 1
    if ship.vies == 0 then
        gameover = true
    end
end

function AjouteTir(pX, pY)
    if #ship.tirs < 2 then
        local tir = {}
        tir.x = pX
        tir.y = pY
        tir.vy = -300
        table.insert(ship.tirs, tir)
    end
end

function AjouteMeteore()
    local meteore = {}

    meteore.taille = love.math.random(1, 3)
    local largeur = images_meteores[meteore.taille]:getWidth()
    local hauteur = images_meteores[meteore.taille]:getHeight()
    meteore.x = love.math.random(largeur / 2, largeur_ecran - largeur / 2)
    meteore.y = 0 - hauteur / 2
    meteore.vy = love.math.random(30, 60)
    table.insert(meteores, meteore)
end

function love.load()
    largeur_ecran = love.graphics.getWidth()
    hauteur_ecran = love.graphics.getHeight()
    Init()
end

function UpdateJeu(dt)
    --[[
    if love.keyboard.isDown("left") and ship.x > 0 then
        ship.x = ship.x - 120 * dt
    end
    if love.keyboard.isDown("right") and ship.x < largeur_ecran then
        ship.x = ship.x + 120 * dt
    end
    ]]
    local mx, my = love.mouse.getPosition()
    ship.x = mx

    -- Difficulté
    timer_difficulte = timer_difficulte + dt
    if timer_difficulte >= 10 then
        timer_difficulte = 0
        if frequence_meteores > 1 then
            frequence_meteores = frequence_meteores - 0.1
        end
    end

    -- Mise à jour des projectiles
    for n = #ship.tirs, 1, -1 do
        local t = ship.tirs[n]
        t.y = t.y + t.vy * dt
        if t.y < 0 - ship.imgLaser:getHeight() / 2 then
            table.remove(ship.tirs, n)
        else
            for m = #meteores, 1, -1 do
                local meteore = meteores[m]
                local lm = images_meteores[meteore.taille]:getWidth()
                local hm = images_meteores[meteore.taille]:getHeight()
                if
                    CheckCollision(
                        meteore.x - lm / 2,
                        meteore.y - hm / 2,
                        lm,
                        hm,
                        t.x - ship.imgLaser:getWidth() / 2,
                        t.y - ship.imgLaser:getHeight() / 2,
                        ship.imgLaser:getWidth(),
                        ship.imgLaser:getHeight()
                    )
                 then
                    table.remove(ship.tirs, n)
                    table.remove(meteores, m)
                end
            end
        end
    end

    -- Mise à jour des météores
    timer_meteores = timer_meteores + dt
    if timer_meteores >= frequence_meteores then
        timer_meteores = 0
        AjouteMeteore()
    end
    for n = #meteores, 1, -1 do
        local m = meteores[n]
        local lm = images_meteores[m.taille]:getWidth()
        local hm = images_meteores[m.taille]:getHeight()
        m.y = m.y + m.vy * dt
        if m.y - hm / 2 > hauteur_ecran then
            PerdEnergie()
            table.remove(meteores, n)
        else
            if math.dist(ship.x, ship.y, m.x, m.y) < lm / 2 then
                table.remove(meteores, n)
                PerdVie()
            end
        end
    end
end

function love.update(dt)
    if gameover == false then
        UpdateJeu(dt)
    end
end

function love.draw()
    for k, v in pairs(ship.tirs) do
        drawImage(ship.imgLaser, v.x, v.y)
    end

    drawImage(ship.image, ship.x, ship.y)

    for k, v in pairs(meteores) do
        drawImage(images_meteores[v.taille], v.x, v.y)
    end

    if gameover == false then
        love.graphics.print("Energie : " .. tostring(ship.energie) .. " - Vies : " .. tostring(ship.vies))
        love.graphics.print("Frequence : " .. tostring(frequence_meteores), 0, 15)
    else
        love.graphics.print("GAME OVER !")
    end
end

function love.keypressed(key)
    if key == "space" and gameover == false then
        AjouteTir(ship.x, ship.y - ship.image:getHeight() / 2)
    end
    if key == "return" and gameover == true then
        Init()
    end
end

function love.mousepressed(b, x, y)
    if gameover == false then
        AjouteTir(ship.x, ship.y - ship.image:getHeight() / 2)
    end
end
