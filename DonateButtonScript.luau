local TS = game:GetService("TweenService")
local Donate = script.Parent
local Frame = Donate:WaitForChild("Purchases")

for i = 1,5 do
	local button = Frame:WaitForChild(i)
	local buttonSize = button.Size
	local buttonPos = button.Position
	button.MouseEnter:Connect(function()
		local tween = TS:Create(button, TweenInfo.new(.15), {Size = buttonSize + UDim2.new(0.06,0,0.03,0)})
		tween:Play()
	end)
	button.MouseLeave:Connect(function()
		local tween = TS:Create(button, TweenInfo.new(0.15), {Size = buttonSize, Position = buttonPos}) tween:Play()
	end)
	button.MouseButton1Down:Connect(function()
		local tween = TS:Create(button, TweenInfo.new(0.15), {Size = buttonSize - UDim2.new(0.03,0,0.015,0)})
		tween:Play()
	end)
	button.MouseButton1Up:Connect(function()
		local tween = TS:Create(button,TweenInfo.new(0.15), {Size = buttonSize, Position = buttonPos}) tween:Play()
	end)
end