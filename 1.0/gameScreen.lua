
--initiating libraries 
local storyboard = require "storyboard"



local gameScreen = storyboard.newScene("gaemScreen")

--basic variables
_W = display.contentWidth
_H = display.contentHeight


--game elements
local bg
local scoreChart
local scoreText
local scoreNumText
local pauseButton
local leftWall
local rightWall
local player
local startButton
local startGame = {}

function gameScreen:createScene(e)
--Game Elements

    bg = display.newImageRect("Icon-60.png",_W,_H)--insert proper image
    bg.anchorX = 0.5
    bg.anchorY = 0.5
    bg.x = _W/2
    bg.y = _H/2
    
    startButton = display.newImageRect("Icon-60", 270,50)--insert proper image
    startButton.anchorX = 0.5
    startButton.anchorY = 0.5
    startButton.x = _W/2
    startButton.y = _H/2
    startButton:addEventListener(startGame,"touch")

    --Score Chart
    scoreChart = display.newImageRect("Icon-72.png",_W,70)--insert proper image
    scoreChart.anchorX = 0.5
    scoreChart.anchorY = 0.5
    scoreChart.x = _W/2
    scoreChart.y = 35
    
    scoreText = display.newText("Score:",_W/2,460,30,native.systemFont)--insert proper font
    scoreText:setColor(255,124,46)
    
    scoreNumText = display.newText(scoreNum,260,30,36,native.systemFont)--insert proper font
    scoreNumText:setColor( 245, 53, 45 )
    
    pauseButton = display.newImageRect("Icon-60.png",30,30)--insert proper image
    pauseButton.anchorX = 0.5
    pauseButton.anchorY = 0.5
    pauseButton.x = 35
    pauseButton.y = 35
    
    --------------

    --Game Playable Elements

    leftWall = display.newImageRect("Icon-76",45,_H)--insert proper image
    leftWall.anchorX = 0.5
    leftWall.anchorY = 0.5
    leftWall.x = 22
    leftWall.y = _H/2

    rightWall = display.newImageRect("Icon-76",45,_H)--insert proper image
    rightWall.anchorX = 0.5
    rightWall.anchorY = 0.5
    rightWall.x = 298
    rightWall.y = _H/2

    player = display.newImageRect("Icon-60", 60,50)--insert proper image
    player.anchorX = 0.5
    player.anchorY = 0.5
    player.x = _W/2
    player.y = _H-30
end


--GAME FUNCTIONS
    
function startGame(e)
    
    print "The Game has Started!"
end   




gameScreen:addEventListener("creatScene",gameScreen)


return gameScreen