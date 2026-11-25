local HomeBtn = script.Parent
local player = game.Players.LocalPlayer
local debounce = false
local lowerTorso = player.Character:WaitForChild("LowerTorso")
local PlotFolder = workspace.Map.Plots:FindFirstChild(player.PlotNumber.Value)
local TeleportPart = PlotFolder:WaitForChild("teleport")

HomeBtn.MouseButton1Click:Connect(function(player)
	if not debounce then 
		debounce = true
		lowerTorso.CFrame = TeleportPart.CFrame
		wait(0.5)
		debounce = false
	end
end)