return function()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    -- Espera o PlayerGui e os elementos aparecerem
    local playerGui = player:WaitForChild("PlayerGui")
    local preloadGui = playerGui:WaitForChild("Preload")
    local chooseTeamGui = preloadGui:WaitForChild("ChooseTeam")
    local marineButton = chooseTeamGui:WaitForChild("MarineButton")

    -- Função para "clicar" no botão programaticamente
    local function clickButton()
        local conns = getconnections(marineButton.MouseButton1Click)
        if #conns > 0 then
            for _, conn in ipairs(conns) do
                conn.Function()
            end
        else
            warn("Nenhuma conexão encontrada no MarineButton")
        end
    end

    -- Loop para clicar enquanto Preload estiver visível
    while preloadGui.Enabled do
        clickButton()
        task.wait(0.1)
    end
end
