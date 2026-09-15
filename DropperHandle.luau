local plot = script.Parent
local rowsFolder = plot:WaitForChild("Rows")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local droppersFolder = ReplicatedStorage:WaitForChild("Droppers")
local dropsFolder = droppersFolder:WaitForChild("Drops")
local MaxDrops = 150

while true do 
	task.wait(3)

	local currentDropsCount = 0
	for _, item in ipairs(plot:GetChildren()) do 
		if item:IsA("Model") and item:FindFirstChild("Collect") then
			currentDropsCount = currentDropsCount + 1
		end
	end

	if currentDropsCount < MaxDrops then	
		for r = 1, 10 do 
			local rowName = string.format("%02d", r)
			local row = rowsFolder:FindFirstChild(rowName)

			if row and row:FindFirstChild("Slots") then
				local slotFolder = row.Slots

				for s = 1, 10 do
					local slotName = string.format("%02d", s)
					local slot = slotFolder:FindFirstChild(slotName)

					if slot then 
						for _, child in ipairs(slot:GetChildren()) do
							if child:IsA("Model") then 
								local numericString = child.Name:match("%d+")
								local tierNumber = numericString and tonumber(numericString)

								if not tierNumber then continue end

								local ownerTag = child:FindFirstChild("PlotOwner")
								local myPlotName = ownerTag and ownerTag.Value or plot.Name

								local gooValue = tierNumber * 1
								local dropTemplateName = string.format("%02d", tierNumber)
								local dropTemplate = dropsFolder:FindFirstChild(dropTemplateName)

								if not dropTemplate then continue end

								local dropModel = dropTemplate:Clone()

								for _, part in ipairs(dropModel:GetDescendants()) do
									if part:IsA("BasePart") then
										part.Anchored = false
										if part.Name == "Collect" then
											part.CanCollide = false
											part.Transparency = 1
										elseif part.Name == "Roll" then
											part.CanCollide = true
										end
									end
								end
								dropModel:PivotTo(slot.CFrame - Vector3.new(0, 0, -8))
								dropModel.Parent = plot


								local collectPart = dropModel:FindFirstChild("Collect") or dropModel:FindFirstChild("Roll")
								if collectPart then
									local connection
									connection = collectPart.Touched:Connect(function(hit)
										local character = hit.Parent
										local player = Players:GetPlayerFromCharacter(character)

										if player then
											local playerPlot = player:FindFirstChild("PlotNumber")

											if playerPlot and tostring(playerPlot.Value) == tostring(myPlotName) then
												local leaderstats = player:FindFirstChild("leaderstats")
												if leaderstats then 
													local goo = leaderstats:FindFirstChild("Goo")
													if goo then
														local gooAmount = dropModel:WaitForChild("GA")
														goo.Value = goo.Value + gooAmount.Value
														connection:Disconnect()
														dropModel:Destroy()
													end
												end
											end
										end
									end)
								end
							end
						end
					end
				end
			end
		end
	end
end