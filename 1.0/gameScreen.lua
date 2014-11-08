
--initiating libraries 
local storyboard = require "storyboard"


--basic varibles
_W = display.contentWidth
_H = display.contentHeight


--game elements
local bg
local scoreChart
local scoreText
local scoreNumText
local pauseButton

function gameScreen:createScene(e)
    
    bg = display.newImageRect("Icon-60.png",320,480)--insert proper image
    bg.anchorX = 0.5
    bg.anchorY = 0.5
    bg.x = _W/2
    bg.y = _H/2
    
    
    scoreChart = display.newImageRect("Icon-72.png",320,50)--insert proper image
    scoreChart.anchorX = 0.5
    scoreChart.anchorY = 0.5
    scoreChart.x = _W/2
    scoreChart.y = _H-25
    
    scoreText = display.newText("Score:",_W/2,_H-30,36,native.systemFont)
    scoreText:setColor(255,124,46)
    
    scoreNumText = display.newText(scoreNum,_W/2+50,_H-30,36,native.systemFont)
    scoreNumText:setColor( 245, 53, 45 )
    
  
end








return gameScreen