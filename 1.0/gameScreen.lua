
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
local score = 0
local asteroid = {}
local startGame = {}
local spawnAsteroids = {}
local spinAsteroids = {}
local update = {}
local gameGroup

function gameScreen:enterScene(e)

    gameGroup = display.newGroup()

    --Game Elements
    bg = display.newImageRect("images/Stars@1x.png",_W,_H)--insert proper image
    bg.anchorX = 0.5
    bg.anchorY = 0.5
    bg.x = _W/2
    bg.y = _H/2
    gameGroup:insert(bg)

    sun = display.newImageRect("images/Space-Thingy@1x.png", 160, 88)
    sun.x = 70
    sun.y = 30
    gameGroup:insert(sun)
    --Game Playable Elements
    player = display.newImageRect("images/player.png", 60,50)--insert proper image
    player.anchorX = 0.5
    player.anchorY = 0.5
    player.x = _W/2
    player.y = _H-30
    gameGroup:insert(player)

    startButton = display.newImageRect("Icon-60.png", 270,50)--insert proper image
    startButton.anchorX = 0.5
    startButton.anchorY = 0.5
    startButton.x = _W/2
    startButton.y = _H/2
    gameGroup:insert(startButton)
    
    startButton:addEventListener("touch", startGame)

    --Score Chart
    scoreText = display.newText("Score:",_W/2 + 70,15,native.systemFont, 25)--insert proper font
    scoreText:setFillColor(255/255,255/255,255/255)
    gameGroup:insert(scoreText)
    
    scoreNumText = display.newText(tostring(score),_W - 30,17,native.systemFont, 25)--insert proper font and scoreNum
    scoreNumText:setFillColor( 255/255,255/255, 255/255 )
    gameGroup:insert(scoreNumText)
    
    score = 0
    scoreNumText.text = tostring(score)
    
    pauseButton = display.newImageRect("images/pauseBtn.png",30,30)--insert proper image
    pauseButton.anchorX = 0.5
    pauseButton.anchorY = 0.5
    pauseButton.x = 35
    pauseButton.y = 35
    gameGroup:insert(pauseButton)
    pauseButton:addEventListener( "tap", pauseTouch)

    local asteroidX = math.random(0, _W)
    local asteroidY = math.random(-800, -100)
    for i = 1,7 do
        asteroid[i] = display.newImageRect("Icon-60.png", 50,50)--insert proper image
        asteroid[i].anchorX = 0
        asteroid[i].anchorY = 0.5
        asteroid[i].y = asteroidY
        asteroid[i].x = asteroidX
        asteroidX = math.random(0, _W*2)
        asteroidY = math.random(-800,-50)
        gameGroup:insert(asteroid[i])
    end

end

function pauseTouch(e)
    print("pause")
end

--GAME FUNCTIONS

function startGame(e)
    startButton:removeEventListener( 'tap', startGame )
    eventListeners("add")
    print "The Game has Started!"
    startButton.isVisible = false
    physics:start()
end   

function updateScore()
    score = score + 1
    scoreNumText.text = tostring(score)
end


function update()
    if(player.x >= _W)then
        player.x = 0
    elseif(player.x <= 0)then
        player.x = _W
    end

    for i  = 1,7 do
        if(not(asteroid[i] == nil))then

            local left = player.contentBounds.xMin <= asteroid[i].contentBounds.xMin and player.contentBounds.xMax >= asteroid[i].contentBounds.xMin
            local right = player.contentBounds.xMin >= asteroid[i].contentBounds.xMin and player.contentBounds.xMin <= asteroid[i].contentBounds.xMax
            local up = player.contentBounds.yMin <= asteroid[i].contentBounds.yMin and player.contentBounds.yMax >= asteroid[i].contentBounds.yMin
            local down = player.contentBounds.yMin >= asteroid[i].contentBounds.yMin and player.contentBounds.yMin <= asteroid[i].contentBounds.yMax
        
            if( (left or right) and (up or down))then
                 event("lose")
            end
        
            asteroid[i].y = asteroid[i].y + 3
            if(asteroid[i].y >= _H + 30)then
                recycleAsteroid(i)
            end
        end
    end
end

function recycleAsteroid(num)
    asteroid[num].y = math.random(-800,-50)
    asteroid[num].x = math.random(0, _W) 
end
local group
function event(action)
    eventListeners("remove")
    if(action == "lose")then
        print(asteroid[1].y)
        group = display.newGroup()
        local bg = display.newImageRect("Icon.png", 300,300)
        bg.x = _W/2
        bg.y = _H/2
        group:insert(bg)
        
        local text = display.newText("Game Over!", _W/2, _H/2 - 50, native.systemFont, 24)
        group:insert(text)

        local scoreText = display.newText("Score: "..tostring(score), _W/2, _H/2, native.systemFont, 24)
        group:insert(scoreText)

        local playAgain = display.newImageRect("Icon.png", bg.width, 50)
        playAgain.x = _W/2
        playAgain.y = _H/2 + 50
        group:insert(playAgain)
        playAgain:addEventListener( 'tap', playAgainTap)
    end
end

function playAgainTap(e)
    storyboard.gotoScene( "menuScreen")
end

function movePlayer(e)
    player.x = (e.xRaw * 100) + 160
end
local scoreTimer
function eventListeners(action)
    if(action == "add")then
        Runtime:addEventListener( "enterFrame", update )
        Runtime:addEventListener( "accelerometer",  movePlayer)
        scoreTimer = timer.performWithDelay( 100,updateScore, -1 )
    end
    if(action == "remove")then
        Runtime:removeEventListener( "enterFrame", update )
        Runtime:addEventListener( "accelerometer",  movePlayer)
        timer.cancel( scoreTimer )
    end
end

function gameScreen:exitScene(e)
    eventListeners("remove")
    gameGroup:removeSelf()
    group:removeSelf()
    score = 0
end

gameScreen:addEventListener("destroyScene",gameScreen)
gameScreen:addEventListener("enterScene",gameScreen)


return gameScreen
