local dir = love.filesystem.getSourceBaseDirectory()
package.path = dir .. "/?.lua;" .. dir .. "/?/init.lua;" .. package.path

function love.load()
    init()
end

function init()
    GameState = "mainMenu"
    titleArt = love.graphics.newImage("/assets/art/title.png")
    gxScale = 3
end

function love.update(dt)

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
end
