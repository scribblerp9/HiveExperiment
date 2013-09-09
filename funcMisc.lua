
function getKeyForValue (array, value)

	for k,v in pairs(array) do
	
		if (v == value) then
			return k
		end
	end
	
end