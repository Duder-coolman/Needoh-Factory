local TS = game:GetService("TweenService")
local Currency = script.Parent


for i = 1,6 do
	local button = Currency:WaitForChild(i)
	local buttonSize = button.Size
	local buttonPos = button.Position
	button.MouseEnter:Connect(function()
		local tween = TS:Create(button, TweenInfo.new(.25), {Size = buttonSize + UDim2.new(0.03,0,0.03,0)}) tween:Play()
	end)
	button.MouseLeave:Connect(function()
		local tween = TS:Create(button, TweenInfo.new(.25), {Size = buttonSize, Position = buttonPos}) tween:Play()
	end)
	button.MouseButton1Down:Connect(function()
		local tween = TS:Create(button, TweenInfo.new(.25), {Size = buttonSize + UDim2.new(-0.02,0,-0.02,0)}) tween:Play()
	end)
	button.MouseButton1Up:Connect(function()
		local tween = TS:Create(button, TweenInfo.new(.25), {Size = buttonSize, Position = buttonPos}) tween:Play()
	end)
end