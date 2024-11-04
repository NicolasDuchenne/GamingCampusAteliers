-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

nombrePV = 5
imgCoeurGauche = nil
imgCoeurDroite = nil
timer = 0

function love.load()
    imgCoeurGauche = love.graphics.newImage("images/coeur_gauche.png")
    imgCoeurDroite = love.graphics.newImage("images/coeur_droite.png")
end

function AffichePV(pX, pY)
    local x = pX
    local y = pY
    local largeur = imgCoeurGauche:getWidth()
    -- 1 2 3 4 5
    for n = 1, nombrePV do
        local bImpair = (n % 2) ~= 0
        if bImpair then
            love.graphics.draw(imgCoeurGauche, x, y)
        else
            love.graphics.draw(imgCoeurDroite, x, y)
        end
        if bImpair == false then
            x = x + largeur
        end
    end
end

function love.update(dt)
    timer = timer + dt * 2
    if timer > 2 then
        timer = 0
    end
end

function love.draw()
    love.graphics.print(timer, 200, 1)
    local bAffiche = true
    if nombrePV == 1 then
        if math.floor(timer) == 0 then
            bAffiche = false
        end
    end
    if bAffiche then
        AffichePV(1, 1)
    end
end

function love.keypressed(key)
    nombrePV = nombrePV - 1
end
