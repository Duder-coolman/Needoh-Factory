local RS = game:GetService("RunService")
local eggs = game.Workspace:WaitForChild("Eggs")
local basicEgg = eggs:WaitForChild("BasicEgg"):WaitForChild("Egg")
local farmEgg = eggs:WaitForChild("FarmEgg"):WaitForChild("Egg")
local forestEgg = eggs:WaitForChild("ForestEgg"):WaitForChild("Egg")
local snowEgg = eggs:WaitForChild("SnowEgg"):WaitForChild("Egg")
local egg = script.Parent
local spinSpeed = 24
local basicStart = basicEgg:GetPivot().Position.Y
local farmStart = farmEgg:GetPivot().Position.Y
local forestStart = forestEgg:GetPivot().Position.Y
local snowStart = snowEgg:GetPivot().Position.Y


local BU = true
RS.Heartbeat:Connect(function(dt)
	basicEgg:PivotTo(basicEgg:GetPivot() * CFrame.Angles(0, math.rad(spinSpeed * dt), 0))
	local currentY = basicEgg:GetPivot().Position.Y
	if BU then 
			basicEgg:PivotTo(basicEgg:GetPivot() * CFrame.new(0, 0.01,0))
		if currentY >= basicStart + 0.5 then 
			BU = false
		end
	elseif not BU then
		basicEgg:PivotTo(basicEgg:GetPivot() * CFrame.new(0, -0.01, 0))
		if currentY <= basicStart - 0.5 then
			BU = true
		end
	end		
end)
local FAU = true
RS.Heartbeat:Connect(function(dt)
	farmEgg:PivotTo(farmEgg:GetPivot() * CFrame.Angles(0, math.rad(spinSpeed * dt), 0))
	local currentY = farmEgg:GetPivot().Position.Y
	if FAU then 
		farmEgg:PivotTo(farmEgg:GetPivot() * CFrame.new(0, 0.01,0))
		if currentY >= farmStart + 0.5 then 
			FAU = false
		end
	elseif not FAU then
		farmEgg:PivotTo(farmEgg:GetPivot() * CFrame.new(0, -0.01, 0))
		if currentY <= farmStart - 0.5 then
			FAU = true
		end
	end		
end)
local FOU = true
RS.Heartbeat:Connect(function(dt)
	forestEgg:PivotTo(forestEgg:GetPivot() * CFrame.Angles(0, math.rad(spinSpeed * dt), 0))
	local currentY = forestEgg:GetPivot().Position.Y
	if FOU then 
		forestEgg:PivotTo(forestEgg:GetPivot() * CFrame.new(0, 0.01,0))
		if currentY >= forestStart + 0.5 then 
			FOU = false
		end
	elseif not FOU then
		forestEgg:PivotTo(forestEgg:GetPivot() * CFrame.new(0, -0.01, 0))
		if currentY <= forestStart - 0.5 then
			FOU = true
		end
	end	
end)
local SU = true
RS.Heartbeat:Connect(function(dt)
	snowEgg:PivotTo(snowEgg:GetPivot() * CFrame.Angles(0, math.rad(spinSpeed * dt), 0))
	local currentY = snowEgg:GetPivot().Position.Y
	if SU then 
		snowEgg:PivotTo(snowEgg:GetPivot() * CFrame.new(0, 0.01,0))
		if currentY >= snowStart + 0.5 then 
			SU = false
		end
	elseif not SU then
		snowEgg:PivotTo(snowEgg:GetPivot() * CFrame.new(0, -0.01, 0))
		if currentY <= snowStart - 0.5 then
			SU = true
		end
	end	
end)