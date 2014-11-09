
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
local bg2
local bg3
local scoreChart
local scoreText
local scoreNumText
local pauseButton
local player
local startButton
local playerBoost
local mountain
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
    bg = display.newImageRect("images/stars2.png",_W,_H)--insert proper image
    bg.anchorX = 0.5
    bg.anchorY = 0
    bg.x = _W/2
    bg.y = 0
    gameGroup:insert(bg)

    bg2 = display.newImageRect("images/stars2.png",_W,_H)--insert proper image
    bg2.anchorX = 0.5
    bg2.anchorY = 0
    bg2.x = _W/2
    bg2.y = _H
    gameGroup:insert(bg2)

    bg3 = display.newImageRect("images/stars2.png",_W,_H)--insert proper image
    bg3.anchorX = 0.5
    bg3.anchorY = 0
    bg3.x = _W/2
    bg3.y = _H*2
    gameGroup:insert(bg3)

    sun = display.newImageRect("images/Space-Thingy@1x.png", 160, 88)
    sun.x = 70
    sun.y = 30
    gameGroup:insert(sun)

    mountain = display.newImageRect( "images/Moutnain@1x.png", 320, 141)
    mountain.x = _W/2
    mountain.y = _H - 60
    gameGroup:insert(mountain)
    
    --Game Playable Elements
    player = display.newImageRect("images/player.png", 60,100)--insert proper image
    player.anchorX = 0.5
    player.anchorY = 0.5
    player.x = _W/2
    player.y = _H-50
    gameGroup:insert(player)

    startButton = display.newImageRect("images/playButton.png", 270,50)--insert proper image
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
        asteroid[i] = display.newImageRect("images/asteroid.png", 50,50)--insert proper image
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
    pauseButton:removeEventListener( 'tap', pauseTouch )
    pauseGroup = display.newGroup()
    eventListeners("remove")
    print("pause")
    pauseBg = display.newImageRect("Icon.png",230,280)
    pauseBg.x = _W/2
    pauseBg.y = _H/2
    pauseGroup:insert(pauseBg)

    pauseText = display.newText("Pause", _W/2,163,"Game Over",100)
    pauseGroup:insert(pauseText)
    --pauseText:setFillColor( 45 )

    resumeText = display.newText("Resume", _W/2,183+60,"Game Over",80)
    pauseGroup:insert(resumeText)
    --resumeText:setFillColor( 45 )
    

    menuText = display.newText("Main Menu", _W/2,183+120,"Game Over",80)
    pauseGroup:insert(menuText)
    --menuText:setFillColor( 45 )

    
    startButton:removeEventListener( 'tap', startGame )

    function resumeGame()
        print("resume")
        pauseGroup:removeSelf()
        resumeText:removeEventListener( "tap", resumeGame )
        menuText:removeEventListener( "tap", menuFunction )
        pauseButton:addEventListener( 'tap', pauseTouch )
        eventListeners("add")
    end

    function menuFunction()
        print "menu button pressed"
        pauseGroup:removeSelf()
        resumeText:removeEventListener( "tap", resumeGame )
        menuText:removeEventListener( "tap", menuFunction )
        scoreNumText:removeSelf()
        scoreText:removeSelf()
        storyboard.gotoScene( "menuScreen")

    end
    resumeText:addEventListener( "tap", resumeGame )
    menuText:addEventListener( "tap", menuFunction )

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
    if(playerBoost)then
        player.y = player.y - 2
    end

    if((playerBoost == false) and (player.y <= _H-51))then
        player.y = player.y + 3
    end


    if(not(bg2 == nil))then
        bg.y = bg.y - 4
        bg2.y = bg2.y - 4
        bg3.y = bg3.y - 4

        if (bg.y + bg.contentHeight) < 0 then
            bg:translate(0, _H*3)
        end
        if (bg2.y + bg2.contentHeight) < 0 then
            bg2:translate(0, _H*3)
        end
        if (bg3.y + bg3.contentHeight) < 0 then
            bg3:translate(0 ,_H*3)
        end
    end

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
        print("hello")
        group = display.newGroup()
        local bg = display.newImageRect("Icon.png", 300,300)
        bg.x = _W/2
        bg.y = _H/2
        group:insert(bg)
        
        local text = display.newText("Game Over!", _W/2, _H/2 - 50, native.systemFont, 24)
        group:insert(text)

        local scoreText = display.newText("Score: "..tostring(score), _W/2, _H/2, native.systemFont, 24)
        group:insert(scoreText)
            
        local playAgain = display.newImageRect("images/playAgain.png",284, 45)
        playAgain.x = _W/2
        playAgain.y = _H/2 + 50
        group:insert(playAgain)
        playAgain:addEventListener( 'tap', playAgainTap)
    end
end

function playAgainTap(e)
    storyboard.gotoScene( "menuScreen")
end

function boostPlayer(e)
    if(e.phase == "began")then
        playerBoost = true
    elseif(e.phase == "ended")then
        playerBoost = false
    end

end

function movePlayer(e)
    player.x = display.contentCenterX + ( display.contentCenterX*( e.xGravity*3 ) )
end
local scoreTimer
function eventListeners(action)
    if(action == "add")then
        Runtime:addEventListener( "enterFrame", update )
        Runtime:addEventListener( "accelerometer",  movePlayer)
        Runtime:addEventListener('touch', boostPlayer)
        scoreTimer = timer.performWithDelay( 100,updateScore, -1 )
    end
    if(action == "remove")then
        Runtime:removeEventListener( "enterFrame", update )
        Runtime:addEventListener( "accelerometer",  movePlayer)
        Runtime:removeEventListener('touch', boostPlayer)
        timer.cancel( scoreTimer )
    end
end

function gameScreen:exitScene(e)
    eventListeners("remove")
    gameGroup:removeSelf()
    group:removeSelf()
    pauseGroup:removeSelf()
    score = 0
    scoreNumText:removeSelf()
    scoreText:removeSelf()
    gameGroup = nil

end

gameScreen:addEventListener("destroyScene",gameScreen)
gameScreen:addEventListener("enterScene",gameScreen)


return gameScreen
