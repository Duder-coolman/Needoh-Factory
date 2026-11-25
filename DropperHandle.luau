local plot = script.Parent
local NumFormat = require(game.ReplicatedStorage:WaitForChild("NumberFormat"))
local rowsFolder = plot:WaitForChild("Rows")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")

local droppersFolder = ReplicatedStorage:WaitForChild("Droppers")
local dropsFolder = droppersFolder:WaitForChild("Drops")
local MaxDrops = 150

local baseWaitTime = 3



while true do 
	
	local plotOwner = nil
	for _, player in ipairs(Players:GetPlayers()) do
		local playerPlot = player:WaitForChild("PlotNumber",2)
		if playerPlot and tostring(playerPlot.Value) == plot.Name then
			plotOwner = player
			break
		end
	end
	
	if not plotOwner then wait(1) continue end

	local DropSpeed = plotOwner:WaitForChild("Upgrades"):WaitForChild("DropSpeed")
	local VIPDropSpeed = plotOwner:WaitForChild("GamePasses"):WaitForChild("VIP")
	local GPDropSpeed = 1
	if VIPDropSpeed.Value then 
		GPDropSpeed = 1.5
	end
	if not DropSpeed then wait(1) continue end
	local waitTime = (baseWaitTime / (DropSpeed.Value / 10)) / GPDropSpeed
	if waitTime < 0.5 then waitTime = 0.5 end
	print(waitTime)
	wait(waitTime)

	local currentDropsCount = 0
	local dropsfolder = plot:WaitForChild("Drops")
	if not dropsfolder then continue end
	for _, item in ipairs(dropsfolder:GetChildren()) do 
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

								local dropTemplateName = string.format("%02d", tierNumber)
								if math.random(1,300) <= tierNumber then dropTemplateName = "GEM" end
								local dropTemplate = dropsFolder:FindFirstChild(dropTemplateName)

								if not dropTemplate then continue end
								

								local dropModel = dropTemplate:Clone()
								Debris:AddItem(dropModel, 180)

								for _, part in ipairs(dropModel:GetDescendants()) do
									if part:IsA("BasePart") then
										part.Anchored = false
										part.CollisionGroup = "noplayer"
										if part.Name == "Collect" then
											part.CanCollide = false
											part.Transparency = 1
											part.CollisionGroup = "noplayer"
										elseif part.Name == "Roll" then
											part.CanCollide = true
											part.CollisionGroup = "noplayer"
										end
									end
								end
								dropModel:PivotTo(slot.CFrame * CFrame.new (0,0,7))
								dropModel.Parent = plot:FindFirstChild("Drops")
								
								local collectPart = dropModel:FindFirstChild("Collect") or dropModel:FindFirstChild("Roll")
								if collectPart then
									local connection
									local debounce = {}
									connection = collectPart.Touched:Connect(function(hit)
										local character = hit.Parent
										local player = Players:GetPlayerFromCharacter(character)
										
										if player then
											
											local Upgrades = player:FindFirstChild("Upgrades")
											if not Upgrades then return end
											local Ugoomult = Upgrades:FindFirstChild("GooMult")
											local Ugemmult = Upgrades:FindFirstChild("GemMult")
											if not Ugoomult and not Ugemmult then return end
									
											
											
											local playerPlot = player:FindFirstChild("PlotNumber")

											if playerPlot and tostring(playerPlot.Value) == tostring(myPlotName) then
												if debounce[dropModel] then return end
												debounce[dropModel] = true
												local leaderstats = player:FindFirstChild("leaderstats")
												local GamePasses = player:FindFirstChild("GamePasses")
												if leaderstats then 
													local goo = leaderstats:FindFirstChild("Goo")
													local gems = leaderstats:FindFirstChild("Gems")
													if goo and gems then
														if dropModel.Name == "GEM" then
															local VIPGemMult = GamePasses:WaitForChild("VIP")
															local GGemMult = 1
															if VIPGemMult.Value then
																GGemMult = 2
															end
															gems.Value = gems.Value + (Ugemmult.Value * GGemMult)
														else
															local doubleGoo = GamePasses:WaitForChild("DoubleGoo")

															local Doubler = 1

															if doubleGoo.Value == true then Doubler = 2 end
															
															local gooAmount = dropModel:FindFirstChild("GA")
															if not gooAmount then return end
															local finalGooAmount = ((gooAmount.Value * (Ugoomult.Value/10))*Doubler)
															
															--Floating Number
															local PM = player:FindFirstChild("Settings"):FindFirstChild("PM")
															if PM and PM.Value then goo.Value = goo.Value + finalGooAmount 
																connection:Disconnect()
																dropModel:Destroy() 
															return end
															local FNG = ReplicatedStorage:WaitForChild("FloatingNumberDisplay")
															local FloatingNumberGui = FNG:Clone()
															FloatingNumberGui.Parent = player:FindFirstChild("PlayerGui")
															FloatingNumberGui.Adornee = dropModel 
															local FloatingNumber = FloatingNumberGui:WaitForChild("TextLabel")
															FloatingNumber.Text = "+" .. NumFormat.formatNumber(finalGooAmount)
															FloatingNumberGui.Enabled= true
															dropModel:WaitForChild("Meshes/Needoh"):Destroy()
															dropModel:WaitForChild("Collect"):Destroy()
															local newDR = dropModel:WaitForChild("Roll")
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