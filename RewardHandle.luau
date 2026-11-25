local PFolder = game.Workspace:WaitForChild("Parkour")
local OSFolder = PFolder:WaitForChild("Obbys")

local EasyObby = OSFolder:WaitForChild("Easy")
local OeasyCashRewardBtn = EasyObby:WaitForChild("CashBtn"):WaitForChild("btn")
local OeasyDimRewardBtn = EasyObby:WaitForChild("DimBtn"):WaitForChild("btn")
local OeasyStart = EasyObby:WaitForChild("easyStart"):WaitForChild("location")
local OEDebounce = false

OeasyCashRewardBtn.Touched:Connect(function(hit)
	if OEDebounce == true then return end
	OEDebounce = true
	local chr = hit.Parent
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character or not character:FindFirstChild("Humanoid") then return end
	local player = game.Players:GetPlayerFromCharacter(chr)
	if not player then return end
	local leaderstats = player:WaitForChild("leaderstats")
	local cash = leaderstats:WaitForChild("Coins")
	character:PivotTo(OeasyStart.CFrame * CFrame.new(0,4,0))
	cash.Value = cash.Value + 100
	wait(0.5)
	OEDebounce = false
end)
OeasyDimRewardBtn.Touched:Connect(function(hit)
	if OEDebounce then return end
	OEDebounce = true
	local chr = hit.Parent
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character or not character:FindFirstChild("Humanoid") then return end
	local player = game.Players:GetPlayerFromCharacter(chr)
	if not player then return end
	local leaderstats = player:WaitForChild("leaderstats")
	local gem = leaderstats:WaitForChild("Gems")
	character:PivotTo(OeasyStart.CFrame * CFrame.new(0,4,0))
	gem.Value = gem.Value + 3
	wait(0.5)
	OEDebounce = false
end)

local MediumObby = OSFolder:WaitForChild("Medium")
local OmedCashRewardBtn = MediumObby:WaitForChild("CashBtn"):WaitForChild("btn")
local OmedDimRewardBtn = MediumObby:WaitForChild("DimBtn"):WaitForChild("btn")
local OmedStart = MediumObby:WaitForChild("MediumStart"):WaitForChild("location")
local OMDebounce = false

OmedCashRewardBtn.Touched:Connect(function(hit)
	if OMDebounce then return end
	OMDebounce = true
	local chr = hit.Parent
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character and not character:FindFirstChild("Humainoid") then return end
	local player = game.Players:GetPlayerFromCharacter(chr)
	if not player then return end
	local leaderstats = player:WaitForChild("leaderstats")
	local cash = leaderstats:WaitForChild("Coins")
	character:PivotTo(OmedStart.CFrame * CFrame.new(0,4,0))
	cash.Value = cash.Value + 500
	wait(0.5)
	OMDebounce = false
end)
OmedDimRewardBtn.Touched:Connect(function(hit)
	if OMDebounce then return end
	OMDebounce = true
	local chr = hit.Parent
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character and not character:FindFirstChild("Humainoid") then return end
	local player = game.Players:GetPlayerFromCharacter(chr)
	if not player then return end
	local leaderstats = player:WaitForChild("leaderstats")
	local gem = leaderstats:WaitForChild("Gems")
	character:PivotTo(OmedStart.CFrame * CFrame.new(0,4,0))
	gem.Value = gem.Value + 7
	wait(0.5)
	OMDebounce = false
end)

local HardObby = OSFolder:WaitForChild("Hard")
local OHardCashRewardBtn = HardObby:WaitForChild("CashBtn"):WaitForChild("btn")
local OHardDimRewardBtn = HardObby:WaitForChild("DimBtn"):WaitForChild("btn")
local OHardStart = HardObby:WaitForChild("HardStart"):WaitForChild("location")
local OHDebounce = false

