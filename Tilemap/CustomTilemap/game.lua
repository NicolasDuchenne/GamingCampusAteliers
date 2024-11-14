local game = {}
game.__index = game

local MAP_WIDTH = 10
local MAP_HEIGHT = 10
local TILE_WIDTH = 70
local TILE_HEIGHT = 70

game.map = {
    {2,0,0,0,2,2,2,2,2,2},
    {2,1,2,2,2,2,2,2,1,2},
    {2,2,2,2,2,2,2,2,2,2},
    {2,2,2,2,3,3,3,2,2,2},
    {2,2,2,2,3,3,3,2,2,2},
    {2,2,2,2,3,3,3,2,2,2},
    {2,2,2,2,4,4,4,2,2,2},
    {2,2,2,2,5,2,2,2,2,2},
    {2,1,2,2,2,2,2,2,1,2},
    {2,2,2,2,2,2,2,2,2,2},
}

game.tileTextures = {}

game.load = function()
    game.tileTextures[0] = nil
    game.tileTextures[1] = love.graphics.newImage("_Images_/grassCenter.png")
    game.tileTextures[2] = love.graphics.newImage("_Images_/liquidLava.png")
    game.tileTextures[3] = love.graphics.newImage("_Images_/liquidWater.png")
    game.tileTextures[4] = love.graphics.newImage("_Images_/snowCenter.png")
    game.tileTextures[5] = love.graphics.newImage("_Images_/stoneCenter.png")

end

game.draw = function()
    for i=1,MAP_HEIGHT do
        for j=1,MAP_WIDTH do
            local id = game.map[j][i]
            local texture = game.tileTextures[id]
            if texture then
                love.graphics.draw(texture, (i-1)*TILE_WIDTH, (j-1)*TILE_HEIGHT)
            end
        end
    end

    local x, y = love.mouse.getPosition()
    local column = math.floor(x / TILE_WIDTH) + 1
    local line = math.floor(y/TILE_HEIGHT) + 1
    if column > 0 and column <= MAP_WIDTH and line > 0 and line <= MAP_HEIGHT then
        local id = game.map[line][column]
        love.graphics.print("ID: "..tostring(id), x+15, y)
    end
end

return game