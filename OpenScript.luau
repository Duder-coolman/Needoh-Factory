local RightSideGui = script.Parent
local LeftSideGui = RightSideGui.Parent:WaitForChild("LeftSideGUI")
local holder = RightSideGui:WaitForChild("HolderFrame")
local DailyRewardsButton = holder:WaitForChild("DailyButton")
local PlaytimeRewardsButton = holder:WaitForChild("PlaytimeButton")
local G = LeftSideGui:WaitForChild("GearShop")
local R = LeftSideGui:WaitForChild("RobuxShop")
local T = LeftSideGui:WaitForChild("TeleportLocation")
local S = RightSideGui.Parent:WaitForChild("Settings"):WaitForChild("SettingsFrame")

local PlaytimeRewardsGui = RightSideGui:WaitForChild("PlaytimeRewards")
local DailyRewardsGui = RightSideGui:WaitForChild("DailyRewards")

local PExitBtn = PlaytimeRewardsGui:WaitForChild("ExitBtn")

DailyRewardsButton.MouseButton1Click:Connect(function()
	if G.Visible or R.Visible or T.Visible or S.Visible or PlaytimeRewardsGui.Visible then
		G.Visible = false
		R.Visible = false
		T.Visible = false
		S.Visible = false
		PlaytimeRewardsGui.Visible = false
	end
	DailyRewardsGui.Visible = not DailyRewardsGui.Visible
end)

PlaytimeRewardsButton.MouseButton1Click:Connect(function()
	if G.Visible or R.Visible or T.Visible or S.Visible or DailyRewardsGui.Visible then
		G.Visible = false
		R.Visible = false
		T.Visible = false
		S.Visible = false
		DailyRewardsGui.Visible = false
	end
	PlaytimeRewardsGui.Visible = not PlaytimeRewardsGui.Visible
end)

PExitBtn.MouseButton1Click:Connect(function()
	PlaytimeRewardsGui.Visible = false
end)