OHardCashRewardBtn.Touched:Connect(function(hit)
	if OHDebounce then return end
	OHDebounce = true
	local chr = hit.Parent
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character and not character:FindFirstChild("Humanoid") then return end
	local player = game.Players:GetPlayerFromCharacter(chr)
	if not player then return end
	local leaderstats = player:WaitForChild("leaderstats")
	local cash = leaderstats:WaitForChild("Coins")
	character:PivotTo(OHardStart.CFrame * CFrame.new(0,4,0))
	cash.Value = cash.Value + 2500
	wait(0.5)
	OHDebounce = false
end)
OHardDimRewardBtn.Touched:Connect(function(hit)
	if OHDebounce then return end
	OHDebounce = true
	local chr = hit.Parent
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character and not character:FindFirstChild("Humanoid") then return end
	local player = game.Players:GetPlayerFromCharacter(chr)
	if not player then return end
	local leaderstats = player:WaitForChild("leaderstats")
	local gem = leaderstats:WaitForChild("Gems")
	character:PivotTo(OHardStart.CFrame * CFrame.new(0,4,0))
	gem.Value = gem.Value + 20
	wait(0.5)
	OHDebounce = false
end)



local MSFolder = PFolder:WaitForChild("Maze")
local Msect1 = MSFolder:WaitForChild("sect1")
local M1CashBtn = Msect1:WaitForChild("CashBtn"):WaitForChild("btn")
local M1DimBtn = Msect1:WaitForChild("DimBtn"):WaitForChild("btn")
local MStart = Msect1:WaitForChild("Start")
local M1Debounce = false

M1CashBtn.Touched:Connect(function(hit)
	if M1Debounce then return end
	M1Debounce = true 
	local chr = hit.Parent
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character and not character:FindFirstChild("Humanaoid") then return end
	local player = game.Players:GetPlayerFromCharacter(chr)
	if not player then return end
	local leaderstats = player:WaitForChild("leaderstats")
	local cash = leaderstats:WaitForChild("Coins")
	character:PivotTo(MStart.CFrame * CFrame.new(0,4,0))
	cash.Value = cash.Value + 250
	wait(0.5)
	M1Debounce = false
end)


M1DimBtn.Touched:Connect(function(hit)
	if M1Debounce then return end
	M1Debounce = true 
	local chr = hit.Parent
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character and not character:FindFirstChild("Humanaoid") then return end
	local player = game.Players:GetPlayerFromCharacter(chr)
	if not player then return end
	local leaderstats = player:WaitForChild("leaderstats")
	local gem = leaderstats:WaitForChild("Gems")
	character:PivotTo(MStart.CFrame * CFrame.new(0,4,0))
	gem.Value = gem.Value + 3
	wait(0.5)
	M1Debounce = false
end)

local Msect2 = MSFolder:WaitForChild("sect2")
local M2CashBtn = Msect2:WaitForChild("CashBtn"):WaitForChild("btn")
local M2DimBtn = Msect2:WaitForChild("DimBtn"):WaitForChild("btn")
local M2Debounce = false

M2CashBtn.Touched:Connect(function(hit)
	if M1Debounce then return end
	M1Debounce = true 
	local chr = hit.Parent
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character and not character:FindFirstChild("Humanaoid") then return end
	local player = game.Players:GetPlayerFromCharacter(chr)
	if not player then return end
	local leaderstats = player:WaitForChild("leaderstats")
	local cash = leaderstats:WaitForChild("Coins")
	character:PivotTo(MStart.CFrame * CFrame.new(0,4,0))
	cash.Value = cash.Value + 750
	wait(0.5)
	M1Debounce = false
end)

M2DimBtn.Touched:Connect(function(hit)
	if M1Debounce then return end
	M1Debounce = true 
	local chr = hit.Parent
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character and not character:FindFirstChild("Humanaoid") then return end
	local player = game.Players:GetPlayerFromCharacter(chr)
	if not player then return end
	local leaderstats = player:WaitForChild("leaderstats")
	local gem = leaderstats:WaitForChild("Gems")
	character:PivotTo(MStart.CFrame * CFrame.new(0,4,0))
	gem.Value = gem.Value + 8
	wait(0.5)
	M1Debounce = false
end)




local TSFolder = PFolder:WaitForChild("Towers")

local ETower = TSFolder:WaitForChild("Easy")
local ETCashBtn = ETower:WaitForChild("CashBtn"):WaitForChild("btn")
local ETDimBtn = ETower:WaitForChild("DimBtn"):WaitForChild("btn")
local ETStart = ETower:WaitForChild("TowerStart"):WaitForChild("Location")
local ETDebounce = false

