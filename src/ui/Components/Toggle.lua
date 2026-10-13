local m = {}
local controls = require("../util/Controls")
local lifecycle = require("../util/Lifecycle")
m.__index = m

function m:SetValue(value: boolean)
    if self.value == value then return end
    self.value = value
    self.button.Text = (if value then "[x] " else "[ ] ") .. self.label
    if self.onToggle then self.onToggle(value) end
    self.changed:Fire(value)
end

function m:GetValue(): boolean
    return self.value
end

function m:OnChanged(fn)
    return self.scope:Connect(self.changed.Event, fn)
end

local function toggle(self)
    self:SetValue(not self.value)
end

function m.new(owner, opts, callback)
    local self = controls.button(owner, opts)
    setmetatable(self, m)
    self.value = opts.value or false
    self.label = opts.text
    self.onToggle = callback
    self.changed = lifecycle.event(self)
    self.callback = function() toggle(self) end
    self.button.Text = (if self.value then "[x] " else "[ ] ") .. opts.text
    return self
end

return m
