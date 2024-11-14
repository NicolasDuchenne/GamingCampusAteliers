-- TILEMAP DEMO

local Game = {}

Game.Map = {}

Game.Map.Grid =  {
  {10, 10, 10, 10, 10, 10, 10, 10, 10, 61, 10, 13, 10, 10, 10, 10, 10, 10, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15},
  {10, 10, 10, 10, 10, 11, 11, 11, 10, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 14, 15, 15, 129, 15, 15, 15, 15, 15, 15, 68, 15, 15},
  {10, 10, 61, 10, 11, 19, 19, 19, 11, 10, 10, 13, 10, 10, 169, 10, 10, 10, 10, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15},
  {10, 10, 10, 11, 19, 19, 19, 19, 19, 11, 10, 13, 10, 10, 10, 10, 10, 10, 10, 10, 13, 14, 15, 15, 15, 68, 15, 15, 15, 15, 15, 15},
  {10, 10, 10, 11, 19, 19, 19, 19, 19, 11, 10, 13, 10, 10, 10, 10, 10, 10, 61, 10, 10, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15},
  {10, 10, 61, 10, 11, 19, 19, 19, 11, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 10, 10, 14, 15, 15, 129, 15, 15, 15, 68, 15, 129, 15},
  {10, 10, 10, 10, 10, 11, 11, 11, 10, 10, 61, 13, 10, 10, 10, 10, 10, 10, 10, 10, 10, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15},
  {10, 10, 10, 10, 10, 13, 13, 13, 13, 13, 13, 13, 10, 10, 10, 10, 10, 169, 10, 10, 10, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15},
  {10, 10, 10, 10, 10, 10, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 61, 10, 13, 14, 14, 14, 14, 14, 14, 14, 15, 129},
  {10, 10, 10, 10, 10, 10, 10, 10, 13, 55, 10, 58, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 13, 14, 14},
  {10, 10, 10, 10, 10, 10, 10, 10, 13, 10, 10, 10, 55, 10, 58, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10},
  {10, 10, 10, 10, 10, 10, 10, 10, 13, 10, 58, 10, 10, 10, 10, 10, 10, 169, 10, 10, 10, 10, 10, 10, 61, 10, 10, 10, 10, 10, 1, 1},
  {10, 10, 10, 10, 10, 10, 10, 10, 13, 10, 10, 10, 58, 10, 10, 10, 10, 10, 10, 10, 10, 61, 10, 10, 10, 10, 10, 10, 10, 1, 37, 37},
  {13, 13, 13, 13, 13, 13, 13, 13, 13, 10, 55, 10, 10, 10, 55, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 1, 1, 37, 37, 37},
  {10, 10, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 55, 10, 10, 10, 10, 169, 10, 10, 10, 10, 10, 10, 10, 10, 1, 37, 37, 37, 37, 37},
  {10, 10, 10, 10, 13, 10, 10, 10, 10, 142, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 1, 37, 37, 37, 37, 37, 37},
  {10, 10, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 10, 142, 10, 10, 10, 10, 10, 10, 10, 169, 10, 10, 1, 37, 37, 37, 37, 37, 37, 37},
  {14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 1, 37, 37, 37, 37, 37, 37, 37},
  {14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 1, 37, 37, 37, 37, 37, 37, 37},
  {19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 1, 37, 37, 37, 37, 37, 37, 37},
  {20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 1, 37, 37, 37, 37, 37, 37},
  {21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 1, 37, 37, 37, 37},
  {21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 1, 37, 37, 37}
  }

Game.Map.MAP_WIDTH = 32
Game.Map.MAP_HEIGHT = 23
Game.Map.TILE_WIDTH = 32
Game.Map.TILE_HEIGHT = 32

Game.TileSheet = {}
Game.TileTextures = {}
Game.TileTypes = {}

Game.Hero = require("hero")

function Game.Load()
  print("Game:Chargement des textures...")
  
  Game.TileSheet = love.graphics.newImage("images/tilesheet.png")
  local nbColumns = Game.TileSheet:getWidth() / Game.Map.TILE_WIDTH
  local nbLines = Game.TileSheet:getHeight() / Game.Map.TILE_HEIGHT
  local id = 1
  
  Game.TileTextures[0] = nil
  for l=1,nbLines do
    for c=1,nbColumns do
      Game.TileTextures[id] = love.graphics.newQuad(
        (c-1)*Game.Map.TILE_WIDTH, (l-1)*Game.Map.TILE_HEIGHT,
        Game.Map.TILE_WIDTH, Game.Map.TILE_HEIGHT, 
        Game.TileSheet:getWidth(), Game.TileSheet:getHeight()
        )
      id = id + 1
    end
  end
  
  Game.TileTypes[1] = "Gravel"
  Game.TileTypes[10] = "Grass"
  Game.TileTypes[11] = "Grass"
  Game.TileTypes[13] = "Sand"
  Game.TileTypes[14] = "Sand"
  Game.TileTypes[15] = "Sand"
  Game.TileTypes[19] = "Water"
  Game.TileTypes[20] = "Water"
  Game.TileTypes[21] = "Sea"
  Game.TileTypes[37] = "Lava"
  Game.TileTypes[55] = "Tree"
  Game.TileTypes[58] = "Tree"
  Game.TileTypes[61] = "Tree"
  Game.TileTypes[68] = "Tree"
  Game.TileTypes[169] = "Rock"
  Game.TileTypes[129] = "Rock"

  print("Game:Chargement des textures terminées...")
end

function Game.Map.IsSolid(pID)
  local typeTile = Game.TileTypes[pID]
  if  typeTile == "Sea" or
      typeTile == "Tree" or
      typeTile == "Rock" then
    return true
  end
  return false
end

function Game.Update(dt)
  Game.Hero.Update(Game.Map, dt)
end

function Game.Draw()
  local c,l
  
  for l=1,Game.Map.MAP_HEIGHT do
    for c=1,Game.Map.MAP_WIDTH do
      local id = Game.Map.Grid[l][c]
      local texQuad = Game.TileTextures[id]
      if texQuad ~= nil then
        love.graphics.draw(Game.TileSheet, texQuad, (c-1)*Game.Map.TILE_WIDTH, (l-1)*Game.Map.TILE_HEIGHT)
      end
    end
  end
  
  
  local c = Game.Hero.column
  local l = Game.Hero.line
  
  -- Informations de debug
  if l>0 and c>0 and l <= Game.Map.MAP_HEIGHT and c <= Game.Map.MAP_WIDTH then
    local id = Game.Map.Grid[l][c]
    love.graphics.print(
      "Ligne: "..tostring(l)..
      " Colonne: "..tostring(c)..
      " ID: "..tostring(id)..
      " ("..tostring(Game.TileTypes[id])..")"
      ,1,Game.Map.TILE_HEIGHT*23)
  end
  
  Game.Hero.Draw(Game.Map)
end

return Game