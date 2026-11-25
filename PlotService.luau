local MergeModule = require(game.ServerScriptService:WaitForChild("MergeModule"))
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local PlotHolders = Instance.new("Folder")
PlotHolders.Parent = ReplicatedStorage
PlotHolders.Name = "PlotHolders"

Players.PlayerAdded:Connect(function(player)
	
	local PlotNumber = Instance.new("IntValue")
	PlotNumber.Name = "PlotNumber"
	PlotNumber.Parent = player
	for i = 1,8 do 
		if PlotHolders:FindFirstChild(i)then 
			continue
		end
		
		local ClaimPlot = Instance.new("ObjectValue")
		ClaimPlot.Parent = PlotHolders
		ClaimPlot.Name = i
		ClaimPlot.Value = player
		
		PlotNumber.Value = i
		break
	end
	
	if PlotNumber.Value == 0 then
		player:Kick("Server Player Limit Reached")
		print("Kicking Extra Player")
	end
	local PlotFolder = workspace.Map.Plots:FindFirstChild(PlotNumber.Value)
	player.CharacterAdded:Connect(function(character)
		local TeleportPart = PlotFolder.teleport
		character:PivotTo(TeleportPart.CFrame)
		
	end)
	
	local sign = PlotFolder.Sign 
	sign.PlayerDisplay.PlayerNameLabel.Text = player.Name .. "'s Island"
	
	local thumbnailType = Enum.ThumbnailType.HeadShot
	local thumbnailSize = Enum.ThumbnailSize.Size420x420
	local content = Players:GetUserThumbnailAsync(player.UserId, thumbnailType, thumbnailSize)
	sign.PlayerDisplay.PlayerIcon.Image = content
	sign.PlayerDisplay.PlayerIcon.Visible = true
	sign.PlayerDisplay.PlayerNameLabel.Visible = true
end)

Players.PlayerRemoving:Connect(function(player)
	local PlotNum = player.PlotNumber.Value
	local plotFolder = workspace.Map.Plots:FindFirstChild(tostring(PlotNum))
	MergeModule.RebuildPlot(plotFolder, 0)
	local PlotOccupied = PlotHolders:FindFirstChild(PlotNum)
	PlotOccupied:Destroy()
	local playerPlot = workspace.Map.Plots:FindFirstChild(PlotNum)
	playerPlot.Sign.PlayerDisplay.PlayerIcon.Visible = false
	playerPlot.Sign.PlayerDisplay.PlayerNameLabel.Visible = false
end)