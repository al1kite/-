local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view


local start = display.newImageRect("images/back.png", 60, 60)
	start.x = 1220
	start.y = 50

local function re(event)
		composer.removeScene("subGame1")
		audio.pause( backgroundMusicChannel )
		composer.gotoScene("view1")
	end

	start:addEventListener("tap", re)

	
-- [배경화면]

local bg = display.newImageRect("images/bg.png",1280,720)
bg.x, bg.y = display.contentWidth*0.5, display.contentHeight*0.5
sceneGroup:insert(bg)

sceneGroup:insert(start)


-- [도토리수]

local bank
local bankText
-- [그릇]

local s1
local s2
local s3
local shells
-- [도토리]

local ball
-- [대화창]

local buttonBar
local squirrel
-- [Bet 버튼]

local betBtn
-- [메세지]

local msg1
local msg2
local msg3
-- [게임화면]

local gameView

-- [실패화면]

local alert

-- 속도 설정

local moveSpeed = 500
local totalMoves = 5

-- 함수

local placeBet = {}
local randomShellMove = {}
local checkMovesLeft = {}
local revealBall = {}
local removeMsg = {}
local alert = {}

	
--function Main()
	
	-- [공]
	local ballGroup = display.newGroup()
	ball = display.newImage(ballGroup,'images/ball.png', 228, 142)
	ball.x, ball.y = display.contentWidth*0.55, display.contentHeight*0.485
	sceneGroup:insert(ballGroup)

	
	-- [그릇]
	local shellGroup = display.newGroup()
	s1 = display.newImage(shellGroup,'images/shell.png', 50, 114)
	s1.x, s1.y =  display.contentWidth*0.35, display.contentHeight*0.4
	s2 = display.newImage(shellGroup,'images/shell.png', 195, 84)
	s2.x, s2.y =  display.contentWidth*0.55, display.contentHeight*0.4
	s2.name = 's2'
	s3 = display.newImage(shellGroup,'images/shell.png', 340, 114)
	s3.x, s3.y =  display.contentWidth*0.75, display.contentHeight*0.4
	shells = display.newGroup(s1, s2, s3)
	shells = {}
	shells[1] = s1
	shells[2] = s2
	shells[3] = s3
	sceneGroup:insert(shellGroup)
	

	-- [대화창]
	local barGroup = display.newGroup()
	
	buttonBar = display.newImage(barGroup,'images/buttonBar.png', 0, 270)
	buttonBar.alpha = 0.8
	buttonBar.x, buttonBar.y =  display.contentWidth*0.51, display.contentHeight*0.81
	squirrel = display.newImage(barGroup,"images/squirrel.png")
	squirrel.x, squirrel.y =  display.contentWidth*0.1, display.contentHeight*0.57
	msg = display.newImage(barGroup, "images/msg.png")
	msg.x, msg.y = display.contentWidth*0.4, display.contentHeight*0.8
	betBtn = display.newImage(barGroup, 'images/betBtn.png', 223, 275)
	betBtn.x, betBtn.y = display.contentWidth*0.85, display.contentHeight*0.9
	sceneGroup:insert(barGroup)

	-- [도토리수]
	local bankGroup = display.newGroup()
	bankText = display.newImage(bankGroup,'images/bankText.png')
	bankText.x, bankText.y = display.contentWidth*0.86, display.contentHeight*0.73
	bank = display.newText(bankGroup, '5', 18, 5, native.systemFontBold, 40)
	bank:setTextColor(black)
	bank.x, bank.y = display.contentWidth*0.88, display.contentHeight*0.73
	sceneGroup:insert(bankGroup)

	betBtn:addEventListener('tap', placeBet)

	gameView = display.newGroup(ball, shells, buttonBar, squirrel, msg, betBtn, bank, bankText)
	transition.to(s2, {time = moveSpeed, y = s2.y - 30})
--end
	
