local m = {}
m.__index = m

local types = require("../Types")
local uiConstructor = require("../Util/UIConstructor")

local function updateWidths(row: types.Row)
    local fixedWidth = 0
    local flexibleCount = 0
    for _, width in row.componentWidths do
        if width < 0 then
            flexibleCount += 1
        else
            fixedWidth += width
        end
    end

    local remaining = math.max(0, row.rowFrame.AbsoluteSize.X
        - fixedWidth - math.max(0, #row.components - 1) * row.gap)
    local flexibleWidth = if flexibleCount > 0 then remaining / flexibleCount else 0
    for index, component in row.components do
        local width = row.componentWidths[index]
        component.button.Size = UDim2.fromOffset(if width < 0 then flexibleWidth else width, 28)
    end
end

local function addComponent(row: types.Row, component: types.Button | types.Textbox, opts: types.RowComponentOpts)
    table.insert(row.components, component)
    table.insert(row.componentWidths, if opts.fill or opts.width == nil then -1 else math.max(0, opts.width))
    component.button.LayoutOrder = #row.components
    updateWidths(row)
end

function m.new(parentSection: types.Section, opts: types.RowOpts?): types.Row
    local options = opts or {}
    local self = setmetatable({}, m)
    self.parentSection = parentSection
    self.components = {}
    self.componentWidths = {}
    self.gap = math.max(0, options.gap or 6)

    local frame = Instance.new("Frame")
    frame.Name = options.text or "Row"
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.ZIndex = parentSection.sectionFrame.ZIndex + 1
    frame.Size = UDim2.new(1, 0, 0, 28)
    frame.Parent = parentSection.contentFrame
    self.rowFrame = frame

    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.VerticalAlignment = Enum.VerticalAlignment.Center
    layout.Padding = UDim.new(0, self.gap)
    layout.Parent = frame

    local conn = frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        updateWidths(self)
    end)
    table.insert(parentSection.parentTab.parentWindow.conns, conn)
    return self :: types.Row
end

function m:NewButton(opts: types.RowComponentOpts, callback: () -> (any)): types.Button
    local gui = uiConstructor.createButton(self.rowFrame, opts)
    local conn = gui.MouseButton1Click:Connect(callback)
    table.insert(self.parentSection.parentTab.parentWindow.conns, conn)
    local component: types.Button = { button = gui, callback = callback }
    addComponent(self, component, opts)
    return component
end

function m:NewTextbox(opts: types.RowComponentOpts, callback: (string) -> (any)): types.Textbox
    local gui = uiConstructor.createTextbox(self.rowFrame, opts)
    local conn = gui.FocusLost:Connect(function(enterPressed: boolean)
        if enterPressed then
            callback(gui.Text)
        end
    end)
    table.insert(self.parentSection.parentTab.parentWindow.conns, conn)
    local component: types.Textbox = { button = gui, callback = callback }
    addComponent(self, component, opts)
    return component
end

return m
