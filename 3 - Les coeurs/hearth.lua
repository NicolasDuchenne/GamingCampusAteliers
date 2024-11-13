function newHearth()
    local hearth = {}
    hearth.heatlh = 5
    hearth.max_health = 10
    hearth.img = love.graphics.newImage("images/coeur.png")
    hearth.left_img = love.graphics.newImage("images/coeur_gauche.png")
    hearth.right_img = love.graphics.newImage("images/coeur_droite.png")
    hearth.frame_per_seconds = 3
    hearth.time_to_last_frame = 0
    hearth.visible = true

    hearth.lose_health = function(damage)
        hearth.heatlh = math.max(0, hearth.heatlh - damage)
    end

    hearth.gain_health = function(health)
        hearth.heatlh = math.min(hearth.max_health, hearth.heatlh + health)
    end


    hearth.draw = function()
        if hearth.heatlh > 2 or hearth.visible then
            for i=1,hearth.heatlh do
                local img_pos = math.floor((i-1)/2)
                if i%2 == 1 then
                    love.graphics.draw(hearth.left_img, img_pos*hearth.left_img:getWidth(), 0, 0, 1, 1)
                else
                    love.graphics.draw(hearth.right_img, img_pos*hearth.right_img:getWidth(), 0, 0, 1, 1)
                end
            end
        end
    end

    hearth.update = function(dt)

        hearth.time_to_last_frame = hearth.time_to_last_frame + dt
        if hearth.time_to_last_frame > 1/hearth.frame_per_seconds then
            hearth.visible =  not hearth.visible
            hearth.time_to_last_frame = 0
        end
    end


    return hearth
end
