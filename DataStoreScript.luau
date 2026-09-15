local MergeModule = require(game.ServerScriptService:WaitForChild("MergeModule"))
local StartupModule = require(game.ServerScriptService:WaitForChild("StartupModule"))
local DataStoreService = game:GetService("DataStoreService")
local GooDataStore = DataStoreService:GetDataStore("PlayerGooData")
local CoinsDataStore = DataStoreService:GetDataStore("PlayerCoinsData")
local ConvtPerSecDataStore = DataStoreService:GetDataStore("ConvtPerSecData")
local ConvertingDataStore = DataStoreService:GetDataStore("ConvertingData")
local DroppersOwnedDataStore = DataStoreService:GetDataStore("DroppersOwnedData")
local DropperPriceDataStore = DataStoreService:GetDataStore("DropperPriceData")
local LastUADataStore = DataStoreService:GetDataStore("LastUA")

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
		Coins.Value =data
	else
		Coins.Value = 10
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
end)