local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
  local sceneGroup = self.view
-- [배경화면]

local bg = display.newImageRect("images/bg.png",1280,720)
bg.x, bg.y = display.contentWidth*0.5, display.contentHeight*0.5
sceneGroup:insert(bg)

-- [축구공수]

local bank
local bankText
local ball

local brickText
local brickNum

-- [게임화면]

local gameView

-- [실패화면]

local createBall

-- 속도 설정

local moveSpeed = 600
local totalMoves = 5

-- 함수

local Main = {}
local startButtonListeners = {}
local showGameView = {}
local setUpPhysics = {}
local alert = {}

 	-- [축구공수]
local bank1Group = display.newGroup()
	
    buttonBar = display.newImage(bank1Group, 'images/buttonBar.png', 0, 270)
    buttonBar.alpha = 0.8
    buttonBar.x, buttonBar.y =  display.contentWidth*0.51, display.contentHeight*0.81
    msg = display.newImage(bank1Group, "images/msg5.png")
    msg.x, msg.y = display.contentWidth*0.4, display.contentHeight*0.8

    bankText = display.newImage(bank1Group, 'images/bankText2.png')
    bankText.x, bankText.y = display.contentWidth*0.86, display.contentHeight*0.73
    bank = display.newText(bank1Group,'5', 18, 5, native.systemFontBold, 40)
    bank:setTextColor(black)
    bank.x, bank.y = display.contentWidth*0.88, display.contentHeight*0.73

    brickText = display.newImage(bank1Group, 'images/bankText1.png')
    brickText.x, brickText.y = display.contentWidth*0.87, display.contentHeight*0.83
    brickNum = display.newText(bank1Group, '40', 18, 5, native.systemFontBold, 40)
    brickNum:setTextColor(black)
    brickNum.x, brickNum.y = display.contentWidth*0.88, display.contentHeight*0.837


sceneGroup:insert(bank1Group)
    


require ("physics")

    physics.start()
    physics.setGravity(0,1.5)

-- 축구공 생성
function createBall()
    local ball2Group = display.newGroup()
    ball = display.newImage(ball2Group,'images/ball2.png', display.contentWidth / 4, display.contentHeight / 5, 10 )
    physics.addBody(ball, "dynamic", {friction=0, bounce = 0.5, radius=ballRadius})
    
   
    ball.collision = function(self, event)
        if(event.phase == "ended") then
            if(event.other.type == "destructible") then
                brickNum.text = brickNum.text - 1;
                event.other:removeSelf()
            end

            if (brickNum.text == '0') then
                ball:removeEventListener("collision", ball)
                composer.setVariable("complete", true)
                composer.removeScene("subGame3")
                composer.gotoScene("mini3")
            end
        end
       
        if(event.other.type == "bottomWall") then

        	-- [축구공수 차감]
			bank.text = bank.text - 1;

            self:removeSelf()
            local onTimerComplete = function(event)
                createBall()
            end
            timer.performWithDelay(500, onTimerComplete , 1)
        end
    end
    ball:addEventListener("collision", ball)
    ball:setLinearVelocity(75, 150)
    sceneGroup:insert(ball2Group)

    -- [엔딩화면]

	if(bank.text == '0') then
		ball:removeEventListener("collision", ball)
		composer.setVariable("complete", false)
        composer.removeScene("subGame3")
        composer.gotoScene("mini3")
	end
    --if(brickNum.text == '0') then
      --  ball:removeEventListener("collision", ball)
      --  composer.setVariable("complete", true)
      --  composer.removeScene("subGame3")
      --  composer.gotoScene("mini3")
  --  end

end

createBall()
-- 벽 생성
    local wallGroup = display.newGroup()
    local wallThickness = 0
    -- [왼쪽 벽]
    wall1 = display.newRect(wallGroup, 0, 0, 0, display.contentHeight*2 )
    physics.addBody(wall1, "static", {friction=0, bounce = 0.7})
    -- [위쪽 벽]
    wall2 = display.newRect(wallGroup, 0,0, display.contentWidth*2, wallThickness)
    physics.addBody(wall2, "static", {friction=0, bounce = 0.7})
    -- [오른쪽 벽]
    wall3 = display.newRect(wallGroup, 1280, 0, 0, display.contentHeight*2)
    physics.addBody(wall3, "static", {friction=0, bounce = 0.7})
    -- [밑쪽 벽]
    wall4 = display.newRect(wallGroup, 0, 720, display.contentWidth*2, 0)
    physics.addBody(wall4, "static", {friction=0, bounce = 0.7})
    wall4.type = "bottomWall"
    sceneGroup:insert(wallGroup)


     -- [왼쪽 벽]
   -- wall = display.newRect(wallGroup, 0, 0, wallThickness, display.contentHeight*2 )
   -- physics.addBody(wall, "static", {friction=0, bounce = 1.5})
    -- [위쪽 벽]
   -- wall = display.newRect(wallGroup, 0,0, display.contentWidth*2, wallThickness)
   -- physics.addBody(wall, "static", {friction=0, bounce = 0.5})
    -- [오른쪽 벽]
   -- wall = display.newRect(wallGroup, display.contentWidth - wallThickness, 0, wallThickness, display.contentHeight*2)
   -- physics.addBody(wall, "static", {friction=0, bounce = 1.5})
    -- [밑쪽 벽]
   -- wall = display.newRect(wallGroup, 0, display.contentHeight - 150 - wallThickness, display.contentWidth*2, wallThickness)
   -- physics.addBody(wall, "static", {friction=0, bounce = 1.5})
   -- wall.type = "bottomWall"
   -- sceneGroup:insert(wallGroup)

-- paddle 생성
   local paddleGroup = display.newGroup()
    local paddleWidth = 100
    local paddleHeight = 10
   
    local paddle = display.newImage(paddleGroup, "images/paddle.png", 
       display.contentWidth / 2 - paddleWidth / 2 - 400, display.contentHeight*0.57, 
       paddleWidth, paddleHeight )

    physics.addBody(paddle, "static", {friction=0, bounce=1.5})

    local  movePaddle = function(event)
        paddle.x = event.x
    end

    Runtime:addEventListener("touch", movePaddle)
    sceneGroup:insert(paddleGroup)


-- 벌집 생성
    local brickGroup = display.newGroup()
    local brickWidth = 40
    local brickHeight = 40
    local numOfRows = 4
    local numOfCols = 10
    local topLeft = {x= display.contentWidth / 2 - (brickWidth * numOfCols ) / 2, y= 50}
    local row
    local col
    for row = 0, numOfRows - 1 do
        	for col = 0, numOfCols - 1 do
            local brick = display.newImage(brickGroup,'images/Honeycomb.png', 
                topLeft.x + (col * (brickWidth+2)), topLeft.y + (row * (brickHeight+2)), brickWidth, brickHeight )
            brick.type = "destructible"
            physics.addBody(brick, "static", {friction=0, bounce = 0.7})
            
    	end
    end
    sceneGroup:insert(brickGroup)
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