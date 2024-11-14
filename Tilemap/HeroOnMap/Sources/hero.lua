local hero = {}

hero.images = {}
hero.images[1] = love.graphics.newImage("images/player_1.png")
hero.images[2] = love.graphics.newImage("images/player_2.png")
hero.images[3] = love.graphics.newImage("images/player_3.png")
hero.images[4] = love.graphics.newImage("images/player_4.png")
hero.nbImages = 4
hero.imgCurrent = 1
hero.keyPressed = false

hero.line = 1
hero.column = 1

function hero.Update(pMap, dt)
  hero.imgCurrent = hero.imgCurrent + 5*dt
  if math.floor(hero.imgCurrent) > hero.nbImages then
    hero.imgCurrent = 1
  end
  
  if love.keyboard.isDown("left","up","right","down") then
    if hero.keyPressed == false then
      hero.keyPressed = true
      local old_c = hero.column
      local old_l = hero.line
    
      if love.keyboard.isDown("up") then
        hero.line = hero.line - 1
      end
      if love.keyboard.isDown("right") then
        hero.column = hero.column + 1
      end
      if love.keyboard.isDown("down") then
        hero.line = hero.line + 1
      end
      if love.keyboard.isDown("left") then
        hero.column = hero.column - 1
      end
      
      local id = pMap.Grid[hero.line][hero.column]
      if pMap.IsSolid(id) then
        print("Collision")
        hero.column = old_c
        hero.line = old_l
      end
    end
  else
    hero.keyPressed = false
  end
end

function hero.Draw(pMap)
  local x = (hero.column-1) * pMap.TILE_WIDTH
  local y = (hero.line-1) * pMap.TILE_HEIGHT
  love.graphics.draw(hero.images[math.floor(hero.imgCurrent)], x, y, 0, 2, 2)
end

return hero