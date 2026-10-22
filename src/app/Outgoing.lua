local Scope = require("../ui/util/Scope")
local Values = require("./Values")
local Catalog = require("./Catalog")
local m = {}
m.__index = m
function m.new(manager, recorder, paused)
    return setmetatable({ manager = manager, recorder = recorder, paused = paused, watches = {}, count = 0, version = 0 }, m)
end
function m:Sync()
    if self.entry and self.manager.entries[self.entry.target] ~= self.entry then
        for _, watch in self.watches do watch:Destroy() end
        table.clear(self.watches)
        self.entry, self.count = nil, 0
        self.version += 1
    end
end
function m:Available(backend)
    local compat = self.manager.compat
    return self.manager:Available(backend) and compat:Has("getrawmetatable")
        and compat:Has("getnamecallmethod") and compat:Has("setnamecallmethod")
end
function m:Watch(instance, backend)
    assert(Catalog.isRemote(instance) and instance:IsDescendantOf(game), "Select a remote in the DataModel")
    self:Sync()
    assert(not self.entry or self.entry.active, "Retry stopping the outgoing hook before watching again")
    assert(self:Available(backend), "Outgoing capture requires backend APIs and getrawmetatable/getnamecallmethod/setnamecallmethod")
    assert(not self.entry or self.entry.backend == backend, "Stop outgoing watches before switching backend")
    if self.watches[instance] then return end
    assert(self.count < 32, "32 outgoing-watch limit reached")
    if not self.entry then
        local ok, mt = self.manager.compat:Call("getrawmetatable", game)
        assert(ok and type(mt) == "table", "DataModel metatable unavailable")
        local target = rawget(mt, "__namecall")
        assert(type(target) == "function", "DataModel __namecall unavailable")
        self.entry = self.manager:Add(target, "Outgoing remote __namecall", backend, {
            recorder = self.recorder, paused = self.paused,
            match = function(remote) return self.watches[remote] ~= nil end,
            context = self.manager.compat.functions.getnamecallmethod,
            restoreContext = self.manager.compat.functions.setnamecallmethod,
            select = function(method, remote, ...)
                if not self.watches[remote] then return nil end
                if (remote.ClassName == "RemoteFunction" and method ~= "InvokeServer")
                    or (remote.ClassName ~= "RemoteFunction" and method ~= "FireServer") then return nil end
                return function() return Values.path(remote) end, "outgoing " .. method, table.pack(...)
            end,
        })
    end
    local watch = Scope.new()
    local ok, err = pcall(function()
        watch:Connect(instance.AncestryChanged, function()
            if not instance:IsDescendantOf(game) then self:Stop(instance) end
        end)
        watch:Connect(instance.Destroying, function() self:Stop(instance) end)
    end)
    if not ok then
        watch:Destroy()
        if self.count == 0 then self:StopAll() end
        error(err, 0)
    end
    self.watches[instance] = watch
    self.count += 1
    self.version += 1
end
function m:Stop(instance)
    self:Sync()
    local watch = self.watches[instance]
    if watch then
        self.watches[instance] = nil
        self.count -= 1
        watch:Destroy()
        self.version += 1
    end
    if self.count == 0 and self.entry then
        local ok, err = self.manager:Stop(self.entry.target)
        if ok then self.entry = nil end
        return ok, err
    end
    return true
end
function m:StopAll()
    self:Sync()
    local instances = {}
    for instance in self.watches do table.insert(instances, instance) end
    for _, instance in instances do
        self.watches[instance]:Destroy()
        self.watches[instance] = nil
    end
    self.count = 0
    self.version += 1
    return self:Stop(nil)
end
function m:Destroy()
    local ok, err = self:StopAll()
    if not ok then warn("DebugSuite outgoing hook cleanup: " .. err) end
end
return m
