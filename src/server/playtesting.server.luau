local Playtesting = require(game.ReplicatedStorage.Modules.Playtesting)
game.Players.PlayerAdded:Connect(function(player)
    Playtesting:RequestUserToBeginSession(player.UserId)
end)