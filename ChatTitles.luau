local TCS = game:GetService("TextChatService")
local Players = game:GetService("Players")

TCS.OnIncomingMessage = function(message: TextChatMessage)
	local textSource = message.TextSource
	if textSource then
		local player = Players:GetPlayerByUserId(textSource.UserId)
		--Order of if statements determines title
		if player.UserId == 1470243924 then
			local props = Instance.new("TextChatMessageProperties")
			props.PrefixText = "<font color = 'rgb(255, 93, 142)'>[Owner]</font>" .. message.PrefixText
			return props
		elseif player and player:FindFirstChild("GamePasses"):FindFirstChild("VIP").Value then
			local props = Instance.new("TextChatMessageProperties")
			props.PrefixText = "<font color = 'rgb(255, 176, 0)'>[??VIP]</font> " .. message.PrefixText
			return props
		else
			print("no title")
			local props = Instance.new("TextChatMessageProperties")
			props.PrefixText = ""
			return props
		end
	end
end