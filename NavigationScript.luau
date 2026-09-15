local NavigationGUI = script.Parent
local starterGui = NavigationGUI.Parent
local ShopGui = starterGui:WaitForChild("ShopGUI")
local RShopGui = ShopGui:WaitForChild("RobuxShop")
local GShopGui = ShopGui:WaitForChild("GearShop")
local MapFolder = game.Workspace:WaitForChild("Map")
local TeleportLocationsFolder = MapFolder:WaitForChild("Teleports")
local ObbyTeleport = TeleportLocationsFolder:WaitForChild("ObbyTeleportPart")
local ShopTeleport = TeleportLocationsFolder:WaitForChild("ShopTeleportPart")
local TeleportLocationsTab = NavigationGUI:WaitForChild("TeleportLocation")
local ObbyTeleportButton = TeleportLocationsTab:WaitForChild("Obbys"):WaitForChild("ImageButton")
local ShopTeleportButton = TeleportLocationsTab:WaitForChild("Shops"):WaitForChild("ImageButton")
local openTeleportButton = NavigationGUI:WaitForChild("OpenTeleportButton")
local closeTeleportButton = TeleportLocationsTab:WaitForChild("ExitButton")
local player = game.Players.LocalPlayer
local lowerTorso = player.Character:WaitForChild("LowerTorso")
local debounce = false

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
	if RShopGui.Visible == true or GShopGui.Visible == true then 
		RShopGui.Visible = false
		GShopGui.Visible = false
	end
	TeleportLocationsTab.Visible = true
	wait(0.3)
	debounce = false
end

openTeleportButton.MouseButton1Click:Connect (function()
	if TeleportLocationsTab.Visible == true then
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