function newCharacter(x, y, vx, vy,  speed)
    local character = {}
    character.x = x
    character.y = y
    character.speed = speed
    character.img = {}
    table.insert(character.img, love.graphics.newImage("images/marche1.png"))
    table.insert(character.img, love.graphics.newImage("images/marche2.png"))
    character.width = character.img[1]:getWidth()
    character.height = character.img[1]:getHeight()
    character.ox = character.width/2
    character.oy = character.height/2
    character.img_index = 1
    character.x_dir = 1
    character.last_update = 0
    character.frame_per_seconds = 5

    character.vx = vx
    character.vy = vy


    character.getCollisionFace =function(box)
        -- Calculate the difference in the centers of box1 and box2 along x and y axes
        local dx = (character.x + character.width / 2) - (box.x + box.width / 2)
        local dy = (character.y + character.height / 2) - (box.y + box.height / 2)
        local combinedHalfWidth = (character.width + box.width) / 2
        local combinedHalfHeight = (character.height + box.height) / 2
    
        -- Check if there is a collision by seeing if the distance between centers
        -- is less than the combined half-width and half-height
        if math.abs(dx) < combinedHalfWidth and math.abs(dy) < combinedHalfHeight then
            -- Collision occurred, determine which face
            local overlapX = combinedHalfWidth - math.abs(dx)
            local overlapY = combinedHalfHeight - math.abs(dy)
    
            if overlapX < overlapY then
                if dx > 0 then
                    return "left", overlapX, overlapY
                else
                    return "right", overlapX, overlapY
                end
            else
                if dy > 0 then
                    return "top", overlapX, overlapY
                else
                    return "bottom", overlapX, overlapY
                end
            end
        end
        return nil  -- No collision
    end

    character.process_collision = function(face, overlapX, overlapY)
        if face == "left" or face == "right" then
            character.vx = -character.vx
            if face == "left" then
                character.x = character.x + overlapX
            else
                character.x = character.x - overlapX
            end


        elseif face == "top" or face == "bottom" then
            character.vy = -character.vy
            if face == "top" then
                character.y = character.y + overlapY
            else
                character.y = character.y - overlapY
            end
        end
    end



    character.update = function(dt)
        character.x = character.x + character.vx * character.speed * dt
        character.y = character.y + character.vy * character.speed * dt
        if character.x < character.ox then
            character.x =  character.ox
            character.vx = - character.vx
            character.x_dir = - character.x_dir
        elseif character.x + character.ox > Monitor_Widht then
            character.x = Monitor_Widht - character.ox
            character.vx = - character.vx
            character.x_dir = - character.x_dir
        end
        if character.y < character.oy then
            character.y = character.oy
            character.vy = - character.vy
        elseif character.y + character.oy > Monitor_Height then
            character.y = Monitor_Height - character.oy
            character.vy = - character.vy
        end
    
        character.last_update = character.last_update + dt
        if character.last_update > 1/character.frame_per_seconds then 
            character.img_index = character.img_index + 1
            character.last_update = 0
            if character.img_index > #character.img   then
                character.img_index = 1
            end
        end
    end

    character.draw = function()
        love.graphics.draw(character.img[character.img_index], character.x, character.y, 0, character.x_dir, 1, character.ox, character.oy)
    end
    return character
end
