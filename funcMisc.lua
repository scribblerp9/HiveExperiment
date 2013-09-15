
function getKeyForValue (array, value)

	for k,v in pairs(array) do
	
		if (v == value) then
			return k
		end
	end
	
end

function xferHoneyFromBeeToComb (comb, bee, xferAmount)
	if ((comb.honeyCur < comb.honeyMax) and (bee.honeyCur > 0)) then -- If the comb is not already full and the bee has honey left
		comb:addHoney(xferAmount)
		bee:reduceHoney(xferAmount)
	end
end