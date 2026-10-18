respawnBrick = script.Parent
location = respawnBrick.Parent:WaitForChild("location")
local debounce = false


respawnBrick.Touched:connect(function(hit)
	if debounce then return end
	debounce = true
	local character = hit:FindFirstAncestorOfClass("Model")
	if not character or not character:FindFirstChild("Humanoid") then return else
		character:PivotTo(location.CFrame * CFrame.new(0,4,0))
	end
	task.wait(0.1)
	debounce = false
end)