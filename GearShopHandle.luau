local player = game.Players.LocalPlayer
local leaderstats = player:WaitForChild("leaderstats")
local Upgrades = player:WaitForChild("Upgrades")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UpgradeCosts = require(ReplicatedStorage:WaitForChild("UpgradeCosts"))
local purchaseEvent = ReplicatedStorage:WaitForChild("PurchaseUpgrade")

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
	
	purchaseBtn.MouseButton1Click:Connect(function()
		purchaseEvent:FireServer(upgradeName)
		print("clicked")
	end)
	
	local function updateVisuals()
		--update bars
		local upgradeObj = Upgrades:FindFirstChild(upgradeName)
		if not upgradeObj then return end
		local upgradeValue = upgradeObj.Value
		
		local currentLevel = 1
		for i, mult in ipairs(multList) do
			if mult == upgradeValue then 
				currentLevel = i
				print(currentLevel)
				break
			end
		end
		
		for i = 1 , 10 do 
			local boxName = string.format("%02d", i)
			local box = counter:FindFirstChild(boxName)
			if not box then return end
			
			if i <= maxLevel then 
				if i < currentLevel then 
					box.BackgroundColor3 = Color3.fromRGB(11, 235, 48)
				else
					box.BackgroundColor3 = Color3.fromRGB(255,255,255)
				end
			end	
		end
		
		-- update text
		local option = item:WaitForChild("option" .. itemNum)
		local before = option:WaitForChild("BeforeValue")
		local after = option:WaitForChild("AfterValue")
		
		local currentMult = multList[currentLevel]
		local nextMult = multList[currentLevel + 1]
		
		if upgradeName == "CashMult" then
			before.Text = currentMult .. "x cash"
			if nextMult == nil then 
				after.Text = "Max"
			else
				after.Text = nextMult .. "x cash"
			end
			
		end
		
		if upgradeName == "GooMult" then
			before.Text = currentMult .. "x goo"
			if nextMult == nil then 
				after.Text = "Max"
			else
				after.Text = nextMult .. "x goo"
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
			before.Text = currentMult .. "x drop speed"
			if nextMult == nil then 
				after.Text = "Max"
			else
				after.Text = nextMult .. "x drop speed"
			end	
		end
		
		-- update buttons
		--[[
		local price = priceList[currentLevel + 1]
		purchaseBtn.Text = price
		]]
		
	end
	
	
	updateVisuals()
	Upgrades:WaitForChild(upgradeName).Changed:Connect(updateVisuals)
end



setupUpgradeGui("1", "CashMult")
setupUpgradeGui("2", "GooMult")
setupUpgradeGui("3", "GemMult")
setupUpgradeGui("4", "DropSpeed")


