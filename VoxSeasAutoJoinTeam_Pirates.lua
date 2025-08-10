return function()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    local playerGui = player:WaitForChild("PlayerGui")
    local preloadGui = playerGui:WaitForChild("Preload")
    local chooseTeamGui = preloadGui:WaitForChild("ChooseTeam")
    local pirateButton = chooseTeamGui:WaitForChild("PirateButton")

    local function clickButton()
        local conns = getconnections(pirateButton.MouseButton1Click)
        if #conns > 0 then
            for _, conn in ipairs(conns) do
                conn.Function()
            end
        else
            warn("Nenhuma conexão encontrada no PirateButton")
        end
    end

    while preloadGui.Enabled do
        clickButton()
        task.wait(0.1)
    end
end
