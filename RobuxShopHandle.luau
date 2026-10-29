local player = game.Players.LocalPlayer
local MPS = game:GetService("MarketplaceService")
local leaderstats = player:WaitForChild("leaderstats")
local GamePasses = player:WaitForChild("GamePasses")
local RShop = script.Parent
local scroll = RShop:WaitForChild("Scroll")
local Gamepasses = scroll:WaitForChild("Upgrades")
local DoubleCoinsBtn = Gamepasses:WaitForChild("1"):WaitForChild("Purchase1"):WaitForChild("TextButton")
local TripleCoinsBtn = Gamepasses:WaitForChild("2"):WaitForChild("Purchase2"):WaitForChild("TextButton")
local DoubleGooBtn = Gamepasses:WaitForChild("3"):WaitForChild("Purchase3"):WaitForChild("TextButton")
local AutoCollectBtn = Gamepasses:WaitForChild("4"):WaitForChild("Purchase4"):WaitForChild("TextButton")

DoubleCoinsBtn.MouseButton1Click:Connect(function()
	if GamePasses:WaitForChild("DoubleCoins").Value == false then
		MPS:PromptGamePassPurchase(player, 2057693658)
	else
		print("Already Owned")
	end
end)

TripleCoinsBtn.MouseButton1Click:Connect(function()
	if GamePasses:WaitForChild("TripleCoins").Value == false then
		MPS:PromptGamePassPurchase(player, 2057681720)
	else
		print("Already Owned")
	end
end)

DoubleGooBtn.MouseButton1Click:Connect(function()
	if GamePasses:WaitForChild("DoubleGoo").Value == false then
		MPS:PromptGamePassPurchase(player, 2057303686)
	else
		print("Already Owned")
	end
end)

AutoCollectBtn.MouseButton1Click:Connect(function()
	if GamePasses:WaitForChild("AutoCollect").Value == false then
		MPS:PromptGamePassPurchase(player, 2057291731)
	else
		print("Already Owned")
	end
end)