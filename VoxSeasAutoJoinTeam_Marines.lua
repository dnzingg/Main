return function()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    local playerGui = player:WaitForChild("PlayerGui")
    local preloadGui = playerGui:WaitForChild("Preload")
    local chooseTeamGui = preloadGui:WaitForChild("ChooseTeam")
    local marineButton = chooseTeamGui:WaitForChild("MarineButton")

    local function clickButton()
        local conns = getconnections(marineButton.MouseButton1Click)
        if #conns > 0 then
            for _, conn in ipairs(conns) do
                conn.Function()
            end
        end
    end

    while preloadGui.Enabled do
        clickButton()
        task.wait(0.1)
    end
end
