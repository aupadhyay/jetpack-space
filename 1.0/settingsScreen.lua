local storyboard = require("storyboard")

local settingsScreen = storyboard.newScene("settingsScreen")
local bg = ("Icon.png")


function settingsScreen:enterScene(e)
	print ("SETTINGS!")    
	local text = display.newText("SETTINGS!", 100,100, native.systemFont, 24)
end




settingsScreen:addEventListener("enterScene", settingsScreen)

return settingsScreen

