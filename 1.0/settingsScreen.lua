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
	text = display.newText("SETTINGS", 160,100, "game over", 60)
	text:setFillColor(126/255,86/255,167/255)
	settingsGroup:insert(text)

	bg = display.newImageRect( "images/help.png", 320 , 80)
	bg.anchorX = 1
	bg.anchorY = 1
	bg.x = 320
	bg.y = 568
	settingsGroup:insert(bg)
	bg:addEventListener( "tap", addHelpScreen )


end
 
function addHelpScreen(e)
	settingsGroup:removeSelf()
	print("help tapped")


	

	helpTitle = display.newText("INSTRUCTIONS", 160,100, "game over", 60)
	helpTitle:setFillColor(126/255,86/255,167/255)
	instructionPage = display.newText("Tilt your device left or right to \n \n guide General Jump through \n \n the asteroid belt as he passes \n \n between obstacles. Avoid the \n \n space-rocks along the edges \n \n of General's path.", 100, 100,  "Game Over", 50 )
	instructionPage.anchorX = 0.5
	instructionPage.anchorY = 0.5
	instructionPage.x = _W/2 
	instructionPage.y = _H/2 





end

settingsScreen:addEventListener("enterScene", settingsScreen)

return settingsScreen

