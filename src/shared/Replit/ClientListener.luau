
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Signals = require(script.Parent.Signals)

export type Config = {
    InstanceID:string;

}

local player = Players.LocalPlayer
local playerGui = player:FindFirstChildOfClass("PlayerGui")
local UI_Folder:Folder = playerGui:WaitForChild("REPLIT_REPLICATION", 500)

local ReplitFolder = Instance.new("Folder")
ReplitFolder.Name = "ReplitFolder"
ReplitFolder.Parent = ReplicatedStorage

local remote:RemoteEvent = script.Parent:WaitForChild("ReplitRemote")

local weak = {
    __mode = "kv"
}

local module = {}::{
    CustomSignals: {[string]:Signals.Signaler<any>};
    RealSignals: {[string]:RBXScriptSignal};
    Instances: {[string]:Instance}
}
module.CustomSignals = {}
module.RealSignals = setmetatable({}, weak)
module.Instances = setmetatable({}, weak)
module.Configs = {}

function module.Track(instance:Instance)
    local config = module.Configs[instance]
    if config == nil then return end
    local newsignal = Signals()
    module.CustomSignals[config.InstanceID] = newsignal
    return newsignal
end

local function onChildAdded(child:Instance)
    local config:Config
    do 
        local instance = child:WaitForChild("REPLIT_CONFIG_OBJECT")
        config = instance and instance:GetAttributes()
        if not config then return end
    end

    local replit = child:Clone()
    replit.Parent = ReplitFolder
    
    remote:FireServer( "ReplitReceived" , {
        ID = config.InstanceID
    })
    
    module.Configs[config.InstanceID] = config
    module.Instances[config.InstanceID] =  Instance
end

local handlers = {
    ReplicateChanges = function(options)
        local props = options.ChangedProperties
        local id = options.InstanceID
        local instance = module.Instances[id]
        if not instance then return end
        for prop_name, prop_value in props do
            instance[prop_name] = prop_value
        end
        module.CustomSignals[id]:Fire()
    end
}

local function onClientEvent(topic:string, options)
    local callback = handlers[topic]
    if callback then
        callback(options) 
    end
end

do  -- setup stuff
    UI_Folder.ChildAdded:Connect(onChildAdded)
    remote.OnClientEvent:Connect(onClientEvent)
end


return module