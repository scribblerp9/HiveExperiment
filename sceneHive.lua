
hiveScene = Core.class(Sprite)
hiveAlreadyBuilt = false

function hiveScene:init()
	
	-- Don't recreate anything if the hive has already been initiated before
	if(hiveAlreadyBuilt == false) then

		print("First time hive scene has been entered")
		--print("self",self,"sceneManager version",sceneManager.scenes["hiveScene"], "hivescene version", hiveScene)
		
		-- Set look parameters
		-- Standard parameters
		--[[
		local combSize = 60
		local hiveNumRows = 17
		local hiveNumPerRow = 4
		local beeSize = 50
		local beesNum = 20
		]]--

		-- General Debug parameters
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
			standardBeeMoveDelay = 1
		else
			-- Calculate where to position Hive
			local hivePosX = (application:getDeviceWidth() - ((hiveNumPerRow*combSize*2) + (combSize*(hiveNumPerRow-1) - combSize))) /2
			createHive(hivePosX, 50, combSize, hiveNumRows, hiveNumPerRow)
			standardBeeMoveDelay = 2000
		end
		createBees(beesNum, beeSize)

		-- Setup hive creation timer
		hiveCreationTimer = Timer.new(0, #hive)

		-- Show the comb when the hive creation timer fires
		function onHiveCreationTimer()
			thisComb = hive[hiveCreationTimer:getCurrentCount()]
			self:addChild(thisComb)
			--self:addChild(thisComb.centreDot) --Debug
		end

		-- Do something when the comb is fully displayed
		function onHiveCreationTimerComplete(e)
			print("Hive Created", e:getTarget(), e:getType())
			
			-- Add bees to hiveScene and start their movement timers
			for i=1, #swarm do
				self:addChild(swarm[i])
				if(beeDrawDebug == true) then
					swarm[i].moveTimer:setRepeatCount(1)
				end
				swarm[i].moveTimer:start()
			end
		end
		
		-- After the bee has waited on a comb move it to the next comb
		function onBeeMovementTimer(beeIndex, timer)
			-- Find a comb to move to
			destinationComb = math.random(1, #hive)
			while (hive[destinationComb].bee ~= nil) do -- If the comb is occupied then pick another comb
				destinationComb = math.random(1, #hive)
			end
			
			-- Move the bee
			swarm[beeIndex]:move(hive[destinationComb])
				
			-- Set a new delay so its not the same everytime
			--local newDelay = math.random(standardBeeMoveDelay-500, standardBeeMoveDelay+3000)
			local newDelay = math.random(standardBeeMoveDelay+2000, standardBeeMoveDelay+8000)
			swarm[beeIndex].moveTimer:setDelay(newDelay)
			
			print("Bee "..beeIndex.." is moving to comb "..destinationComb.." and won't move for another "..newDelay.." milliseconds", timer:getTarget(), timer:getType())
		end

		-- Setup listener functions for events
		hiveCreationTimer:addEventListener(Event.TIMER, onHiveCreationTimer)
		hiveCreationTimer:addEventListener(Event.TIMER_COMPLETE, onHiveCreationTimerComplete)
		for i=1, #swarm do
			swarm[i].moveTimer:addEventListener(Event.TIMER, onBeeMovementTimer, i)
		end
		-- Start the hive creation timer
		hiveCreationTimer:start()

		-- Display button for switching to Forest scene
		local forestButton = Button.new(
			Bitmap.new(Texture.new("buttonClass/button_up.png")),
			Bitmap.new(Texture.new("buttonClass/button_down.png"))
		)	 
		forestButton:setPosition(
			((application:getDeviceWidth()-forestButton:getWidth())/4),
			((application:getDeviceHeight()-forestButton:getHeight())-20)
		)
		self:addChild(forestButton)
 
		forestButton:addEventListener("click",
			function() 
				print("Off to the Forest with you")
				sceneManager:changeScene("forestScene", 1, SceneManager.flipWithFade, easing.outBack)
			end
		)
		
		-- Mark hive as built so it doesnt get rebuilt later
		hiveAlreadyBuilt = true
		
		--Debug
		for i=1, self:getNumChildren() do
			print("child "..i, self:getChildAt(i))
		end
		
		print("bee 1's parent is ",hive[1]:getParent())
		
	else
		print("Welcome back to the hive")
	end
	print("hiveScene init run")
end