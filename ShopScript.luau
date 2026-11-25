local ShopGUI = script.Parent
local starterGUI = ShopGUI.Parent
local SettingGUI = starterGUI:WaitForChild("Settings"):WaitForChild("SettingsFrame")
local TeleportLocationGUI = ShopGUI:WaitForChild("TeleportLocation")
local RShopGUI = ShopGUI:WaitForChild("RobuxShop")
local GShopGUI = ShopGUI:WaitForChild("GearShop")
local MapFolder = game.Workspace:WaitForChild("Map")
local Shops = MapFolder:WaitForChild("shops")
local RobuxShop = Shops:WaitForChild("RobuxShop")
local GearShop = Shops:WaitForChild("GearShop")
local RShopTouchPart = RobuxShop:WaitForChild("TouchPart")
local GShopTouchPart = GearShop:WaitForChild("TouchPart")
local RShopExit = RShopGUI:WaitForChild("ExitButton")
local GShopExit = GShopGUI:WaitForChild("ExitButton")
local RShopOpenBtn = ShopGUI:WaitForChild("HolderFrame"):WaitForChild("OpenRobuxShop")
local GShopOpenBtn = ShopGUI:WaitForChild("HolderFrame"):WaitForChild("OpenGearShop")
local RightSideGui = starterGUI:WaitForChild("RightSideGui")
local P = RightSideGui:WaitForChild("PlaytimeRewards")
local D = RightSideGui:WaitForChild("DailyRewards")
local debounce = false

function openShop(Shop)
	if debounce == true or Shop.Visible == true then return end
	debounce = true
	if RShopGUI.Visible or GShopGUI.Visible or TeleportLocationGUI.Visible or SettingGUI.Visible or P.Visible or D.Visible then 
		RShopGUI.Visible = false
		GShopGUI.Visible = false
		TeleportLocationGUI.Visible = false
		SettingGUI.Visible = false
		P.Visible = false
		D.Visible = false
	end
	Shop.Visible = true
	wait(0.2)
	debounce = false
end

function closeShop(Shop)
	if debounce == true or Shop.Visible == false then return end
	debounce = true
	Shop.Visible = false
	wait(0.1)
	debounce = false
end
-- handelinf Rshop
RShopTouchPart.Touched:Connect(function()
	openShop(RShopGUI)
end)

RShopOpenBtn.MouseButton1Click:Connect(function()
	if RShopGUI.Visible == true then
		closeShop(RShopGUI)
		return
	end
	openShop(RShopGUI)
end)

RShopExit.MouseButton1Click:Connect(function()
	closeShop(RShopGUI)
end)


--handeling Gshop
GShopTouchPart.Touched:Connect(function()
	openShop(GShopGUI)
end)

GShopOpenBtn.MouseButton1Click:Connect(function()
	if GShopGUI.Visible == true then
		closeShop(GShopGUI)
		return
	end
	openShop(GShopGUI)
end)

GShopExit.MouseButton1Click:Connect(function()
	closeShop(GShopGUI)
end)