-- bet 버튼 클릭

function placeBet:tap(e)	

	-- [도토리수 차감]
	bank.text = bank.text - 1;
	
	-- [메세지]
	local msgGroup = display.newGroup()
	msg.isVisible = false
	msg1 = display.newImage(msgGroup,"images/msg1.png")
	msg1.x, msg1.y = display.contentWidth*0.4, display.contentHeight*0.8
	msg1.isVisible = false

	msg2 = display.newImage(msgGroup,"images/msg2.png")
	msg2.x, msg2.y = display.contentWidth*0.4, display.contentHeight*0.82
	msg2.isVisible = false

	msg3 = display.newImage(msgGroup,"images/msg3.png")
	msg3.x, msg3.y = display.contentWidth*0.4, display.contentHeight*0.82
	msg3.isVisible = false
	sceneGroup:insert(msgGroup)
	
	betBtn:removeEventListener('tap', placeBet)

	-- [움직이는 횟수]
	totalMoves = 5
	
	-- [공 숨기기]
	transition.to(s2, {time = moveSpeed, y = s2.y + 30, onComplete = randomShellMove})
end

-- 그릇 랜덤 이동
function randomShellMove()
	local randm = math.floor(math.random() * 2) + 1
	print(randm) -- 2  ,  2  , 1

	local shell1 = shells[randm]
	local shell2

	print(shells[randm]) -- 88  ,  88  , C0

	if(shell1 ~= shells[3]) then
       shell2 = shells[randm + 1]
    elseif(shell1 ~= shells[1]) then
       shell2 = shells[randm - 1]
    else
   		shell2 = shells[3]
    end

	ball.isVisible = false

	totalMoves = totalMoves -1
	
	print(shell1) -- 88  , 88  , C0
	print(shell2) -- 30  , 30  , 88

	transition.to(shell1, {time = moveSpeed, x = shell2.x, y = shell2.y})
	transition.to(shell2, {time = moveSpeed, x = shell1.x, y = shell1.y, onComplete = checkMovesLeft})
	--transition.to({time = moveSpeed, delay = 2000, onComplete = checkMovesLeft()})
end

-- 그릇 위치 클릭

function checkMovesLeft()
	if(totalMoves > 0) then
		randomShellMove()
	else
		s1:addEventListener('tap', revealBall)
		s2:addEventListener('tap', revealBall)
		s3:addEventListener('tap', revealBall)
		
		-- [메세지]
		msg1.isVisible = true
	end
end

-- 도토리 위치 

function revealBall:tap(e)

	msg1.isVisible = false

	-- [그릇 클릭]
	s1:removeEventListener('tap', revealBall)
	s2:removeEventListener('tap', revealBall)
	s3:removeEventListener('tap', revealBall)
	
	-- [도토리 보이기]
	ball.x = s2.x 
	ball.y = s2.y + 100
	ball.isVisible = true
	
	-- [그릇 원위치]
	transition.to(s2, {time = moveSpeed, y = s2.y - 30})

	if(e.target.name == 's2') then
		--[도토리수 증가]
		print(bank.text)
		bank.text = bank.text + 2
		
		--[메세지]
		msg2.isVisible = true
	else
		msg3.isVisible = true
	end
	
	betBtn:addEventListener('tap', placeBet)
	betBtn:addEventListener('tap', removeMsg)
	
	-- [엔딩화면]

	print(bank.text)

	if(bank.text == '0') then
		betBtn:removeEventListener('tap', placeBet)
		composer.setVariable("complete", false)
		composer.removeScene("subGame1")
		composer.gotoScene("mini1")
	end

	if(bank.text == '10')then
		betBtn:removeEventListener('tap', placeBet)
		composer.setVariable("complete", true)
		composer.removeScene("subGame1")
		composer.gotoScene("mini1")
	end
end

function removeMsg()
	display.remove(msg2)
	display.remove(msg3)


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