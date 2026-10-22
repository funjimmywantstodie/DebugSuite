local ReturnValues = require("./ReturnValues")
local m = {}
m.__index = m

function m:Refresh()
    local kind = self.kind:GetValue()
    self.value:SetVisible(kind == "string" or kind == "number")
    self.boolean:SetVisible(kind == "boolean")
    self.kind:SetEnabled(self.enabled)
    self.value:SetEnabled(self.enabled and (kind == "string" or kind == "number"))
    self.boolean:SetEnabled(self.enabled and kind == "boolean")
end

function m:SetEnabled(enabled)
    self.enabled = enabled
    self:Refresh()
end

function m:GetValue()
    return ReturnValues.parse(self.kind:GetValue(),
        if self.kind:GetValue() == "boolean" then self.boolean:GetValue() else self.value:GetValue())
end

function m.new(owner, label, kind, value, options)
    local panel = owner:NewPanel({ auto = true, padding = 0, clip = false })
    local self = setmetatable({ panel = panel, enabled = true }, m)
    self.kind = panel:NewDropdown({ text = label, options = options or { "nil", "string", "number", "boolean" }, value = kind or "nil" })
    self.value = panel:NewTextbox({ text = "Literal value (strings need no quotes)" })
    self.value:SetValue(if value == nil then "" else tostring(value))
    self.boolean = panel:NewDropdown({ text = "Value", options = { "false", "true" }, value = if value == true then "true" else "false" })
    self.kind:OnChanged(function() self:Refresh() end)
    self:Refresh()
    return self
end

return m
