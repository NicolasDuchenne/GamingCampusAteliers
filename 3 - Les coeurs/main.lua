-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

require("hearth")

local hearth = newHearth()

function love.load()
end

function love.update(dt)
    hearth.update(dt)
end

function love.draw()
    hearth.draw()
end

function love.keypressed(key)
    if key == "s" then
        hearth.number = hearth.lose_health(1)
    end
    if key == "z" then
        hearth.number = hearth.gain_health(1)
    end
end
