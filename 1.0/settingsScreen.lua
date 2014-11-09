local storyboard = require("storyboard")

local settingsScreen = storyboard.newScene("settingsScreen")
local settingsGroup = display.newGroup()
local bg
local text
local helpTitle
local addHelpScreen = {}
local helpGroup = display.newGroup()
local helpBg

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
	
	helpBg = display.newText("Tilt screen left and right to guide General Jump and avoid the astroids. Try not to die!", 100, 100, native.systemFont, 24)
	helpBg = _W/2 - 200
	helpBg = _H/2

end
 
function addHelpScreen(e)
	settingsGroup:removeSelf()
	print("help tapped")


	

	helpTitle = display.newText("INSTRUCTIONS!", 160,100, "COCOGOOSE", 24)
	helpTitle:setFillColor(40/255,40/255,195/255)




end

settingsScreen:addEventListener("enterScene", settingsScreen)

return settingsScreen

