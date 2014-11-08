local storyboard = require("storyboard")

local settingsScreen = storyboard.newScene("settingsScreen")
local bg = ("Icon.png")


function settingsScreen:enterScene(e)
print ("SETTINGS!")
local text = display.newText("SETTINGS!", 160,0, "COCOGOOSE", 24)
text:setFillColor(50/255,130/255,240/255)
end


function menuScreen:enterScene(e)
	bg = display.newImageRect( "Icon-60.png",100,100)
	bg.x = 270
	bg.y = 475
	bg:addEventListener( "tap", changeScreen )
end



settingsScreen:addEventListener("enterScene", settingsScreen)

return settingsScreen

