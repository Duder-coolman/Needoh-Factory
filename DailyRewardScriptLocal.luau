local TweenService = game:GetService("TweenService")
local DailyRewards = script.Parent
player = game.Players.LocalPlayer

local exitBtn = DailyRewards:WaitForChild("ExitButton")
exitBtn.MouseButton1Click:Connect(function()
	DailyRewards.Visible = false
end)

for i = 1,7 do
	local button = DailyRewards:WaitForChild(i)
	local OriginalSize = button.Size
	local OriginalPos = button.Position
	button.MouseEnter:Connect(function()
		local tween = TweenService:Create(button, TweenInfo.new(.25), {Size = OriginalSize + UDim2.new(0.03,0,0.03,0), Position = OriginalPos - UDim2.new(0.015,0,0.015,0)})
		tween:Play()
	end)
	button.MouseLeave:Connect(function()
		local tween = TweenService:Create(button, TweenInfo.new(.25), {Size = OriginalSize, Position = OriginalPos})
		tween:Play()
	end)
	button.MouseButton1Click:Connect(function()
		print("clicked")
		--game.ReplicatedStorage.ClaimedRewardDaily:FireServer(i)
		
		
	end)
end