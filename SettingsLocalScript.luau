local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local settingsGui = script.Parent
local starterGui = settingsGui.Parent
local btn = settingsGui:WaitForChild("Btn")
local SettingsFrame = settingsGui:WaitForChild("SettingsFrame")
local ExitBtn = SettingsFrame:WaitForChild("ExitBtn")
local SettingsFolder = player:WaitForChild("Settings")
local MusicSetting = SettingsFolder:WaitForChild("Music")
local SFXSetting = SettingsFolder:WaitForChild("SFX")
local AutoCollectSetting = SettingsFolder:WaitForChild("AutoCollectEnabled")
local PMSetting = SettingsFolder:WaitForChild("PM")

--open/close settings
local LSGUI = starterGui:WaitForChild("LeftSideGUI")
local GSFrame = LSGUI:WaitForChild("GearShop")
local RSFrame = LSGUI:WaitForChild("RobuxShop")
local TSFrame =LSGUI:WaitForChild("TeleportLocation")

btn.MouseButton1Click:Connect(function()
	if SettingsFrame.Visible == false then
		if GSFrame.Visible or RSFrame.Visible or TSFrame.Visible then
			GSFrame.Visible = false
			RSFrame.Visible = false
			TSFrame.Visible = false
		end
		SettingsFrame.Visible = true
	else
		SettingsFrame.Visible = false
	end
end)

ExitBtn.MouseButton1Click:Connect(function()
	SettingsFrame.Visible = false
end)
--Sound
local Music = SettingsFrame:WaitForChild("Music")
local MusicBtn = Music:WaitForChild("on/off")
local MusicLabel = Music:WaitForChild("TextLabel")


local SFX = SettingsFrame:WaitForChild("SFX")
local SFXBtn = SFX:WaitForChild("on/off")
local SFXLabel = SFX:WaitForChild("TextLabel")

-- AutoCollect
local AutoCollect = SettingsFrame:WaitForChild("AutoCollect")
local AutoCollectBtn = AutoCollect:WaitForChild("on/off")



local ToggleAutoCollectEvent = ReplicatedStorage:WaitForChild("ToggleAutoCollect")
AutoCollectBtn.MouseButton1Click:Connect(function()
	print("click")
	if player.GamePasses.AutoCollect.Value then
		ToggleAutoCollectEvent:FireServer()
	else
		game.MarketplaceService:PromptGamePassPurchase(player, 2057291731)
	end	
end)
AutoCollectSetting.Changed:Connect(function()
	if AutoCollectSetting.Value then 
		AutoCollectBtn.Text = "On"
		AutoCollectBtn.BackgroundColor3 = Color3.fromRGB(112, 231, 103)
	elseif AutoCollectSetting.Value == false then 
		AutoCollectBtn.Text = "Off"
		AutoCollectBtn.BackgroundColor3 = Color3.fromRGB(231,100,100)
	end
end)
local AutoCollectGamepass = player:FindFirstChild("GamePasses"):FindFirstChild("AutoCollect")
AutoCollectGamepass.Changed:Connect(function()
	if AutoCollectGamepass.Value then 
		AutoCollectSetting.Value = true
		AutoCollectBtn.Text = "On"
		AutoCollectBtn.BackgroundColor3 = Color3.fromRGB(112, 231, 103)
	elseif AutoCollectGamepass.Value == false then 
		AutoCollectSetting.Value = false
		AutoCollectBtn.Text = "Off"
		AutoCollectBtn.BackgroundColor3 = Color3.fromRGB(231,100,100)
	end
end)



--Preformance
local PM = SettingsFrame:WaitForChild("Preformance")
local PMBtn = PM:WaitForChild("on/off")

local TogglePMEvent = ReplicatedStorage:WaitForChild("PerfromanceMode")

PMBtn.MouseButton1Click:Connect(function()
	TogglePMEvent:FireServer()
	PMSetting.Changed:Connect(function()
		if PMSetting.Value then
			PMBtn.Text = "On"
			PMBtn.BackgroundColor3 = Color3.fromRGB(112, 231, 103)
		elseif PMSetting.Value == false then 
			PMBtn.Text = "Off"
			PMBtn.BackgroundColor3 = Color3.fromRGB(231, 100, 100)
		end
	end)
end)



local function UpdateOnJoin()
	wait(2)
	local AutoCollectValue = AutoCollectSetting.Value
	if not AutoCollectValue then 
		AutoCollectBtn.Text = "Off"
		AutoCollectBtn.BackgroundColor3 = Color3.fromRGB(231,100,100)
	elseif AutoCollectValue then 
		if player.GamePasses.AutoCollect.Value then
			AutoCollectBtn.Text = "On"
			AutoCollectBtn.BackgroundColor3 = Color3.fromRGB(112, 231, 103)
		else
			AutoCollectBtn.Text = "Off"
			AutoCollectBtn.BackgroundColor3 = Color3.fromRGB(231,100,100)
		end
	end

	local PMValue = PMSetting.Value
	if PMValue then
		PMBtn.Text = "On"
		PMBtn.BackgroundColor3 = Color3.fromRGB(112, 231, 103)
		print("on)")
	elseif PMValue == false then
		PMBtn.Text = "Off"
		PMBtn.BackgroundColor3 = Color3.fromRGB(231, 100 ,100)
		print("off")
	end
end
UpdateOnJoin()