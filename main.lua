local dir = love.filesystem.getSourceBaseDirectory()
package.path = dir .. "/?.lua;" .. dir .. "/?/init.lua;" .. package.path

local animsF require "code.anims"

function love.load()
    init()
    setPlayerEquipment()
end

function init()
    love.graphics.setDefaultFilter("nearest","nearest")
    GameState = "mainMenu"
    titleArt = love.graphics.newImage("/assets/art/title.png")
    SS_guns = love.graphics.newImage("/assets/art/SS_guns.png")
    gxScale = 3
    tileWH = 32
    anim4Frame = 1
    spriteTimer = 0
    animStall = 15

    guns = {
        basic = {
            damage = 1
            , art = love.graphics.newQuad(0,0,tileWH,tileWH, SS_guns:getDimensions())
        }
    }
    playerShips = {
        slipstream = {
            hp = 1
            , spriteSheet = love.graphics.newImage("/assets/art/SS_slipstream-Sheet.png")
        }
    }

    PLAYER_ARR = {
        x = 64 * gxScale, y = 64 * gxScale, state = "IdleUp"
    }

    slipstreamAnims = AnimClass:new(
          { -- _animState
            "IdleUp"
        }
        , { -- _frames
            4
        } 
        , { -- _animations
            {}
        } 
    )
    slipstreamAnims.animations = slipstreamAnims:BuildAnimations(playerShips.slipstream.spriteSheet)
end

function love.update(dt)
    love.timer.sleep(1/60)
    spriteTimer = spriteTimer + dt
    anim4Frame = math.ceil(spriteTimer*animStall % 4)
    animManager()
end

function setPlayerEquipment()
    PLAYER_ARR.gun = guns.basic
    PLAYER_ARR.ship = playerShips.slipstream
    PLAYER_ARR.hp = PLAYER_ARR.ship.hp
    PLAYER_ARR.damage = PLAYER_ARR.gun.damage
    PLAYER_ARR.animations = slipstreamAnims.animations
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
    love.graphics.draw(SS_guns, PLAYER_ARR.gun.art, PLAYER_ARR.x, PLAYER_ARR.y, 0, gxScale, gxScale)
    love.graphics.draw(PLAYER_ARR.ship.spriteSheet, PLAYER_ARR.currentAnimArr[anim4Frame], PLAYER_ARR.x, PLAYER_ARR.y, 0, gxScale, gxScale)
end
