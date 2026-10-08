local MergeModule = require(game.ServerScriptService:WaitForChild("MergeModule"))
local StartupModule = require(game.ServerScriptService:WaitForChild("StartupModule"))
local replicatedStorage = game:GetService("ReplicatedStorage")
local Tier1PreFab = replicatedStorage:WaitForChild("Droppers"):WaitForChild("01")
local debounce = true
local Purchase1Btn = script.Parent:WaitForChild("Purchase1Btn")
local Purchase5Btn = script.Parent:WaitForChild("Purchase5Btn")
local Purchase25Btn = script.Parent:WaitForChild("Purchase25Btn")
local Purchase100Btn = script.Parent:WaitForChild("Purchase100Btn")
local Purchase0Btn = script.Parent:WaitForChild("0Btn")
local Btn1Bill = Purchase1Btn:WaitForChild("Btn1Billboard"):WaitForChild("Btn1Price")
local Btn5Bill = Purchase5Btn:WaitForChild("Btn5Billboard"):WaitForChild("Btn5Price")
local Btn25Bill = Purchase25Btn:WaitForChild("Btn25Billboard"):WaitForChild("Btn25Price")
local Btn100Bill = Purchase100Btn:WaitForChild("Btn100Billboard"):WaitForChild("Btn100Price")

local function SpawnTier1(plotfolder)
	local rowsFolder = plotfolder:FindFirstChild("Rows")
	if not rowsFolder then return end
	
	for r = 1, 10 do 
		local row = rowsFolder:FindFirstChild(string.format("%02d", r))
		if row and row:FindFirstChild("Slots") then
			for s = 1, 10 do 
				local slot = row.Slots:FindFirstChild(string.format("%02d", s))
				
				if slot and #slot:GetChildren() == 0 then
					local newNeedoh = Tier1PreFab:Clone()
					local targetCFrame = slot.CFrame * CFrame.Angles(0, math.rad(180), 0) + Vector3.new(0, 1, -5)

					if newNeedoh:IsA("Model") then
						newNeedoh:PivotTo(targetCFrame)
					else
						newNeedoh.CFrame = targetCFrame
					end

					newNeedoh.Parent = slot
					return true
				end
			end
		end
	end
	return false 
	
end


local BasePrice = 10
local PriceIncrement = 1.5



local function calculatePurchase(amountToBuy, droppersOwned)
	local totalCost = (amountToBuy * BasePrice) + PriceIncrement * (amountToBuy * droppersOwned + (amountToBuy * (amountToBuy - 1)) / 2)
	local newLastPrice = BasePrice + ((droppersOwned + amountToBuy) * PriceIncrement)

	return math.floor(totalCost), math.floor(newLastPrice)
end
local function calculateDisplayedPurchase(amountToBuy, droppersOwned)
	local totalCost = (amountToBuy * BasePrice) + PriceIncrement * (amountToBuy * droppersOwned + (amountToBuy * (amountToBuy - 1)) / 2)
	local newLastPrice = BasePrice + ((droppersOwned + amountToBuy) * PriceIncrement)

	return math.floor(totalCost)
end


local function setupButton(button, amount)
	button.Touched:Connect(function(hit)
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		if player and debounce then
			local Coinstat = player.leaderstats.Coins
			local Goostat = player.leaderstats.Goo
			local PlotNum = player.PlotNumber
			local DroppersOwned = player:WaitForChild("DroppersOwned")
			local LastPrice = player:WaitForChild("DropperPrice")

			local Cost, NewLastPrice = calculatePurchase(amount, DroppersOwned.Value)

			
			if PlotNum.Value == tonumber(button.Parent.Parent.Name) and Coinstat.Value >= Cost then
				debounce = false

				print(player.Name, "bought", amount, "For $" .. StartupModule.formatNumber(Cost))

				Coinstat.Value -= Cost
				Goostat.Value -= 0
				DroppersOwned.Value += amount
				local plotFolder = workspace.Map.Plots:FindFirstChild(tostring(PlotNum.Value))

				if plotFolder then
					if amount >= 100 then
						MergeModule.RebuildPlot(plotFolder, DroppersOwned.Value)
					else
						for i = 1, amount do
							local placed = SpawnTier1(plotFolder)

							if not placed then

								MergeModule.RebuildPlot(plotFolder, DroppersOwned.Value)
								break
							end
						end
					end
				end
				LastPrice.Value = NewLastPrice
				
				button.BrickColor = BrickColor.new("Really red")
				
				--updates buton display
				StartupModule.UpdatePurchaseBtnDisp(PlotNum, DroppersOwned)

				task.wait(0.7)
				button.Color = Color3.fromHex("#68d94e")
				debounce = true
			end
			
			
		end
	end)
end

local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
wait(6)
	local plrplot = player:WaitForChild("PlotNumber")
	local plrDroppers = player:WaitForChild("DroppersOwned")
	if tostring(plrplot.Value) == script.Parent.Parent.Name or plrplot.Value == tonumber(script.Parent.Parent.Name) then
		StartupModule.UpdatePurchaseBtnDisp(plrplot, plrDroppers)
	end
end)


setupButton(Purchase1Btn, 1)
setupButton(Purchase5Btn, 5)
setupButton(Purchase25Btn, 25)
setupButton(Purchase100Btn, 100)
