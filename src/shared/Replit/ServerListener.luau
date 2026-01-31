local module = {}
local Players = game:GetService("Players")
local ReplicationCache:{[Player]:any} = {}
---------------------------------------------------------------------------- VARS

---------------------------------------------------------------------------- EVENTS
Players.PlayerAdded:Connect(function(targetPlayer)
    local PlayerFolder = targetPlayer.PlayerGui:FindFirstChild("REPLIT_REPLICATION")
    if not PlayerFolder then
        PlayerFolder = Instance.new("Folder")
        PlayerFolder.Name = "REPLIT_REPLICATION"
        PlayerFolder.Parent = targetPlayer.PlayerGui
    end
    ReplicationCache[targetPlayer] = {
        Folder = PlayerFolder
    }
end)

return module