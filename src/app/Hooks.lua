-- Explicit tracing and optional scalar return overrides. Discovery installs nothing.
local Recorder = require("./Recorder")
local Values = require("./Values")
local ReturnValues = require("./ReturnValues")
local m = {}
m.__index = m
local protected = { [coroutine.running] = true, [os.clock] = true }
for _, library in { table, string } do
    for _, value in library do if type(value) == "function" then protected[value] = true end end
end
for _, value in { pcall, xpcall, type, typeof, next, tostring, error, math.floor, math.max, math.min } do protected[value] = true end

function m.new(compat, started)
    return setmetatable({ compat = compat, started = started, entries = {}, sequence = 0,
        recorder = Recorder.new(), busy = setmetatable({}, { __mode = "k" }),
        paused = false, capturing = false, dirty = false, failures = 0, destroyed = false }, m)
end
function m:Available(backend)
    if backend == "Volt OTH" then
        return self.compat:Has("oth.hook") and self.compat:Has("oth.unhook") and self.compat:Has("iscclosure")
    end
    return self.compat:Has("hookfunction") and self.compat:Has("restorefunction") and self.compat:Has("newcclosure")
end
function m:CanTrace(target, backend)
    if self.destroyed then return false, "Hook manager is closed" end
    if type(target) ~= "function" then return false, "Select a function first" end
    local required = if backend == "Volt OTH" then { "oth.hook", "oth.unhook", "iscclosure" }
        else { "hookfunction", "restorefunction", "newcclosure" }
    local missing = {}
    for _, name in required do if not self.compat:Has(name) then table.insert(missing, name) end end
    if #missing > 0 then return false, "Missing APIs: " .. table.concat(missing, ", ") end
    if protected[target] then return false, "Target is a tracing dependency" end
    for _, fn in self.compat.functions do
        if fn == target then return false, "Target is an executor API used by this tool" end
    end
    if self.entries[target] then return false, "Target already managed by this session" end
    if self.compat:Has("isfunctionhooked") then
        local ok, hooked = self.compat:Call("isfunctionhooked", target)
        if not ok or hooked then return false, "Existing hook or hook status unavailable" end
    end
    if backend == "Volt OTH" then
        local ok, isC = self.compat:Call("iscclosure", target)
        if not ok or not isC then return false, "Volt OTH requires a C closure" end
    end
    local count = 0
    for _ in self.entries do count += 1 end
    if count >= 32 then return false, "32-hook limit reached" end
    return true
