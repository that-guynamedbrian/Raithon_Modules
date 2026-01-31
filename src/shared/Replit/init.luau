local RunService = game:GetService("RunService")
local IsClient = RunService:IsClient()
if IsClient == true then script:WaitForChild("Objects") end
local Objects = require("@self/Objects")
local module = IsClient == true and require(script:WaitForChild("ClientListener")) or require("@self/ServerListener")

export type Replit = {
    Check:() -> (boolean, string?)
}

export type Status = Objects.Status

return module::Replit