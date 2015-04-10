--variables

_W = display.contentWidth
_H = display.contentHeight

local storyboard = require("storyboard")
local ads = require "ads"
local provider = "admob"
if(system.getInfo("platformName") == "Android")then
    appID = "ca-app-pub-6411000418609328/5551532299"
elseif(system.getInfo("platformName") == "iPhone")then
     appID= "ca-app-pub-6411000418609328/2598065893"
end



local menuScreen = storyboard.newScene("menuScreen")

local bg
local bg2
local bg3
local changeScreen = {}
local menuScreenGroup = display.newGroup()
local playBtn
local settingsBtn
local title
local sun
local developerBtn
local mountain
system.activate("multitouch")
local music = audio.loadSound( "music/gameMusic.mp3" )
local musicPlay = audio.play(music, {	channel = 3,
		loops = -1
	})

--function

function menuScreen:createScene(e)
	gameListeners("add")
	local function adListener( event )
    end
    if(system.getInfo("platformName") == "iPhone OS")then
	    ads.init( adNetwork,"ca-app-pub-6411000418609328/2598065893", adListener )
		ads.show( "banner",{ x=0, y=_H - 50, appID = "ca-app-pub-6411000418609328/2598065893"} )
    else
		ads.init( adNetwork,"ca-app-pub-6411000418609328/5551532299", adListener )
		ads.show( "banner",{ x=0, y=_H - 50, appID = "ca-app-pub-6411000418609328/5551532299"} )	
    end
end


function menuScreen:enterScene(e)
	bg = display.newImageRect( "images/stars2.png",_W,_H)
	bg.x = 0
	bg.y = _H/2 - 50
	bg.anchorX = 0
	

	bg2 = display.newImageRect( "images/stars2.png",_W,_H)
	bg2.x = _W
	bg2.y = _H/2 - 50
	bg2.anchorX = 0
	

	bg3 = display.newImageRect( "images/stars2.png",_W,_H)
	bg3.x = _W*2
	bg3.y = _H/2 - 50
	bg3.anchorX = 0


	menuScreenGroup = display.newGroup()


	playBtn = display.newImageRect ("images/Play@1x.png", 284, 45)
	playBtn.x = _W/2
	playBtn.y = _H/2 
	playBtn:addEventListener( "tap", changeScreen )
	menuScreenGroup:insert (playBtn)

	mountain = display.newImageRect( "images/Moutnain@1x.png", 320, 141)
	mountain.x = _W/2
	mountain.y = _H - 60 - 50
	menuScreenGroup:insert(mountain)
	
	settingsBtn = display.newImageRect( "images/Settings@1x.png", 284, 45 )
	settingsBtn.anchorX = 0.5
	settingsBtn.anchorY = 0.5
	settingsBtn.x = _W/2
	settingsBtn.y = _H/2 + 75 
	settingsBtn:addEventListener( "tap", changeScreen )
	menuScreenGroup:insert (settingsBtn)

	sun = display.newImageRect("images/Space-Thingy@1x.png", 160, 88)
	sun.x = 70
	sun.y = 30
	menuScreenGroup:insert(sun)
	
	title = display.newImageRect("images/title_1.png", 220, 100)
	title.x = _W/2
	title.y = _H/2 - 100
	menuScreenGroup:insert(title)


	developerBtn = display.newImageRect("images/Developer@1x.png", 284, 45)
	developerBtn.x = _W/2
	developerBtn.y = _H/2 + 150
	developerBtn:addEventListener( 'tap', developerTap )
	menuScreenGroup:insert(developerBtn)



	function adListener(e)
	end
	if(system.getInfo("platformName") == "iPhone OS")then
		ads.init("admob", "test", adListener)
		ads.show("banner", {x=0, y=_H - 50, "test", testMode = true})
	else
		ads.init("admob", "test", adListener)
		ads.show("banner", {x=0, y=_H-50, "test", testMode = true})
	end



end


function developerTap(e)
	system.openURL("http://www.blazegamestudios.webs.com")
end
function update()
	if(not(bg2 == nil))then
		bg.x = bg.x - 4
		bg2.x = bg2.x - 4
		bg3.x = bg3.x - 4

		if (bg.x + bg.contentWidth) < 0 then
			bg:translate( _W*3, 0)
		end
		if (bg2.x + bg2.contentWidth) < 0 then
			bg2:translate( _W*3, 0)
		end
		if (bg3.x + bg3.contentWidth) < 0 then
			bg3:translate(_W*3, 0  )
		end
	end
end



function changeScreen(e)
	if(e.target== settingsBtn)then
		playBtn:removeEventListener( 'tap', changeScreen )
		developerBtn:removeEventListener( 'tap', developerTap )
		settingsBtn:removeEventListener( 'tap', changeScreen )
		storyboard.gotoScene("settingsScreen")
	end

	if(e.target == playBtn)then
		playBtn:removeEventListener( 'tap', changeScreen )
		developerBtn:removeEventListener( 'tap', developerTap )
		settingsBtn:removeEventListener( 'tap', changeScreen )
		storyboard.gotoScene("gameScreen")
	end
end

function menuScreen:exitScene(e)
	gameListeners("remove")
	if (not(menuScreenGroup==nil)) then
	menuScreenGroup:removeSelf()
    end
end

function gameListeners(action)
	if(action == "add")then
		Runtime:addEventListener( "enterFrame", update)
	end
	if(action == "remove")then
		--Runtime:removeEventListener( "enterFrame", update)
	end
end

menuScreen:addEventListener( "enterScene", menuScreen )
menuScreen:addEventListener( "exitScene", menuScreen )
menuScreen:addEventListener( "createScene", menuScreen )


return menuScreen

