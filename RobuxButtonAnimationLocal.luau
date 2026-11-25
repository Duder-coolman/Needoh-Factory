local TS = game:GetService("TweenService")
local main = script.Parent

for i = 1, 4 do
	local button = main:WaitForChild(i):WaitForChild(i):WaitForChild(i)
	local buttonSize = button.Size
	button.MouseEnter:Connect(function()
		local tween = TS:Create(button, TweenInfo.new(0.2),  {Size = buttonSize + UDim2.new(0.05,0,0.04,0)})	
		tween:Play()
	end)
	button.MouseLeave:Connect(function()
		local tween = TS:Create(button, TweenInfo.new(0.2), {Size = buttonSize})
		tween:Play()
	end)
	button.MouseButton1Down:Connect(function()
		local tween = TS:Create(button, TweenInfo.new(0.2), {Size = buttonSize - UDim2.new(0.05,0,0.04,0)})
		tween:Play()
	end)
	button.MouseButton1Up:Connect(function()
		local tween = TS:Create(button, TweenInfo.new(0.2), {Size = buttonSize})
		tween:Play()
	end)
end

local VIP = main.Parent:WaitForChild("VIP")
local vbutton = VIP:WaitForChild("Frame"):WaitForChild("Purchase")
local vbuttonSize = vbutton.Size

vbutton.MouseEnter:Connect(function()
	local tween = TS:Create(vbutton, TweenInfo.new(0.2),  {Size = vbuttonSize + UDim2.new(0.01,0,0.008,0)})	
	tween:Play()
end)
vbutton.MouseLeave:Connect(function()
	local tween = TS:Create(vbutton, TweenInfo.new(0.2), {Size = vbuttonSize})
	tween:Play()
end)
vbutton.MouseButton1Down:Connect(function()
	local tween = TS:Create(vbutton, TweenInfo.new(0.2), {Size = vbuttonSize - UDim2.new(0.01,0,0.008,0)})
	tween:Play()
end)
vbutton.MouseButton1Up:Connect(function()
	local tween = TS:Create(vbutton, TweenInfo.new(0.2), {Size = vbuttonSize})
	tween:Play()
end)