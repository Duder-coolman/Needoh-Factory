local MergeModule = require(game.ServerScriptService:WaitForChild("MergeModule"))
local mergeBtn = script.Parent
plotFolder = mergeBtn.Parent


mergeBtn.Touched:Connect(function(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	local totalDroppers = player:WaitForChild("DroppersOwned")
	if not player then return
	else
		MergeModule.RebuildPlot(plotFolder, totalDroppers.Value)
	end

end)
