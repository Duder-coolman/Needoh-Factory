local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local PlaytimeRewardEvent = RS:WaitForChild("ClaimedRewardPlaytime")

Players.PlayerAdded:Connect(function(player)
	local jointime = os.time()
	player:SetAttribute("JoinTime", jointime)
end)


local rewardTimers = {
	[1] = 10,
	[2] = 300,
	[3] = 480, 
	[4] = 600, 
	[5] = 900, 
	[6] = 1800
}
local rewards = {--add coins potions and gem potions to reawrds later
	[1] = {MinGems = 5, MaxGems = 10, MinCoins = 1000, MaxCoins = 5000, },
	[2] = {MinGems = 15, MaxGems = 30, MinCoins = 5000, MaxCoins = 10000, },
	[3] = {MinGems = 30, MaxGems = 45, MinCoins = 10000, MaxCoins = 20000, },
	[4] = {MinGems = 45, MaxGems = 60, MinCoins = 20000, MaxCoins = 40000, },
	[5] = {MinGems = 60, MaxGems = 75, MinCoins = 40000, MaxCoins = 80000, },
	[6] = {MinGems = 75, MaxGems = 100, MinCoins = 80000, MaxCoins = 160000, },
}
local rewarddebug = false
PlaytimeRewardEvent.OnServerEvent:Connect(function(player, rewardIndex)
	if rewarddebug then return end
	rewarddebug = true
	if not (type(rewardIndex) == "number") or rewardIndex < 1 or rewardIndex > 6 then return end
	local jointime = player:GetAttribute("JoinTime")
	if not jointime then return end
	local timeplayed = os.time() - jointime
	print(timeplayed, rewardTimers[rewardIndex])
	if timeplayed < rewardTimers[rewardIndex] then print("time") return end
	
	local leaderstats = player:WaitForChild("leaderstats")
	local coins = leaderstats:WaitForChild("Coins")
	local gems = leaderstats:WaitForChild("Gems")
	local playerGui = player:WaitForChild("PlayerGui")
	local playtimeRewards = playerGui:WaitForChild("RightSideGui"):WaitForChild("PlaytimeRewards")
	local button = playtimeRewards:WaitForChild(rewardIndex)
	local item = button:WaitForChild("Item")
	local claimed = button:WaitForChild("ClaimedImage")
	local timer = button:WaitForChild("Timer")
	
	if claimed.Visible then return end
	
	local rewardList = rewards[rewardIndex]
	local coinsReward = math.random(rewardList.MinCoins, rewardList.MaxCoins)
	local gemsReward = math.random(rewardList.MinGems, rewardList.MaxGems)
	coins.Value += coinsReward
	gems.Value += gemsReward
	
	
	timer.Text = "Claimed!"
	claimed.Visible = true
	item.Visible = false
	
	print("reward claimed by:" , player , rewardIndex)
	wait(0.2)
	rewarddebug = false
	
	
end)