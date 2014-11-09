--variables

_W = display.contentWidth
_H = display.contentHeight

local storyboard = require("storyboard")

local menuScreen = storyboard.newScene("menuScreen")

local bg

local changeScreen = {}

local menuScreenGroup = display.newGroup()

local playBtn

local settingsBtn

local titleGJ





--functions

function menuScreen:enterScene(e)
	bg = display.newImageRect( "images/backgroundJump.jpg",_W,_H)
	bg.x = _W/2
	bg.y = _H/2
	menuScreenGroup:insert(bg)


	playBtn = display.newImageRect ("Icon-60.png", 200, 100)
	playBtn.x = _W/2
	playBtn.y = _H/2 
	playBtn:addEventListener( "tap", changeScreen )
	menuScreenGroup:insert (playBtn)


	settingsBtn = display.newImageRect( "images/cog.png", 50, 50 )
	settingsBtn.anchorX = 1
	settingsBtn.anchorY = 1
	settingsBtn.x = _W - 10
	settingsBtn.y = _H - 10
	settingsBtn:addEventListener( "tap", changeScreen )
	menuScreenGroup:insert (settingsBtn)

titleGJ = display.newImageRect("images/title.png",280, 130)
titleGJ.x = _W/2
titleGJ.y = _H/2-100

end



function changeScreen(e)
	if(e.target== settingsBtn)then
		storyboard.gotoScene("settingsScreen")
	end

	if(e.target == playBtn)then
		storyboard.gotoScene("gameScreen")
	end
end

function menuScreen:exitScene(e)	
	menuScreenGroup:removeSelf()
end

menuScreen:addEventListener( "enterScene", menuScreen )
menuScreen:addEventListener( "exitScene", menuScreen )

return menuScreen

