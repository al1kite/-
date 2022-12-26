------------------------------------------------------------------------------------------
--메인 게임 2라운드
-- mgGame2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
		-- 성공음 --
	local success = audio.loadSound("audio/success.mp3")


	-- 배경2(숲) --
	local bg1 = display.newImageRect("image/forest.jpg", 1280, 720)
	bg1.x, bg1.y = display.contentCenterX, display.contentCenterY
	sceneGroup:insert(bg1)

	-- 동물 먹이2(당근, 사과) -- 
	local food2 = { }
	local food2Group = display.newGroup()

	for i =1, 3 do
		food2[i] = display.newImageRect(food2Group, "image/food2.png", 20, 70)
	end
	sceneGroup:insert(food2Group)


	local food3 = { }
	local food3Group = display.newGroup()
	for i = 4, 5 do
		food3[i] = display.newImageRect(food2Group, "image/food3.png", 40, 40)
	end
	sceneGroup:insert(food3Group)

	-- 두번째 당근 회전
	food2[2].rotation = 90

	-- 동물 먹이2(당근) 위치 --
	food2[1].x, food2[1].y = display.contentWidth*0.27, display.contentHeight*0.73
	food2[2].x, food2[2].y = display.contentWidth*0.92, display.contentHeight*0.49
	food2[3].x, food2[3].y = display.contentWidth*0.9, display.contentHeight*0.7
	food3[4].x, food3[4].y = display.contentWidth*0.055, display.contentHeight*0.33
	food3[5].x, food3[5].y = display.contentWidth*0.13, display.contentHeight*0.39


	-- 먹이 숨겨둘 물건 1번은 꽃 2번은 나무둥지 3번은 나무조각 8번은 돌--
	local object1 = display.newImageRect("image/object1.png", 120, 150)
	local object2 = display.newImageRect("image/object2.png", 140, 120)
	local object3 = display.newImageRect("image/object3.png", 250, 160)
	local object4 = display.newImageRect("image/object1.png", 100, 150)
	local object5 = display.newImageRect("image/object1.png", 120, 160)
	local object6 = display.newImageRect("image/object1.png", 120, 150)
	local object7 = display.newImageRect("image/object1.png", 120, 140)
	local object8 = display.newImageRect("image/rock.png", 180, 100)
	local object9 = display.newImageRect("image/object6.png", 100, 80)
	local object10 = display.newImageRect("image/object1.png", 120, 150)
	local object11 = display.newImageRect("image/object10.png", 160, 100)
	local object12 = display.newImageRect("image/object2.png", 120, 100)
	local object13 = display.newImageRect("image/object10.png", 80, 50)
	local object14 = display.newImageRect("image/object1.png", 100, 130)
	local object15 = display.newImageRect("image/object1.png", 100, 120)



	-- 물건 위치 --
	object1.x, object1.y = display.contentWidth*0.27, display.contentHeight*0.73
	object4.x, object4.y = display.contentWidth*0.60, display.contentHeight*0.66
	object5.x, object5.y = display.contentWidth*0.59, display.contentHeight*0.71
	object6.x, object6.y = display.contentWidth*0.61, display.contentHeight*0.7
	object7.x, object7.y = display.contentWidth*0.25, display.contentHeight*0.74
	object2.x, object2.y = display.contentWidth*0.14, display.contentHeight*0.42
	object3.x, object3.y = display.contentWidth*0.9, display.contentHeight*0.51
	object8.x, object8.y = display.contentWidth*0.95, display.contentHeight*0.65
	object9.x, object9.y = display.contentWidth*0.06, display.contentHeight*0.31
	object10.x, object10.y = display.contentWidth*0.265, display.contentHeight*0.69
	object11.x, object11.y = display.contentWidth*0.9, display.contentHeight*0.7
	object12.x, object12.y = display.contentWidth*0.78, display.contentHeight*0.35
	object13.x, object13.y = display.contentWidth*0.95, display.contentHeight*0.71
	object14.x, object14.y = display.contentWidth*0.384, display.contentHeight*0.48
	object15.x, object15.y = display.contentWidth*0.394, display.contentHeight*0.51



	sceneGroup:insert(object1)
	sceneGroup:insert(object2)
	sceneGroup:insert(object3)
	sceneGroup:insert(object4)
	sceneGroup:insert(object5)
	sceneGroup:insert(object6)
	sceneGroup:insert(object7)
	sceneGroup:insert(object8)
	sceneGroup:insert(object9)
	sceneGroup:insert(object10)
	sceneGroup:insert(object11)
	sceneGroup:insert(object12)
	sceneGroup:insert(object13)
	sceneGroup:insert(object14)
	sceneGroup:insert(object15)


	-- 동물2 (토끼)  --
	local animal2 = display.newImageRect("image/animal2.png", 280, 280) 
	animal2.x, animal2.y = display.contentWidth*0.09, display.contentHeight*0.85
	sceneGroup:insert(animal2)

	-- 점수 --
	local score =0



	for i = 1, 3 do
		food2[i].id = i .. "번 당근"
	end

	for i = 4, 5 do
		food3[i].id = i .. "번 사과"
	end


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


	-- 물건 삭제 --
	local function moving(event)
		if (event.phase == "began") then
			transition.fadeOut(event.target, {time = 1500})
		end
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
				if event.target.x < animal2.x + 100 and event.target.x > animal2.x - 100
					and event.target.y < animal2.y + 100 and event.target.y > animal2.y - 100 then
						display.remove(event.target)
						score = score + 1
						
						local successMusic = audio.play( success, { channel=2, loops=0, fadein=0 } )
						audio.setMaxVolume( 0.4, { channel=2 } )
						local heart = display.newImageRect( "image/heart.png" , 50, 50 )
         				   heart.x, heart.y =display.contentWidth*0.1, display.contentHeight*0.75
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
							composer.gotoScene("view4")
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

		for i = 1, 3 do
			food2[i]:addEventListener("touch", catch)
		end

		for i = 4, 5 do
			food3[i]:addEventListener("touch", catch)
		end

	object1:addEventListener("touch", moving)
	object2:addEventListener("touch", moving)
	object3:addEventListener("touch", moving)
	object4:addEventListener("touch", moving)
	object5:addEventListener("touch", moving)
	object6:addEventListener("touch", moving)
	object7:addEventListener("touch", moving)
	object8:addEventListener("touch", moving)
	object9:addEventListener("touch", moving)
	object10:addEventListener("touch", moving)
	object11:addEventListener("touch", moving)
	object12:addEventListener("touch", moving)
	object13:addEventListener("touch", moving)
	object14:addEventListener("touch", moving)
	object15:addEventListener("touch", moving)
	
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
			composer.removeScene("mgGame2")
			composer.gotoScene("view3")
			--audio.pause( backgroundMusicChannel )
		elseif score == 5 then
			timer.cancel( event.source )
			composer.setVariable("complete", true)
			composer.removeScene("mgGame2")
			composer.gotoScene("view3")
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