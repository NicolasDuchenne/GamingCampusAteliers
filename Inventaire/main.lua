-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

Inventaire = {}

function AjouteALinventaire(pID, pEtat, pNiveau, pImage)
    local obj = {}
    obj.ID = pID
    obj.Etat = pEtat
    obj.Niveau = pNiveau
    obj.Image = pImage
    table.insert(Inventaire, obj)
end

function MonteDeNiveau(pID)
    for k, v in ipairs(Inventaire) do
        if v.ID == pID then
            v.Niveau = v.Niveau + 1
            break
        end
    end
end

function love.load()
    AjouteALinventaire("EPEE", 100, 1, love.graphics.newImage("images/epee.png"))
    AjouteALinventaire("DAGUE", 100, 1, love.graphics.newImage("images/dague.png"))
    AjouteALinventaire("HACHE", 100, 1, love.graphics.newImage("images/hache.png"))
end

function love.update(dt)
end

function love.draw()
    local y = 1
    for k, v in ipairs(Inventaire) do
        love.graphics.draw(v.Image, 1, y)
        --love.graphics.print(v.ID .. " " .. v.Niveau, 1, y)
        y = y + 70
    end
end

function love.keypressed(key)
    if key == "space" then
        MonteDeNiveau("EPEE")
    end
end
