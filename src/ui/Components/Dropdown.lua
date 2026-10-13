local m = {}
local colors = require("../Colors")
local ui = require("../util/UIConstructor")
local lifecycle = require("../util/Lifecycle")
local scope = require("../util/Scope")
local popupUtil = require("../util/Popup")
m.__index = m

function m:updateText()
    self.button.Text = self.label .. (if self.value then ": " .. self.value else ": select")
    for _, item in self.items do
        local selected = item.value == self.value
        item.button.Text = item.value .. (if selected then "  (selected)" else "")
        item.button.BackgroundColor3 = if selected then colors.sectionHeader else colors.component
    end
end

function m:SetValue(value: string?)
    assert(value == nil or table.find(self.options, value), "unknown dropdown value")
    local different = self.value ~= value
    self.value = value
    self:SetOpen(false)
    if different then
        if self.callback then self.callback(value) end
        self.changed:Fire(value)
    end
end

function m:GetValue()
    return self.value
end

function m:SetEnabled(value: boolean)
    self.enabled = value
    self.button.Active = value
    self.button.AutoButtonColor = value
    if not value then self:SetOpen(false) end
end

function m:SetOptions(options)
    self.optionScope:Destroy()
    self.optionScope = scope.new()
    for _, child in self.popup:GetChildren() do child:Destroy() end
    self.items = {}
    self.options = table.clone(options)
    local height = if #options > 0 then #options * 34 + 10 else 0
    self.popup.CanvasSize = UDim2.fromOffset(0, height)
    self.popup.Size = UDim2.new(1, -16, 0, math.min(180, height))
    self.popup.ScrollBarThickness = if height > 180 then 6 else 0
    for i, value in options do
        local item = ui.createButton(self.popup, { text = value }, self.popup.ZIndex + 1)
        item.Position = UDim2.fromOffset(8, 8 + (i - 1) * 34)
        item.Size = UDim2.new(1, if height > 180 then -24 else -16, 0, 28)
        item.TextXAlignment = Enum.TextXAlignment.Left
        local padding = Instance.new("UIPadding")
        padding.PaddingLeft = UDim.new(0, 8)
        padding.PaddingRight = UDim.new(0, 8)
        padding.Parent = item
        table.insert(self.items, { button = item, value = value })
        self.optionScope:Connect(item.MouseButton1Click, function() if self.enabled then self:SetValue(value) end end)
    end
    self:SetValue(if table.find(options, self.value) then self.value else nil)
end

function m:OnChanged(fn)
    return self.scope:Connect(self.changed.Event, fn)
end

function m.new(owner, opts, callback)
    local frame = Instance.new("Frame")
    frame.Name = opts.text
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, 28)
    frame.ZIndex = owner.contentFrame.ZIndex + 1
    frame.Parent = owner.contentFrame
    local self = lifecycle.attach(setmetatable({}, m), frame, owner)
    self.label = opts.text
    self.callback = callback
    self.options = opts.options or {}
    self.value = opts.value
    self.items = {}
    self.open = false
    self.enabled = true
    local button = ui.createButton(frame, opts)
    self.button = button
    local popup = Instance.new("ScrollingFrame")
    popup.BackgroundTransparency = 1
    popup.BorderSizePixel = 0
    popup.Size = UDim2.new(1, 0, 0, math.min(180, math.max(0, #self.options * 34 - 6)))
    popup.Position = UDim2.fromOffset(0, 28)
    popup.ZIndex = frame.ZIndex + 1
    popup.Visible = false
    popup.ScrollBarThickness = 6
    popup.CanvasSize = UDim2.fromOffset(0, #self.options * 28)
    popup.Parent = frame
    self.popup = popup
    self.changed = lifecycle.event(self)
    self.optionScope = scope.new()
    self.scope:Add(function() self.optionScope:Destroy() end)

    popupUtil.attach(self, popup, button)

    self.scope:Connect(button.MouseButton1Click, function() self:SetOpen(not self.open) end)
    self.scope:Connect(frame:GetPropertyChangedSignal("Visible"), function()
        if not frame.Visible then self:SetOpen(false) end
    end)
    self:SetOptions(self.options)
    return self
end

return m
