--variables

_W = display.contentWidth
_H = display.contentHeight

local storyboard = require("storyboard")

local menuScreen = storyboard.newScene("menuScreen")

local bg
local bg2
local bg3
local changeScreen = {}
local menuScreenGroup = display.newGroup()
local playBtn
local settingsBtn
local title
local sun
local mountain



--functions

function menuScreen:enterScene(e)
	menuScreenGroup = display.newGroup()
	gameListeners("add")
	bg = display.newImageRect( "images/stars2.png",_W,_H)
	bg.x = 0
	bg.y = _H/2
	bg.anchorX = 0
	menuScreenGroup:insert(bg)

	bg2 = display.newImageRect( "images/stars2.png",_W,_H)
	bg2.x = _W
	bg2.y = _H/2
	bg2.anchorX = 0
	menuScreenGroup:insert(bg2)

	bg3 = display.newImageRect( "images/stars2.png",_W,_H)
	bg3.x = _W*2
	bg3.y = _H/2
	bg3.anchorX = 0
	menuScreenGroup:insert(bg3)


	playBtn = display.newImageRect ("images/Play@1x.png", 284, 45)
	playBtn.x = _W/2
	playBtn.y = _H/2 
	playBtn:addEventListener( "tap", changeScreen )
	menuScreenGroup:insert (playBtn)

	settingsBtn = display.newImageRect( "images/Settings@1x.png", 284, 45 )
	settingsBtn.anchorX = 0.5
	settingsBtn.anchorY = 0.5
	settingsBtn.x = _W/2
	settingsBtn.y = _H/2 + 75 
	settingsBtn:addEventListener( "tap", changeScreen )
	menuScreenGroup:insert (settingsBtn)

	sun = display.newImageRect("images/Space-Thingy@1x.png", 160, 88)
	sun.x = 70
	sun.y = 30

	menuScreenGroup:insert(sun)
	title = display.newImageRect("images/title.png", 220, 100)
	title.x = _W/2
	title.y = _H/2 - 100
	menuScreenGroup:insert(title)

	mountain = display.newImageRect( "images/Moutnain@1x.png", 320, 141)
	mountain.x = _W/2
	mountain.y = _H - 60
	menuScreenGroup:insert(mountain)

end

function update()
	if(not(bg2 == nil))then
		bg.x = bg.x - 4
		bg2.x = bg2.x - 4
		bg3.x = bg3.x - 4

		if (bg.x + bg.contentWidth) < 0 then
			bg:translate( _W*3, 0)
		end
		if (bg2.x + bg2.contentWidth) < 0 then
			bg2:translate( _W*3, 0)
		end
		if (bg3.x + bg3.contentWidth) < 0 then
			bg3:translate(_W*3, 0  )
		end
	end
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
	gameListeners("remove")
	menuScreenGroup:removeSelf()
end

function gameListeners(action)
	if(action == "add")then
		Runtime:addEventListener( "enterFrame", update)
	end
	if(action == "remove")then
		Runtime:removeEventListener( "enterFrame", update)
	end
end

menuScreen:addEventListener( "enterScene", menuScreen )
menuScreen:addEventListener( "exitScene", menuScreen )


return menuScreen

