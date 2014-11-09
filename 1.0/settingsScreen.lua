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
local background
local backHelp
local instructionPage
local bgHelp
local backBtn
local addMenuScreen = {}
local helpGroup = display.newGroup( )
local backButtonTap = {}
local mute
local unmute
local logo

function settingsScreen:enterScene(e)
	settingsGroup = display.newGroup()
	helpGroup = display.newGroup()
	print ("SETTINGS!")

	background = display.newImageRect("images/stars2.png", _W, _H)
	background.x = _W/2
	background.y = _H/2
	settingsGroup:insert(background)

	text = display.newText("SETTINGS", 160,100, "8BIT WONDER", 24)
	text:setFillColor(126/255,86/255,167/255)
	settingsGroup:insert(text)


	bg = display.newImageRect( "images/helpButton.png", 284, 45)
	bg.x = _W/2 
	bg.y = _H/2 + 30
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

	mute = display.newImageRect("images/mute.png", 100, 100)
	mute.x = _W/2 - 60
	mute.y = _H/2 - 80
	settingsGroup:insert(mute)

	unmute = display.newImageRect("images/unmute.png", 100, 100)
	unmute.x = _W/2 + 60
	unmute.y = _H/2 - 80
	settingsGroup:insert(unmute)


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

	bgHelp = display.newImageRect("images/stars2.png", _W, _H)
	bgHelp.x = _W/2
	bgHelp.y = _H/2
	helpGroup:insert(bgHelp)

	sun = display.newImageRect("images/Space-Thingy@1x.png", 160, 88)
	sun.x = 70
	sun.y = 30
	helpGroup:insert(sun)

	mountain = display.newImageRect( "images/Moutnain@1x.png", 320, 141)
	mountain.x = _W/2
	mountain.y = _H - 60
	helpGroup:insert (mountain)

	helpTitle = display.newText("INSTRUCTIONS", 160,100, "8BIT WONDER", 24)
	helpTitle:setFillColor(126/255,86/255,167/255)
	helpGroup:insert(helpTitle)

	local options  = {
		text = "Tilt your device left or right to guide Colonel Comet through the asteroid belt as he passes between obstacles.",
		x = _W/2 + 10,
		y = _H/2 + 150,
		font = "Game Over",
		fontSize = 70,
		width = _W,
		height = _H,
		align = center

	}


	instructionPage = display.newText(options)
	instructionPage.anchorX = 0.5
	instructionPage.anchorY = 0.5
	helpGroup:insert(instructionPage)

	--logo = display.newImageRect("images/blazeStudiosLogo.png", 300, 140)
	--logo.anchorX = 1
	--logo.anchorY = 1
	--logo.x = _W/2 + 170
	--logo.y = _H/2 + 280

	backHelp = display.newImageRect( "images/backBtn.png" , 100, 30)
	backHelp.x = 60
	backHelp.y = 20
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

