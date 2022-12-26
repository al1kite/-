-----------------------------------------------------------------------------------------
--메인 게임 3라운드 결과
-- view4.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- 성공, 실패 --
function scene:create( event )
	local sceneGroup = self.view

	local function win(event)
		print("win")
		composer.removeScene("view4")
		composer.setVariable("ending3", true)
		composer.gotoScene("view1")
	end

	local function gameOver(event)
		print("gameOver")
		composer.removeScene("view4")
		composer.gotoScene("mgGame3")
	end

	local result = composer.getVariable("complete")

	if result then
		local bg1 = display.newImageRect("image/pass.jpg", 1280, 720)
		bg1.x = display.contentCenterX
		bg1.y = display.contentCenterY
		sceneGroup:insert(bg1)

		local next = display.newImageRect("image/next.png", 200, 140)
		next.x, next.y = display.contentWidth*0.9, display.contentHeight*0.85
		sceneGroup:insert(next)

		next:addEventListener("tap", win)
	else
		local bg2 = display.newImageRect("images/fail.jpg", 1280, 720)
		bg2.x = display.contentCenterX
		bg2.y = display.contentCenterY
		sceneGroup:insert(bg2)

		local back = display.newImageRect("images/restart.png", 300, 100)
		back.x, back.y = display.contentWidth*0.85, display.contentHeight*0.85
		sceneGroup:insert(back)

		back:addEventListener("tap", gameOver)
	end
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
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
