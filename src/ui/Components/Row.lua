local m = {}
m.__index = m

local types = require("../Types")
local controls = require("../util/Controls")
local lifecycle = require("../util/Lifecycle")

local function updateWidths(self)
    local fixed = 0
    local count = 0
    local visible = 0
    for i, component in self.components do
        if component.frame.Visible then
            visible += 1
            local width = self.componentWidths[i]
            if width < 0 then count += 1 else fixed += width end
        end
    end
    local remaining = math.max(0, self.rowFrame.AbsoluteSize.X - fixed - math.max(0, visible - 1) * self.gap)
    for i, component in self.components do
        local width = self.componentWidths[i]
        component.frame.Size = UDim2.fromOffset(if width < 0 then (if count > 0 then remaining / count else 0) else width, 28)
    end
end

local function add(self, component, opts)
    table.insert(self.components, component)
    table.insert(self.componentWidths, if opts.fill or opts.width == nil then -1 else math.max(0, opts.width))
    self.order = (self.order or 0) + 1
    component.frame.LayoutOrder = self.order
    component.scope:Connect(component.frame:GetPropertyChangedSignal("Visible"), function() updateWidths(self) end)
    updateWidths(self)
    return component
end

local function onRemove(self, index)
    if index then table.remove(self.componentWidths, index) end
    updateWidths(self)
end

function m.new(owner: types.Container, opts: types.RowOpts?): types.Row
    local options = opts or {}
    local frame = Instance.new("Frame")
    frame.Name = options.text or "Row"
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.ZIndex = owner.contentFrame.ZIndex + 1
    frame.Size = UDim2.new(1, 0, 0, 28)
    frame.Parent = owner.contentFrame
    local self = lifecycle.attach(setmetatable({}, m), frame, owner)
    self.rowFrame = frame
    self.componentWidths = {}
    self.gap = math.max(0, options.gap or 6)
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.Padding = UDim.new(0, self.gap)
    layout.Parent = frame
    self.onRemove = function(index) onRemove(self, index) end
    self.scope:Connect(frame:GetPropertyChangedSignal("AbsoluteSize"), function() updateWidths(self) end)
    return self
end

function m:NewButton(opts: types.RowComponentOpts, callback): types.Button
    return add(self, controls.button(self, opts, callback, self.rowFrame), opts)
end

function m:NewTextbox(opts: types.RowComponentOpts, callback): types.Textbox
    return add(self, controls.textbox(self, opts, callback, self.rowFrame), opts)
end

return m
