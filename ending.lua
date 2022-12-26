
local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local backgroundMusic = audio.loadStream( "music/endMusic.wav" )
	local backgroundMusicChannel = audio.play( backgroundMusic, { loops=-1 }  ) 

	local background = display.newImageRect("images/pass.jpg", 1280, 720)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local Text1 = display.newText("우리를 도와줘서", 1000, 470, "HSSaemaul-Regular.ttf", 90)
		Text1:setFillColor( 1 )
		
	local Text2 = display.newText("고마워♥", 1000, 570, "HSSaemaul-Regular.ttf",90)
		Text2:setFillColor( 1 )
	sceneGroup:insert(background)
	sceneGroup:insert(Text2)
	sceneGroup:insert(Text1)

	local start = display.newImageRect("images/back.png", 80, 80)
	start.x = 1230
	start.y = 670
	

	local function re(event)
		composer.removeScene("ending")
		composer.gotoScene("start")
		audio.pause( backgroundMusicChannel )
	end

	start:addEventListener("tap", re)

	sceneGroup:insert(start)
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
		composer.removeScene("view1")
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