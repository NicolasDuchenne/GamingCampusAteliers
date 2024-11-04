-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

tailleColonne = 0
ExerciceTermine = false
listePersonnes = {}
listePersonnes[1] = {}
listePersonnes[2] = {}
listePersonnes[3] = {}

function AjoutePersonne(pPrenom)
    local p = {}
    p.prenom = pPrenom
    p.delai = love.math.random(3, 10)
    p.delaiDepart = p.delai
    table.insert(listePersonnes[1], p)
end

function CreeListe()
    listePersonnes = {}
    listePersonnes[1] = {}
    listePersonnes[2] = {}
    listePersonnes[3] = {}
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

function love.load()
    largeur_ecran = love.graphics.getWidth()
    hauteur_ecran = love.graphics.getHeight()
    tailleColonne = largeur_ecran / 3

    CreeListe()
end

function UpdateColonne(pColonne, dt)
    for n = #listePersonnes[pColonne], 1, -1 do
        local v = listePersonnes[pColonne][n]
        v.delai = v.delai - dt
        if v.delai <= 0 then
            v.delai = love.math.random(3, 10)
            v.delaiDepart = v.delai
            table.insert(listePersonnes[pColonne + 1], v)
            table.remove(listePersonnes[pColonne], n)
        end
    end
end

function love.update(dt)
    UpdateColonne(1, dt)
    UpdateColonne(2, dt)
    --UpdateColonne(3, dt)
end

function DrawColonne(pColonne_A_Afficher, pX)
    -- Affiche les prénoms
    local y = 10
    for k, v in pairs(listePersonnes[pColonne_A_Afficher]) do
        local delai = math.floor(v.delai)
        local ratio = v.delai / v.delaiDepart
        love.graphics.rectangle("line", pX, y + 4, 25, 8)
        love.graphics.rectangle("fill", pX, y + 4, 25 * ratio, 8)
        love.graphics.print(v.prenom, pX + 30, y)
        y = y + 16
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
    if key == "space" then
        CreeListe()
    end
end
