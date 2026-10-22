local m = {}
m.__index = m
function m.new(owner, status, onBusyChanged)
    local self = setmetatable({ generation = 0, owner = owner, status = status, busy = false, onBusyChanged = onBusyChanged }, m)
    owner.scope:Add(function() self.generation += 1 end)
    return self
end
function m:SetBusy(value)
    self.busy = value
    if self.onBusyChanged then self.onBusyChanged(value) end
end
function m:Cancel()
    if not self.busy then return end
    self.generation += 1
    if not self.owner.destroyed then
        self:SetBusy(false)
        self.status("Cancelled. Previous results retained.")
    end
end
function m:Run(work, commit)
    self.generation += 1
    local generation = self.generation
    local function alive() return not self.owner.destroyed and generation == self.generation end
    self.status("Scanning...")
    self:SetBusy(true)
    task.spawn(function()
        if not alive() then return end
        local steps = 0
        local function checkpoint()
            if not alive() then return false end
            steps += 1
            if steps % 100 == 0 then task.wait() end
            return alive()
        end
        local ok, result, summary = pcall(work, checkpoint)
        if not alive() then return end
        self:SetBusy(false)
        if not ok then self.status("Scan failed: " .. tostring(result)) return end
        local committed, err = pcall(commit, result)
        self.status(if committed then summary or "Ready" else "Display failed: " .. tostring(err))
    end)
end
return m
