-----------------------------------------------------------------------------------------
--
-- mgGame.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local sceneGroup = self.view

	-- 성공음 --
	local success = audio.loadSound("audio/success.mp3")

	-- 배경1(흰색 바탕)
	local background = display.newRect(display.contentWidth, display.contentHeight, 
		display.contentWidth, display.contentHeight) 
	background:setFillColor(1)
	sceneGroup:insert(background)

	-- 배경2(숲) --
	local bg1 = display.newImageRect("image/forest.jpg", 1280, 720)
	bg1.x, bg1.y = display.contentCenterX, display.contentCenterY
	sceneGroup:insert(bg1)

	-- 동물 먹이1(도토리) -- 
	local food1 ={ }
	local food1Group = display.newGroup()

	food1[1] = display.newImageRect(food1Group, "image/food1_3.png", 50, 50)
	food1[2] = display.newImageRect(food1Group, "image/food1_2.png", 50, 50 )
	food1[3] = display.newImageRect(food1Group, "image/food1_3.png", 50, 50)
	food1[4] = display.newImageRect(food1Group, "image/food1_2.png", 50, 50)
	food1[5] = display.newImageRect(food1Group, "image/food1_3.png", 50, 50)

	-- 동물 먹이1(도토리) 위치 --
	food1[1].x, food1[1].y = display.contentWidth*0.06, display.contentHeight*0.33
	food1[2].x, food1[2].y = display.contentWidth*0.23, display.contentHeight*0.73
	food1[3].x, food1[3].y = display.contentWidth*0.53, display.contentHeight*0.63
	food1[4].x, food1[4].y = display.contentWidth*0.92, display.contentHeight*0.45
	food1[5].x, food1[5].y = display.contentWidth*0.438, display.contentHeight*0.367
	sceneGroup:insert(food1Group)


	-- 정답 버튼 --
	local button ={ }
	local buttonGroup = display.newGroup()

	for i =1, 5 do
		buttonGroup[i] = display.newImageRect(buttonGroup, "image/empty.png", 50, 50)
	end

	-- 정답 버튼 위치 --

	buttonGroup[1].x, buttonGroup[1].y = display.contentWidth*0.2, display.contentHeight*0.93
	buttonGroup[2].x, buttonGroup[2].y = display.contentWidth*0.25, display.contentHeight*0.93
	buttonGroup[3].x, buttonGroup[3].y = display.contentWidth*0.3, display.contentHeight*0.93
	buttonGroup[4].x, buttonGroup[4].y = display.contentWidth*0.35, display.contentHeight*0.93
	buttonGroup[5].x, buttonGroup[5].y = display.contentWidth*0.4, display.contentHeight*0.93
	sceneGroup:insert(buttonGroup)
	

	-- 동물1 (다람쥐)  --
	local animal1 = display.newImageRect("image/animal1.png", 280, 280) 
	animal1.x, animal1.y = display.contentWidth*0.08, display.contentHeight*0.85
	sceneGroup:insert(animal1)


	-- 점수 --
	local score =0
	

	for i = 1, 5 do
		food1[i].id = i .. "번 도토리"
	end


	-- 먹이 드래그, 점수 획득 --
	local function catch(event)
		if (event.phase == "began") then
			print(event.target.id .. " 드래그")
			display.getCurrentStage():setFocus(event.target)
			event.target.isFocus = true
		elseif (event.phase == "moved") then
			if(event.target.isFocus) then
				event.target.x = event.xStart + event.xDelta
				event.target.y = event.yStart + event.yDelta
			end
		elseif (event.phase == "ended" or event.phase == "cancelled") then
			if (event.target.isFocus) then
				print("catch")
				if event.target.x < animal1.x + 100 and event.target.x > animal1.x - 100
					and event.target.y < animal1.y + 100 and event.target.y > animal1.y - 100 then
						display.remove(event.target)
						score = score + 1
						
						local successMusic = audio.play( success, { channel=2, loops=0, fadein=0 } )
						audio.setMaxVolume( 0.4, { channel=2 } )
						local heart = display.newImageRect( "image/heart.png" , 50, 50 )
         				   heart.x, heart.y =display.contentWidth*0.085, display.contentHeight*0.75
         				   transition.from( heart, { time=1000, alpha=1.0, delay=0, transition=easing.inOutExpo } )
         				   transition.to( heart, { time=2000, alpha=0.0, delay=0, transition=easing.inOutExpo } )

						if score == 1 then
							local obj = display.newImageRect( "image/full.png",50, 50)
							obj.x, obj.y = display.contentWidth*(0.2), display.contentHeight*0.93
							sceneGroup:insert(obj)
						end

						if score == 2 then
							local obj = display.newImageRect( "image/full.png",50, 50)
							obj.x, obj.y = display.contentWidth*(0.25), display.contentHeight*0.93
							sceneGroup:insert(obj)
						end

						if score == 3 then

							local obj = display.newImageRect( "image/full.png",50, 50)
							obj.x, obj.y = display.contentWidth*(0.3), display.contentHeight*0.93
							sceneGroup:insert(obj)
						end

						if score == 4 then

							local obj = display.newImageRect( "image/full.png",50, 50)
							obj.x, obj.y = display.contentWidth*(0.35), display.contentHeight*0.93
							sceneGroup:insert(obj)
						end			
					
						if score == 5 then
							display.remove(buttonGroup[5])
							buttonGroup[5] = nil

							local obj = display.newImageRect( "image/full.png",50, 50)
							obj.x, obj.y = display.contentWidth*(0.4), display.contentHeight*0.93
							sceneGroup:insert(obj)

							composer.setVariable("complete", true)
							composer.gotoScene("view2")
						end
					else
						event.target.x = event.xStart
						event.target.y = event.yStart
					end

				display.getCurrentStage():setFocus(nil)
				event.target.isFocus = false
				end
				display.getCurrentStage():setFocus(nil)
				event.target.isFocus = false
			end
		end

		for i = 1, 5 do
			food1[i]:addEventListener("touch", catch)
		end


	local time1 = display.newImage( "images/배터리.png" )
	time1:translate( 1068, 662)
	local time2 = display.newImage( "images/배터리.png" )
	time2:translate( 1095, 662)
	local time3 = display.newImage( "images/배터리.png" )
	time3:translate( 1122, 662 )
	local time4 = display.newImage( "images/배터리.png" )
	time4:translate( 1149, 662 )
	local time5 = display.newImage( "images/배터리.png" )
	time5:translate( 1176, 662 )
	local time6 = display.newImage( "images/배터리.png" )
	time6:translate( 1041, 662 )

	-- 타이머 --
	local limit = 60


	local function t( event )
		limit = limit - 1
		
		local count = event.count
		print(count)

		if count == 50 then
			display.remove( time1 )
			time1 = nil

		elseif count == 40 then
			display.remove( time2 )
			time2 = nil

		elseif count == 30 then
			display.remove( time3 )
			time3 = nil

		elseif count == 20 then
			display.remove( time4 )
			time4 = nil

		elseif count == 10 then
			display.remove( time5 )
			time5 = nil

		elseif count == 59 then
			display.remove( time6 )
			time6 = nil
		end

		if count >= 60 then
			timer.cancel( event.source )
			composer.setVariable("complete", false)
			composer.removeScene("mgGame")
			composer.gotoScene("view2")
			--audio.pause( backgroundMusicChannel )
		elseif score == 5 then
			timer.cancel( event.source )
			composer.setVariable("complete", true)
			composer.removeScene("mgGame")
			composer.gotoScene("view2")
			audio.pause( backgroundMusicChannel )
		end
	end
	timer.performWithDelay( 1000, t, 0 )

	sceneGroup:insert(time1)
	sceneGroup:insert(time2)
	sceneGroup:insert(time3)
	sceneGroup:insert(time4)
	sceneGroup:insert(time5)
	sceneGroup:insert(time6)
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		
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