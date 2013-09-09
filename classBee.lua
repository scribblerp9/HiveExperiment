
Bee = Core.class(Sprite)
function Bee:init(centreX, centreY, size)
	
	-- Centre point of bee for potential access later
	self.centreX = centreX
	self.centreY = centreY
	self.size = size
	
	-- Set timers
	self.moveTimer = nil -- This is set later when the bee is created
	
	self.type = nil -- This can be either worker, drone or queen
	
	self.comb = nil -- The comb the bee is currently sitting on
	
	self.swarmIndex = nil -- This is the index of this bee in the swarm
	
	self.honeyMax = 800
	self.honeyCur = self.honeyMax
	
	-- Build bee's entire body	
	self:buildBody()
end

function Bee:buildBody()

	local centreX = self.centreX
	local centreY = self.centreY
	local size = self.size

	-- Set the order for drawing the body parts, first (furthest to the back) to last (closest to the front)
	beeBodyParts = { -- Use this to access the body parts elsewhere (this needs to be global so other functions can get to it)
		"sting",
		"blackBody",
		"honeyBody",
		"bodyStripe1",
		"bodyStripe2",
		"bodyStripe3",
		"bodyStripe4",
		"head",
		"leftWing",
		"rightWing",
		"leg1",
		"leg2",
		"leg3",
		"leg4",
		"leftAnt",
		"rightAnt",
		"mouth",
		"leftEye",
		"leftPupil",
		"rightEye",
		"rightPupil"
	}
	local beeBodyPartSprites = {} -- Store the sprites in the correct order
