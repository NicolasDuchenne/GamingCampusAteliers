-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

imgGun = nil
gunX = 50
gunY = 0
gunTimer = 0
gunNombre = 0
gunPause = 0
sndGun = nil
listeProjectiles = {}
mode = "CPC"

function CreeProjectile(px, py, pvx)
    local projectile = {}
    projectile.x = px
    projectile.y = py
    projectile.vx = pvx
    table.insert(listeProjectiles, projectile)
    sndGun:stop()
    sndGun:play()
end

function love.load()
    sndGun = love.audio.newSource("sons/GunShot.wav", "static")
    imgGun = love.graphics.newImage("images/pistol.png")
    gunY = (love.graphics.getHeight() - imgGun:getHeight()) / 2
    gunX = 50
end

function love.update(dt)
    local bPretATirer = false
    gunTimer = gunTimer + dt
    if gunPause > 0 then
        gunPause = gunPause - dt
        if gunPause < 0 then
            gunPause = 0
        end
    end
    if mode == "AUTO" or mode == "RAFALE" or mode == "HYBRIDE" then
        gunTimer = gunTimer + dt
        if gunTimer > 0.6 and mode == "AUTO" then
            gunTimer = 0
            bPretATirer = true
        elseif gunTimer > 0.2 and mode == "RAFALE" then
            gunTimer = 0
            bPretATirer = true
        elseif gunTimer > 0.2 and gunPause == 0 and mode == "HYBRIDE" then
            gunTimer = 0
            bPretATirer = true
        end
    end
    if love.keyboard.isDown("space") then
        if mode == "AUTO" and bPretATirer then
            CreeProjectile(gunX + imgGun:getWidth(), gunY + 10, 5)
        elseif mode == "RAFALE" and bPretATirer and gunNombre < 10 then
            CreeProjectile(gunX + imgGun:getWidth(), gunY + 10, 5)
            gunNombre = gunNombre + 1
        elseif mode == "HYBRIDE" and bPretATirer then
            CreeProjectile(gunX + imgGun:getWidth(), gunY + 10, 5)
            gunNombre = gunNombre + 1
            if gunNombre == 10 then
                gunPause = 0.5
                gunNombre = 0
            end
        end
    end

    for n = #listeProjectiles, 1, -1 do
        local p = listeProjectiles[n]
        p.x = p.x + p.vx
        if p.x > love.graphics.getWidth() then
            table.remove(listeProjectiles, n)
        end
    end
end

function love.draw()
    love.graphics.draw(imgGun, gunX, gunY)

    -- Dessiner le projectile
    for k, v in pairs(listeProjectiles) do
        love.graphics.circle("fill", v.x, v.y, 3)
    end

    love.graphics.print(
        tostring(#listeProjectiles) ..
            " " .. tostring(gunNombre) .. " " .. tostring(gunTimer) .. " " .. tostring(gunPause),
        1,
        1
    )
    love.graphics.print(mode, 1, 16)
end

function love.keypressed(key)
    if key == "space" then
        if mode == "CPC" then
            CreeProjectile(gunX + imgGun:getWidth(), gunY + 10, 5)
        elseif mode == "AUTO" or mode == "RAFALE" or mode == "HYBRIDE" then
            gunTimer = 0
            gunNombre = 0
        end
    end

    if key == "return" then
        if mode == "CPC" then
            mode = "AUTO"
        elseif mode == "AUTO" then
            mode = "RAFALE"
        elseif mode == "RAFALE" then
            mode = "HYBRIDE"
        elseif mode == "HYBRIDE" then
            mode = "CPC"
        end
    end
end
