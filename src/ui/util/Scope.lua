local m = {}
m.__index = m

function m.new()
    return setmetatable({ conns = {}, cleanups = {}, destroyed = false }, m)
end

function m:Connect(signal, callback)
    assert(not self.destroyed, "scope destroyed")
    local conn = signal:Connect(callback)
    table.insert(self.conns, conn)
    return conn
end

function m:Add(callback)
    assert(not self.destroyed, "scope destroyed")
    table.insert(self.cleanups, callback)
end

function m:Destroy()
    if self.destroyed then return end
    self.destroyed = true
    for _, conn in self.conns do conn:Disconnect() end
    for i = #self.cleanups, 1, -1 do self.cleanups[i]() end
    table.clear(self.conns)
    table.clear(self.cleanups)
end

return m
