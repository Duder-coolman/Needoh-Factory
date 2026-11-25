local ShopGui = script.Parent
local starterGui = ShopGui.Parent
local RShopGui = ShopGui:WaitForChild("RobuxShop")
local GShopGui = ShopGui:WaitForChild("GearShop")
local SettingsGui = starterGui:WaitForChild("Settings"):WaitForChild("SettingsFrame")
local MapFolder = game.Workspace:WaitForChild("Map")
local TeleportLocationsFolder = MapFolder:WaitForChild("Teleports")
local ObbyTeleport = TeleportLocationsFolder:WaitForChild("ObbyTeleportPart")
local ShopTeleport = TeleportLocationsFolder:WaitForChild("ShopTeleportPart")
local TeleportLocationsTab = ShopGui:WaitForChild("TeleportLocation")
local ObbyTeleportButton = TeleportLocationsTab:WaitForChild("Obbys"):WaitForChild("ImageButton")
local ShopTeleportButton = TeleportLocationsTab:WaitForChild("Shops"):WaitForChild("ImageButton")
local openTeleportButton = ShopGui:WaitForChild("HolderFrame"):WaitForChild("OpenTeleportButton")
local closeTeleportButton = TeleportLocationsTab:WaitForChild("ExitButton")
local player = game.Players.LocalPlayer
local lowerTorso = player.Character:WaitForChild("LowerTorso")
local debounce = false
local RightSideGui = starterGui:WaitForChild("RightSideGui")
local P = RightSideGui:WaitForChild("PlaytimeRewards")
local D = RightSideGui:WaitForChild("DailyRewards")

function closeTeleGUI()
	if debounce == true then return end
	debounce = true
	TeleportLocationsTab.Visible = false
	wait(0.3)
	debounce = false
end

function openTeleGUI()
	if debounce == true then return end
	debounce = true
	if RShopGui.Visible or GShopGui.Visible or SettingsGui.Visible or P.Visible or D.Visible then 
		RShopGui.Visible = false
		GShopGui.Visible = false
		SettingsGui.Visible = false
		P.Visible = false
		D.Visible = false
	end
	TeleportLocationsTab.Visible = true
	wait(0.3)
	debounce = false
end

openTeleportButton.MouseButton1Click:Connect (function()
	if TeleportLocationsTab.Visible then
		closeTeleGUI()
		return
	end
	openTeleGUI()
end)



closeTeleportButton.MouseButton1Click:Connect(function()
	closeTeleGUI()
end)

ObbyTeleportButton.MouseButton1Click:Connect(function()
	if debounce == true then return end
	debounce = true
	lowerTorso.CFrame = ObbyTeleport.CFrame
	wait(0.5)
	debounce = false
end)

ShopTeleportButton.MouseButton1Click:Connect(function()
	if debounce == true then return end
	debounce = true
	lowerTorso.CFrame = ShopTeleport.CFrame
	wait(0.5)
	debounce = false
end)