end
function m:Add(target, label, backend, opts)
    local allowed, reason = self:CanTrace(target, backend)
    assert(allowed, reason)
    opts = opts or {}
    self.sequence += 1
    local api = self.compat.functions
    -- Capture installation/restoration APIs; a later compatibility refresh cannot
    -- change which backend owns an installed hook.
    local entry = { id = self.sequence, target = target, label = label, backend = backend, active = true,
        hits = 0, recorder = opts.recorder or self.recorder, editable = opts.recorder == nil,
        remove = if backend == "Volt OTH" then api["oth.unhook"] else api.restorefunction,
        restoreContext = opts.restoreContext }
    local function callback(...)
        if not entry.active or self.destroyed then return entry.original(...) end
        if opts.match and not opts.match(...) then return entry.original(...) end
        local thread = coroutine.running()
        if self.capturing or self.busy[thread] then return entry.original(...) end
        local override = entry.override
        local capture = not (self.paused or (opts.paused and opts.paused()))
        if not capture and not override then return entry.original(...) end
        self.busy[thread] = true
        -- OTH can dispatch nested hooks on another thread. Serialization does
        -- not intentionally yield; suppress its nested hooks across threads.
        self.capturing = true
        local record, contextValue, started
        local captured = pcall(function(...)
            if not capture then return end
            if opts.context then contextValue = opts.context() end
            local path, kind, arguments
            if opts.select then path, kind, arguments = opts.select(contextValue, ...)
            else path, kind, arguments = entry.label, "function call", table.pack(...) end
            if not path then return end
            entry.hits += 1
            started = os.clock()
            record = entry.recorder:Push(path, arguments, started - self.started, kind)
            self.dirty = true
            if record then record.values.outcome = "running" end
            if record and backend == "Volt OTH" then
                local parts = {}
                for _, name in { "oth.is_hook_thread", "oth.get_original_thread", "oth.get_root_callback" } do
                    if api[name] then
                        local ok, value = pcall(api[name])
                        table.insert(parts, name .. " = " .. (if ok then Values.preview(value) else "unavailable"))
                    end
                end
                record.text ..= "\n-- " .. table.concat(parts, "; ")
            end
        end, ...)
        self.capturing = false
        self.busy[thread] = nil
        if not captured then self.failures += 1 self.dirty = true end
        -- Serialization may make its own namecalls (e.g. CFrame:GetComponents).
        if entry.restoreContext and contextValue then entry.restoreContext(contextValue) end
        if not record and not override then return entry.original(...) end
        local callStarted = os.clock()
        local results = table.pack(pcall(entry.original, ...))
        -- Replacing or disabling the rule, stopping, or closing cancels pending
        -- overrides too. A yielded call cannot apply an obsolete configuration.
        local modified = if results[1] and entry.active and not self.destroyed
            and override and entry.override == override then override.values else nil
        self.busy[thread] = true
        self.capturing = true
        local finished = pcall(function()
            if not record then return end
            local values = { n = results.n - 1 }
            for i = 2, results.n do values[i - 1] = results[i] end
            entry.recorder:Finish(record, results[1], values, os.clock() - callStarted, modified)
        end)
        self.capturing = false
        self.busy[thread] = nil
        if not finished then self.failures += 1 end
        self.dirty = true
        if entry.restoreContext and contextValue then entry.restoreContext(contextValue) end
        if not results[1] then error(results[2], 0) end
        if modified then return table.unpack(modified, 1, modified.n) end
        return table.unpack(results, 2, results.n)
    end
    local replacement = callback
    if backend ~= "Volt OTH" then replacement = api.newcclosure(callback) end
    local install = if backend == "Volt OTH" then api["oth.hook"] else api.hookfunction
    entry.original = install(target, replacement)
    if type(entry.original) ~= "function" then
        entry.active = false
        pcall(entry.remove, target)
        error("Hook API did not return an original function", 0)
    end
    self.entries[target] = entry
    self.dirty = true
    return entry
end
function m:SetReturnOverride(target, values)
    local entry = self.entries[target]
    assert(not self.destroyed and entry and entry.active, "Select an active managed hook")
    assert(entry.editable, "Return overrides are only available for function traces")
    local copy = ReturnValues.copy(values)
    entry.returnValues = copy
    entry.override = { values = copy }
    self.dirty = true
end
function m:DisableReturnOverride(target)
    local entry = self.entries[target]
    assert(entry, "Select a managed hook")
    entry.override = nil
    self.dirty = true
end
function m:Stop(target)
    local entry = self.entries[target]
    if not entry then return true end
    entry.active = false
    entry.override, entry.returnValues = nil, nil
    local ok, result = pcall(entry.remove, target)
    if not ok or (entry.backend == "Volt OTH" and result ~= true) then
        entry.error = if ok then "OTH unhook failed" else tostring(result)
        self.dirty = true
        return false, entry.error
    end
    self.entries[target] = nil
    self.dirty = true
    return true
end
function m:StopAll()
    local targets, errors = {}, {}
    for target in self.entries do table.insert(targets, target) end
    for _, target in targets do
        local ok, err = self:Stop(target)
        if not ok then table.insert(errors, err) end
    end
    return #errors == 0, table.concat(errors, "\n")
end
function m:Destroy()
    if self.destroyed then return end
    self.destroyed = true
    local ok, err = self:StopAll()
    if not ok then warn("DebugSuite hook cleanup: " .. err) end
    self.recorder:Clear()
    table.clear(self.busy)
end
return m
