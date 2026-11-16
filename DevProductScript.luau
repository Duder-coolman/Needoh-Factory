local MPS = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local MS = game:GetService("MessagingService")

local announcementEvent = RS:WaitForChild("GlobalAnnouncement")
local announcementTopic = "GlobalPurchaseAnnouncement"



local products = {
	--Currencys
	[3730882582] = function(receipt, player)
		--1 Million Cash
		local leaderstats = player:WaitForChild("leaderstats")
		local Coins = leaderstats:WaitForChild("Coins")
		if not Coins then return end
		Coins.Value += 1000000
		return true
	end,
	[3730888048] = function(receipt, player)
		-- 10 Million Cash
		local leaderstats = player:WaitForChild("leaderstats")
		local Coins = leaderstats:WaitForChild("Coins")
		if not Coins then return end
		Coins.Value += 10000000
		return true
	end,
	[3731020674] = function(reciept, player)
		-- 100 Million Cash
		local leaderstats = player:WaitForChild("leaderstats")
		local Coins = leaderstats:WaitForChild("Coins")
		if not Coins then return end
		Coins.Value += 100000000
		return true
	end,
	[3731020863] = function(reciept, player)
		-- 100 Gems
		local leaderstats = player:WaitForChild("leaderstats")
		local Gems = leaderstats:WaitForChild("Gems")
		if not Gems then return end
		Gems.Value += 100
		return true
	end,
	[3731020973] = function(reciept, player)
		-- 500 Gems
		local leaderstats = player:WaitForChild("leaderstats")
		local Gems = leaderstats:WaitForChild("Gems")
		if not Gems then return end
		Gems.Value += 500
		return true
	end,
	[3731021131] = function(reciept, player)
		-- 1K Gems
		local leaderstats = player:WaitForChild("leaderstats")
		local Gems = leaderstats:WaitForChild("Gems")
		if not Gems then return end
		Gems.Value += 1000
		return true
	end,
	
	
	--Donations
	[3731124802] = function(reciept, player) return true end, -- 5
	[3731124996] = function(reciept, player) return true end, -- 15
	[3731125176] = function(reciept, player) return true end, -- 50
	[3731125319] = function(reciept, player) return true end, -- 100
	[3731125501] = function(reciept, player) return true end -- 1000
}

local localDonations = {
	[3731124802] = {
		Message = "5",
		Color = "#3cff00"
	},
	[3731124996] = {
		Message ="15",
		Color = "#3cff00"
	}
}

local globalDonations = {
	[3731125176] = {
		Message = "50",
		Color = "#ffaf3e"
	},
	[3731125319] = {
		Message = "100",
		Color = "#ff3a86"
	},
	[3731125501] = {
		Message = "1000",
		Color = "#3dcbff"
	}
}


MS:SubscribeAsync(announcementTopic, function(message)
	announcementEvent:FireAllClients(message.Data) 
end)



local function processReceipt(receiptInfo)
	local UserId = receiptInfo.PlayerId
	local productId = receiptInfo.ProductId
	local player = Players:GetPlayerByUserId(UserId)
	local player = Players:GetPlayerByUserId(UserId)
	if not player then return Enum.ProductPurchaseDecision.NotProcessedYet end
	local handler = products[productId]
	
	local success, result = pcall(handler, receiptInfo, player)
	if success then
		local LocalDono = localDonations[productId]
		local GlobalDono = globalDonations[productId]
		
		if LocalDono then
			print("LD")
			local textToSend = player.Name .. " has donated <font color=\"".. LocalDono.Color .."\"><b>" .. LocalDono.Message .. "</b></font> Robux!, Thank you for your support!"			
			announcementEvent:FireAllClients(textToSend)
		elseif GlobalDono then
			print("GD")
			local textToSend = "[??Global] " .. player.Name .. " has donated <font color=\"".. GlobalDono.Color .."\"><b>" .. GlobalDono.Message .. "</b></font> Robux!, Thank you for your support!"			
			task.spawn(function()
				MS:PublishAsync(announcementTopic, textToSend)
			end)
		end
		
		return Enum.ProductPurchaseDecision.PurchaseGranted
	else
		warn("Failed" .. tostring(receiptInfo) .. "" .. tostring(result))
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end
end

MPS.ProcessReceipt = processReceipt