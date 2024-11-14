-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Empèche Love de filtrer les contours des images quand elles sont redimentionnées
-- Indispensable pour du pixel art
love.graphics.setDefaultFilter("nearest")

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

love.window.setMode(1024, 708)

ScreenWidth = love.graphics.getWidth()
ScreenHeight = love.graphics.getHeight()

local game = require("game")

function love.load()
    game.load()
end

function love.update(dt)
end

function love.draw()
    game.draw()
end

function love.keypressed(key)
end
