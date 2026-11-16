local TweenService = game:GetService("TweenService")
local MainBtn =  script.Parent
local holdframe = MainBtn.Parent
local playtimeBtn = holdframe:WaitForChild("PlaytimeButton")
local dailyRewardBtn = holdframe:WaitForChild("DailyButton")

local isOpen = false

local playtimeOpenPos = playtimeBtn.Position
local playtimeOpenSize = playtimeBtn.Size
local dailyRewardBtnOpenPos = dailyRewardBtn.Position
local dailyRewardBtnOpenSize = dailyRewardBtn.Size

local closedSize = UDim2.new(0,0,0,0)
local closedPos = MainBtn.Position

playtimeBtn.Position = closedPos
playtimeBtn.Size = closedSize
playtimeBtn.Visible = false
playtimeBtn.Active = false

dailyRewardBtn.Position = closedPos
dailyRewardBtn.Size = closedSize
dailyRewardBtn.Visible = false
dailyRewardBtn.Active = false

MainBtn.MouseButton1Click:Connect(function()
	isOpen = not isOpen
	local openTweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local closeTweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
	
	if isOpen then 
		playtimeBtn.Visible = true
		playtimeBtn.Active = true
		dailyRewardBtn.Visible = true
		dailyRewardBtn.Active = true
		
		TweenService:Create(playtimeBtn, openTweenInfo, {Position = playtimeOpenPos, Size = playtimeOpenSize}):Play()
		TweenService:Create(dailyRewardBtn, openTweenInfo, {Position = dailyRewardBtnOpenPos, Size = dailyRewardBtnOpenSize}):Play()
		
	elseif not isOpen then
		TweenService:Create(playtimeBtn, closeTweenInfo, {Position = closedPos, Size = closedSize}):Play()
		TweenService:Create(dailyRewardBtn, closeTweenInfo, {Position = closedPos, Size = closedSize}):Play()
		
		wait(0.5)
		if not isOpen then
			playtimeBtn.Visible = false
			playtimeBtn.Active = false
			dailyRewardBtn.Visible = false
			dailyRewardBtn.Active = false
		end
	end
end)
