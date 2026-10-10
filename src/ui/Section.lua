local m = {}
m.__index = m

local colors = require("./Colors")
local types = require("./Types")
local container = require("./Container")
local lifecycle = require("./util/Lifecycle")

local function updateHeight(self)
    self.frame.Size = UDim2.new(1, 0, 0, 40 + self.layout.AbsoluteContentSize.Y)
end

function m.new(tab: types.Tab, name: string, side: types.SectionSide, order: number): types.Section
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.BackgroundColor3 = colors.section
    frame.Size = UDim2.new(1, 0, 0, 40)
    frame.LayoutOrder = order
    frame.ZIndex = 40
    frame.Parent = tab.columns[side]
    local self = lifecycle.attach(setmetatable({}, m), frame, tab)
    self.sectionFrame = frame
    self.parentTab = tab
    local header = Instance.new("TextLabel")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 24)
    header.BorderSizePixel = 0
    header.BackgroundColor3 = colors.sectionHeader
    header.TextColor3 = colors.text
    header.Text = name
    header.ZIndex = frame.ZIndex + 1
    header.Parent = frame
    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Position = UDim2.fromOffset(0, 24)
    content.Size = UDim2.new(1, 0, 1, -24)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.ZIndex = frame.ZIndex + 1
    content.Parent = frame
    self.contentFrame = content
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Padding = UDim.new(0, 6)
    layout.Parent = content
    self.layout = layout
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 8)
    padding.PaddingRight = UDim.new(0, 8)
    padding.PaddingTop = UDim.new(0, 8)
    padding.PaddingBottom = UDim.new(0, 8)
    padding.Parent = content
    self.scope:Connect(layout:GetPropertyChangedSignal("AbsoluteContentSize"), function() updateHeight(self) end)
    updateHeight(self)
    return container.attach(self)
end

return m
