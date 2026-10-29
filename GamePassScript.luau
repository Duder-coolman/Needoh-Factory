game.Players.PlayerAdded:Connect(function(player)
	
	local leaderstats = player:WaitForChild("leaderstats")
	local MPS =game:GetService("MarketplaceService")
	local DSS = game:GetService("DataStoreService")
	local DoubleCoinsData = DSS:GetDataStore("DoubleCoins")
	
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
		hasDoubleCoins = MPS:UserOwnsGamePassAsync(player.UserId, 2057693658)
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
		hasTripleCoins = MPS:UserOwnsGamePassAsync(player.UserId, 2057681720)
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
		hasDoubleGoo = MPS:UserOwnsGamePassAsync(player.UserId, 2057303686)
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
		hasAutoCollect = MPS:UserOwnsGamePassAsync(player.UserId, 2057291731)
	end)
	if not success then error(errorMsg) return end
	if hasAutoCollect then AutoCollect.Value = true end
	
end)

local MPS = game:GetService("MarketplaceService")

local DoubleCoinsId = 2057693658
local TripleCoinsId = 2057681720
local DoubleGooId = 2057303686
local AutoCollectId = 2057291731

MPS.PromptGamePassPurchaseFinished:Connect(function(player, gamepassId, waspurchased)
	if not waspurchased then return end
	local g = player:WaitForChild("GamePasses")
	if gamepassId == DoubleCoinsId then
		g:WaitForChild("DoubleCoins").Value = true
	elseif gamepassId == TripleCoinsId then
		g:WaitForChild("TripleCoins").Value = true
	elseif gamepassId == DoubleGooId then
		g:WaitForChild("DoubleGoo").Value = true
	elseif gamepassId == AutoCollectId then
		g:WaitForChild("AutoCollect").Value = true
	else
		print("Gamepass not found")
		return
	end
end)