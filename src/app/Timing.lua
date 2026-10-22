local m = {}
m.__index = m
function m.new() return setmetatable({ samples = {}, sequence = 0 }, m) end
function m:Push(dt)
    if type(dt) ~= "number" or dt <= 0 or dt ~= dt or dt == math.huge then return end
    self.sequence += 1
    table.insert(self.samples, { id = self.sequence, dt = dt,
        values = { frame = self.sequence, ms = dt * 1000, fps = 1 / dt, stall = if dt >= .05 then "stall" else "" } })
    if #self.samples > 120 then table.remove(self.samples, 1) end
end
function m:Report()
    if #self.samples == 0 then return "No frame samples. Enable sampling, then reproduce the problem." end
    local sorted, total, stalls = {}, 0, 0
    for _, sample in self.samples do
        total += sample.dt
        table.insert(sorted, sample.dt)
        if sample.dt >= .05 then stalls += 1 end
    end
    table.sort(sorted)
    return string.format("Latest %d frames\nAverage: %.1f FPS / %.2f ms\nP95: %.2f ms | Worst: %.2f ms\nFrames >= 50 ms: %d\n", #sorted, #sorted / total, total / #sorted * 1000,
        sorted[math.ceil(#sorted * .95)] * 1000, sorted[#sorted] * 1000, stalls)
end
function m:Clear() table.clear(self.samples) end
return m
