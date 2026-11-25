local NumberFormat = {}

local Suffixes = {"", "k", "m", "b", "t", "qa", "qi", "sx", "sp", "oc", "no", "dc"}

function NumberFormat.formatNumber(n)
	if n < 1000 then
		return tostring(math.floor(n))
	end

	local index = math.floor(math.log10(n) / 3)
	index = math.min(index, #Suffixes - 1)

	local scaled = n / (10 ^ (index * 3))
	local suffix = Suffixes[index + 1]

	if scaled >= 100 then
		return string.format("%d%s", math.floor(scaled), suffix)
	else
		local safeNum = math.floor(scaled * 10) / 10
		local formatted = string.format("%.1f%s", safeNum, suffix)
		return formatted:gsub("%.0", "")
	end
end

return NumberFormat
