local Workbench = require("./Workbench")
local ReturnValues = require("./ReturnValues")
local LiteralEditor = require("./LiteralEditor")
local m = {}
m.__index = m
function m:AddSlot(kind, value)
    assert(#self.slots < ReturnValues.limit, "16 return-slot limit reached")
    local index = #self.slots + 1
    local slot = LiteralEditor.new(self.fields, "Return #" .. index, kind, value)
    slot:SetEnabled(self:CanEdit())
    table.insert(self.slots, slot)
end
function m:CanEdit()
    local entry = self.entry
    return entry ~= nil and entry.active and entry.editable and self.manager.entries[entry.target] == entry
end
function m:SetEntry(entry)
    if self.entry ~= entry then
        self.entry = entry
        self.fields:Clear()
        table.clear(self.slots)
        local values = entry and entry.returnValues
        if values then
            for i = 1, values.n do self:AddSlot(type(values[i]), values[i]) end
        else self:AddSlot() end
    end
    local editable = self:CanEdit()
    self.apply:SetEnabled(editable)
    self.disable:SetEnabled(editable and entry.override ~= nil)
    self.add:SetEnabled(editable and #self.slots < ReturnValues.limit)
    self.remove:SetEnabled(editable and #self.slots > 0)
    for _, slot in self.slots do
        slot:SetEnabled(editable)
    end
    self.status:SetText(if not entry then "OFF: start tracing a function, then configure its returns."
        elseif not editable then "Unavailable: select an active function trace."
        else "Target: " .. entry.label .. "\n" .. (if entry.override then "ON: replacing all returns with " .. entry.override.values.n .. " slots."
            else "OFF: original return values pass through.") .. "\nEdits take effect when you click Apply and enable override.")
end
function m.new(section, manager, action)
    local self = setmetatable({ manager = manager, slots = {} }, m)
    self.status = Workbench.hint(section, { height = 85 })
    Workbench.hint(section, { height = 85, text = "The original function still runs. Replace its entire successful return tuple (0-16 slots); nil slots count. Strings are literal text; choose true or false for booleans. Errors pass through. Pause capture leaves overrides active." })
    self.fields = section:NewPanel({ auto = true, padding = 0 })
    self:AddSlot()
    local row = section:NewRow()
    self.add = row:NewButton({ text = "Add return slot" }, action(function()
        assert(self:CanEdit(), "Select an active function trace")
        self:AddSlot()
        return "Return slot added to draft."
    end))
    self.remove = row:NewButton({ text = "Remove last slot" }, action(function()
        assert(self:CanEdit(), "Select an active function trace")
        local slot = table.remove(self.slots)
        if slot then slot.panel:Destroy() end
        return "Draft has " .. #self.slots .. " return slots."
    end))
    self.apply = section:NewButton({ text = "Apply and enable override" }, action(function()
        assert(self:CanEdit(), "Select an active function trace")
        local values = { n = #self.slots }
        for i, slot in self.slots do
            local ok, value = pcall(slot.GetValue, slot)
            assert(ok, "Return #" .. i .. ": " .. tostring(value))
            values[i] = value
        end
        manager:SetReturnOverride(self.entry.target, values)
        return "Return override enabled for " .. self.entry.label .. " (" .. values.n .. " slots)."
    end))
    self.disable = section:NewButton({ text = "Disable override" }, action(function()
        assert(self:CanEdit(), "Select an active function trace")
        manager:DisableReturnOverride(self.entry.target)
        return "Return override disabled; tracing continues."
    end))
    return self
end
return m
