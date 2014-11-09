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
local backButton

function settingsScreen:enterScene(e)
	print ("SETTINGS!")

	text = display.newText("SETTINGS", 160,100, "8BIT WONDER", 20)
	text:setFillColor(50/255,130/255,240/255)
	settingsGroup:insert(text)

	bg = display.newImageRect( "images/helpButton.png", 284, 45)
	bg.x = _W/2
	bg.y = _H/2
	settingsGroup:insert(bg)
	bg:addEventListener( "tap", addHelpScreen )

	backButton = display.newImageRect( "images/backBtn.png", 100 , 100 )
	backButton.anchorX = 0
	backButton.anchorY = 0
	backButton.x = 0
	backButton.y = 0

	sun = display.newImageRect("images/Space-Thingy@1x.png", 160, 88)
    	sun.x = 70
    	sun.y = 30
	
    	mountain = display.newImageRect( "images/Moutnain@1x.png", 320, 141)
    	mountain.x = _W/2
    	mountain.y = _H - 60
end
 
function addHelpScreen(e)
	settingsGroup:removeSelf()
	print("help tapped")



	helpTitle = display.newText("INSTRUCTIONS", 160,100, "8BIT WONDER", 20)
	helpTitle:setFillColor(126/255,86/255,167/255)
	instructionPage = display.newText("Tilt your device left or right to \n \n guide General Jump through \n \n the asteroid belt as he passes \n \n between obstacles. Avoid the \n \n space-rocks along the edges \n \n of General's path.", 100, 100,  "Game Over", 50 )
	instructionPage.anchorX = 0.5
	instructionPage.anchorY = 0.5
	instructionPage.x = _W/2 
	instructionPage.y = _H/2 





end

settingsScreen:addEventListener("enterScene", settingsScreen)

return settingsScreen

