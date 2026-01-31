local module = {}
module.CustomSignals = {}
module.RealSignals = {}
module.Pending = {} :: {[string]:Instance}

local remote = Instance.new("RemoteEvent")
remote.Name = "ReplitRemote"
remote.Parent = script.Parent

local handlers = {
    ReplicaReceived = function(options)

    end
}

local function remoteFired(player:Player, topic:string, options)
    local callback = typeof(topic) == "string" and handlers[topic]
    if callback then
        callback(options)
    end
end

do
    remote.OnServerEvent:Connect(remoteFired)
end

return module