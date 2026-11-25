local DS = game:GetService("DataStoreService")
local MusicDataStore = DS:GetDataStore("MuiscData")
local SFXDataStore = DS:GetDataStore("SFXData")
local PMDataStore = DS:GetDataStore("PMData")

game.Players.PlayerAdded:Connect(function(player)
	local SettingsFolder = player:WaitForChild("Settings")
	local Music = Instance.new("BoolValue")
	Music.Name = "Music"
	Music.Parent = SettingsFolder
	local SFX = Instance.new("BoolValue")
	SFX.Name = "SFX"
	SFX.Parent = SettingsFolder
	local AutoCollectSetting = SettingsFolder:WaitForChild("AutoCollectEnabled")
	local PM = Instance.new("BoolValue")
	PM.Name = "PM"
	PM.Parent = SettingsFolder
	
	local success, data = pcall(function()
		return MusicDataStore:GetAsync(player.UserId)
	end)
	if success and data then
		Music.Value = data
	else
		Music.Value = true
	end
	local success, data = pcall(function()
		return SFXDataStore:GetAsync(player.UserId)
	end)
	if success and data then
		SFX.Value = data
	else
		SFX.Value = true
	end
	local success, data = pcall(function()
		return PMDataStore:GetAsync(player.UserId)
	end)
	if success and data then
		PM.Value = data
	else
		PM.Value = false
	end
	
	
	
	--Auto Collect Setup
	
	local plotnum = player:WaitForChild("PlotNumber")
	local AutoCollectPart = workspace.Map.Plots:FindFirstChild(tostring(plotnum.Value)):FindFirstChild("AutoCollectPart")
local function UpdateAutoCollectPart()
	if AutoCollectSetting.Value then 
		AutoCollectPart.Transparency = 0
		AutoCollectPart.CanTouch = true
	else
		AutoCollectPart.Transparency = 1
		AutoCollectPart.CanTouch = false
	end
end
	AutoCollectSetting.Changed:Connect(UpdateAutoCollectPart)
	UpdateAutoCollectPart()
	
end)


-- Performance mode
local PMEvent = game.ReplicatedStorage:WaitForChild("PerfromanceMode")
PMEvent.OnServerEvent:Connect(function(player)
	local SettingsFolder = player:WaitForChild("Settings")
	local PM = SettingsFolder:WaitForChild("PM")
	PM.Value = not PM.Value
end)




game.Players.PlayerRemoving:Connect(function(player)
	local SettingsFolder = player:WaitForChild("Settings")
	local Music = SettingsFolder:WaitForChild("Music")
	local SFX = SettingsFolder:WaitForChild("SFX")
	local AutoCollect = SettingsFolder:WaitForChild("AutoCollectEnabled")
	local PM = SettingsFolder:WaitForChild("PM")
	
	if Music then
		local success, errorMsg = pcall(function()
			MusicDataStore:SetAsync(player.UserId, Music.Value)
		end)
		if not success then warn ("Failed to save Music data" .. errorMsg) end
	end
	if SFX then 
		local success, errorMsg = pcall(function()
			SFXDataStore:SetAsync(player.UserId, SFX.Value)
		end)
		if not success then warn("failed to save SFX data" .. errorMsg) end
	end
	if PM then 
		local succes , errorMsg = pcall(function()
			PMDataStore:SetAsync(player.UserId, PM.Value)
		end)
		if not succes then warn("Failed to save Preformance mode data" .. errorMsg) end
	end
end)
