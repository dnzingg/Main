local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local TS = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local char, hum, hrp
local function updateCharacter(c)
    char = c or plr.Character or plr.CharacterAdded:Wait()
    hum = char:WaitForChild("Humanoid")
    hrp = char:WaitForChild("HumanoidRootPart")
end

if plr.Character then updateCharacter(plr.Character) else plr.CharacterAdded:Wait(); updateCharacter(plr.Character) end
plr.CharacterAdded:Connect(updateCharacter)

getgenv().defaultWalkSpeed = 12
getgenv().defaultJumpPower = 50

getgenv().SendNotification = function(title, content, duration, image)
if Rayfield then
        Rayfield:Notify({
    Title = title or "GG hub",
	Content = content or "",
	Duration = duration or 3,
	Image = image or 5107182098,
})
end
end

local gameInfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
local gameName = gameInfo.Name
local Window = Rayfield:CreateWindow({
    Name = "GG hub - " .. gameName,
    Icon = 16570037140,
    LoadingTitle = "Loading...",
    LoadingSubtitle = "by DNzinGG",
    ShowText = "GG hub",
    Theme = "Amethyst",
    ToggleUIKeybind = "K",
    DisableRayfieldPrompts = true,
   DisableBuildWarnings = true,
    ConfigurationSaving = { Enabled = true, FolderName = "GG_hub", FileName = "GG hub - Eat The World" }
})

local Main = Window:CreateTab("Main", 124620632231839)
local Teleports = Window:CreateTab("Teleports", 6723742952)
local Others = Window:CreateTab("Others", 12122755689)

local SliderWalkSpeed = Others:CreateSlider({
	Name = "Change WalkSpeed",
	Range = {1, 1000},
	Increment = 1,
	CurrentValue = defaultWalkSpeed,
	Callback = function(v)
		getgenv().currentWalkSpeed = v
	end,
})

local InputWalkSpeed = Others:CreateInput({
	Name = "Input WalkSpeed",
	CurrentValue = tostring(defaultWalkSpeed),
	PlaceholderText = tostring(defaultWalkSpeed),
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		local num = tonumber(Text)
		if num then
			if num <= 1000 then
				getgenv().currentWalkSpeed = num
			else
				SendNotification("GG hub", "The maximum value is 1000!", 2)
			end
		else
			SendNotification("GG hub", "Invalid WalkSpeed value, use numbers!", 2)
		end
	end,
})

task.spawn(function()
	while task.wait(0.05) do
		if hum then
			pcall(function()
				hum.WalkSpeed = tonumber(getgenv().currentWalkSpeed) or defaultWalkSpeed
			end)
		end
	end
end)

local SliderJumpPower = Others:CreateSlider({
	Name = "Change JumpPower",
	Range = {1, 1000},
	Increment = 1,
	CurrentValue = defaultJumpPower,
	Callback = function(Value)
		if hum then
			hum.UseJumpPower = true
			hum.JumpPower = Value
		end
	end,
})

local InputJumpPower = Others:CreateInput({
	Name = "Input JumpPower",
	CurrentValue = tostring(defaultJumpPower),
	PlaceholderText = tostring(defaultJumpPower),
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		local num = tonumber(Text)
		if num then
			if num <= 1000 then
				getgenv().currentJumpPower = num
				if hum then hum.JumpPower = num end
			else
				SendNotification("GG hub", "The maximum value is 1000!", 2)
			end
		else
			SendNotification("GG hub", "Invalid JumpPower value, use numbers!", 2)
		end
	end,
})

Others:CreateButton({ Name = "Reset WalkSpeed", Callback = function() if hum then hum.WalkSpeed = defaultWalkSpeed SliderWalkSpeed:Set(defaultWalkSpeed) InputWalkSpeed:Set(tostring(defaultWalkSpeed)) end end })
Others:CreateButton({ Name = "Reset JumpPower", Callback = function() if hum then hum.JumpPower = defaultJumpPower SliderJumpPower:Set(defaultJumpPower) InputJumpPower:Set(tostring(defaultJumpPower)) end end })

local jumpConnection
Others:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Flag = "Infinite Jump",
    Callback = function(Value)
        if jumpConnection then jumpConnection:Disconnect() end
        if Value then
            jumpConnection = UserInputService.JumpRequest:Connect(function()
                local h = plr.Character and plr.Character:FindFirstChild("Humanoid")
                if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
            end)
        end
    end,
})

