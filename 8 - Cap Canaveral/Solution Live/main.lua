-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

fusee = {}

etapes = {}
etapes[1] = "Evacuez la tour"
etapes[2] = "Préparez le pas de tir"
etapes[3] = "Retrait des bras cryogéniques"
etapes[4] = "Lancez les moteurs"
etapes[5] = "Décollage"

etape_courante = 1
compte_a_rebours = 40

lstParticules = {}

function CreeParticuleReacteur()
    local p = {}
    p.x = (largeur_ecran / 2) - love.math.random(-20, 20)
    p.y = fusee.y + fusee.image:getHeight() - 15
    p.vx = love.math.random(-150, 150)
    p.vy = love.math.random(70, 150)
    p.alpha = love.math.random()
    p.r = love.math.random(5, 30)
    p.red = love.math.random(0.5, 1)
    table.insert(lstParticules, p)
end

function love.load()
    hauteur_ecran = love.graphics.getHeight()
    largeur_ecran = love.graphics.getWidth()
    fusee.image = love.graphics.newImage("images/fusee.png")
    fusee.image_reacteur = love.graphics.newImage("images/reacteur.png")
    fusee.y = hauteur_ecran - fusee.image:getHeight()
    fusee.x = (largeur_ecran - fusee.image:getWidth()) / 2
    fusee.vy = 1
end

function love.update(dt)
    compte_a_rebours = compte_a_rebours - dt * 5
    if compte_a_rebours <= 0 and etape_courante ~= 5 then
        etape_courante = 5
    elseif compte_a_rebours <= 10 and compte_a_rebours > 0 and etape_courante ~= 4 then
        etape_courante = 4
    elseif compte_a_rebours <= 20 and compte_a_rebours > 10 and etape_courante ~= 3 then
        etape_courante = 3
    elseif compte_a_rebours <= 30 and compte_a_rebours > 20 and etape_courante ~= 2 then
        etape_courante = 2
    end

    if etape_courante >= 4 then
        for n = 1, 10 do
            CreeParticuleReacteur()
        end
    end

    if etape_courante == 5 then
        if fusee.y + fusee.image:getHeight() > -500 then
            fusee.y = fusee.y - fusee.vy * dt
            fusee.vy = fusee.vy + 1
        end
    end

    for n = #lstParticules, 1, -1 do
        local p = lstParticules[n]
        p.y = p.y + p.vy * dt
        p.vy = p.vy - 1.5
        p.x = p.x + p.vx * dt
        p.alpha = p.alpha - 0.5 * dt
        if p.alpha <= 0 then
            table.remove(lstParticules, n)
        end
    end
end

function love.draw()
    love.graphics.print(math.floor(compte_a_rebours), 1, 1)
    love.graphics.print(etapes[etape_courante], 1, 25)
    love.graphics.draw(fusee.image, fusee.x, fusee.y)

    if fusee.y + fusee.image:getHeight() < 0 then
        love.graphics.print("Décollage réussi !", 1, 45)
    end

    -- Particules de fumée
    for k, v in pairs(lstParticules) do
        love.graphics.setColor(v.red, 0.2, 0.2, v.alpha / 2)
        love.graphics.circle("fill", v.x, v.y, v.r)
    end
    love.graphics.setColor(1, 1, 1, 1)

    -- Reacteur
    if etape_courante >= 4 then
        love.graphics.draw(
            fusee.image_reacteur,
            (largeur_ecran - fusee.image_reacteur:getWidth()) / 2,
            fusee.y + fusee.image:getHeight()
        )
    end
end

function love.keypressed(key)
end
