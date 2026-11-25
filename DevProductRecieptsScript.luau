local MPS = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local MS = game:GetService("MessagingService")

local announcementEvent = RS:WaitForChild("GlobalAnnouncement")
local announcementTopic = "GlobalPurchaseAnnouncement"



local Currencyproducts = {
	--Currencys
	[3730882582] = function(receipt, player)
		--1 Million Cash
		local leaderstats = player:FindFirstChild("leaderstats")
		local Coins = leaderstats:FindFirstChild("Coins")
		if not Coins then return false end
		Coins.Value += 1000000
		return true
	end,
	[3730888048] = function(receipt, player)
		-- 10 Million Cash
		local leaderstats = player:FindFirstChild("leaderstats")
		local Coins = leaderstats:FindFirstChild("Coins")
		if not Coins then return false end
		Coins.Value += 10000000
		return true
	end,
	[3731020674] = function(reciept, player)
		-- 100 Million Cash
		local leaderstats = player:FindFirstChild("leaderstats")
		local Coins = leaderstats:FindFirstChild("Coins")
		if not Coins then return false end
		Coins.Value += 100000000
		return true
	end,
	[3731020863] = function(reciept, player)
		-- 100 Gems
		local leaderstats = player:FindFirstChild("leaderstats")
		local Gems = leaderstats:FindFirstChild("Gems")
		if not Gems then return false end
		Gems.Value += 100
		return true
	end,
	[3731020973] = function(reciept, player)
		-- 500 Gems
		local leaderstats = player:FindFirstChild("leaderstats")
		local Gems = leaderstats:FindFirstChild("Gems")
		if not Gems then return false end
		Gems.Value += 500
		return true
	end,
	[3731021131] = function(reciept, player)
		-- 1K Gems
		local leaderstats = player:FindFirstChild("leaderstats")
		local Gems = leaderstats:FindFirstChild("Gems")
		if not Gems then return false end
		Gems.Value += 1000
		return true
	end,
	
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

local Upgrades = {
	[3732993121] = function(reciept, player)
		local CashMult = player:FindFirstChild("Upgrades"):FindFirstChild("CashMult")
		if not CashMult then return false end
		if CashMult.Value >= 20 then return false end
		CashMult.Value += 1
		print("uprgrade 1 successful")
		return true
	end,
	[3732993151] = function(receipt, player)
		local GooMult = player:FindFirstChild("Upgrades"):FindFirstChild("GooMult")
		if not GooMult then return false end
		if GooMult.Value >= 20 then return false end
		GooMult.Value += 1
		print("uprgrade 2 successful")
		return true
	end,
	[3732993203] = function(receipt, player)
		local GemMult = player:FindFirstChild("Upgrades"):FindFirstChild("GemMult")
		if not GemMult then return false end
		if GemMult.Value >= 32 then return false end
		GemMult.Value  = GemMult.Value * 2
		print("upgrade 3 successful")
		return true
	end,
	[3732993234] = function(receipt, player)
		local DropSpeed = player:FindFirstChild("Upgrades"):FindFirstChild("DropSpeed")
		if not DropSpeed then return false end
		if DropSpeed.Value >= 20 then return false end
		DropSpeed.Value += 2 
		print("upgrade 4 successful")
		return true

	end,
	[3733510052] = function(receipt, player)
		local TierUpgrade = player:FindFirstChild("Upgrades"):FindFirstChild("TierUpgrade")
		if not TierUpgrade then return false end
		if TierUpgrade.Value >= 5 then return false end
		TierUpgrade.Value += 1
		print("Upgrdae 5 successful")
		return true
	end,
}





MS:SubscribeAsync(announcementTopic, function(message)
	announcementEvent:FireAllClients(message.Data) 
end)



local function processReceipt(receiptInfo)
	local UserId = receiptInfo.PlayerId
	local productId = receiptInfo.ProductId
	local player = Players:GetPlayerByUserId(UserId)
	if not player then return Enum.ProductPurchaseDecision.NotProcessedYet end
	
	local Currencyhandler = Currencyproducts[productId]
	if Currencyhandler then 
		local success, result = pcall(Currencyhandler, receiptInfo, player)
		if success then
			return Enum.ProductPurchaseDecision.PurchaseGranted
		else
			warn("Currency Purchase Failed" .. tostring(receiptInfo) .. "" .. tostring(result))
			return Enum.ProductPurchaseDecision.NotProcessedYet
		end
	end
	
	local LocalDono = localDonations[productId]
	local GlobalDono = globalDonations[productId]
	if LocalDono then
		print("LD")
		local textToSend = player.Name .. " has donated <font color=\"".. LocalDono.Color .."\"><b>" .. LocalDono.Message .. "</b></font> Robux!, Thank you for your support!"			
		announcementEvent:FireAllClients(textToSend)
		return Enum.ProductPurchaseDecision.PurchaseGranted
	elseif GlobalDono then
		print("GD")
		local textToSend = "[??Global] " .. player.Name .. " has donated <font color=\"".. GlobalDono.Color .."\"><b>" .. GlobalDono.Message .. "</b></font> Robux!, Thank you for your support!"			
		task.spawn(function()
			MS:PublishAsync(announcementTopic, textToSend)
		end)
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end
	
	local UpgradeHandler = Upgrades[productId]
	if UpgradeHandler then
		local succes, result = pcall(UpgradeHandler, receiptInfo, player)
		if succes then 
			return Enum.ProductPurchaseDecision.PurchaseGranted
		else
			warn("Upgrade Purchase Failed" , tostring(receiptInfo), tostring(result))
			return Enum.ProductPurchaseDecision.NotProcessedYet
		end
		
	end

end

MPS.ProcessReceipt = processReceipt