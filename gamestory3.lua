-----------------------------------------------------------------------------------------
--
-- story.lua
--
-----------------------------------------------------------------------------------------
local json =require('json')
local Data, pos, msg

local function parse()
	local filename=system.pathForFile("Content/JSON/game3story.json")
	Data,pos,msg=json.decodeFile(filename)

	if Data then
		print(Data[1].title)
	else
		print(pos)
		print(msg)
	end
end
parse()

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	

	local background = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)

	local section = display.newImageRect("대화창.png", 1330, 300)
	section.alpha = 0.8
	section.x, section.y =  display.contentWidth*0.51, display.contentHeight*0.79
	

	local speakerImg = display.newRect(section.x - 450, section.y-200, 400, 400)
	

	local speaker = display.newText("더미 텍스트", section.x-250, section.y-75,"HSSaemaul-Regular.ttf")
	speaker.size = 46
	speaker:setFillColor(0)

	local script = display.newText("더미 텍스트입니다.", display.contentWidth*0.55-40, display.contentHeight*0.8,"HSSaemaul-Regular.ttf", 120)
	script.width = display.contentWidth*0.6
	script.size = 50
	script:setFillColor(0)



	-- 배경음악 --
	local backgroundMusic = audio.loadStream( "music/good.mp3" )
	local backgroundMusicChannel = audio.play( backgroundMusic, { loops=-1 }  ) 

	local index = 1
	local function nextScript( ... )
		if(index <= #Data) then
				if(Data[index].type == "background") then

					background.fill = {
						type = "image",
						filename = Data[index].img
					}
					index = index+1
					nextScript()

				elseif(Data[index].type == "Narration") then

					speakerImg.alpha= 0
					speaker.alpha = 0

					script.text = Data[index].content

					index = index + 1
			    elseif(Data[index].type == "Dialogue") then

			    	speakerImg.alpha=1

			    	speakerImg.fill={
			    		type="image",
						filename = Data[index].img
			    	}
			    
			    	speaker.alpha=1

			    	speaker.text = Data[index].speaker

			    	script.text = Data[index].content

			    	index=index+1
				end
		else
			composer.gotoScene("mgGame3")
		end
	end
	nextScript()

	local function tap (event)
		nextScript()
	end
	background:addEventListener("tap",tap)

	-- 레이어 정리
	sceneGroup:insert(background)
	sceneGroup:insert(section)
	sceneGroup:insert(speakerImg)
	sceneGroup:insert(speaker)
	sceneGroup:insert(script)
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
		composer.removeScene("gamestory3")
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