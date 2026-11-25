local startSize = script.Parent.Size
local hoverSize = UDim2.new(startSize.X.Scale + 0.03, startSize.X.Offset, startSize.Y.Scale + 0.01, startSize.Y.Offset)
local tweenService = game:GetService("TweenService")
local RShopButton = script.Parent
local label = RShopButton:WaitForChild("RShopLabel")
local MI = false
function HappyLabel(mi)
	if mi == true then
		label.Rotation = math.random(-25,-14)
	end
end

RShopButton.MouseEnter:Connect(function()
	MI = true
	
	local tween = tweenService:Create(RShopButton, TweenInfo.new(.25), {Size = hoverSize})
	tween:Play()
	while MI do
		HappyLabel(MI)
		wait(0.2)
	end	
end)

RShopButton.MouseLeave:Connect(function()
	MI = false
	local tween = tweenService:Create(RShopButton, TweenInfo.new(.25), {Size = startSize})
	tween:Play()
end)	
RShopButton.MouseButton1Down:Connect(function()
	local tween = tweenService:Create(RShopButton, TweenInfo.new(.2), {Size = startSize - UDim2.new(0.03,0,0.01,0)})
	tween:Play()
end)
RShopButton.MouseButton1Click:Connect(function()
	local tween = tweenService:Create(RShopButton, TweenInfo.new(.2), {Size = startSize})
	tween:Play()
end)