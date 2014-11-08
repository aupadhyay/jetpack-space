local storyboard = require("storyboard")

local settingsScreen = storyboard.newScene("settingsScreen")
local bg = ("Icon.png")


function settingsScreen:enterScene(e)
<<<<<<< HEAD
	print ("SETTINGS!")    
	local text = display.newText("SETTINGS!", 100,100, native.systemFont, 24)
=======
print ("SETTINGS!")
local text = display.newText("SETTINGS!", 100,100,native.systemFont, 24)
>>>>>>> 2214e87295518a906258712d37cf668339dc7fff
end




settingsScreen:addEventListener("enterScene", settingsScreen)

return settingsScreen

