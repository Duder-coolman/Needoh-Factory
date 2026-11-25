local collectPart = script.Parent
local NumFormat = require(game.ReplicatedStorage:WaitForChild("NumberFormat"))
local plot = collectPart.Parent
local Players = game:GetService("Players")
local debounce = {}

collectPart.Touched:Connect(function(hit)
	local dropmodel = hit.Parent
	if not dropmodel or dropmodel.Parent ~= plot then return end
	if debounce[dropmodel] == false then return end
	debounce[dropmodel] = false
	

	if not dropmodel:FindFirstChild("GA") then return end
	local plotOwner = nil
	for _, player in pairs(Players:GetPlayers()) do
		local plotNumber = player:FindFirstChild("PlotNumber")
		if plotNumber and plotNumber.Value == tonumber(plot.Name) then
			plotOwner = player
			break
		end
	end
	
	if not plotOwner then return end
	local GamePasses = plotOwner:FindFirstChild("GamePasses")
	local Settings = plotOwner:FindFirstChild("Settings")
	local Upgrades = plotOwner:FindFirstChild("Upgrades")
	local Ugoomult = Upgrades:FindFirstChild("GooMult")
	local Ugemmult = Upgrades:FindFirstChild("GemMult")
	local AutoCollectPass = GamePasses:FindFirstChild("AutoCollect")
	if AutoCollectPass.Value == false then return end
	local AutoCollectEnabled = Settings:FindFirstChild("AutoCollectEnabled")
	if AutoCollectEnabled.Value == false then return end
	
	
	local leaderstats = plotOwner:FindFirstChild("leaderstats")
	if leaderstats then 
		local goo = leaderstats:FindFirstChild("Goo")
		local gems = leaderstats:FindFirstChild("Gems")
		if goo and gems then
			if dropmodel.Name == "GEM" then
				gems.Value = gems.Value + Ugemmult.Value
			else
				local doubleGoo = GamePasses:FindFirstChild("DoubleGoo")
				local Doubler = 1
				if doubleGoo.Value then Doubler = 2 end


				local gooAmount = dropmodel:FindFirstChild("GA")
				local finalGooAmount = ((gooAmount.Value * (Ugoomult.Value/10))*Doubler)

				--Floating Number
				local PM = plotOwner:FindFirstChild("Settings"):FindFirstChild("PM")
				if PM and PM.Value then goo.Value = goo.Value + finalGooAmount 
					dropmodel:Destroy() 
					return end
				local FNG = game.ReplicatedStorage:WaitForChild("FloatingNumberDisplay")
				local FloatingNumberGui = FNG:Clone()
				FloatingNumberGui.Parent = plotOwner:FindFirstChild("PlayerGui")
				FloatingNumberGui.Adornee = dropmodel 
				local FloatingNumber = FloatingNumberGui:WaitForChild("TextLabel")
				FloatingNumber.Text = "+" .. NumFormat.formatNumber(finalGooAmount)
				FloatingNumberGui.Enabled= true
				dropmodel:WaitForChild("Meshes/Needoh"):Destroy()
				dropmodel:WaitForChild("Collect"):Destroy()
				local newDR = dropmodel:WaitForChild("Roll")
				newDR.Anchored = true
				newDR.CanCollide = false


				while FloatingNumber.TextTransparency < 1.1 do
					FloatingNumber.TextTransparency += 0.025
					FloatingNumber:FindFirstChild("UIStroke").Transparency += 0.025
					local Y = FloatingNumber.Parent.StudsOffsetWorldSpace.Y + 0.1
					FloatingNumber.Parent.StudsOffsetWorldSpace = Vector3.new(0,Y,0)
					if FloatingNumber.TextTransparency >= 1 then 
						FloatingNumberGui:Destroy()
					break end

					wait(0.03)
				end
				goo.Value = goo.Value + finalGooAmount
			end
			dropmodel:Destroy()
		end
	end
end)
