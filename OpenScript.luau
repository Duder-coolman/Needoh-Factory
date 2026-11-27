local RightSideGui = script.Parent
local LeftSideGui = RightSideGui.Parent:WaitForChild("LeftSideGUI")
local holder = RightSideGui:WaitForChild("HolderFrame")
local DailyRewardsButton = holder:WaitForChild("DailyButton")
local PlaytimeRewardsButton = holder:WaitForChild("PlaytimeButton")
local InventoryButton = holder:WaitForChild("Inventory")
local G = LeftSideGui:WaitForChild("GearShop")
local R = LeftSideGui:WaitForChild("RobuxShop")
local T = LeftSideGui:WaitForChild("TeleportLocation")
local S = RightSideGui.Parent:WaitForChild("Settings"):WaitForChild("SettingsFrame")

local PlaytimeRewardsGui = RightSideGui:WaitForChild("PlaytimeRewards")
local DailyRewardsGui = RightSideGui:WaitForChild("DailyRewards")
local InventoryGui = RightSideGui:WaitForChild("Inventory")


local PExitBtn = PlaytimeRewardsGui:WaitForChild("ExitBtn")

DailyRewardsButton.MouseButton1Click:Connect(function()
	if G.Visible or R.Visible or T.Visible or S.Visible or PlaytimeRewardsGui.Visible or InventoryGui.Visible then
		G.Visible = false
		R.Visible = false
		T.Visible = false
		S.Visible = false
		PlaytimeRewardsGui.Visible = false
		InventoryGui.Visible = false
	end
	DailyRewardsGui.Visible = not DailyRewardsGui.Visible
end)

PlaytimeRewardsButton.MouseButton1Click:Connect(function()
	if G.Visible or R.Visible or T.Visible or S.Visible or DailyRewardsGui.Visible or InventoryGui.Visible then
		G.Visible = false
		R.Visible = false
		T.Visible = false
		S.Visible = false
		DailyRewardsGui.Visible = false
		InventoryGui.Visible = false
	end
	PlaytimeRewardsGui.Visible = not PlaytimeRewardsGui.Visible
end)

InventoryButton.MouseButton1Click:Connect(function()
	if G.Visible or R.Visible or T.Visible or S.Visible or DailyRewardsGui.Visible or InventoryGui.Visible then
		G.Visible = false
		R.Visible = false
		T.Visible = false
		S.Visible = false
		DailyRewardsGui.Visible = false
		PlaytimeRewardsGui.Visible = false

	end
	InventoryGui.Visible = not InventoryGui.Visible
end)



PExitBtn.MouseButton1Click:Connect(function()
	PlaytimeRewardsGui.Visible = false
end)