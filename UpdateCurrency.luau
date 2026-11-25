local NumberFormat = require(game.ReplicatedStorage:WaitForChild("NumberFormat"))
local plr = game.Players.LocalPlayer
local plrGUI = plr:WaitForChild("PlayerGui")
local CurrencyDisp = plrGUI:WaitForChild("CurrencyTracker"):WaitForChild("HolderFrame")





local CoinDisp = CurrencyDisp:WaitForChild("Coin")
local CoinAmtDisp = CoinDisp:WaitForChild("Amount")
local CoinAmt = plr.leaderstats:WaitForChild("Coins")
CoinAmt.Changed:connect(function()
	CoinAmtDisp.Text = (NumberFormat.formatNumber(CoinAmt.Value))
end)

local GooDisp = CurrencyDisp:WaitForChild("Goo")
local GooAmtDisp = GooDisp:WaitForChild("Amount")
local GooAmt = plr.leaderstats:WaitForChild("Goo")
GooAmt.Changed:connect(function()
	GooAmtDisp.Text = (NumberFormat.formatNumber(GooAmt.Value))
end)

local GemDisp = CurrencyDisp:WaitForChild("Gem")
local GemAmtDisp = GemDisp:WaitForChild("Amount")
local GemAmt = plr.leaderstats:WaitForChild("Gems")
GemAmt.Changed:connect(function()
	GemAmtDisp.Text = (NumberFormat.formatNumber(GemAmt.Value))
end)

GooAmtDisp.Text = (NumberFormat.formatNumber(GooAmt.Value))
CoinAmtDisp.Text = (NumberFormat.formatNumber(CoinAmt.Value))
GemAmtDisp.Text = (NumberFormat.formatNumber(GemAmt.Value))