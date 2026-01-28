local dir = love.filesystem.getSourceBaseDirectory()
package.path = dir .. "/?.lua;" .. dir .. "/?/init.lua;" .. package.path

function love.load()
    init()
end

function init()
    love.graphics.setDefaultFilter("nearest","nearest")
    GameState = "mainMenu"
    titleArt = love.graphics.newImage("/assets/art/title.png")
    SS_guns = love.graphics.newImage("/assets/art/SS_guns.png")
    gxScale = 3

    guns = {
        basic = {
            damage = 1
            , art = love.graphics.newQuad(0,0,32,32, SS_guns:getDimensions())
        }
    }
    playerShips = {
        slipstream = {
            hp = 1
            , spriteSheet = love.graphics.newImage("/assets/art/SS_slipstream.png")
        }
    }

    PLAYER_ARR = {
        gun = guns.basic
        , ship = playerShips.slipstream
        , x = 64 * gxScale, y = 64 * gxScale
    }

    PLAYER_ARR.hp = PLAYER_ARR.ship.hp
    PLAYER_ARR.damage = PLAYER_ARR.gun.damage

end

function love.update(dt)

end

function animManager()

end

function love.draw()
    if GameState == "mainMenu" then 
        drawMainMenu()
    end
end

function drawMainMenu()
    for i=1, 3, 1 do
        love.graphics.setColor(1,1,1,i*0.33)
        love.graphics.draw(titleArt,0,(4 - ((i-1)*2))*gxScale,0,gxScale,gxScale)    
    end
    drawPlayer()
end

function drawPlayer()
    love.graphics.draw(SS_guns, PLAYER_ARR.gun.art, PLAYER_ARR.x, PLAYER_ARR.y, 0,gxScale,gxScale)
    love.graphics.draw(PLAYER_ARR.ship.spriteSheet, PLAYER_ARR.x, PLAYER_ARR.y, 0,gxScale,gxScale)
end
