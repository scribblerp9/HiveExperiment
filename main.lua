

function xferHoneyFromBeeToComb (comb, bee, xferAmount)
	if ((comb.honeyCur < comb.honeyMax) and (bee.honeyCur > 0)) then -- If the comb is not already full and the bee has honey left
		comb:addHoney(xferAmount)
		bee:reduceHoney(xferAmount)
	end
end

-- Setup array for storing entire hive and bees
hive = {}
totNumCombs = 1
bees = {}

-- Set look parameters
-- Standard parameters
--[[

local combSize = 60
local hiveNumRows = 17
local hiveNumPerRow = 4
local beeSize = 50
local beesNum = 20
]]--

-- Debug parameters
local combSize = 120
local hiveNumRows = 7
local hiveNumPerRow = 2
local beeSize = 100
local beesNum = 4

local beeDrawDebug = false
if(beeDrawDebug) then
	combSize = 300
	hiveNumRows = 1
	hiveNumPerRow = 1
	beeSize = 280
	beesNum = 1
end

-- Prepare the hive and the bees
if(beeDrawDebug) then
	createHive(application:getDeviceWidth()/2-combSize/2, application:getDeviceHeight()/2-combSize, combSize, hiveNumRows, hiveNumPerRow)
else
	-- Calculate where to position Hive
	local hivePosX = (application:getDeviceWidth() - ((hiveNumPerRow*combSize*2) + (combSize*(hiveNumPerRow-1) - combSize))) /2
	createHive(hivePosX, 50, combSize, hiveNumRows, hiveNumPerRow)
end
standardBeeMoveDelay = 2000
createBees(beesNum, beeSize)

-- Setup hive creation timer
hiveCreationTimer = Timer.new(0, #hive)

-- Setup listener functions for events
hiveCreationTimer:addEventListener(Event.TIMER, onHiveCreationTimer)
hiveCreationTimer:addEventListener(Event.TIMER_COMPLETE, onHiveCreationTimerComplete)
for i=1, #bees do
	bees[i].moveTimer:addEventListener(Event.TIMER, onBeeMovementTimer, i)
end
-- Start the hive creation timer
hiveCreationTimer:start()

--[[ Debug - testing scaling a shape while keeping it in the center
testTimer = Timer.new(1)
testShape = Shape.new()
testShape:setFillStyle(Shape.SOLID, 0x000000)
testShape:beginPath()
--testShape:moveTo(100,500)
--testShape:lineTo(200,500)
--testShape:lineTo(200,600)
--testShape:lineTo(100,600)
testShape:moveTo(0,0)
testShape:lineTo(100,0)
testShape:lineTo(100,100)
testShape:lineTo(0,100)
testShape:closePath()
testShape:endPath()
testShape:setScale(0,0)
testShape:setPosition(200,600) --set the initial position at the center

local len = 40
local pt1X = 0
local pt1Y = 0
local pt2X = pt1X + len
local pt2Y = pt1Y
local pt3X = pt2X + (len/2)
local pt3Y = pt2Y + (len*.875)
local pt4X = pt3X - (len/2)
local pt4Y = pt3Y + (len*.875)
local pt5X = pt4X - len
local pt5Y = pt4Y
local pt6X = pt5X - (len/2)
local pt6Y = pt5Y - (len*.875)
testShape2 = Shape.new()
testShape2:setFillStyle(Shape.SOLID, 0xFFC308)

-- Draw
testShape2:beginPath()
testShape2:moveTo(pt1X,pt1Y)
testShape2:lineTo(pt2X,pt2Y)
testShape2:lineTo(pt3X,pt3Y)
testShape2:lineTo(pt4X,pt4Y)
testShape2:lineTo(pt5X,pt5Y)
testShape2:lineTo(pt6X,pt6Y)
testShape2:closePath()
testShape2:endPath()
testShape2:setScale(0,0)
testShape2:setPosition(200,600) 

testBGShape = Shape.new()
testBGShape:setFillStyle(Shape.SOLID, 0xF00000)
testBGShape:beginPath()
testBGShape:moveTo(100,500)
testBGShape:lineTo(300,500)
testBGShape:lineTo(300,700)
testBGShape:lineTo(100,700)
testBGShape:closePath()
testBGShape:endPath()

stage:addChild(testBGShape)
stage:addChild(testShape2)

function onTestTimer()

	local scale = testShape2:getScaleX()
	local posX = testShape2:getX()
	local posY = testShape2:getY()
	local delta = 0.01
	
	if(scale >= 2.4) then
		return
	end
	--print(scale)
	testShape2:setScale(scale+delta, scale+delta) -- Increase size slightly
	--testShape2:setPosition(posX-0.1, posY-0.175)	
	testShape2:setPosition(posX-(delta*(len/2)), posY-(delta*(len/1.15)))	

end

testTimer:addEventListener(Event.TIMER, onTestTimer)
testTimer:start()
]]--


