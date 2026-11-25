local rs = game:GetService("ReplicatedStorage")
local UpgradeCosts = require(rs:WaitForChild("UpgradeCosts"))
local purchaseEvent = rs:WaitForChild("PurchaseUpgrade")

purchaseEvent.OnServerEvent:Connect(function(player, upgradeName)
	
	local upgradetype = UpgradeCosts[upgradeName]
	if not upgradetype then return end
	
	local leaderstats = player:WaitForChild("leaderstats")
	local upgradeFolder = player:WaitForChild("Upgrades")
	if not leaderstats or not upgradeFolder then
	return end

	
	local gems = leaderstats:FindFirstChild("Gems")
	local upgradeObj = upgradeFolder:FindFirstChild(upgradeName)
	if not gems or not upgradeObj then
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
	return end
	
	local price = priceList[currentIndex + 1]
	if gems.Value < price then
	return end
	gems.Value -= price
	upgradeObj.Value = multList[currentIndex + 1]
	
end)