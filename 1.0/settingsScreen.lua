local storyboard = require("storyboard")
local widget = require("widget")


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
local creditsBtn
local backHelp
local instructionPage
local bgHelp
local backBtn
local highScoreFile
local highScoreText
local addMenuScreen = {}
local helpGroup = display.newGroup( )
local creditsGroup = display.newGroup( )
local backButtonTap = {}
local mute
local unmute
local bgCredits
local creditsTitle
local creditsText

function settingsScreen:enterScene(e)
	settingsGroup = display.newGroup()
	helpGroup = display.newGroup()

	if((system.getInfo("platformName") == "iPhone OS") or (system.getInfo("environment") == "simulator"))then
	text = display.newText("SETTINGS", 160,100, "8BIT WONDER", 24)
	text:setFillColor(126/255,86/255,167/255)
	settingsGroup:insert(text)
	else
	text = display.newText("SETTINGS", 160,100, "8-bit", 24)
	text:setFillColor(126/255,86/255,167/255)
	settingsGroup:insert(text)	
	end
	
	bg = display.newImageRect( "images/helpButton.png", 284, 45)
	bg.x = _W/2 
	bg.y = _H/2 + 50
	settingsGroup:insert(bg)
	bg:addEventListener( "tap", addHelpScreen )

	sun = display.newImageRect("images/Space-Thingy@1x.png", 160, 88)
	sun.x = 70
	sun.y = 30
	settingsGroup:insert(sun)


	mountain = display.newImageRect( "images/Moutnain@1x.png", 320, 141)
	mountain.x = _W/2
	mountain.y = _H - 60 - 50
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
	mute:addEventListener( 'tap', muteAudio )

	unmute = display.newImageRect("images/unmute.png", 100, 100)
	unmute.x = _W/2 + 60
	unmute.y = _H/2 - 80
	settingsGroup:insert(unmute)
	unmute:addEventListener( 'tap', unmuteAudio )

	creditsBtn = display.newImageRect("images/Credits@3x.png",284, 45)
	creditsBtn.x = _W/2 
	creditsBtn.y = _H/2 + 120
	settingsGroup:insert(creditsBtn)
	creditsBtn:addEventListener( "tap", addCreditsScreen )

	highScoreFile =io.open( system.pathForFile("scorefile.txt", system.DocumentsDirectory), "r" )
	if(highScoreFile)then
		print("highScoreFile Worked!")
	else
		highScoreFile = io.open(system.pathForFile("scorefile.txt", system.DocumentsDirectory), "w")
		highScoreFile:write(0)
		highScoreFile =io.open( system.pathForFile("scorefile.txt", system.DocumentsDirectory), "r" )
	end
	if((system.getInfo("platformName") == "iPhone OS") or (system.getInfo("environment") == "simulator"))then
	highScoreText = display.newText("High Score: ".. highScoreFile:read("*a"), _W/2, _H/2 - 10, "8BIT Wonder", 20)
	settingsGroup:insert(highScoreText)
	else
	highScoreText = display.newText("High Score: ".. highScoreFile:read("*a"), _W/2, _H/2 - 10, "8-bit", 20)
	settingsGroup:insert(highScoreText)	
	end
end


function muteAudio(e)
	audio.setVolume( 0 , {channel = 3} )
end

function unmuteAudio(e)
	audio.setVolume( 1 , {channel = 3} )
end
 

function backButtonTap(e)
	storyboard.gotoScene("menuScreen")
	helpGroup = nil
end

