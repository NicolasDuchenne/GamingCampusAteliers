-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

tailleColonne = 0
ExerciceTermine = false
listePersonnes = {}

function AjoutePersonne(pPrenom)
    local p = {}
    p.prenom = pPrenom
    p.delai = love.math.random(3, 10)
    p.colonne = 1
    table.insert(listePersonnes, p)
end

function love.load()
    largeur_ecran = love.graphics.getWidth()
    hauteur_ecran = love.graphics.getHeight()
    tailleColonne = largeur_ecran / 3

    AjoutePersonne("Anne")
    AjoutePersonne("Basile")
    AjoutePersonne("Céleste")
    AjoutePersonne("David")
    AjoutePersonne("Edgard")
    AjoutePersonne("Félix")
    AjoutePersonne("Gaspar")
    AjoutePersonne("Hippolyte")
    AjoutePersonne("Jules")
    AjoutePersonne("Kévin")
end

function love.update(dt)
    local bTermine = true
    for k, v in pairs(listePersonnes) do
        if v.colonne < 3 then
            bTermine = false
            v.delai = v.delai - dt
            if v.delai <= 0 then
                v.colonne = v.colonne + 1
                v.delai = love.math.random(3, 10)
            end
        end
    end
    if bTermine then
        ExerciceTermine = true
    end
end

function DrawColonne(pColonne_A_Afficher, pX)
    -- Affiche les prénoms
    local y = 10
    for k, v in pairs(listePersonnes) do
        if v.colonne == pColonne_A_Afficher then
            local delai = math.floor(v.delai)
            love.graphics.print(v.prenom .. " > " .. tostring(delai), pX, y)
            y = y + 16
        end
    end

    if ExerciceTermine then
        love.graphics.print("C'est terminé !", 10, 10)
    end
end

function love.draw()
    local x = 0
    -- 1ère colonne de prénoms
    DrawColonne(1, x + 10)

    x = x + tailleColonne
    love.graphics.line(x, 0, x, hauteur_ecran)
    -- 2ème colonne de prénoms
    DrawColonne(2, x + 10)

    x = x + tailleColonne
    love.graphics.line(x, 0, x, hauteur_ecran)
    -- 3ème colonne de prénoms
    DrawColonne(3, x + 10)
end

function love.keypressed(key)
end
