local MergeModule = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DroppersFolder = ReplicatedStorage:WaitForChild("Droppers")

local plotDebounces = {}

function MergeModule.TierCounts(totalOwned)
	local tierCounts = {}
	local remaining = totalOwned

	for tier = 20 , 1 , -1 do
		local tierValue = 3^ (tier - 1)
		local count = math.floor(remaining / tierValue)

		tierCounts[tier] = count
		remaining = remaining % tierValue

	end

	return tierCounts

end

function MergeModule.RebuildPlot(plotFolder, totalOwned)

	if plotDebounces[plotFolder] then return end
	plotDebounces[plotFolder] = true
	task.delay(1, function()
		plotDebounces[plotFolder] = nil
	end)

	local rowsFolder = plotFolder:WaitForChild("Rows")
	if not rowsFolder then return end

	local tierCounts = MergeModule.TierCounts(totalOwned)
	for r = 1 , 10 do 

		local row = rowsFolder:FindFirstChild(string.format("%02d", r))

		if row and row:FindFirstChild("Slots") then

			for s = 1 , 10 do 

				local slot = row.Slots:FindFirstChild(string.format("%02d", s))

				if slot then
					slot:ClearAllChildren()
				end

			end

		end

	end
	
	local currentTier = 20
	for r = 1, 10 do
		local row = rowsFolder:FindFirstChild(string.format("%02d", r))
		if not row or not row:FindFirstChild("Slots") then continue end

		for s = 1, 10 do
			local slot = row.Slots:FindFirstChild(string.format("%02d", s))
			if not slot then continue end

			while currentTier >= 1 and (tierCounts[currentTier] or 0) <= 0 do
				currentTier = currentTier - 1
			end

			if currentTier < 1 then return end

			local folderName = string.format("%02d", currentTier)
			local prefab = DroppersFolder:FindFirstChild(folderName)

			if prefab then
				local newNeedoh = prefab:Clone()
				if newNeedoh:IsA("Model") then
					newNeedoh:PivotTo(slot.CFrame * CFrame.Angles(0, math.rad(180), 0) + Vector3.new(0, 1, -5))

					if currentTier == 8 then 
						newNeedoh:PivotTo(slot.CFrame * CFrame.Angles(0, math.rad(180), 0) + Vector3.new(0, -8.5, -5))
					end
				else
					newNeedoh.CFrame = slot.CFrame + Vector3.new(0, 2, 0)
				end
				newNeedoh.Parent = slot
			end
			tierCounts[currentTier] = tierCounts[currentTier] - 1
		end
	end
end


return MergeModule