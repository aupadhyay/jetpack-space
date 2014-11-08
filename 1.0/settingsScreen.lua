local storyboard = require("storyboard")

local settingsScreen = storyboard.newScene("settingsScreen")
local bg
local text
local addHelpScreen = {}


function settingsScreen:enterScene(e)
	print ("SETTINGS!")
	text = display.newText("SETTINGS!", 160,100, "COCOGOOSE", 24)
	text:setFillColor(50/255,130/255,240/255)

	bg = display.newImageRect( "Icon-60.png",100,100)
	bg.x = 270
	bg.y = 475
	bg:addEventListener( "tap", addHelpScreen )
end


function addHelpScreen(e)
	print("help tapped")
end

settingsScreen:addEventListener("enterScene", settingsScreen)

return settingsScreen

