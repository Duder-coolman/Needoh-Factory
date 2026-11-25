local TS = game:GetService("TweenService")
local main = script.Parent


function buttonTween(button, TweenTime, XScale, XOffset, YScale, YOffset)
	local buttonSize = button.Size
	button.MouseEnter:Connect(function()
		local tween = TS:Create(button, TweenInfo.new(TweenTime), {Size = buttonSize + UDim2.new(XScale, XOffset, YScale, YOffset)} ) tween:Play()

	end)
	button.MouseLeave:Connect(function()
		local tween = TS:Create(button, TweenInfo.new(TweenTime), {Size = buttonSize} ) tween:Play()

	end)
	button.MouseButton1Down:Connect(function()
		local tween = TS:Create(button, TweenInfo.new(TweenTime), {Size = buttonSize - UDim2.new(XScale, XOffset, YScale, YOffset)} ) tween:Play()
	end)
	button.MouseButton1Up:Connect(function()
		local tween = TS:Create(button, TweenInfo.new(TweenTime), {Size = buttonSize} ) tween:Play()
	end)
end



for i = 1, 5 do
	local frame = main:WaitForChild(i)
	local Gbutton = frame:WaitForChild("GemPurchase" .. i)
	local Rbutton = frame:WaitForChild("RobuxPurchase" .. i)
	
	buttonTween(Gbutton, 0.2, 0.02,0,0.03,0)
	buttonTween(Rbutton, 0.2, 0.02,0,0.03,0)
end

