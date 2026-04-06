-- Auto Farm Script

function autoFarm()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()

    while true do
        wait(1) -- delay to prevent lag
        -- Implement your farming logic here
        -- For example, collect resources or complete tasks
    end
end

autoFarm()