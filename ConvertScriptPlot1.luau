local StartupModule = require(game.ServerScriptService:WaitForChild("StartupModule"))
local CnvtBtn = script.Parent
local plotFolder = CnvtBtn.Parent
local plotNum = tonumber(plotFolder.Name)
local debounce = true
local udebounce = true
local currentlyConverting = false
local Players = game:GetService("Players")
local ConvtBillPart = plotFolder:WaitForChild("ConvertionBillPart")
local ConvtBill = ConvtBillPart:WaitForChild("ConversionBill")
local ConvertPerSecLabel = ConvtBill:WaitForChild("Convert/S")
local ConvertRemainingLabel = ConvtBill:WaitForChild("ConvertRemaining")
local upgradeBtn = plotFolder:WaitForChild("PackageBtn")
local packageUpgradeBill = upgradeBtn:WaitForChild("PackageUpgradeBill")
local upgradeAmountLabel = packageUpgradeBill:WaitForChild("PackageAmount")
local upgradePriceLabel = packageUpgradeBill:WaitForChild("Price")
local StarterGui = game:GetService("StarterGui")





CnvtBtn.Touched:Connect(function(hit)
	local character = hit.Parent
	local player = Players:GetPlayerFromCharacter(character)
	
	if player and debounce then
		debounce = false
		local plotNumber = player:FindFirstChild("PlotNumber")
		if plotNumber.Value == plotNum then
			CnvtBtn.Color = Color3.fromRGB(68, 126, 177)
			local goo = player.leaderstats.Goo
			local coins = player.leaderstats.Coins
			local convertAmount = player:WaitForChild("ConvtPerSec")
			local Converting = player:WaitForChild("Converting")
			
			if goo.Value > 0 then 
				Converting.Value = Converting.Value + goo.Value
				ConvertRemainingLabel.Text = ("Remaining: " .. Converting.Value)
				goo.Value = 0
			end
			if currentlyConverting == false then 	
				while Converting.Value > 0 do
					if Converting.Value > convertAmount.Value then
						if currentlyConverting == false then 
							currentlyConverting = true
							Converting.Value = Converting.Value - convertAmount.Value
							coins.Value = coins.Value + convertAmount.Value
							ConvertRemainingLabel.Text = ("Remaining: " .. Converting.Value)
						end
					else
						local CoinAmount = StarterGui:WaitForChild("CurrencyTracker"):WaitForChild("Coin"):WaitForChild("Amount")
						coins.Value = coins.Value + Converting.Value
						CoinAmount.Text = coins.Value
						Converting.Value = 0
						ConvertRemainingLabel.Text = ("Remaining: " .. StartupModule.formatNumber(Converting.Value))
					end
				
					wait(1)
					CnvtBtn.Color = Color3.fromRGB(9, 144, 140)
					currentlyConverting = false
				end
			end		
		end
	end
	wait(4)
	debounce = true
end)

local function CalculateConvertUpgradeAndPrice(player, lastUpgradeAmount)
	local coins = player.leaderstats.Coins
	local convertPS = player:WaitForChild("ConvtPerSec")
	local currentRate = convertPS.Value
	local upgradePrice = 14 + currentRate * (math.min(20,(currentRate^0.45)))
	local upgradeAmount = lastUpgradeAmount.Value + 1
	lastUpgradeAmount = upgradeAmount
	return math.floor(upgradeAmount), math.floor(upgradePrice), math.floor(lastUpgradeAmount)
end

upgradeBtn.Touched:Connect(function(hit)
	local character = hit.Parent
	local player = Players:GetPlayerFromCharacter(character)
	
	if player and udebounce then
		
		local plotNumber = player:FindFirstChild("PlotNumber")
		
		if plotNumber.Value == plotNum then
			udebounce = false
			local convertAmount = player:WaitForChild("ConvtPerSec")
			local lastUA = player:WaitForChild("LastUA")
			local coins = player:WaitForChild("leaderstats").Coins
			local upgradeAmount, upgradePrice, lastUpgradeAmount = CalculateConvertUpgradeAndPrice(player, lastUA)
			lastUA.Value = lastUpgradeAmount
			if coins.Value >= upgradePrice then
				upgradeBtn.Color = Color3.fromRGB(179, 74, 74)

				coins.Value = coins.Value - upgradePrice
				convertAmount.Value = convertAmount.Value + upgradeAmount
				StartupModule.UpdateConvertDiplay(player)
				StartupModule.UpdateConvertUpgradeButtonDiplay(player, lastUpgradeAmount)
			end
		end
		wait(1)
		upgradeBtn.Color = Color3.fromRGB(104, 217, 78)
		udebounce = true
	end
end)