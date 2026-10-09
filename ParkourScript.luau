local parkfldr = game.Workspace:WaitForChild("Parkour")
local lobbyfldr = parkfldr:WaitForChild("Lobby")
local mazefldr  = parkfldr:WaitForChild("Maze")
local obbysfldr = parkfldr:WaitForChild("Obbys")
local towersfldr = parkfldr:WaitForChild("Towers")
local mazeteleport = mazefldr:WaitForChild("LobbyTeleport")
local obbyteleport = obbysfldr:WaitForChild("LobbyTeleport")
local towerteleport = towersfldr:WaitForChild("LobbyTeleport")
local mainLandTeleport = game.Workspace:WaitForChild("Map"):WaitForChild("Teleports"):WaitForChild("ObbyTeleportPart")
local Players = game:GetService("Players")



--works the portals to get to parkour lobby and back to main island

local portaldebounce = false
local mazeportaltouch = mazefldr:WaitForChild("MazePortal"):WaitForChild("PortalTouchIndicator")
local obbyportaltouch = obbysfldr:WaitForChild("ObbyPortal"):WaitForChild("PortalTouchIndicator")
local towerportaltouch = towersfldr:WaitForChild("TowerPortal"):WaitForChild("PortalTouchIndicator")
local ReturnPortalTouch = lobbyfldr:WaitForChild("ReturnPortal"):WaitForChild("PortalTouchIndicator")



mazeportaltouch.Touched:Connect(function(hit)
	if portaldebounce == true then return end
	portaldebounce = true
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character or not character:FindFirstChild("Humanoid") then return end
	character:PivotTo(mazeteleport.CFrame * CFrame.new(0,4,0)) 
	wait(1)
	portaldebounce = false
end)

obbyportaltouch.Touched:Connect(function(hit)
	if portaldebounce == true then return end
	portaldebounce = true
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character or not character:FindFirstChild("Humanoid") then return end
	character:PivotTo(obbyteleport.CFrame * CFrame.new(0,4,0)) 
	wait(1)
	portaldebounce = false
end)

towerportaltouch.Touched:Connect(function(hit)
	if portaldebounce == true then return end
	portaldebounce = true
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character or not character:FindFirstChild("Humanoid") then return end
	character:PivotTo(towerteleport.CFrame * CFrame.new(0,4,0)) 
	wait(1) 
	portaldebounce = false
end)

ReturnPortalTouch.Touched:Connect(function(hit)
	if portaldebounce == true then return end
	portaldebounce = true
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character or not character:FindFirstChild("Humanoid") then return end
	character:PivotTo(mainLandTeleport.CFrame * CFrame.new(0,4,0)) 
	wait(1) 
	portaldebounce = false
end)