--[[
	for i=1, #beeBodyParts do

		local key = getKeyForValue(beeBodyParts, beeBodyParts[i])
		print(i, key, beeBodyParts[i])
		
	end
]]--

	local blackBody = Shape.new()
	blackBody:setPosition(centreX,centreY)
	blackBody:setLineStyle(4, 0x000000)
	blackBody:setFillStyle(Shape.SOLID, 0x000000)
	blackBody:beginPath()
	blackBody:moveTo(0,0)
	blackBody:lineTo(size,0)
	blackBody:lineTo(size,size*.8)
	blackBody:lineTo(0,size*.8)
	blackBody:closePath()
	blackBody:endPath()
	beeBodyPartSprites[getKeyForValue(beeBodyParts, "blackBody")] = blackBody

	local honeyBody = Shape.new()
	honeyBody:setPosition(centreX,centreY)
	honeyBody:setLineStyle(2, 0x000000)
	honeyBody:setFillStyle(Shape.SOLID, 0xffec00)
	honeyBody:beginPath()
	honeyBody:moveTo(0,0)
	honeyBody:lineTo(size,0)
	honeyBody:lineTo(size,size*.8)
	honeyBody:lineTo(0,size*.8)
	honeyBody:closePath()
	honeyBody:endPath()
	honeyBody:setRotation(180)
	honeyBody:setPosition(size*.5,size*.4)
	beeBodyPartSprites[getKeyForValue(beeBodyParts, "honeyBody")] = honeyBody

	local bodyStripe1 = Shape.new()
	bodyStripe1:setPosition(centreX+(size*.125),centreY)
	bodyStripe1:setLineStyle(.1, 0x000000)
	bodyStripe1:setFillStyle(Shape.SOLID, 0x000000)
	bodyStripe1:beginPath()
	bodyStripe1:moveTo(0,0)
	bodyStripe1:lineTo(size*.125,0)
	bodyStripe1:lineTo(size*.125,size*.8)
	bodyStripe1:lineTo(0,size*.8)
	bodyStripe1:closePath()
	bodyStripe1:endPath()
	beeBodyPartSprites[getKeyForValue(beeBodyParts, "bodyStripe1")] = bodyStripe1
	
	local bodyStripe2 = Shape.new()
	bodyStripe2:setPosition(centreX+(size*.375),centreY)
	bodyStripe2:setLineStyle(.1, 0x000000)
	bodyStripe2:setFillStyle(Shape.SOLID, 0x000000)
	bodyStripe2:beginPath()
	bodyStripe2:moveTo(0,0)
	bodyStripe2:lineTo(size*.125,0)
	bodyStripe2:lineTo(size*.125,size*.8)
	bodyStripe2:lineTo(0,size*.8)
	bodyStripe2:closePath()
	bodyStripe2:endPath()
	beeBodyPartSprites[getKeyForValue(beeBodyParts, "bodyStripe2")] = bodyStripe2
	
	local bodyStripe3 = Shape.new()
	bodyStripe3:setPosition(centreX+(size*.625),centreY)
	bodyStripe3:setLineStyle(.1, 0x000000)
	bodyStripe3:setFillStyle(Shape.SOLID, 0x000000)
	bodyStripe3:beginPath()
	bodyStripe3:moveTo(0,0)
	bodyStripe3:lineTo(size*.125,0)
	bodyStripe3:lineTo(size*.125,size*.8)
	bodyStripe3:lineTo(0,size*.8)
	bodyStripe3:closePath()
	bodyStripe3:endPath()
	beeBodyPartSprites[getKeyForValue(beeBodyParts, "bodyStripe3")] = bodyStripe3

	local bodyStripe4 = Shape.new()
	bodyStripe4:setPosition(centreX+(size*.875),centreY)
	bodyStripe4:setLineStyle(.1, 0x000000)
	bodyStripe4:setFillStyle(Shape.SOLID, 0x000000)
	bodyStripe4:beginPath()
	bodyStripe4:moveTo(0,0)
	bodyStripe4:lineTo(size*.125,0)
	bodyStripe4:lineTo(size*.125,size*.8)
	bodyStripe4:lineTo(0,size*.8)
	bodyStripe4:closePath()
	bodyStripe4:endPath()
	beeBodyPartSprites[getKeyForValue(beeBodyParts, "bodyStripe4")] = bodyStripe4

	local head = Shape.new()
	head:setPosition(centreX+(size*.8),centreY-(size*.4))
	head:setLineStyle(3, 0x000000)
	head:setFillStyle(Shape.SOLID, 0xffc308)
	head:beginPath()
	head:moveTo(0,0)
	head:lineTo((size*.6),0)
	head:lineTo((size*.6),(size*.6))
	head:lineTo(0,(size*.6))
	head:closePath()
	head:endPath()
	beeBodyPartSprites[getKeyForValue(beeBodyParts, "head")] = head

	local leftWing = Shape.new()
	leftWing:setPosition(centreX+(size*.35),centreY)
	leftWing:setLineStyle(2, 0x000000)
	leftWing:setFillStyle(Shape.SOLID, 0xb3b3b3, 0.5)
	leftWing:beginPath()
	leftWing:moveTo(0,0)
	leftWing:lineTo(-(size*.2),-(size*.4))
	leftWing:lineTo(0,-(size*.4))
	leftWing:closePath()
	leftWing:endPath()
	beeBodyPartSprites[getKeyForValue(beeBodyParts, "leftWing")] = leftWing
	
	local rightWing = Shape.new()
	rightWing:setPosition(centreX+(size*.45),centreY)
	rightWing:setLineStyle(2, 0x000000)
	rightWing:setFillStyle(Shape.SOLID, 0xb3b3b3, 0.5)
	rightWing:beginPath()
	rightWing:moveTo(0,0)
	rightWing:lineTo((size*.2),-(size*.4))
	rightWing:lineTo(0,-(size*.4))
	rightWing:closePath()
	rightWing:endPath()
	beeBodyPartSprites[getKeyForValue(beeBodyParts, "rightWing")] = rightWing
	
	local sting = Shape.new()
	sting:setPosition(centreX-(size*.5),centreY+(size*.4))
	sting:setLineStyle(2, 0x000000)
	sting:setFillStyle(Shape.SOLID, 0xff4300)
	sting:beginPath()
	sting:moveTo(0,0)
	sting:lineTo((size*.5),-(size*.15))
	sting:lineTo((size*.5),(size*.15))
	sting:closePath()
	sting:endPath()
	beeBodyPartSprites[getKeyForValue(beeBodyParts, "sting")] = sting

	local leg1 = Shape.new()
	leg1:setPosition(centreX+(size*.2),centreY+(size*.8))
	leg1:setLineStyle(2, 0x000000)
	leg1:beginPath()
	leg1:moveTo(0,0)
	leg1:lineTo(0,(size*.25))
	leg1:endPath()
	beeBodyPartSprites[getKeyForValue(beeBodyParts, "leg1")] = leg1
	
	local leg2 = Shape.new()
	leg2:setPosition(centreX+(size*.4),centreY+(size*.8))
	leg2:setLineStyle(2, 0x000000)
	leg2:beginPath()
	leg2:moveTo(0,0)
	leg2:lineTo(0,(size*.25))
	leg2:endPath()
	beeBodyPartSprites[getKeyForValue(beeBodyParts, "leg2")] = leg2
	
	local leg3 = Shape.new()
	leg3:setPosition(centreX+(size*.6),centreY+(size*.8))
	leg3:setLineStyle(2, 0x000000)
	leg3:beginPath()
	leg3:moveTo(0,0)
	leg3:lineTo(0,(size*.25))
	leg3:endPath()
	beeBodyPartSprites[getKeyForValue(beeBodyParts, "leg3")] = leg3
	
	local leg4 = Shape.new()
	leg4:setPosition(centreX+(size*.8),centreY+(size*.8))
	leg4:setLineStyle(2, 0x000000)
	leg4:beginPath()
	leg4:moveTo(0,0)
	leg4:lineTo(0,(size*.25))
	leg4:endPath()
	beeBodyPartSprites[getKeyForValue(beeBodyParts, "leg4")] = leg4
	
	local leftAnt = Shape.new()
	leftAnt:setPosition(centreX+(size*1),centreY-(size*.4))
	leftAnt:setLineStyle(2, 0x000000)
	leftAnt:beginPath()
	leftAnt:moveTo(0,0)
	leftAnt:lineTo(0,-(size*.25))
	leftAnt:lineTo((size*.1),-(size*.25))
	leftAnt:endPath()
	beeBodyPartSprites[getKeyForValue(beeBodyParts, "leftAnt")] = leftAnt
	
	local rightAnt = Shape.new()
	rightAnt:setPosition(centreX+(size*1.2),centreY-(size*.4))
	rightAnt:setLineStyle(2, 0x000000)
	rightAnt:beginPath()
	rightAnt:moveTo(0,0)
	rightAnt:lineTo(0,-(size*.25))
	rightAnt:lineTo((size*.1),-(size*.25))
	rightAnt:endPath()
	beeBodyPartSprites[getKeyForValue(beeBodyParts, "rightAnt")] = rightAnt
	
	local mouth = Shape.new()
	mouth:setPosition(centreX+(size*.9),centreY-(size*.02))
	mouth:setLineStyle(2, 0x000000)
	mouth:beginPath()
	mouth:moveTo(0,0)
	mouth:lineTo(0,(size*.1))
	mouth:lineTo((size*.4),(size*.1))
	mouth:lineTo((size*.4),0)
	mouth:endPath()
	beeBodyPartSprites[getKeyForValue(beeBodyParts, "mouth")] = mouth
	
	local leftEye = Shape.new()
	leftEye:setPosition(centreX+(size*.95),centreY-(size*.3))
	leftEye:setLineStyle(2, 0x000000)
	leftEye:setFillStyle(Shape.SOLID, 0xffffff)
	leftEye:beginPath()
	leftEye:moveTo(0,0)
	leftEye:lineTo(0,(size*.2))
	leftEye:lineTo((size*.1),(size*.2))
	leftEye:lineTo((size*.1),0)
	leftEye:lineTo(0,0)
	leftEye:endPath()
	beeBodyPartSprites[getKeyForValue(beeBodyParts, "leftEye")] = leftEye
	
	local leftPupil = Shape.new()
	leftPupil:setPosition(centreX+(size*.985),centreY-(size*.2))
	leftPupil:setLineStyle(2, 0x000000)
	leftPupil:setFillStyle(Shape.SOLID, 0x000000)
	leftPupil:beginPath()
	leftPupil:moveTo(0,0)
	leftPupil:lineTo(0,(size*.07))
	leftPupil:lineTo((size*.03),(size*.07))
	leftPupil:lineTo((size*.03),0)
	leftPupil:lineTo(0,0)
	leftPupil:endPath()
	beeBodyPartSprites[getKeyForValue(beeBodyParts, "leftPupil")] = leftPupil
	
	local rightEye = Shape.new()
	rightEye:setPosition(centreX+(size*1.15),centreY-(size*.3))
	rightEye:setLineStyle(2, 0x000000)
	rightEye:setFillStyle(Shape.SOLID, 0xffffff)
	rightEye:beginPath()
	rightEye:moveTo(0,0)
	rightEye:lineTo(0,(size*.2))
	rightEye:lineTo((size*.1),(size*.2))
	rightEye:lineTo((size*.1),0)
	rightEye:lineTo(0,0)
	rightEye:endPath()
	beeBodyPartSprites[getKeyForValue(beeBodyParts, "rightEye")] = rightEye
	
	local rightPupil = Shape.new()
	rightPupil:setPosition(centreX+(size*1.185),centreY-(size*.2))
	rightPupil:setLineStyle(2, 0x000000)
	rightPupil:setFillStyle(Shape.SOLID, 0x000000)
	rightPupil:beginPath()
	rightPupil:moveTo(0,0)
	rightPupil:lineTo(0,(size*.07))
	rightPupil:lineTo((size*.03),(size*.07))
	rightPupil:lineTo((size*.03),0)
	rightPupil:lineTo(0,0)
	rightPupil:endPath()
	beeBodyPartSprites[getKeyForValue(beeBodyParts, "rightPupil")] = rightPupil

	-- Add body parts to the bee in the right order
	for i=1, #beeBodyParts do
		self:addChild(beeBodyPartSprites[i])	
	end
