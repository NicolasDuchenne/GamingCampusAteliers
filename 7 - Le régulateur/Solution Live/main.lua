-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

vitesse_courante = 0
vitesse_regulateur = 0
vitesse_max = 240

function love.load()
end

function love.update(dt)
    local dif = math.abs(vitesse_courante - vitesse_regulateur)

    if vitesse_courante < vitesse_regulateur then
        vitesse_courante = vitesse_courante + (dif) * dt
        if vitesse_courante > vitesse_regulateur then
        --vitesse_courante = vitesse_regulateur
        end
    elseif vitesse_courante > vitesse_regulateur then
        vitesse_courante = vitesse_courante - (dif) * dt
        if vitesse_courante < vitesse_regulateur then
        --vitesse_courante = vitesse_regulateur
        end
    end
    if dif < 0.05 then
        vitesse_courante = vitesse_regulateur
    end
end

function love.draw()
    love.graphics.print(vitesse_regulateur, 10, 10)
    love.graphics.print(vitesse_courante, 50, 10)

    local ratio_courant = vitesse_courante / vitesse_max
    local position_courant = 400 * ratio_courant

    local ratio_regulateur = vitesse_regulateur / vitesse_max
    local position_regulateur = 400 * ratio_regulateur

    -- Dessine le regulateur
    love.graphics.setColor(0.5, 1, 0)
    love.graphics.rectangle("fill", position_regulateur, 150, 10, 30)

    -- Dessine la vitesse max
    love.graphics.setColor(1, 0.5, 0)
    love.graphics.rectangle("fill", 400, 150, 10, 30)

    -- Dessine la vitesse courante
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", position_courant, 150, 10, 30)
end

function love.keypressed(key)
    if key == "up" and vitesse_regulateur < 240 then
        vitesse_regulateur = vitesse_regulateur + 10
    end
    if key == "down" and vitesse_regulateur >= 10 then
        vitesse_regulateur = vitesse_regulateur - 10
    end
end
