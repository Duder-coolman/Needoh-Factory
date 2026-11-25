local player = game.Players.LocalPlayer
local MPS = game:GetService("MarketplaceService")
local leaderstats = player:WaitForChild("leaderstats")
local GamePasses = player:WaitForChild("GamePasses")
local RShop = script.Parent
local scroll = RShop:WaitForChild("Scroll")
local Gamepasses = scroll:WaitForChild("Upgrades")
local DoubleCoinsBtn = Gamepasses:WaitForChild("1"):WaitForChild("1"):WaitForChild("1")
local TripleCoinsBtn = Gamepasses:WaitForChild("2"):WaitForChild("2"):WaitForChild("2")
local DoubleGooBtn = Gamepasses:WaitForChild("3"):WaitForChild("3"):WaitForChild("3")
local AutoCollectBtn = Gamepasses:WaitForChild("4"):WaitForChild("4"):WaitForChild("4")
local VIPBtn = scroll:WaitForChild("VIP"):WaitForChild("Frame"):WaitForChild("Purchase")

local RS = game:GetService("ReplicatedStorage")
local TCS = game:GetService("TextChatService")
local announcementEvent = RS:WaitForChild("GlobalAnnouncement")

announcementEvent.OnClientEvent:Connect(function(message)
	TCS:WaitForChild("TextChannels"):WaitForChild("RBXGeneral"):DisplaySystemMessage(message)
end)

--Gamepasses
--IDS
local DoubleCoins = 2057693658
local TripleCoins = 2057681720
local DoubleGoo = 2057303686
local AutoCollect = 2057291731
local VIP = 2076154389

DoubleCoinsBtn.MouseButton1Click:Connect(function()
	if GamePasses:WaitForChild("DoubleCoins").Value == false then
		MPS:PromptGamePassPurchase(player, DoubleCoins)
	else
		print("Already Owned")
	end
end)

TripleCoinsBtn.MouseButton1Click:Connect(function()
	if GamePasses:WaitForChild("TripleCoins").Value == false then
		MPS:PromptGamePassPurchase(player, TripleCoins)
	else
		print("Already Owned")
	end
end)

DoubleGooBtn.MouseButton1Click:Connect(function()
	if GamePasses:WaitForChild("DoubleGoo").Value == false then
		MPS:PromptGamePassPurchase(player, DoubleGoo)
	else
		print("Already Owned")
	end
end)

AutoCollectBtn.MouseButton1Click:Connect(function()
	if GamePasses:WaitForChild("AutoCollect").Value == false then
		MPS:PromptGamePassPurchase(player, AutoCollect)
	else
		print("Already Owned")
	end
end)

VIPBtn.MouseButton1Click:Connect(function()
	if GamePasses:WaitForChild("VIP").Value == false then 
		MPS:PromptGamePassPurchase(player, VIP)
	else
		print("Already Owned")
	end
end)


--Developer Products For Currency
local currecnyIds = {
	[1] = {
		Name = "OneMCoins",
		Id = 3730882582,
	},
	[2] = {
		Name = "TenMCoins",
		Id = 3730888048
		
	},
	[3] = {
		Name = "HundMCoins",
		Id = 3731020674
	},
	[4] = {
		Name = "100Gems",
		Id = 3731020863
	},
	[5] = {
		Name = "500Gems",
		Id = 3731020973
	},
	[6] = {
		Name = "1kGems",
		Id = 3731021131
	}
}

local currency = scroll:WaitForChild("Currency")
for i = 1,6 do
	local button = currency:WaitForChild(i)
	local Id = currecnyIds[i].Id
	button.MouseButton1Click:Connect(function()
		MPS:PromptProductPurchase(player, Id)
	end)
end

--Developer Products For Donations
local donateIds = {
	[1] = {
		Name = "Donate5",
		Id = 3731124802
	},
	[2] = {
		Name = "Donate15",
		Id = 3731124996
	},
	[3] = {
		Name = "Donate50",
		Id = 3731125176
	},
	[4] = {
		Name = "Donate100",
		Id = 3731125319
	},
	[5] = {
		Name = "Donate1k",
		Id = 3731125501
	}
}
local donate = scroll:WaitForChild("Donate")
for i = 1,5 do
	local frame = donate:WaitForChild("7"):WaitForChild("Purchases")
	local button = frame:WaitForChild(i)
	local Id = donateIds[i].Id
	button.MouseButton1Click:Connect(function()
		MPS:PromptProductPurchase(player, Id)
	end)
end

