
Comb = Core.class(Shape)
function Comb:init(len, cenX, cenY)
	
	self.edgeLength = len
	self.centreX = cenX
	self.centreY = cenY
	self.centreDot = nil
	
	self.bee = nil -- The bee that is resting on this comb
	
	self.honeyCur = 0
	self.honeyMax = 500
	self.honeyFillTimer = nil
	
	self.hiveIndex = nil -- This is the index of this comb in the hive
	
	self.honeyShape = Shape.new()
	-- Set the coords of the 6 vertices
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
	-- Set look
	self.honeyShape:setFillStyle(Shape.SOLID, 0xFFC308)
	
	-- Draw
	self.honeyShape:beginPath()
	self.honeyShape:moveTo(pt1X,pt1Y)
	self.honeyShape:lineTo(pt2X,pt2Y)
	self.honeyShape:lineTo(pt3X,pt3Y)
	self.honeyShape:lineTo(pt4X,pt4Y)
	self.honeyShape:lineTo(pt5X,pt5Y)
	self.honeyShape:lineTo(pt6X,pt6Y)
	self.honeyShape:closePath()
	self.honeyShape:endPath()
	
	self.honeyShape:setScale(0,0)
	self.honeyShape:setPosition(len*.5,len*.875)
	
	self:addChild(self.honeyShape)
	
end

function Comb:addHoney(addition)

	--[[
	local scale = comb.honeyShape:getScaleX() -- Don't need to get X and Y scale as we will be keeping them the same anyway
	local posX = comb.honeyShape:getX()
	local posY = comb.honeyShape:getY()
	local delta = 0.002 -- This controls how quickly the honey "fills up"
	
	if(scale >= 0.95) then
		return
	end
	--print(honeyFillTimer:getCurrentCount())
	comb.honeyShape:setScale(scale+delta, scale+delta) -- Increase size slightly
	comb.honeyShape:setPosition(posX-(delta*(comb.edgeLength/2)), posY-(delta*(comb.edgeLength/1.15))) -- This formula keeps the honeyShape in the centre of the comb
	]]--


	if (self.honeyCur+addition < self.honeyMax) then -- As long as this addition does not take the honey level above the max
		-- Increase the comb's honey level
		self.honeyCur = self.honeyCur + addition
		
		-- Figure out how much to change the scale by based on max level
		local delta = 1 / self.honeyMax -- Figure out how much to change the scale based on honey max level
		
		-- Increase the scale of the comb's honey shape
		local scale = self.honeyShape:getScaleX() -- Get the current scale of the comb's honey level
		self.honeyShape:setScale(scale+(delta*addition)) -- Reduce the scale based on how much honey is being reduced
		
		-- Move the honey shape so it stays in the center
		local posX = self.honeyShape:getX() -- Get the honey shape's x coord
		local posY = self.honeyShape:getY() -- Get the honey shape's y coord
		self.honeyShape:setPosition(posX-(delta*(self.edgeLength/2)), posY-(delta*(self.edgeLength/1.15))) -- This formula keeps the honeyShape in the centre of the comb

		--print(posX, delta, delta*addition)
	else -- If the addition doesn't take it above the max, set the cur to the max (this needs work)
		self.honeyCur = self.honeyMax
	end
end

-- Start filling the comb
function startHoneyFill(comb)
	
	comb.honeyFillTimer = Timer.new(1)
	comb.honeyFillTimer:addEventListener(Event.TIMER, onHoneyFillTimer, comb)
	comb.honeyFillTimer:start()
	
end

-- Fill the comb a little bit each millisecond
function onHoneyFillTimer(comb)
	xferHoneyFromBeeToComb(comb, comb.bee, 1)
end
