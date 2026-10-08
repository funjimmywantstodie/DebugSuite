local m = {}
local controls = require("../util/Controls")
local lifecycle = require("../util/Lifecycle")

function m.new(owner, opts, callback)
    local self = controls.button(owner, opts)
    self.value = opts.value or false
    local changed = lifecycle.event(self)

    function self:SetValue(value: boolean)
        if self.value == value then return end
        self.value = value
        self.button.Text = (if value then "[x] " else "[ ] ") .. opts.text
        if callback then callback(value) end
        changed:Fire(value)
    end

    function self:GetValue(): boolean
        return self.value
    end

    function self:OnChanged(fn)
        return self.scope:Connect(changed.Event, fn)
    end

    self.callback = function() self:SetValue(not self.value) end
    self.button.Text = (if self.value then "[x] " else "[ ] ") .. opts.text
    return self
end

return m
