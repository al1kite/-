-----------------------------------------------------------------------------------------
--
-- start.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	-- 배경1(흰색 바탕) --
	local background =display.newRect(display.contentWidth/2, display.contentHeight/2, 
		display.contentWidth, display.contentHeight) 
	background:setFillColor(1)
	sceneGroup:insert(background)

	local backgroundMusic = audio.loadStream( "music/startMusic.wav" )
	local backgroundMusicChannel = audio.play( backgroundMusic, { loops=-1 }  )

	local bg = display.newImageRect("images/start.jpg", 1280, 720)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	sceneGroup:insert(bg)

	local play = display.newImageRect("images/gameStart.png", 330, 110)
	play.x = 1100
	play.y = 650
	sceneGroup:insert(play)

	local function playing(event)
		composer.removeScene("start")
		composer.gotoScene("view1")
		audio.pause( backgroundMusicChannel )
	end

	play:addEventListener("tap", playing)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene