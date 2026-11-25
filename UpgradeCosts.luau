local UpgradeCosts = {
	
	CashMult = {
		prices = {0,10,15,25,30,45,60,80,100,125,150},
		multipliers = {10,11, 12, 13, 14, 15, 16, 17, 18, 19, 20},
		max = 10
	},
	GooMult = {
		prices = {0,10,15,20,30,40,50,65,80,100,120},
		multipliers = {10,11, 12, 13, 14, 15, 16, 17, 18, 19, 20},
		max = 10
	},
	GemMult = {
		prices = {0,50, 150, 350, 750, 1500},
		multipliers = {1,2, 4, 8, 16, 32},
		max = 5
	},
	DropSpeed = {
		prices = {0,25, 60, 120, 200, 300},
		multipliers = {10,12, 14, 16 , 18, 20},
		max = 5
	},
	TierUpgrade = {
		prices = {0, 1000, 2500, 5000, 8500},
		multipliers = {1,2,3,4,5},
		max = 4
	},
}
		
return UpgradeCosts
