-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect("Content/PNG/메인게임화면.png", 1280, 720)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local backgroundMusic = audio.loadStream( "music/subMusic.mp3" )
	local backgroundMusicChannel = audio.play( backgroundMusic, { loops=-1 }  ) 

	local star1 = composer.getVariable("ending")
	local star2 = composer.getVariable("ending2")
	local star3 = composer.getVariable("ending3")

	local tree1
	local tree2
	local treeGroup = display.newGroup()
	
	local function none(event)
		local noneText = display.newText("잠겨있습니다", 675, 400, "HSSaemaul-Regular.ttf", 30)
		noneText:setFillColor( 1, 0, 0 )
		transition.fadeOut( noneText, { time=1300 } )
	end
	local function ending(event)
		composer.gotoScene("ending")
		audio.pause( backgroundMusicChannel )
	end

	print(star1)
	print(star2)
	print(star3)
	if star1 and star2 and star3 then
		tree1 = display.newImageRect(treeGroup, "images/tree.png", 230, 230)
		tree1.x, tree1.y = 650, 470
		
		tree1:addEventListener("tap", ending)
	else
		tree2 = display.newImageRect(treeGroup, "images/tree2.png", 230, 230)
		tree2.x, tree2.y = 670, 450
		tree2:addEventListener("tap", none)
	end
	
	sceneGroup:insert(treeGroup)

	-- 락부분
	local game = {}
	local gameGroup = display.newGroup()
	
	game[1]=display.newImageRect(gameGroup,"Content/PNG/메인게임화면버튼.png",130,130)
	game[2]=display.newImageRect(gameGroup,"Content/PNG/메인게임화면미니게임버튼.png",80,120)
	game[3]=display.newImageRect(gameGroup,"Content/PNG/메인게임화면버튼.png",130,130)
	game[4]=display.newImageRect(gameGroup,"Content/PNG/메인게임화면미니게임버튼.png",80,120)
	game[5]=display.newImageRect(gameGroup,"Content/PNG/메인게임화면미니게임버튼.png",80,120)
	game[6]=display.newImageRect(gameGroup,"Content/PNG/메인게임화면버튼.png",130,130)

	game[1].x,game[1].y=display.contentWidth*0.13,display.contentHeight*0.52
	game[2].x,game[2].y=display.contentWidth*0.31,display.contentHeight*0.64
	game[3].x,game[3].y=display.contentWidth*0.43,display.contentHeight*0.4
	game[4].x,game[4].y=display.contentWidth*0.63,display.contentHeight*0.4
	game[5].x,game[5].y=display.contentWidth*0.72,display.contentHeight*0.62
	game[6].x,game[6].y=display.contentWidth*0.90,display.contentHeight*0.52

	local function touch1(event)
		composer.gotoScene("gamestory1")
		audio.pause( backgroundMusicChannel )
	end
	game[1]:addEventListener("tap",touch1)

	local function touch2(event)
		composer.gotoScene("ministory1")
		audio.pause( backgroundMusicChannel )
	end
	game[2]:addEventListener("tap",touch2)

	local function touch3(event)
		composer.gotoScene("gamestory2")
		audio.pause( backgroundMusicChannel )
	end
	game[3]:addEventListener("tap",touch3)

	local function touch4(event)
		composer.gotoScene("ministory2")
		audio.pause( backgroundMusicChannel )
	end
	game[4]:addEventListener("tap",touch4)

	local function touch5(event)
		composer.gotoScene("ministory3")
		audio.pause( backgroundMusicChannel )
	end
	game[5]:addEventListener("tap",touch5)
	
	local function touch6(event)
		composer.gotoScene("gamestory3")
		audio.pause( backgroundMusicChannel )
	end
	game[6]:addEventListener("tap",touch6)
	
	sceneGroup:insert(background)
	sceneGroup:insert(gameGroup)

	local button = display.newImageRect("images/search.png", 70, 70)
	button.x = 1210
	button.y = 195
	sceneGroup:insert(button)

	local function go(event)
		composer.gotoScene("search")
		audio.pause( backgroundMusicChannel )
	end

	button:addEventListener("tap", go)
	treeGroup:toFront()
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
		--sceneGroup:insert(noneText)
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