local Game = {}
local MAP_WIDTH = 10
local MAP_HEIGHT = 10
local TILE_WIDTH = 70
local TILE_HEIGHT = 70

Game.Map = {}
Game.Map =  {
              { 2,4,4,2,2,2,2,2,2,2 },
              { 2,1,2,2,0,0,2,2,1,2 },
              { 2,2,2,2,2,2,2,2,2,2 },
              { 2,5,2,2,2,2,2,2,2,2 },
              { 2,2,2,2,3,3,2,2,2,2 },
              { 2,2,2,2,3,3,2,2,2,2 },
              { 2,2,2,2,2,2,2,2,2,2 },
              { 2,2,2,2,2,2,2,2,2,2 },
              { 2,1,2,2,2,2,2,2,1,2 },
              { 2,2,2,2,2,2,2,2,2,2 },
            }

Game.TileTextures = {}

function Game.Load()
  print("Game:Chargement des textures...")
  Game.TileTextures[0] = nil
  Game.TileTextures[1] = love.graphics.newImage("images/grassCenter.png")
  Game.TileTextures[2] = love.graphics.newImage("images/liquidLava.png")
  Game.TileTextures[3] = love.graphics.newImage("images/liquidWater.png")
  Game.TileTextures[4] = love.graphics.newImage("images/snowCenter.png")
  Game.TileTextures[5] = love.graphics.newImage("images/stoneCenter.png")
  print("Game:Chargement des textures terminées...")
end

function Game.Draw()
  local c,l
  
  for l=1,MAP_HEIGHT do
    for c=1,MAP_WIDTH do
      local id = Game.Map[l][c]
      local tex = Game.TileTextures[id]
      if tex ~= nil then
        love.graphics.draw(tex, (c-1)*TILE_WIDTH, (l-1)*TILE_HEIGHT)
      end
    end
  end
end

return Game