function addCreditsScreen(e)
	backBtn:removeEventListener( 'tap', backButtonTap )
	settingsGroup:removeSelf()
	settingsGroup = nil
	creditsGroup = display.newGroup()

	sun = display.newImageRect("images/Space-Thingy@1x.png", 160, 88)
	sun.x = 70
	sun.y = 30
	creditsGroup:insert(sun)

	if((system.getInfo("platformName") == "iPhone OS") or (system.getInfo("environment") == "simulator"))then
	creditsTitle = display.newText("Credits", _W - 100, 30, "8BIT WONDER", 24)
	creditsTitle:setFillColor(126/255,86/255,167/255)
	creditsGroup:insert(creditsTitle)
	else
	creditsTitle = display.newText("Credits", _W - 100, 30, "8-bit", 24)
	creditsTitle:setFillColor(126/255,86/255,167/255)
	creditsGroup:insert(creditsTitle)
	end
	backBtn = display.newImageRect("images/backBtn.png", 100, 30)
	backBtn.x = 60
	backBtn.y = 30
	creditsGroup:insert(backBtn)
	backBtn:addEventListener( "tap", backButtonTap )
	local options
	if((system.getInfo("platformName") == "iPhone OS") or (system.getInfo("environment") == "simulator"))then
		options  = {
		text= "Programmers:\nAbhi Upadhyay, Cyrus Vachha, Rohan Jayaprakash, Yash Gupta, Rayyaan Mustafa \n\n Images:\nEthan Chacko and Ruslan Grebeniouk",
		x = _W/2,
		y = _H/2,
		font = "Game Over",
		fontSize = 65,
		width = _W,
		align = "center"
	}
	else
		options  = {
		text= "Programmers:\nAbhi Upadhyay, Cyrus Vachha, Rohan Jayaprakash, Yash Gupta, Rayyaan Mustafa \n\n Images:\nEthan Chacko and Ruslan Grebeniouk",
		x = _W/2,
		y = _H/2,
		font = "game_over",
		fontSize = 65,
		width = _W,
		align = "center"
	}
	end
	programmers = display.newText(options)
	programmers.anchorX = 0.5
	programmers.anchorY = 0.5
	creditsGroup:insert(programmers)
end

function addHelpScreen(e)
	backBtn:removeEventListener( 'tap', backButtonTap )
	settingsGroup:removeSelf()
	settingsGroup = nil
	helpGroup = display.newGroup()


	sun = display.newImageRect("images/Space-Thingy@1x.png", 160, 88)
	sun.x = 70
	sun.y = 30
	helpGroup:insert(sun)

	mountain = display.newImageRect( "images/Moutnain@1x.png", 320, 141)
	mountain.x = _W/2
	mountain.y = _H - 60 - 50
	helpGroup:insert (mountain)
	local options
	if((system.getInfo("platformName") == "iPhone OS") or (system.getInfo("environment") == "simulator"))then
	helpTitle = display.newText("INSTRUCTIONS", 160,100, "8BIT WONDER", 24)
	helpTitle:setFillColor(126/255,86/255,167/255)
	helpGroup:insert(helpTitle)
	
	options  = {
		text = "Tilt your device left or right to guide Colonel Comet through the asteroid belt as he passes between obstacles.",
		x = _W/2,
		y = _H/2,
		font = "Game Over",
		fontSize = 65,
		width = _W - 10,
		align = "center"

	}
	else
	helpTitle = display.newText("INSTRUCTIONS", 160,100, "8-bit", 24)
	helpTitle:setFillColor(126/255,86/255,167/255)
	helpGroup:insert(helpTitle)
	
	options  = {
		text = "Tilt your device left or right to guide Colonel Comet through the asteroid belt as he passes between obstacles.",
		x = _W/2,
		y = _H/2,
		font = "game_over",
		fontSize = 65,
		width = _W - 10,--10 is the margin
		align = "center"

	}
	end

	instructionPage = display.newText(options)
	instructionPage.anchorX = 0.5
	instructionPage.anchorY = 0.5
	helpGroup:insert(instructionPage)


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

	if(not(creditsGroup == nil))then
		creditsGroup:removeSelf()
	end
end

settingsScreen:addEventListener("enterScene", settingsScreen)
settingsScreen:addEventListener("exitScene", settingsScreen)

helpGroup:addEventListener("enterScene", helpGroup)
helpGroup:addEventListener( "exitScene", helpGroup )

return settingsScreen

