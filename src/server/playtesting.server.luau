local Playtesting = require(game.ReplicatedStorage.Modules.Playtesting)
game.Players.PlayerAdded:Connect(function(player)
    local success, data = Playtesting:RequestUserToBeginSession(player.UserId)
    if not success then print(data) end
end)

game.Players.PlayerRemoving:Connect(function(player)
    local success, data = Playtesting:EndUserSession(player.UserId)
    if not success then print(data) end
end)