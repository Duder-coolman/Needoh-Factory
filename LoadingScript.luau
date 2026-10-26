local plr = game.Players.LocalPlayer
local pGUI = plr:WaitForChild("PlayerGui")
local LoadingScreen = pGUI:WaitForChild("LoadingScreen")
local Background = LoadingScreen:WaitForChild("Background")
local LoadingBar = Background:WaitForChild("Loading")
local loadingBackground = LoadingBar:WaitForChild("Background")
local loadingFill = LoadingBar:WaitForChild("Fill")
local loadingTxt = LoadingBar:WaitForChild("Loading")
local playBtn = Background:WaitForChild("PlayButton"):WaitForChild("TextButton")
local clickDebounce = false

local loadingList = {"loading", "loading.", "loading..", "loading..."}
local loadingListVal = 1

wait(1)
print("start")

local function GetRidOfLoadingScreen()
	local End = false
	while not End do
		local pos = Background.Position.Y.Scale
		pos += 0.03
		Background.Position = UDim2.new(0,0,pos,0)
		wait(0.0025)
		if pos >= 1 then 
			LoadingScreen:Destroy()
			End =  true
		end
	end
end

while loadingFill.Size.X.Scale < 0.99 do
	local size = loadingFill.Size.X.Scale
	local pos = loadingFill.Position.X.Scale
	size = size + 0.01
	pos = pos - 0.005
	loadingFill.Size = UDim2.new(size,0,1,0)
	loadingFill.Position = UDim2.new(pos,0,0,0)
	
	
	if loadingListVal > 4 then
		loadingListVal = 1
	end
	
	loadingTxt.Text = loadingList[loadingListVal]
	local randomNum = math.random(1,10)
	if randomNum == 1 then
		loadingListVal = loadingListVal + 1
	end
	

		
	wait(0.05)
	playBtn.MouseButton1Click:Connect(function()
		if clickDebounce then return end
		clickDebounce = true
		GetRidOfLoadingScreen()
	end)
	if loadingFill.Size.X.Scale >= 0.99 then
		GetRidOfLoadingScreen()
	end
end

