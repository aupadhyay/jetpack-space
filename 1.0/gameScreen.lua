
--initiating libraries 
local storyboard = require ("storyboard")
local physics = require("physics")


local gameScreen = storyboard.newScene("gameScreen")

--basic variables
_W = display.contentWidth
_H = display.contentHeight

system.setIdleTimer(false)
system.setAccelerometerInterval(40)
--game elements
local bg
local scoreChart
local scoreText
local scoreNumText
local pauseButton
local player
local startButton
local sun
local asteroid = {}
local startGame = {}
local spawnAsteroids = {}
local spinAsteroids = {}
local update = {}

function gameScreen:createScene(e)
    --Game Elements
    bg = display.newImageRect("images/Stars@1x.png",_W,_H)--insert proper image
    bg.anchorX = 0.5
    bg.anchorY = 0.5
    bg.x = _W/2
    bg.y = _H/2

    sun = display.newImageRect("images/Space-Thingy@1x.png", 160, 88)
    sun.x = 70
    sun.y = 30
    
    --Game Playable Elements
    player = display.newImageRect("images/player.png", 60,50)--insert proper image
    player.anchorX = 0.5
    player.anchorY = 0.5
    player.x = _W/2
    player.y = _H-30

    startButton = display.newImageRect("Icon-60.png", 270,50)--insert proper image
    startButton.anchorX = 0.5
    startButton.anchorY = 0.5
    startButton.x = _W/2
    startButton.y = _H/2
    
    startButton:addEventListener("touch", startGame)

    --Score Chart
    scoreText = display.newText("Score:",_W/2 + 70,15,native.systemFont, 25)--insert proper font
    scoreText:setFillColor(255/255,255/255,255/255)
    
    scoreNumText = display.newText("100",_W - 30,17,native.systemFont, 25)--insert proper font and scoreNum
    scoreNumText:setFillColor( 255/255,255/255, 255/255 )
    
    pauseButton = display.newImageRect("images/pauseBtn.png",30,30)--insert proper image
    pauseButton.anchorX = 0.5
    pauseButton.anchorY = 0.5
    pauseButton.x = 35
    pauseButton.y = 35

end


--GAME FUNCTIONS

function startGame(e)
    eventListeners("add")
    print "The Game has Started!"
    startButton.isVisible = false
    timer.performWithDelay( 250, spawnAsteriods, 1 )

    physics:start()
end   

function spawnAsteriods(e)
    local asteroidOne = math.random(0,_W)
    for i = 1,4 do
        asteroid[i] = display.newImageRect("Icon-60.png", 50,50)--insert proper image
        asteroid[i].anchorX = 0.5
        asteroid[i].anchorY = 0.5
        asteroid[i].x = asteroidOne + i*50
        asteroid[i].y = -30
        physics.addBody( asteroid[i],"static", { friction=0.5, bounce=2.3 } )
    end
end

function update()
    for i  = 1,10,1 do
        if(not(asteroid[i] == nil))then
            local left = player.contentBounds.xMin <= asteroid[i].contentBounds.xMin and player.contentBounds.xMax >= asteroid[i].contentBounds.xMin
            local right = player.contentBounds.xMin >= asteroid[i].contentBounds.xMin and player.contentBounds.xMin <= asteroid[i].contentBounds.xMax
            local up = player.contentBounds.yMin <= asteroid[i].contentBounds.yMin and player.contentBounds.yMax >= asteroid[i].contentBounds.yMin
            local down = player.contentBounds.yMin >= asteroid[i].contentBounds.yMin and player.contentBounds.yMin <= asteroid[i].contentBounds.yMax
    
            if( (left or right) and (up or down))then
                 print("collide")
            end
    
            print("one")
            asteroid[i].y = asteroid[i].y + 3
        end
    end
end

function event(action)
    if(action == "lose")then
        local bg = display.newImageRect("images")
    end

    if(action == "win")then
        local bg = display.newImageRect( "images")
 
    end
end

function movePlayer(e)
    player.x = (e.xRaw * 100) + 160
end

function eventListeners(action)
    if(action == "add")then
        Runtime:addEventListener( "enterFrame", update )
        Runtime:addEventListener( "accelerometer",  movePlayer)
    end
    if(action == "remove")then
        Runtime:removeEventListener( "enterFrame", update )
        Runtime:addEventListener( "accelerometer",  movePlayer)
    end
end

gameScreen:addEventListener("createScene",gameScreen)


return gameScreen
