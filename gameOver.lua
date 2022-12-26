-----------------------------------------------------------------------------------------
--
-- gameOver.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local bg = display.newImageRect("images/start.png", 1280, 720)
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	sceneGroup:insert(bg)

	local searchBg2 =display.newRect(display.contentWidth/2, display.contentHeight/2, 1000, 500) 
	searchBg2:setFillColor(1)
	sceneGroup:insert(searchBg2)

	local button = display.newImageRect("images/x.png", 100, 100)
	button.x = 1100
	button.y = 150
	sceneGroup:insert(button)

	local searchText = display.newText( "게임설명", display.contentWidth/2, display.contentHeight/2, native.systemFont, 100 )
	searchText:setFillColor( 0.4, 0.4, 0.8 )
	sceneGroup:insert(searchText)

	local function back(event)
		composer.gotoScene("start")
	end

	button:addEventListener("tap", back)
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