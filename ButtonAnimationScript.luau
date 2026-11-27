local TS = game:GetService("TweenService")
local GUIfolder = script.Parent

local function buttonTween(button, TweenTime)
	local buttonSize = button.Size
	button.MouseEnter:Connect(function()
		local tween = TS:Create(button, TweenInfo.new(TweenTime), {Size = buttonSize + UDim2.new(0.05,0,0.05,0)}) tween:Play()
	end)
	button.MouseLeave:Connect(function()
		local tween = TS:Create(button, TweenInfo.new(TweenTime), {Size = buttonSize}) tween:Play()
	end)
	button.MouseButton1Down:Connect(function()
		local tween = TS:Create(button, TweenInfo.new(TweenTime), {Size = buttonSize - UDim2.new(0.05,0,0.05,0)}) tween:Play()
	end)
	button.MouseButton1Up:Connect(function()
		local tween = TS:Create(button, TweenInfo.new(TweenTime), {Size = buttonSize + UDim2.new(0.05,0,0.05,0)}) tween:Play()
	end)
end

for _, bill in pairs(GUIfolder:GetChildren()) do
	if bill:IsA("BillboardGui") then

		local holder = bill:WaitForChild("Holder")
		if not holder then continue end

		local Buttons = holder:WaitForChild("Buttons")
		if not Buttons then continue end

		--purchase buttons
		for _, frame in pairs(Buttons:GetChildren()) do
			if frame:IsA("Frame") then
				local button = frame:WaitForChild("Button")	
				buttonTween(button, 0.1)
			else continue
			end
		end

		--pet Images
		local Images = holder:WaitForChild("PetImages")
		if not Images then continue end
		
		for _, frame in pairs(Images:GetChildren()) do
			if frame:IsA("Frame") then
				local button = frame:WaitForChild("Button")
				buttonTween(button, 0.1)
			else continue
			end
		end
	end
end

