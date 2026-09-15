local StartupModule = {}

local Suffixes = {"", "k", "m", "b", "t", "qa", "qi", "sx", "sp", "oc", "no", "dc"}

function StartupModule.formatNumber(n)
	if n < 1000 then
		return tostring(math.floor(n))
	end
	
	local index = math.floor(math.log10(n) / 3)
	index = math.min(index, #Suffixes - 1)
	
	local scaled = n / (10 ^ (index * 3))
	local suffix = Suffixes[index + 1]
	
	if scaled >= 100 then
		return string.format("%.0f%s", scaled, suffix)
	else
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



return StartupModule

