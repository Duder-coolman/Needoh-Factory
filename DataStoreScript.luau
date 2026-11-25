local MergeModule = require(game.ServerScriptService:WaitForChild("MergeModule"))
local StartupModule = require(game.ServerScriptService:WaitForChild("StartupModule"))
local DataStoreService = game:GetService("DataStoreService")
local GooDataStore = DataStoreService:GetDataStore("PlayerGooData")
local CoinsDataStore = DataStoreService:GetDataStore("PlayerCoinsData")
local GemsDataStore = DataStoreService:GetDataStore("PlayerGemsData")
local ConvtPerSecDataStore = DataStoreService:GetDataStore("ConvtPerSecData")
local ConvertingDataStore = DataStoreService:GetDataStore("ConvertingData")
local DroppersOwnedDataStore = DataStoreService:GetDataStore("DroppersOwnedData")
local DropperPriceDataStore = DataStoreService:GetDataStore("DropperPriceData")
local LastUADataStore = DataStoreService:GetDataStore("LastUA")

--Upgrade Data Stores
local CashMultDataStore = DataStoreService:GetDataStore("CashMultData")
local GooMultDataStore = DataStoreService:GetDataStore("GooMultData")
local GemMultDataStore = DataStoreService:GetDataStore("GemMultData")
local DropSpeedDataStore = DataStoreService:GetDataStore("DropSpeedData")
local TierUpgradeDataStore = DataStoreService:GetDataStore("TierUpgradeData")

local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player
	local DroppersOwned = Instance.new("IntValue")
	DroppersOwned.Name = "DroppersOwned"
	DroppersOwned.Parent = player
	local DropperPrice = Instance.new("IntValue")
	DropperPrice.Name = "DropperPrice"
	DropperPrice.Parent = player
	local ConvtPerSec = Instance.new("IntValue")
	ConvtPerSec.Name = "ConvtPerSec"
	ConvtPerSec.Parent = player
	local Converting = Instance.new("IntValue")
	Converting.Name = "Converting"
	Converting.Parent = player
	local LastUA = Instance.new("IntValue")
	LastUA.Name = "LastUA"
	LastUA.Parent = player
	local Goo = Instance.new("IntValue")
	Goo.Name = "Goo"
	Goo.Parent = leaderstats
	local Coins = Instance.new("IntValue")
	Coins.Name = "Coins"
	Coins.Parent = leaderstats
	local Gems = Instance.new("IntValue")
	Gems.Name = "Gems"
	Gems.Parent = leaderstats
	
	--Upgrades
	local Upgrades = Instance.new("Folder")
	Upgrades.Name = "Upgrades"
	Upgrades.Parent = player
	local CashMult = Instance.new("IntValue")
	CashMult.Name = "CashMult"
	CashMult.Parent = Upgrades
	local GooMult = Instance.new("IntValue")
	GooMult.Name = "GooMult"
	GooMult.Parent = Upgrades
	local GemMult = Instance.new("IntValue")
	GemMult.Name = "GemMult"
	GemMult.Parent = Upgrades
	local DropSpeed = Instance.new("IntValue")
	DropSpeed.Name = "DropSpeed"
	DropSpeed.Parent = Upgrades
	local TierUpgrade = Instance.new("IntValue")
	TierUpgrade.Name = "TierUpgrade"
	TierUpgrade.Parent = Upgrades
	

	local success, data = pcall(function()
		return GooDataStore:GetAsync(player.UserId)
	end)
	if success and data then
		Goo.Value = data
	else
		Goo.Value = 0
	end
	local success, data = pcall(function()
		return CoinsDataStore:GetAsync(player.UserId)
	end)
	if success and data then 
		Coins.Value = data
	else
		Coins.Value = 10
	end
	local success, data = pcall(function()
		return GemsDataStore:GetAsync(player.UserId)
	end)
	if success and data then 
		Gems.Value = data
	else
		Gems.Value = 0
	end
	local success, data = pcall(function()
		return ConvtPerSecDataStore:GetAsync(player.UserId)
	end)
	if success and data then 
		ConvtPerSec.Value = data
	else
		ConvtPerSec.Value = 1
	end
	local success, data = pcall(function()
		return ConvertingDataStore:GetAsync(player.UserId)
	end)
	if success and data then 
		Converting.Value = data
	else
		Converting.Value = 0
	end
	local success, data = pcall(function()
		return LastUADataStore:GetAsync(player.UserId)
	end)
	if success and data then 
		LastUA.Value = data
	else
		LastUA.Value = 0
	end
	local success, data = pcall(function()
		return DroppersOwnedDataStore:GetAsync(player.UserId)
	end)
	if success and data then
		DroppersOwned.Value = data
	else
		DroppersOwned.Value = 0
	end
	local success, data = pcall(function()
		return DropperPriceDataStore:GetAsync(player.UserId)
	end)
	if success and data then
		DropperPrice.Value = data
	else
		DropperPrice.Value = 0
	end
	
	--Upgrades
	local success, data = pcall(function()
		return CashMultDataStore:GetAsync(player.UserId)
	end)
	if success and data and data > 0 then
		CashMult.Value = data
	else
		CashMult.Value = 10
	end
	local success, data = pcall(function()
		return GooMultDataStore:GetAsync(player.UserId)
	end)
	if success and data and data > 0 then
		GooMult.Value = data
	else
		GooMult.Value = 10
	end
	local success, data = pcall(function()
		return GemMultDataStore:GetAsync(player.UserId)
	end)
	if success and data and data > 0 then
		GemMult.Value = data
	else
		GemMult.Value = 1
	end
	local success, data = pcall(function()
		return DropSpeedDataStore:GetAsync(player.UserId)
	end)
	if success and data and data > 0 then
		DropSpeed.Value = data
	else
		DropSpeed.Value = 10
	end
	local success, data = pcall(function()
		return TierUpgradeDataStore:GetAsync(player.UserId)
	end)
	if success and data and data > 0 then 
		TierUpgrade.Value = data
	else
		TierUpgrade.Value = 1
	end
	
	
	local plotNum = player:WaitForChild("PlotNumber")
	MergeModule.RebuildPlot(workspace.Map.Plots:FindFirstChild(tostring(plotNum.Value)), DroppersOwned.Value)
	StartupModule.UpdateConvertDiplay(player)
	StartupModule.UpdateConvertUpgradeButtonDiplay(player, LastUA.Value)
