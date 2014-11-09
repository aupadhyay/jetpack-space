local storyboard = require("storyboard")

local settingsScreen = storyboard.newScene("settingsScreen")
local settingsGroup = display.newGroup()
local bg
local text
local helpTitle
local addHelpScreen = {}
local helpGroup = display.newGroup()
local helpBg
local sun 
local mountain
local bgImage
local backHelp
local instructionPage
local backBtn
local addMenuScreen = {}
local helpGroup = display.newGroup( )
local backButtonTap = {}

function settingsScreen:enterScene(e)
	settingsGroup = display.newGroup()
	helpGroup = display.newGroup()
	print ("SETTINGS!")

	text = display.newText("SETTINGS", 160,100, "8BIT WONDER", 20)
	text:setFillColor(50/255,130/255,240/255)
	settingsGroup:insert(text)

	bg = display.newImageRect( "images/helpButton.png", 284, 45)
	bg.x = _W/2
	bg.y = _H/2
	settingsGroup:insert(bg)
	bg:addEventListener( "tap", addHelpScreen )

	sun = display.newImageRect("images/Space-Thingy@1x.png", 160, 88)
	sun.x = 70
	sun.y = 30
	settingsGroup:insert(sun)


	mountain = display.newImageRect( "images/Moutnain@1x.png", 320, 141)
	mountain.x = _W/2
	mountain.y = _H - 60
	settingsGroup:insert (mountain)

	backBtn = display.newImageRect("images/backBtn.png", 100, 30)
	backBtn.x = 60
	backBtn.y = 30
	settingsGroup:insert(backBtn)
	backBtn:addEventListener( "tap", backButtonTap )
end
 
function backButtonTap(e)
	print("tap")
	storyboard.gotoScene("menuScreen")
	helpGroup = nil
end


function addHelpScreen(e)
	backBtn:removeEventListener( 'tap', backButtonTap )
	settingsGroup:removeSelf()
	settingsGroup = nil
	helpGroup = display.newGroup()
	print("help tapped")



	helpTitle = display.newText("INSTRUCTIONS", 160,100, "8BIT WONDER", 20)
	helpTitle:setFillColor(126/255,86/255,167/255)
	helpGroup:insert(helpTitle)

	instructionPage = display.newText("Tilt your device left or right to \n \n guide General Jump through \n \n the asteroid belt as he passes \n \n between obstacles. Avoid the \n \n space-rocks along the edges \n \n of General's path.", 100, 100,  "Game Over", 50 )
	instructionPage.anchorX = 0.5
	instructionPage.anchorY = 0.5
	instructionPage.x = _W/2 
	instructionPage.y = _H/2 
	helpGroup:insert(instructionPage)

	backHelp = display.newImageRect( "images/backBtn.png" , 100, 30)
	backHelp.x = 60
	backHelp.y = 30
	backHelp:addEventListener( "tap", backButtonTap )
	helpGroup:insert(backHelp)

end

function settingsScreen:exitScene(e)
	if(not(settingsGroup == nil))then
		settingsGroup:removeSelf()
	end

	if(not(helpGroup == nil))then
		helpGroup:removeSelf()
	end
end

settingsScreen:addEventListener("enterScene", settingsScreen)
settingsScreen:addEventListener("exitScene", settingsScreen)

helpGroup:addEventListener("enterScene", helpGroup)
helpGroup:addEventListener( "exitScene", helpGroup )

return settingsScreen

