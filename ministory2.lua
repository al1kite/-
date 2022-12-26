local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	minibackgroundMusic = audio.loadStream( "music/bad.mp3" )
	minibackgroundMusicChannel = audio.play( minibackgroundMusic, { loops=-1 }  ) 

-- [배경화면]

local bg = display.newImageRect("images/bg.png",1280,720)
bg.x, bg.y = display.contentWidth*0.5, display.contentHeight*0.5
sceneGroup:insert(bg)
-- [게임설명창]

local title
local titleMsg
local playBtn
local titleView

local title1Group = display.newGroup()
-- 게임설명창

	title = display.newImage(title1Group,"images/title.png", 1280, 720)
	title.x, title.y = display.contentWidth*0.5, display.contentHeight*0.5
	titleMsg = display.newImage(title1Group,'images/titleMsg1.png')
	titleMsg.x, titleMsg.y = display.contentWidth*0.5, display.contentHeight*0.45
	titleView = display.newGroup(title, titleMsg, playBtn)
	sceneGroup:insert(title1Group)

local playBtn = display.newImage('images/playBtn.png', display.contentCenterX, display.contentCenterY+210)
	sceneGroup:insert(playBtn)

	local function playing(event)
		composer.removeScene("ministory2")
		composer.gotoScene("subGame2")
	end

	playBtn:addEventListener("tap", playing)
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