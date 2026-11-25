local DoubleCoinsId = 2057693658
local TripleCoinsId = 2057681720
local DoubleGooId = 2057303686
local AutoCollectId = 2057291731
local VIPId = 2076154389

game.Players.PlayerAdded:Connect(function(player)
	
	local MPS =game:GetService("MarketplaceService")
	local DSS = game:GetService("DataStoreService")
	
	local GamePasses = Instance.new("Folder")
	GamePasses.Name = "GamePasses"
	GamePasses.Parent = player
	
	
	--DoubleCoins
	local DoubleCoins = Instance.new("BoolValue")
	DoubleCoins.Name = "DoubleCoins"
	DoubleCoins.Parent = GamePasses
	DoubleCoins.Value = false
	local hasDoubleCoins = false
	local success, errorMsg = pcall(function()
		hasDoubleCoins = MPS:UserOwnsGamePassAsync(player.UserId, DoubleCoinsId)
	end)
	if not success then error(errorMsg) return end 
	if hasDoubleCoins then DoubleCoins.Value = true end
	
	
	--TripleCoins
	local TripleCoins = Instance.new("BoolValue")
	TripleCoins.Name = "TripleCoins"
	TripleCoins.Parent = GamePasses
	TripleCoins.Value = false
	local hasTripleCoins = false
	local success, errorMsg = pcall(function()
		hasTripleCoins = MPS:UserOwnsGamePassAsync(player.UserId, TripleCoinsId)
	end)
	if not success then error(errorMsg) return end
	if hasTripleCoins then TripleCoins.Value = true end
	
	--DoubleGoo
	local DoubleGoo = Instance.new("BoolValue")
	DoubleGoo.Name = "DoubleGoo"
	DoubleGoo.Parent = GamePasses
	DoubleGoo.Value = false
	local hasDoubleGoo = false
	local success, errorMsg = pcall(function()
		hasDoubleGoo = MPS:UserOwnsGamePassAsync(player.UserId, DoubleGooId)
	end)
	if not success then error(errorMsg) return end
	if hasDoubleGoo then DoubleGoo.Value = true end
	
	--AutoCollect
	local AutoCollect = Instance.new("BoolValue")
	AutoCollect.Name = "AutoCollect"
	AutoCollect.Parent = GamePasses
	AutoCollect.Value = false
	local hasAutoCollect = false
	local success, errorMsg = pcall(function()
		hasAutoCollect = MPS:UserOwnsGamePassAsync(player.UserId, AutoCollectId)
	end)
	if not success then error(errorMsg) return end
	if hasAutoCollect then AutoCollect.Value = true end
	
	--VIP
	local VIP = Instance.new("BoolValue")
	VIP.Name = "VIP"
	VIP.Parent = GamePasses
	VIP.Value = false
	local hasVIP = false
	local success, errorMsg =  pcall(function()
		hasVIP = MPS:UserOwnsGamePassAsync(player.UserId, VIPId)
	end)
	if not success then error(errorMsg) return end
	if hasVIP then VIP.Value = true end
	
	
	
	--Settings
	local Settings = Instance.new("Folder")
	Settings.Name = "Settings"
	Settings.Parent = player
	local AutoCollectEnabled = Instance.new("BoolValue")
	AutoCollectEnabled.Name = "AutoCollectEnabled"
	AutoCollectEnabled.Parent = Settings
	if AutoCollect.Value then AutoCollectEnabled.Value = true 
	else AutoCollectEnabled.Value = false end
	
	
end)

local MPS = game:GetService("MarketplaceService")
local RS = game:GetService("ReplicatedStorage")
local ToggleAutoCollectEvent = RS:WaitForChild("ToggleAutoCollect")


--If the player buys a gamepass
MPS.PromptGamePassPurchaseFinished:Connect(function(player, gamepassId, waspurchased)
	if not waspurchased then return end
	local g = player:WaitForChild("GamePasses")
	if gamepassId == DoubleCoinsId then
		g:WaitForChild("DoubleCoins").Value = true
	elseif gamepassId == VIPId then
		g:WaitForChild("VIP").Value = true
	elseif gamepassId == TripleCoinsId then
		g:WaitForChild("TripleCoins").Value = true
	elseif gamepassId == DoubleGooId then
		g:WaitForChild("DoubleGoo").Value = true
	elseif gamepassId == AutoCollectId then
		g:WaitForChild("AutoCollect").Value = true
		player:WaitForChild("Settings"):WaitForChild("AutoCollectEnabled").Value = true
	else
		print("Gamepass not found")
		return
	end
end)


--Turns on and off Auto Collect
ToggleAutoCollectEvent.OnServerEvent:Connect(function(player)
	local Settings = player:WaitForChild("Settings")
	local gamepasses = player:WaitForChild("GamePasses")
	
	if Settings and gamepasses then 
		local autoCollectPass = gamepasses:WaitForChild("AutoCollect")
		local autoCollectEnabled  = Settings:waitForChild("AutoCollectEnabled")
		
		if autoCollectPass and autoCollectPass.Value then
			autoCollectEnabled.Value = not autoCollectEnabled.Value
		end
	end
end)