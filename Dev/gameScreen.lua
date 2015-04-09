--initiating libraries 
local storyboard = require ("storyboard")
local physics = require("physics")
local scoreMod = require("score")

local gameScreen = storyboard.newScene("gameScreen")
local pauseGroup
local scoreText
local scoreNumText
local pauseButton
local player
local playerXText
local startButton
local playerBoost
local mountain
local sun
local scoreNum = 0
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
    bg.y = 0 - 50
    gameGroup:insert(bg)

    bg2 = display.newImageRect("images/stars2.png",_W,_H)--insert proper image
    bg2.anchorX = 0.5
    bg2.anchorY = 0 
    bg2.x = _W/2
    bg2.y = _H - 50
    gameGroup:insert(bg2)

    bg3 = display.newImageRect("images/stars2.png",_W,_H)--insert proper image
    bg3.anchorX = 0.5
    bg3.anchorY = 0
    bg3.x = _W/2
    bg3.y = _H*2 - 50
    gameGroup:insert(bg3)

    sun = display.newImageRect("images/Space-Thingy@1x.png", 160, 88)
    sun.x = 70
    sun.y = 30
    gameGroup:insert(sun)

    mountain = display.newImageRect( "images/Moutnain@1x.png", 320, 141)
    mountain.x = _W/2
    mountain.y = _H - 60 - 50
    gameGroup:insert(mountain)
    
    --Game Playable Elements
    player = display.newImageRect("images/player.png", 60,100)--insert proper image
    player.anchorX = 0.5
    player.anchorY = 0.5
    player.x = _W/2
    player.y = _H-50 - 50
    gameGroup:insert(player)

    playerJump = display.newImageRect( "images/sprite.png", 60,120)
    playerJump.x = _W/2
    playerJump.y = -300
    gameGroup:insert(playerJump)

    startButton = display.newImageRect("images/playButton.png", 270,50)--insert proper image
    startButton.anchorX = 0.5
    startButton.anchorY = 0.5
    startButton.x = _W/2
    startButton.y = _H/2 - 50
    gameGroup:insert(startButton)
    
    startButton:addEventListener("touch", startGame)
	if((system.getInfo("platformName") == "iPhone OS") or (system.getInfo("environment") == "simulator"))then
    --Score Chart
    scoreText = display.newText("Score:",_W/2 + 50,15,"8BIT Wonder", 20)--insert proper font
    scoreText:setFillColor(255/255,255/255,255/255)
    gameGroup:insert(scoreText)
    
    scoreNumText = scoreMod.init({
       fontSize = 20,
       font = "8BIT Wonder",
       x = _W - 50,
       y = 15,
       maxDigits = 7,
       leadingZeros = false,
       filename = "scorefile.txt",
    })
    else
	scoreText = display.newText("Score:",_W/2 + 50,15,"8-bit", 20)--insert proper font
    scoreText:setFillColor(255/255,255/255,255/255)
    gameGroup:insert(scoreText)
    
    scoreNumText = scoreMod.init({
       fontSize = 20,
       font = "8-bit",
       x = _W - 40,
       y = 15,
       maxDigits = 7,
       leadingZeros = false,
       filename = "scorefile.txt",
    })
	end
    scoreNum = 0
    scoreMod.set(0)
    scoreNumText.text = scoreMod.get()
    pauseButton = display.newImageRect("images/pauseBtn.png",50,50)--insert proper image
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
    pauseBg = display.newImageRect("images/pauseBg.png",230,280)
    pauseBg.x = _W/2
    pauseBg.y = _H/2
    pauseGroup:insert(pauseBg)
	if((system.getInfo("platformName") == "iPhone OS") or (system.getInfo("environment") == "simulator"))then
    pauseText = display.newText("Pause", _W/2,163+10,"Game Over",100)
    pauseGroup:insert(pauseText)
    --pauseText:setFillColor( 45 )

    resumeText = display.newText("Resume", _W/2,183+60,"Game Over",80)
    pauseGroup:insert(resumeText)
    --resumeText:setFillColor( 45 )
    

    menuText = display.newText("Main Menu", _W/2,183+120,"Game Over",80)
    pauseGroup:insert(menuText)
    --menuText:setFillColor( 45 )
	else
	
    pauseText = display.newText("Pause", _W/2,163 +10,"game_over",100)
    pauseGroup:insert(pauseText)
    --pauseText:setFillColor( 45 )

    resumeText = display.newText("Resume", _W/2,183+60,"game_over",80)
    pauseGroup:insert(resumeText)
    --resumeText:setFillColor( 45 )
    

    menuText = display.newText("Main Menu", _W/2,183+120,"game_over",80)
    pauseGroup:insert(menuText)	
	
	end
    
    startButton:removeEventListener( 'tap', startGame )

    function resumeGame()
        pauseGroup:removeSelf()
        resumeText:removeEventListener( "tap", resumeGame )
        menuText:removeEventListener( "tap", menuFunction )
        pauseButton:addEventListener( 'tap', pauseTouch )
        eventListeners("add")
    end

    function menuFunction()
                if (not(pauseGroup == nil)) then
                pauseGroup:removeSelf()
        end

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
    startButton.isVisible = false
    physics:start()
