

function onMouseDown(self, event)
	if self:hitTestPoint(event.x, event.y) then
		self.isFocus = true

		--[[self.x0 = event.x
		self.y0 = event.y]]--

		event:stopPropagation()
		
		-- Check if a comb was tapped
		for combIndex in pairs(hiveScene.hive) do
			if hiveScene.hive[combIndex] == self then
				print("Comb "..combIndex.." tapped")
			end
		end
		
	end
end

--[[local function onMouseMove(self, event)
	if self.isFocus then
		local dx = event.x - self.x0
		local dy = event.y - self.y0
		
		self:setX(self:getX() + dx)
		self:setY(self:getY() + dy)

		self.x0 = event.x
		self.y0 = event.y

		event:stopPropagation()
	end
end]]--

function onMouseUp(self, event)
	if self.isFocus then
		self.isFocus = false
		event:stopPropagation()
	end
end
