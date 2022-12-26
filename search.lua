-----------------------------------------------------------------------------------------
--
-- search.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
   local sceneGroup = self.view

   local bg = display.newImageRect("images/title.png", 1280, 720)
   bg.x = display.contentCenterX
   bg.y = display.contentCenterY
   sceneGroup:insert(bg)

   local button = display.newImageRect("images/x.png", 110, 110)
   button.x = 1150
   button.y = 105
   sceneGroup:insert(button)

   local searchText1 = display.newText( " 다람쥐, 새앙토끼 불곰 세 친구들의 이야기를 듣고 ", display.contentWidth/2, display.contentHeight/2-120, "HSSaemaul-Regular.ttf", 40 )
   searchText1:setFillColor( 0.4, 0.4, 0.4 )
   sceneGroup:insert(searchText1)

   local searchText2 = display.newText( " 숲 속 친구들의 먹이를 찾아주자!!  ", display.contentWidth/2 , display.contentHeight/2-60, "HSSaemaul-Regular.ttf", 40 )
   searchText2:setFillColor( 0.4, 0.4, 0.4 )
   sceneGroup:insert(searchText2)

   local searchText3 = display.newText( " (중간에 나오는 미니게임으로 외로웠던 친구들과 놀아주자) ", display.contentWidth/2 , display.contentHeight/2, "HSSaemaul-Regular.ttf", 40 )
   searchText3:setFillColor( 0.4, 0.4, 0.4 )
   sceneGroup:insert(searchText3)

   local searchText4 = display.newText( "   세 친구들의 이야기를 듣고 숲 속 친구들의 먹이를 모두 찾아주면 ", display.contentWidth/2 , display.contentHeight/2+60, "HSSaemaul-Regular.ttf", 40 )
   searchText4:setFillColor( 0.4, 0.4, 0.4 )
   sceneGroup:insert(searchText4)

   local searchText5 = display.newText( " 숨겨진 엔딩이 나타난다!  ", display.contentWidth/2, display.contentHeight/2+120, "HSSaemaul-Regular.ttf", 40 )
   searchText5:setFillColor( 0.4, 0.4, 0.4 )
   sceneGroup:insert(searchText5)

   local function back(event)
      composer.gotoScene("view1")
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