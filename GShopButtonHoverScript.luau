local startSize = script.Parent.Size
local hoverSize = UDim2.new(startSize.X.Scale + 0.03, startSize.X.Offset, startSize.Y.Scale + 0.01, startSize.Y.Offset)
local tweenService = game:GetService("TweenService")
local GShopButton = script.Parent
local label = GShopButton:WaitForChild("GShopLabel")
local MI = false
function HappyLabel(mi)
	if mi == true then
		label.Rotation = math.random(-25,-14)
	end
end

GShopButton.MouseEnter:Connect(function()
	MI = true
	
	local tween = tweenService:Create(GShopButton, TweenInfo.new(.25), {Size = hoverSize})
	tween:Play()
	while MI do
		HappyLabel(MI)
		wait(0.2)
	end	
end)

GShopButton.MouseLeave:Connect(function()
	MI = false
	local tween = tweenService:Create(GShopButton, TweenInfo.new(.25), {Size = startSize})
	tween:Play()
end)	

GShopButton.MouseButton1Down:Connect(function()
	local tween = tweenService:Create(GShopButton, TweenInfo.new(0.2), {Size = startSize - UDim2.new(0.03,0,0.01,0)})
	tween:Play()
end)
GShopButton.MouseButton1Up:Connect(function()
	local tween = tweenService:Create(GShopButton, TweenInfo.new(0.2), {Size = startSize})
	tween:Play()
end)