ETCashBtn.Touched:Connect(function(hit)
	if ETDebounce then return end
	ETDebounce = true
	local chr = hit.Parent
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character and not character:FindFirstChild("Humanoid") then return end
	local player = game.Players:GetPlayerFromCharacter(chr)
	if not player then return end
	local leaderstats = player:WaitForChild("leaderstats")
	local cash = leaderstats:WaitForChild("Coins")
	character:PivotTo(ETStart.CFrame * CFrame.new(0,4,0))
	cash.Value += 250
	wait(0.5)
	ETDebounce = false
end)

ETDimBtn.Touched:Connect(function(hit)
	if ETDebounce then return end
	ETDebounce = true
	local chr = hit.Parent
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character and not character:FindFirstChild("Humanoid") then return end
	local player = game.Players:GetPlayerFromCharacter(chr)
	if not player then return end
	local leaderstats = player:WaitForChild("leaderstats")
	local gem = leaderstats:WaitForChild("Gems")
	character:PivotTo(ETStart.CFrame * CFrame.new(0,4,0))
	gem.Value += 5
	wait(0.5)
	ETDebounce = false
end)

local MTower = TSFolder:WaitForChild("Medium")
local MTCashBtn = MTower:WaitForChild("CashBtn"):WaitForChild("btn")
local MTDimBtn = MTower:WaitForChild("DimBtn"):WaitForChild("btn")
local MTStart = MTower:WaitForChild("TowerStart"):WaitForChild("Location")
local MTDebounce = false

MTCashBtn.Touched:Connect(function(hit)
	if MTDebounce then return end
	MTDebounce = true
	local chr = hit.Parent
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character and not character:FindFirstChild("Humanoid") then return end
	local player = game.Players:GetPlayerFromCharacter(chr)
	if not player then return end
	local leaderstats = player:WaitForChild("leaderstats")
	local cash = leaderstats:WaitForChild("Coins")
	character:PivotTo(MTStart.CFrame * CFrame.new(0,4,0))
	cash.Value += 1250
	wait(0.5)
	MTDebounce = false
end)

MTDimBtn.Touched:Connect(function(hit)
	if MTDebounce then return end
	MTDebounce = true
	local chr = hit.Parent
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character and not character:FindFirstChild("Humanoid") then return end
	local player = game.Players:GetPlayerFromCharacter(chr)
	if not player then return end
	local leaderstats = player:WaitForChild("leaderstats")
	local gem = leaderstats:WaitForChild("Gems")
	character:PivotTo(MTStart.CFrame * CFrame.new(0,4,0))
	gem.Value += 10
	wait(0.5)
	MTDebounce = false
end)

local HTower = TSFolder:WaitForChild("Hard")
local HTCashBtn = HTower:WaitForChild("CashBtn"):WaitForChild("btn")
local HTDimBtn = HTower:WaitForChild("DimBtn"):WaitForChild("btn")
local HTStart = HTower:WaitForChild("TowerStart"):WaitForChild("Location")
local HTDebounce = false

HTCashBtn.Touched:Connect(function(hit)
	if HTDebounce then return end
	HTDebounce = true
	local chr = hit.Parent
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character and not character:FindFirstChild("Humanoid") then return end
	local player = game.Players:GetPlayerFromCharacter(chr)
	if not player then return end
	local leaderstats = player:WaitForChild("leaderstats")
	local cash = leaderstats:WaitForChild("Coins")
	character:PivotTo(HTStart.CFrame * CFrame.new(0,4,0))
	cash.Value += 2500
	wait(0.5)
	HTDebounce = false
end)

HTDimBtn.Touched:Connect(function(hit)
	if HTDebounce then return end
	HTDebounce = true
	local chr = hit.Parent
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character and not character:FindFirstChild("Humanoid") then return end
	local player = game.Players:GetPlayerFromCharacter(chr)
	if not player then return end
	local leaderstats = player:WaitForChild("leaderstats")
	local gem = leaderstats:WaitForChild("Gems")
	character:PivotTo(HTStart.CFrame * CFrame.new(0,4,0))
	gem.Value += 25
	wait(0.5)
	HTDebounce = false
end)