Others:CreateButton({ Name = "Fly Gui", Callback = function() pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))() end) end })

local ToggleNoClip = Others:CreateToggle({
	Name = "No Clip",
	CurrentValue = false,
	Flag = "No Clip",
	Callback = function(Value)
		getgenv().noClip = Value
		task.spawn(function()
			while noClip do task.wait(0.001)
				if char then
					for _, v in pairs(char:GetChildren()) do
						if (v:IsA("MeshPart") or v:IsA("Part")) then
							v.CanCollide = not noClip
						end
					end
				end
			end
		end)
	end,
})

local ButtonAntiLag = Others:CreateButton({ Name = "Anti Lag", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/LegiteriumZ/RobloxScript/main/binh%20hub%20fps%20booster%20v1.lua"))() end,})
local ButtonDestroyGui = Others:CreateButton({
	Name = "Destroy Gui",
	Callback = function()
	Rayfield:Destroy()
	end,
})

local ToggleAutoGrab = Main:CreateToggle({
	Name = "Auto Grab",
	CurrentValue = false,
	Flag = "Auto Grab",
	Callback = function(Value)
	getgenv().autoGrab = Value
	
	while autoGrab do task.wait(.8)
		if char:FindFirstChild("CurrentChunk") and char.CurrentChunk.Value == nil then
	local args = {
	false,
	false,
	false
}
game:GetService("Players").LocalPlayer.Character:WaitForChild("Events"):WaitForChild("Grab"):FireServer(unpack(args))
task.wait(3)
hrp.CFrame = hrp.CFrame + Vector3.new(math.random(-3, 3), 0, math.random(-3, 3))
end
end
end,	
})

local ToggleAutoEat = Main:CreateToggle({
	Name = "Auto Eat",
	CurrentValue = false,
	Flag = "Auto Eat",
	Callback = function(Value)
		getgenv().autoEat = Value
		
		while autoEat do task.wait(.0001)
			game:GetService("Players").LocalPlayer.Character:WaitForChild("Events"):WaitForChild("Eat"):FireServer()
		end
end,
})

local ToggleAutoThrow = Main:CreateToggle({
	Name = "Auto Throw",
	CurrentValue = false,
	Flag = "Auto Throw",
	Callback = function(Value)
		getgenv().autoThrow = Value
		
		while autoThrow do task.wait(.2)
			game:GetService("Players").LocalPlayer.Character:WaitForChild("Events"):WaitForChild("Throw"):FireServer()
		end
	
end,
})

local ToggleAutoSell = Main:CreateToggle({
	Name = "Auto Sell",
	CurrentValue = false,
	Flag = "Auto Sell",
	Callback = function(Value)
		getgenv().autoSell = Value
		
		while autoSell do task.wait(.1)
			if char:FindFirstChild("Size") and plr.PlayerGui.ScreenGui.Sell.SellText.Visible then
			game:GetService("Players").LocalPlayer.Character:WaitForChild("Events"):WaitForChild("Sell"):FireServer()
			end
end
end,
})

local ButtonGetAllGamepasses = Main:CreateButton({
	Name = "Get All Gamepasses",
	Callback = function(Value)
		SendNotification(nil, "Está função pode não funcionar!", 2.5)
		for _,v in pairs(plr.Gamepasses:GetChildren()) do
			if v:IsA("BoolValue") and v.Value == false then
				v.Value = true
			end
		end
end,
})

local ToggleAutoCollectCandyAndCubes = Main:CreateToggle({
	Name = "Auto Collect Candy And Cubes",
	CurrentValue = false,
	Flag = "Auto Collect Candy And Cubes",
	Callback = function(Value)
	getgenv().autoCollect = Value
		
	while autoCollect do task.wait(.0001)
		for _,v in pairs(Workspace:GetChildren()) do
			if v.Name == "Candy" or v.Name == "Cube" then
					local oldPos = hrp.CFrame
					local part = v:FindFirstChildOfClass("Part") or v:FindFirstChild("MeshPart") or v
					hrp.CFrame = part.CFrame
					task.wait(.2)
					hrp.CFrame = oldPos
			end
		end
	end
end,
})

Rayfield:LoadConfiguration()
