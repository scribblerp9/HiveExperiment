
hiveScene = gideros.class(Sprite)
function hiveScene:init()
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

end