end

function Bee:reduceHoney(reduction)

	if (self.honeyCur-reduction > 0) then -- As long as this reduction does not take the honey level below 0
		-- Reduce the bee's honey level
		self.honeyCur = self.honeyCur - reduction
		
		-- Get the bee's body shape and reduce it
		local delta = 1 / self.honeyMax --Figure out how much to change the scale based on honey max level
		local honeyBodyIndex = getKeyForValue(beeBodyParts, "honeyBody") -- Get the index of the honeyBody
		local beeBody = self:getChildAt(honeyBodyIndex) -- Get the bee's honey body
		local beeScale = beeBody:getScaleY() -- Get the current scale of the bee's honey body
		beeBody:setScaleY(beeScale-(delta*reduction)) -- Reduce the scale based on how much honey is being reduced
	else -- If the reduction doesn't take it below ero, set the cur to 0 (this needs work)
		self.honeyCur = 0
	end
end

function Bee:move (destinationComb)
	
	if(self.comb ~= nil) then -- Only do the following if this is not the first time the bee is moving
	
		-- Stop the comb the bee is currently on from being filled
		--bee.comb.honeyFillTimer = nil
		if (self.comb.honeyFillTimer ~= nil) then 
			self.comb.honeyFillTimer:stop()
		end
		
		-- Reset the comb the bee is currently on so it does not think a bee is still on it
		self.comb.bee = nil

	end
	-- Figure out where to move the bee to
	moveToX = destinationComb.centreX
	moveToY = destinationComb.centreY

	-- Work out which easing functions to use for X and Y
	if (moveToX-self:getX()==0) then
		easeX = {self:getX(), moveToX, "linear"}
		easeY = {self:getY(), moveToY, "inOutBack"}
		--print("moving along x-axis")
	elseif (moveToY-self:getY()==0) then
		easeX = {self:getX(), moveToX, "inOutBack"}
		easeY = {self:getY(), moveToY, "linear"}
		--print("moving along y-axis")
	else
		easeX = {self:getX(), moveToX, "linear"}
		easeY = {self:getY(), moveToY, "inOutBack"}
		--print("moving as default")
	end
	
	-- Work out how many frames to use (i.e. speed)
	speedFactor = 200
	distFactor = (math.abs((moveToX-self:getX()))+math.abs((moveToY-self:getY())))
	--print("Distance factor: "..distFactor)
	if (distFactor <= 100) then
		speed = speedFactor / 4;
	elseif (distFactor <= 200) then
		speed = speedFactor / 3.5;
	elseif (distFactor <= 300) then
		speed = speedFactor / 3;
	else
		speed = speedFactor / 2.5;
	end
	
	-- Move the bee
	local movement = MovieClip.new{
		{1, speed, self, {
			x = easeX, 
			y = easeY
		}}
	}
	
	-- Add event listener so we know when the movement is finished
	movement:addEventListener(Event.COMPLETE, startHoneyFill, destinationComb)
	
	-- Set the comb the bee will now be on and reset the bees current comb tracker
	self.comb = destinationComb
	-- Tell the comb which bee is resting on it
	destinationComb.bee = self
end