end   

function updateScore()
    scoreNum = scoreNum + 1
    scoreMod.set(scoreNum + 1) 
    scoreNumText.text = scoreMod.get()
    if(scoreMod.get() > scoreMod.load())then
        scoreMod.save()
    end
end


function update()
    if(playerBoost)then --going up w/ boost
        player.y = player.y - 2
        playerJump.y = playerJump.y - 2
    end

    if((playerBoost == false) and (player.y <= _H-51 - 50))then --going down after boost
        player.y = player.y + 3
    end


    --[[Warp Effect
    if((player.x < 0) or (playerJump.x < 0))then
        Runtime:removeEventListener( "accelerometer",  movePlayer)
        player.x = _W
        playerJump.x = _W
        Runtime:addEventListener( "accelerometer",  movePlayer)
    end

    if((player.x > _W + 30) or (playerJump.x > _W + 30))then
        Runtime:removeEventListener( "accelerometer",  movePlayer)
        player.x = 30
        playerJump.x = 30
        Runtime:addEventListener( "accelerometer",  movePlayer)
    end]]--


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
    group = display.newGroup()
    if(action == "lose")then
        local bg = display.newImageRect("images/space.png", 300,300)
        bg.x = _W/2
        bg.y = _H/2
        group:insert(bg)
        if((system.getInfo("platformName") == "iPhone OS") or (system.getInfo("environment") == "simulator"))then
        local text = display.newText("Game Over!", _W/2, _H/2 - 70,"Game Over", 124)
        group:insert(text)

        local scoreText = display.newText("Score: "..tostring(scoreMod.get()), _W/2, _H/2- 10,"Game Over", 124)
        group:insert(scoreText)
        else
		local text = display.newText("Game Over!", _W/2, _H/2 - 70,"game_over", 124)
        group:insert(text)

        local scoreText = display.newText("Score: "..tostring(scoreMod.get()), _W/2, _H/2- 10,"game_over", 124)
        group:insert(scoreText)
		
		end
         playAgain = display.newImageRect("images/playAgain.png",284, 45)
        playAgain.x = _W/2
        playAgain.y = _H/2 + 50
        group:insert(playAgain)
        playAgain:addEventListener( 'tap', playAgainTap)
    end
end

function playAgainTap(e)
    playAgain:removeEventListener( 'tap', playAgainTap)
    storyboard.gotoScene( "menuScreen")
end


function boostPlayer(e)
    if(e.phase == "began")then
        playerBoost = true
        player.isVisible = false
        playerJump.isVisible = true
        playerJump.x = player.x
        playerJump.y = player.y
    elseif(e.phase == "ended")then
        playerBoost = false
        player.isVisible = true        
        playerJump.isVisible = false
        playerJump.x = _W/2
        playerJump.y = -300
    end

end

function movePlayer(e)
    player.x = display.contentCenterX + ( display.contentCenterX*( e.xGravity*3 ) )
    playerJump.x = display.contentCenterX + ( display.contentCenterX*( e.xGravity*3 ) )
    if((player.x - player.width * 0.5) < 0)then
        player.x = player.width * 0.5;
        playerJump.x = playerJump.width * 0.5;
    elseif((player.x + player.width * 0.5)> display.contentWidth)then
        player.x = display.contentWidth - player.width * 0.5
        playerJump.x = display.contentWidth - playerJump.width * 0.5
    end 
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
        Runtime:removeEventListener( "accelerometer",  movePlayer)
        Runtime:removeEventListener('touch', boostPlayer)
        timer.cancel( scoreTimer )
    end
end

function gameScreen:exitScene(e)
    eventListeners("remove")
    gameGroup:removeSelf()
    if(not(group == nil))then
        group:removeSelf()
    end
    if(not(pauseGroup == nil))then
        pauseGroup:removeSelf()
    end
    pauseButton:removeEventListener('tap', pauseTouch)
    scoreNum = 0
    scoreNumText:removeSelf()
    scoreText:removeSelf()
    gameGroup = nil
end

gameScreen:addEventListener("enterScene",gameScreen)
gameScreen:addEventListener("exitScene",gameScreen)


return gameScreen
