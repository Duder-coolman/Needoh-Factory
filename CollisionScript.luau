local ps = game:GetService("PhysicsService")
local group = ps:RegisterCollisionGroup("noplayer")
local group = ps:RegisterCollisionGroup("Players")


local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CollisionGroup = "Players"
			end
		end
	end)
end)

ps:CollisionGroupSetCollidable("noplayer", "Players", false)


