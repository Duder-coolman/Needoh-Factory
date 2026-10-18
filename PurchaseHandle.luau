local rs = game:GetService("ReplicatedStorage")
local UpgradeCosts = require(rs:WaitForChild("UpgradeCosts"))
local purchaseEvent = rs:WaitForChild("PurchaseUpgrade")

purchaseEvent.OnServerEvent:Connect(function(player, upgradeName)
	
	print("eventFires")
	
	local upgradetype = UpgradeCosts[upgradeName]
	if not upgradetype then return end
	
	local leaderstats = player:WaitForChild("leaderstats")
	local upgradeFolder = player:WaitForChild("Upgrades")
	if not leaderstats or not upgradeFolder then
		print("leaderstats")
	return end

	
	local gems = leaderstats:FindFirstChild("Gems")
	local upgradeObj = upgradeFolder:FindFirstChild(upgradeName)
	print(upgradeObj)
	print(upgradeObj.Value)
	if not gems or not upgradeObj then
		print("gems or upgradeObj not found")
	return end
	
	local currentVal = upgradeObj.Value
	local maxLevel = upgradetype.max
	local multList = upgradetype.multipliers
	local priceList = upgradetype.prices
	
	local currentIndex = 0
	for i , mult in ipairs(multList) do
		if mult == currentVal then currentIndex = i break end
	end
	
	if currentIndex > maxLevel then
		print("maxlevel")
	return end
	
	local price = priceList[currentIndex + 1]
	if gems.Value < price then
		print("not enough gems")
	return end
	gems.Value -= price
	upgradeObj.Value = multList[currentIndex + 1]
	print(upgradeObj)
	print(price)
	print(upgradeObj.Value)
	
end)