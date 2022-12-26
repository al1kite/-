local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
  local sceneGroup = self.view
-- [배경화면]

local bg = display.newImageRect("images/bg.png",1280,720)
bg.x, bg.y = display.contentWidth*0.5, display.contentHeight*0.5
sceneGroup:insert(bg)

local ball

-- [게임화면]

local restart = {}
 
require ("physics")

-- [대화창]

local bar1Group = display.newGroup()
buttonBar = display.newImage(bar1Group,'images/buttonBar.png', 0, 270)
buttonBar.alpha = 0.8
buttonBar.x, buttonBar.y =  display.contentWidth*0.51, display.contentHeight*0.81
msg = display.newImage(bar1Group,"images/msg4.png")
msg.x, msg.y = display.contentWidth*0.4, display.contentHeight*0.8
restartBtn = display.newImage(bar1Group, 'images/restart1.png', 223, 275)
restartBtn.x, restartBtn.y = display.contentWidth*0.85, display.contentHeight*0.9
restartBtn:addEventListener('tap', restart)
rabbit = display.newImage(bar1Group,"images/rabbit.png")
rabbit.x, rabbit.y =  display.contentWidth*0.1, display.contentHeight*0.57
sceneGroup:insert(bar1Group)

-- [중력 설정]

physics.start()
physics.setGravity(0, 1.5)

--[골대]

local goalGroup = display.newGroup()
  goal = display.newImage(goalGroup,'images/shell1.png', 195, 84)
  goal.x, goal.y = display.contentWidth*0.8, display.contentHeight*0.5
  physics.addBody(goal, "static", {friction=0, bounce = 0})
  goal.type = "goalpost"
  sceneGroup:insert(goalGroup)

--[선 그리기]

  local i = 1
  local lineGroup= display.newGroup()
  local tempLine
  local ractgangle_hit = {}
  local prevX , prevY
  local function runTouch(event)
  if(event.phase=="began") then
    if(tempLine==nil) then
      tempLine = display.newLine(lineGroup,event.x, event.y, event.x, event.y)
 
      r = math.random (0, 255)
      g = math.random ( 0, 255)
      b = math.random (0, 255 )
       tempLine:setColor(r,g, b)
 
      prevX = event.x
      prevY = event.y
    end
  elseif(event.phase=="moved") then
    tempLine:append(event.x,event.y-5)
     tempLine.width=tempLine.width-0.8
    ractgangle_hit[i] = display.newLine(lineGroup, prevX, prevY, event.x, event.y)
     ractgangle_hit[i]:setColor(r,g, b)
     ractgangle_hit[i].width = 5

     local Width = ractgangle_hit[i].width * 0.6
    local Height = ractgangle_hit[i].height * 0.2
 
    local lineShape = {-Width,-Height,Width,-Height,Width,Height,-Width,Height}
 
    physics.addBody(ractgangle_hit[i], "static", { bounce = -1, density=0.3, friction=0.7, shape = lineShape})
    prevX = event.x
    prevY = event.y
    i = i + 1
    elseif(event.phase=="ended") then
    tempLine.parent.remove(lineGroup)
    tempLine=nil
  end

end

Runtime:addEventListener("touch", runTouch)
sceneGroup:insert(lineGroup)


-- [당근]

local ball1Group = display.newGroup()
  ball = display.newImage(ball1Group,"images/carrot.png",display.contentWidth/2, display.contentHeight / 5, 10)
  physics.addBody(ball, "dynamic", {bounce=1.1, radius = 25, friction=1})

  ball.collision = function(self, event)
       
        if(event.other.type == "goalpost") then
            -- [엔딩화면]
            while i > 1 do
              i = i - 1
              ractgangle_hit[i]:removeSelf()
            end
            composer.setVariable("complete", true)
            Runtime:removeEventListener("touch", runTouch)
            restartBtn:removeEventListener('tap', restart)
            ball:removeEventListener("collision", ball)

            composer.removeScene("subGame2")
            composer.gotoScene("mini2")
        end
            local onTimerComplete = function(event)
            end
            timer.performWithDelay(500, onTimerComplete , 1)
    end
    ball:addEventListener("collision", ball)  
    ball:setLinearVelocity(75, 150)

sceneGroup:insert(ball1Group)


function restart:tap(e) 
   while i > 1 do
        i = i - 1
        ractgangle_hit[i]:removeSelf()
    end
  Runtime:removeEventListener("touch", runTouch)
  restartBtn:removeEventListener('tap', restart)
  ball:removeEventListener("collision", ball)

   composer.setVariable("complete", false)
  composer.removeScene("subGame2")
  composer.gotoScene("mini2")
  end
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