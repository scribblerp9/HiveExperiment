
function createComb (startX, startY, len)
		
	local comb = Comb.new(len, startX + (len/2), startY + (len*.875))
	
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

	--[[ Debug
	print("1 - ("..pt1X..","..pt1Y..")")
	print("2 - ("..pt2X..","..pt2Y..")")
	print("3 - ("..pt3X..","..pt3Y..")")
	print("4 - ("..pt4X..","..pt4Y..")")
	print("5 - ("..pt5X..","..pt5Y..")")
	print("6 - ("..pt6X..","..pt6Y..")")
	]]--
	
	-- Set look
	comb:setLineStyle(4, 0xde6821)
	comb:setFillStyle(Shape.SOLID, 0x857142)
	
	-- Draw
	comb:beginPath()
	comb:moveTo(pt1X,pt1Y)
	comb:lineTo(pt2X,pt2Y)
	comb:lineTo(pt3X,pt3Y)
	comb:lineTo(pt4X,pt4Y)
	comb:lineTo(pt5X,pt5Y)
	comb:lineTo(pt6X,pt6Y)
	comb:closePath()
	comb:endPath()
	
	comb:setPosition(startX,startY)
	
	-- Add event listeners for touching
	comb.isFocus = false
	comb:addEventListener(Event.MOUSE_DOWN, onMouseDown, comb)
	--hexagon:addEventListener(Event.MOUSE_MOVE, onMouseMove, hexagon)
	comb:addEventListener(Event.MOUSE_UP, onMouseUp, comb)
	
	--Add a dot at the centre for future debug purposes
	local dot = Shape.new()
	dot:setLineStyle(4, 0x000000)
	dot:setFillStyle(Shape.SOLID, 0xFFC308, 0.5)
	dot:beginPath()
	dot:moveTo(0,0)
	dot:closePath()
	dot:endPath()
	dot:setPosition(comb.centreX,comb.centreY)
	comb.centreDot = dot

	return comb
end

function createRow (posX, posY, length, numCombs)
--[[
pos X and Y = Top left coords of the row of cells
numCombs = Number of combs in the row
length = length of each side of a combs
]]--
	factor = 0
	for i = 1, numCombs do
		local comb = createComb(posX + (length*3*factor), posY, length)
		comb.hiveIndex = totNumCombs

		hive[totNumCombs] = comb
		totNumCombs = totNumCombs + 1
		factor = factor + 1
	end
end

function createHive (posX, posY, length, numRows, numPerRow)

	local factor = 0
	for rowNum = 1, numRows do
		
		-- Figure out if this is an even row or not
		evenRow = math.fmod(rowNum,2)
		-- Switch the evenRow flag around, without this it would be called "oddRow"! How silly!
		if evenRow == 0 then 
			evenRow = 1 
		elseif evenRow == 1 then 
			evenRow = 0
		end
		
		createRow(posX + ((length+length/2)*evenRow), posY + (length*.875*factor), length, numPerRow-evenRow, scene)
		factor = factor + 1
		
	end
		
end

function createBee (bodyLen, posiX, posiY)
	
	--Setup the center point of the bee
	local posX = -(bodyLen*.5)
	local posY = -(bodyLen*.4)
	
	-- Initiate bee
	local bee = Bee.new(posX, posY, bodyLen)
	--print("bee funccreation",bee)
	-- Set position of bee on screen
	bee:setPosition(posiX,posiY)

	return bee
end

function createBees (numBees, beeSize)

	for i = 1, numBees do		
		
		--[[ Start each bee on a comb (but do not fill honey on ths start comb)
		startComb = math.random(1, #hivehive)
		while (hivehive[startComb].bee ~= nil) do -- If the comb is occupied then pick another comb
			startComb = math.random(1, #hivehive)
		end
		bees[i] = createBee(beeSize, hivehive[startComb].centreX, hivehive[startComb].centreY)
		bees[i].comb = hivehive[startComb]
		bees[i].swarmIndex = i
		hivehive[startComb].bee = bees[i]
		
		initBeeMoveDelay = math.random(200, 7000)
		bees[i].moveTimer = Timer.new(initBeeMoveDelay)
		]]--
		
		-- Start bee off screen
		local maxOffscreenDist = 200 -- Maximum distance off scren a bee can start at
		startX = math.random(-maxOffscreenDist, application:getDeviceWidth()+maxOffscreenDist)
		while((startX>0) and (startX<application:getDeviceWidth())) do -- If random number is between 0 and screen width then pick another number
			startX = math.random(-maxOffscreenDist, application:getDeviceWidth()+maxOffscreenDist)
		end
		startY = math.random(-maxOffscreenDist, application:getDeviceHeight()+maxOffscreenDist)
		while((startY>0) and (startY<application:getDeviceHeight())) do -- If random number is between 0 and screen height then pick another number
			startY = math.random(-maxOffscreenDist, application:getDeviceHeight()+maxOffscreenDist)
		end
		
		swarm[i] = createBee(beeSize, startX, startY)
		swarm[i].swarmIndex = i

		initBeeMoveDelay = math.random(200, 7000)
		swarm[i].moveTimer = Timer.new(initBeeMoveDelay)
	end
	
end