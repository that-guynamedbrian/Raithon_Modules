
export type Config = {
    ID:string;

}

local function onChildAdded(child:Instance)
    local config = child:FindFirstChildOfClass("Configuration")
    config = config and config:GetAttributes()::Config

end

onChildAdded(Instance.new("Part"))

return {
    CustomSignals = {};
    RealSignals = {};
}