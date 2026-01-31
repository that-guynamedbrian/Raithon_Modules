local RunService = game:GetService("RunService")
local IsClient = RunService:IsClient() 

<<<<<<< HEAD
local module = IsClient == true and require(script:WaitForChild("ClientListener")) or require("@self/ServerListener")
=======
type TrackedAspects = {
    CustomSignals:{[string]:Signals.Signaler<any>};
    RealSignals:{[string]:RBXScriptConnection};
}
>>>>>>> 28be8e83d2dd7a93f35e2b4f82df97a7dc998f7e

export type Replit = {
    -- Server Methods
    Check: () -> (boolean, string?);
    ReplicateTo: (players:{Player}, isntance:Instance) -> {[string]:ReplitInstance}; -- returns a dict mapping config id to status object

    -- Client Methods
    
}

<<<<<<< HEAD
export type ReplitInstance = {
    State:{}
}

return module::Replit
=======
return module::Replit
>>>>>>> 28be8e83d2dd7a93f35e2b4f82df97a7dc998f7e
