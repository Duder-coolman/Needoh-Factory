local TweenService = game:GetService("TweenService")
local PlaytimeRewards = script.Parent
player = game.Players.LocalPlayer
local JoinTime = player:GetAttribute("JoinTime")

--setup buttons
for i = 1,6 do
	local button = PlaytimeRewards:WaitForChild(i)
	local OriginalSize = button.Size
	local OriginalPos = button.Position
	button.MouseEnter:Connect(function()
		local tween = TweenService:Create(button, TweenInfo.new(.35), {Size = OriginalSize + UDim2.new(0.05,0,0.05,0), Position = OriginalPos - UDim2.new(0.025,0,0.025,0)}) tween:Play()
	end)
	button.MouseLeave:Connect(function()
		local tween = TweenService:Create(button, TweenInfo.new(.35), {Size = OriginalSize, Position = OriginalPos}) tween:Play()
	end)
	
	button.MouseButton1Click:Connect(function()
		print("clicked")
		local timePlayed = os.time() - JoinTime
		local value = button:WaitForChild("Value")
		local claimed = button:WaitForChild("ClaimedImage")
		if claimed.Visible then return end
		if value.Value > timePlayed then print("not enough time played")return end
		game.ReplicatedStorage.ClaimedRewardPlaytime:FireServer(i)
	end)
end










-- deals with rewards
local HolderFrame = PlaytimeRewards.Parent:WaitForChild("HolderFrame")
local PlaytimeButton = HolderFrame:WaitForChild("PlaytimeButton")
local isupdating  = false
PlaytimeButton.MouseButton1Click:Connect(function()
	while PlaytimeRewards.Visible and not isupdating do
		isupdating = true
		local Timeplayed = os.time() - JoinTime
		for i = 1,6 do
			local button = PlaytimeRewards:WaitForChild(i)
			local claimed = button:WaitForChild("ClaimedImage")
			if claimed.Visible then continue end
			local timer = button:WaitForChild("Timer")
			local value = button:WaitForChild("Value")
			local minutesRemaining = math.floor((value.Value - Timeplayed) / 60)
			local secondsRemaining  = math.floor((value.Value - Timeplayed) % 60)
			
			if value.Value >= Timeplayed then
				if math.floor(secondsRemaining) < 10 then secondsRemaining = "0" .. math.floor(secondsRemaining) end
				timer.Text = math.floor(minutesRemaining) .. ":" .. secondsRemaining
			else
				if claimed.Visible == false then
					timer.Text = "Claim!"
				else
					timer.Text = "Claimed!"
				end
				
			end
		end
		wait(1)
		isupdating = false
	end 
end)

