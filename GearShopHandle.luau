local player = game.Players.LocalPlayer
local NumberFormatModule = require(game.ReplicatedStorage:WaitForChild("NumberFormat"))
local leaderstats = player:WaitForChild("leaderstats")
local Upgrades = player:WaitForChild("Upgrades")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UpgradeCosts = require(ReplicatedStorage:WaitForChild("UpgradeCosts"))
local purchaseEvent = ReplicatedStorage:WaitForChild("PurchaseUpgrade")
local MPS = game:GetService("MarketplaceService")

local gearShop = script.Parent
local ScrollFrame = gearShop:WaitForChild("Scroll")

local function setupUpgradeGui(itemNum, upgradeName)
	local item = ScrollFrame:WaitForChild(itemNum)
	local counter = item:WaitForChild("option" .. itemNum):WaitForChild("UpgradeCounter")
	local purchaseBtn = item:WaitForChild("GemPurchase" .. itemNum)
	
	local upgradeData = UpgradeCosts[upgradeName]
	local maxLevel = upgradeData.max
	local multList = upgradeData.multipliers
	local priceList = upgradeData.prices
	
	
	
	local function updateVisuals()
		--update bars
		local upgradeObj = Upgrades:FindFirstChild(upgradeName)
		if not upgradeObj then return end
		local upgradeValue = upgradeObj.Value
		
		local currentLevel = 1
		for i, mult in ipairs(multList) do
			if mult == upgradeValue then 
				currentLevel = i
				break
			end
		end
		
		for i = 1 , maxLevel do 
			local boxName = string.format("%02d", i)
			local box = counter:FindFirstChild(boxName)
			if not box then return end
						
			if i < currentLevel then 
				box.BackgroundColor3 = Color3.fromRGB(11, 235, 48)
			else
				box.BackgroundColor3 = Color3.fromRGB(255,255,255)
			end	
		end
		
		-- update text
		local option = item:WaitForChild("option" .. itemNum)
		local before = option:WaitForChild("BeforeValue")
		local after = option:WaitForChild("AfterValue")
		
		local currentMult = multList[currentLevel]
		local nextMult = multList[currentLevel + 1]
		
		if upgradeName == "CashMult" then
			before.Text = currentMult/10 .. "x cash"
			if nextMult == nil then 
				after.Text = "Max"
			else
				after.Text = nextMult/10 .. "x cash"
			end
			
		end
		
		if upgradeName == "GooMult" then
			before.Text = currentMult/10 .. "x goo"
			if nextMult == nil then 
				after.Text = "Max"
			else
				after.Text = nextMult/10 .. "x goo"
			end
		end
		
		if upgradeName == "GemMult" then
			before.Text = currentMult .. "x gems"
			if nextMult == nil then 
				after.Text = "Max"
			else
				after.Text = nextMult .. "x gems"
			end
		end
		
		if upgradeName == "DropSpeed" then 
			before.Text = currentMult/10 .. "x drop speed"
			if nextMult == nil then 
				after.Text = "Max"
			else
				after.Text = nextMult/10 .. "x drop speed"
			end	
		end
		
		if upgradeName == "TierUpgrade" then
			before.Text = "Tier " .. currentMult .. " Droppers"
			if nextMult == nil then 
				after.Text = "Max"
			else
				after.Text = "Tier " .. nextMult .. " Droppers"
			end
		end
		
		-- update purchasebuttons

		local price = priceList[currentLevel + 1]
		if price == nil then
			purchaseBtn.Text = "Max"
		else
			purchaseBtn.Text = NumberFormatModule.formatNumber(price)
		end
		
	end
	
	updateVisuals()
	Upgrades:WaitForChild(upgradeName).Changed:Connect(updateVisuals)
	
	purchaseBtn.MouseButton1Click:Connect(function()
		purchaseEvent:FireServer(upgradeName)
		updateVisuals()
	end)
end



setupUpgradeGui("1", "CashMult")
setupUpgradeGui("2", "GooMult")
setupUpgradeGui("3", "GemMult")
setupUpgradeGui("4", "DropSpeed")
setupUpgradeGui("5", "TierUpgrade")







-- robux purchases

local UpgradesAmounts = player:WaitForChild("Upgrades")
local CashMult = UpgradesAmounts:WaitForChild("CashMult")
local GooMult = UpgradesAmounts:WaitForChild("GooMult")
local GemMult = UpgradesAmounts:WaitForChild("GemMult")
local DropSpeed = UpgradesAmounts:WaitForChild("DropSpeed")
local TierUpgrade = UpgradesAmounts:WaitForChild("TierUpgrade")


local RobuxUpgradePurchaseIds = {
	[1] = {
		Id = 3732993121,
		MaxValue = 20,
		Name = "CashMult"
	},	
	[2] ={ 
		Id = 3732993151,
		MaxValue = 20,
		Name = "GooMult"
	},
	[3] = {
		Id = 3732993203,
		MaxValue = 32,
		Name = "GemMult"
	},
	[4] = {
		Id = 3732993234,
		MaxValue = 20,
		Name = "DropSpeed"
	},
	[5] = {
		Id = 3733510052,
		MaxValue = 5,
		Name = "TierUpgrade"
	}
}


for i = 1,5 do
	local RobuxPurchaseButton = script.Parent:WaitForChild("Scroll"):WaitForChild(i):WaitForChild("RobuxPurchase" .. i)
	local Id = RobuxUpgradePurchaseIds[i].Id
	local Name = RobuxUpgradePurchaseIds[i].Name
	local item = player:WaitForChild("Upgrades"):WaitForChild(Name)
	local Value = item.Value
	local MaxValue = RobuxUpgradePurchaseIds[i].MaxValue
	item.Changed:Connect(function()
		Value = item.Value
		if Value >= MaxValue then RobuxPurchaseButton.Text = "Max" end
	end)
	RobuxPurchaseButton.MouseButton1Click:Connect(function()
		if MaxValue <= Value then return end
		MPS:PromptProductPurchase(player, Id)
	end)
end