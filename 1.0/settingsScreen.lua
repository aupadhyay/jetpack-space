local storyboard = require("storyboard")

local settingsScreen = storyboard.newScene("settingsScreen")
local settingsGroup = display.newGroup()
local bg
local text
local helpTitle
local addHelpScreen = {}
local helpGroup = display.newGroup()
local helpBg
local bgImage
local instructionPage

function settingsScreen:enterScene(e)
	print ("SETTINGS!")
	text = display.newText("SETTINGS!", 160,100, "COCOGOOSE", 24)
	text:setFillColor(50/255,130/255,240/255)
	settingsGroup:insert(text)

	bg = display.newImageRect( "Icon-60.png",100,100)
	bg.x = 270
	bg.y = 475
	settingsGroup:insert(bg)
	bg:addEventListener( "tap", addHelpScreen )


end
 
function addHelpScreen(e)
	settingsGroup:removeSelf()
	print("help tapped")


	

	helpTitle = display.newText("INSTRUCTIONS", 160,100, "COCOGOOSE", 24)
	helpTitle:setFillColor(200/255,0/255,0/255)
	instructionPage = display.newText("Tilt your device left or right to \n \n guide General Jump through \n \n the asteroid belt as he passes \n \n between obstacles. Avoid the \n \n space-rocks along the edges \n \n of General's path.", 100, 100,  "Comic Sans MS", 20 )
	instructionPage.anchorX = 0.5
	instructionPage.anchorY = 0.5
	instructionPage.x = _W/2 
	instructionPage.y = _H/2 





end

settingsScreen:addEventListener("enterScene", settingsScreen)

return settingsScreen

