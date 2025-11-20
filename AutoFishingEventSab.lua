task.wait(0.3)
pcall(function()
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local plr = Players.LocalPlayer

getgenv().autoEquipFishingRod = getgenv().autoEquipFishingRod or false
getgenv().autoBuyFishingRod = getgenv().autoBuyFishingRod or false
getgenv().fishingRodToBuy = getgenv().fishingRodToBuy or "Starter Rod"

local char
local function updateCharacter(c)
	char = c or plr.Character or plr.CharacterAdded:Wait()
end

if plr.Character then updateCharacter(plr.Character) else plr.CharacterAdded:Wait(); updateCharacter(plr.Character) end
plr.CharacterAdded:Connect(updateCharacter)

local allowed = {
	["Starter Rod"] = true,
	["Frozen Rod"] = true,
	["Fiery Rod"] = true,
	["Radioactive Rod"] = true
}

local function isValidRod(v)
	return typeof(v) == "string" and allowed[v] == true
end

local function buyRod(rod)
local args = {
	tostring(rod)
}
game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RF/RodsShopService/RequestBuy"):InvokeServer(unpack(args))
	local args = {
	tostring(rod)
}
game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RF/RodsShopService/RequestEquip"):InvokeServer(unpack(args))
end

task.spawn(function()
	while task.wait(0.1) do
		if autoEquipFishingRod then
			local tool = plr.Backpack:FindFirstChild("Fishing Rod") or char:FindFirstChild("Fishing Rod")
			if tool and tool.Parent ~= char then tool.Parent = char end
		end
	end
end)

task.spawn(function()
	while task.wait(0.1) do
		if autoBuyFishingRod and isValidRod(fishingRodToBuy) then
			local tool = plr.Backpack:FindFirstChild("Fishing Rod") or char:FindFirstChild("Fishing Rod")
			if not tool:FindFirstChild(tostring(fishingRodToBuy)) then
				buyRod(fishingRodToBuy)
buyRod(fishingRodToBuy)
			end
		end
	end
end)
end)
