local Players = game:GetService("Players")
local player = Players.LocalPlayer
local function getMarineButton()
    local playerGui = player:WaitForChild("PlayerGui")
    local preload = playerGui:WaitForChild("Preload")
    local chooseTeam = preload:WaitForChild("ChooseTeam")
    local marineButton = chooseTeam:WaitForChild("MarineButton")
    return marineButton, preload
end
local marineButton, preloadGui = getMarineButton()
repeat
    task.wait(0.1)
    if marineButton and marineButton:IsA("GuiButton") then
        local conns = getconnections and getconnections(marineButton.MouseButton1Click) or {}
        if #conns > 0 then
            for _, conn in ipairs(conns) do
                if conn and typeof(conn.Function) == "function" then
                    conn.Function()
                end
            end
    else
            marineButton.MouseButton1Click:Fire()
        end
    end
until preloadGui.Enabled == false