end)


Players.PlayerRemoving:Connect(function(player)
	local Converting = player:FindFirstChild("Converting")
	local leaderstats = player:FindFirstChild("leaderstats")
	local Goo = leaderstats:FindFirstChild("Goo")
	if Converting.Value > 0 then
		Goo.Value = Goo.Value + Converting.Value
		Converting.Value = 0
	end
	if leaderstats then
		local Goo = leaderstats:FindFirstChild("Goo")
		if Goo then
			local success, errorMessage = pcall(function()
				GooDataStore:SetAsync(player.UserId, Goo.Value)
			end)
			if not success then
				warn("Failed to save Goo for player " .. player.Name .. ": " .. errorMessage)	
			end
		end
		local Coins = leaderstats:FindFirstChild("Coins")
		if Coins then
			local success, errorMessage = pcall(function()
				CoinsDataStore:SetAsync(player.UserId, Coins.Value)
			end)
			if not success then
				warn("Failed to save Coins for player " .. player.Name .. ": " .. errorMessage)	
			end
		end
		local Gems = leaderstats:FindFirstChild("Gems")
		if Gems then
			local success, errorMessage = pcall(function()
				GemsDataStore:SetAsync(player.UserId, Gems.Value)
			end)
			if not success then
				warn("Failed to save Gems for player " .. player.Name .. ": " .. errorMessage)	
			end
		end
	end
	local DroppersOwned = player:FindFirstChild("DroppersOwned")
	if DroppersOwned then
		local success, errorMessage = pcall(function()
			DroppersOwnedDataStore:SetAsync(player.UserId, DroppersOwned.Value)
		end)
		if not success then
			warn("Failed to save DroppersOwned for player " .. player.Name .. ": " .. errorMessage)	
		end
	end
	local DropperPrice = player:FindFirstChild("DropperPrice")
	if DropperPrice then
		local success, errorMessage = pcall(function()
			DropperPriceDataStore:SetAsync(player.UserId, DropperPrice.Value)
		end)
		if not success then
			warn("Failed to save DropperPrice for player " .. player.Name .. ": " .. errorMessage)	
		end
	end
	local ConvtPerSec = player:FindFirstChild("ConvtPerSec")
	if ConvtPerSec then
		local success, errorMessage = pcall(function()
			ConvtPerSecDataStore:SetAsync(player.UserId, ConvtPerSec.Value)
		end)
		if not success then
			warn("Failed to save ConvtPerSec for player " .. player.Name .. ": " .. errorMessage)	
		end
	end
	local LastUA = player:FindFirstChild("LastUA")
	if LastUA then
		local success, errorMessage = pcall(function()
			LastUADataStore:SetAsync(player.UserId, LastUA.Value)
		end)
		if not success then
			warn("Failed to save ConvtPerSec for player " .. player.Name .. ": " .. errorMessage)	
		end
	end
	local Converting = player:FindFirstChild("Converting")
	if Converting then
		local success, errorMessage = pcall(function()
			ConvertingDataStore:SetAsync(player.UserId, Converting.Value)
		end)
		if not success then
			warn("Failed to save Converting amount for player " .. player.Name .. ": " .. errorMessage)	
		end
	end
	
	
	--Upgrades
	local Upgrades = player:FindFirstChild("Upgrades")
	if Upgrades then 
		local CashMult = Upgrades:FindFirstChild("CashMult")
		if CashMult then 
			local success, errorMessage = pcall (function()
				CashMultDataStore:SetAsync(player.UserId, CashMult.Value)
			end)
			if not success then 
				warn("Failed to save CashMult for player" .. player.Name .. ":" .. errorMessage)
			end
		end
		
		local GooMult = Upgrades:FindFirstChild("GooMult")
		if GooMult then 
			local success, errorMessage = pcall (function()
				GooMultDataStore:SetAsync(player.UserId, GooMult.Value)
			end)
			if not success then 
				warn("Failed to save GooMult for player" .. player.Name .. ":" .. errorMessage)
			end
		end
		
		local GemMult = Upgrades:FindFirstChild("GemMult")
		if GemMult then 
			local success, errorMessage = pcall (function()
				GemMultDataStore:SetAsync(player.UserId, GemMult.Value)
			end)
			if not success then 
				warn("Failed to save GemMult for player" .. player.Name .. ":" .. errorMessage)
			end
		end
		
		local DropSpeed = Upgrades:FindFirstChild("DropSpeed")
		if DropSpeed then 
			local success, errorMessage = pcall (function()
				DropSpeedDataStore:SetAsync(player.UserId, DropSpeed.Value)
			end)
			if not success then 
				warn("Failed to save DropSpeed for player" .. player.Name .. ":" .. errorMessage)
			end
		end
		
		local TierUpgrade = Upgrades:FindFirstChild("TierUpgrade")
		if TierUpgrade then
			local success, errorMessage = pcall(function()
				TierUpgradeDataStore:SetAsync(player.UserId, TierUpgrade.Value)
			end)
			if not success then 
				warn("Failed to save Tier Upgrade for player" .. player.Name .. ":" .. errorMessage)
			end
		end
		
	end
end)