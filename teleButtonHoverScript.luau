local startSize = script.Parent.Size
local hoverSize = UDim2.new(startSize.X.Scale + 0.01, startSize.X.Offset + 1, startSize.Y.Scale + 0.01, startSize.Y.Offset + 1)
local tweenService = game:GetService("TweenService")
local teleButton = script.Parent
local label = teleButton:WaitForChild("TeleLabel")
local MI = false
function HappyLabel(mi)
	if mi == true then
		label.Rotation = math.random(-25,10)
	end
end

teleButton.MouseEnter:Connect(function()
	MI = true
	
	local tween = tweenService:Create(teleButton, TweenInfo.new(.35), {Size = hoverSize})
	tween:Play()
	while MI do
		HappyLabel(MI)
		wait(0.2)
	end	
end)

teleButton.MouseLeave:Connect(function()
	MI = false
	local tween = tweenService:Create(teleButton, TweenInfo.new(.35), {Size = startSize})
	tween:Play()
end)	
