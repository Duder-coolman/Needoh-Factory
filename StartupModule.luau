local StartupModule = {}

local Suffixes = {"", "k", "m", "b", "t", "qa", "qi", "sx", "sp", "oc", "no", "dc"}

function StartupModule.formatNumber(n)
	if n < 1000 then
		return tostring(math.ceil(n))
	end
	
	local index = math.floor(math.log10(n) / 3)
	index = math.min(index, #Suffixes - 1)
	
	local scaled = n / (10 ^ (index * 3))
	local suffix = Suffixes[index + 1]
	
	if scaled >= 100 then
		scaled = math.ceil(scaled)
		return string.format("%.0f%s", scaled, suffix)
	else
		scaled = math.ceil(scaled * 10) / 10
		local formatted = string.format("%.1f%s", scaled, suffix)
		return(formatted:gsub("%.0", ""))
	end
end

function StartupModule.UpdateConvertDiplay(player)
	local plrPlotNum = player:WaitForChild("PlotNumber")
	local plotFolder = game.Workspace.Map.Plots:WaitForChild(plrPlotNum.Value)
	local ConvtBillPart = plotFolder:WaitForChild("ConvertionBillPart")
	local ConvtBill = ConvtBillPart:WaitForChild("ConversionBill")
	local ConvertPerSecLabel = ConvtBill:WaitForChild("Convert/S")
	local ConvertPS = player:WaitForChild("ConvtPerSec")
	
	ConvertPerSecLabel.Text = ("Converting " .. ConvertPS.Value .. " Every Second")
	
end

function StartupModule.UpdateConvertUpgradeButtonDiplay(player, lastUA)
	local plrPlotNum = player:WaitForChild("PlotNumber")
	local plotFolder = game.Workspace.Map.Plots:WaitForChild(plrPlotNum.Value)
	local upgradeBtn = plotFolder:WaitForChild("PackageBtn")
	local packageUpgradeBill = upgradeBtn:WaitForChild("PackageUpgradeBill")
	local upgradeAmountLabel = packageUpgradeBill:WaitForChild("PackageAmount")
	local upgradePriceLabel = packageUpgradeBill:WaitForChild("Price")
	
	local coins = player.leaderstats.Coins
	local convertPS = player:WaitForChild("ConvtPerSec")
	local currentRate = convertPS.Value
	
	local upgradePrice = 14 + currentRate * (math.min(20,(currentRate^0.45)))
	local upgradeAmount = lastUA + 1
	
	upgradePriceLabel.Text = ("$" .. StartupModule.formatNumber(upgradePrice))
	upgradeAmountLabel.Text = ("+ " .. upgradeAmount .. " Packaged/s")
end

local BasePrice = 10
local PriceIncrement = 1.5
local function calculateDisplayedPurchase(amountToBuy, droppersOwned)
	local totalCost = (amountToBuy * BasePrice) + PriceIncrement * (amountToBuy * droppersOwned + (amountToBuy * (amountToBuy - 1)) / 2)
	local newLastPrice = BasePrice + ((droppersOwned + amountToBuy) * PriceIncrement)

	return math.floor(totalCost)
end

function StartupModule.UpdatePurchaseBtnDisp(plrPlotNum, DroppersOwned)
	
	local Btn1Bill = game.Workspace.Map.Plots:WaitForChild(plrPlotNum.Value):WaitForChild("PurchaseButtons"):WaitForChild("Purchase1Btn"):WaitForChild("Btn1Billboard"):WaitForChild("Btn1Price")
	local Btn5Bill = game.Workspace.Map.Plots:WaitForChild(plrPlotNum.Value):WaitForChild("PurchaseButtons"):WaitForChild("Purchase5Btn"):WaitForChild("Btn5Billboard"):WaitForChild("Btn5Price")
	local Btn25Bill = game.Workspace.Map.Plots:WaitForChild(plrPlotNum.Value):WaitForChild("PurchaseButtons"):WaitForChild("Purchase25Btn"):WaitForChild("Btn25Billboard"):WaitForChild("Btn25Price")
	local Btn100Bill = game.Workspace.Map.Plots:WaitForChild(plrPlotNum.Value):WaitForChild("PurchaseButtons"):WaitForChild("Purchase100Btn"):WaitForChild("Btn100Billboard"):WaitForChild("Btn100Price")
	
	
	local cost1 = calculateDisplayedPurchase(1, DroppersOwned.Value)
	local cost5 = calculateDisplayedPurchase(5, DroppersOwned.Value)
	local cost25 = calculateDisplayedPurchase(25, DroppersOwned.Value)
	local cost100 = calculateDisplayedPurchase(100, DroppersOwned.Value)

	Btn1Bill.Text = "$" .. StartupModule.formatNumber(cost1)
	Btn5Bill.Text = "$" .. StartupModule.formatNumber(cost5)
	Btn25Bill.Text = "$" .. StartupModule.formatNumber(cost25)
	Btn100Bill.Text = "$" .. StartupModule.formatNumber(cost100)

	
end
	




return StartupModule

