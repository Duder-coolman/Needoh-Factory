local ShopGUI = script.Parent
local StarterGUI = ShopGUI.Parent
local navGUI = StarterGUI:WaitForChild("Navigation")
local TeleportLocationGUI = navGUI:WaitForChild("TeleportLocation")
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
local RShopOpenBtn = ShopGUI:WaitForChild("OpenRobuxShop")
local GShopOpenBtn = ShopGUI:WaitForChild("OpenGearShop")
local debounce = false

function openShop(Shop)
	if debounce == true or Shop.Visible == true then return end
	debounce = true
	if RShopGUI.Visible == true or GShopGUI.Visible == true or TeleportLocationGUI.Visible == true then 
		RShopGUI.Visible = false
		GShopGUI.Visible = false
		TeleportLocationGUI.Visible = false
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

