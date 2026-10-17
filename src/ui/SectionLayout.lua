local m = {}

local section = require("./Section")

local function createArea(parent, name, order)
    local area = Instance.new("Frame")
    area.Name = name
    area.BackgroundTransparency = 1
    area.Size = UDim2.new(1, 0, 0, 0)
    area.AutomaticSize = Enum.AutomaticSize.Y
    area.LayoutOrder = order
    area.ZIndex = parent.ZIndex + 1
    area.Parent = parent

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 5)
    layout.Parent = area
    return area, layout
end

function m.NewSection(self, name, side)
    assert(not self.destroyed, "container destroyed")
    assert(type(name) == "string", 'NewSection expects a name string and an optional side')
    side = side or "left"
    assert(self.columns[side], "invalid section side")
    self.nextOrder = (self.nextOrder or 0) + 1
    local newSection = section.new(self, name, side, self.nextOrder)
    table.insert(self.components, newSection)
    return newSection
end

function m.attach(self, viewport, layout)
    self.NewSection = m.NewSection
    self.sections = self.components
    viewport.CanvasSize = UDim2.new()
    viewport.ScrollingDirection = Enum.ScrollingDirection.Y
    viewport.ClipsDescendants = true

    if layout == "free" then
        viewport.AutomaticCanvasSize = Enum.AutomaticSize.None
        viewport.ScrollBarThickness = 0
        local content = Instance.new("Frame")
        content.Name = "Content"
        content.BackgroundTransparency = 1
        content.Size = UDim2.fromScale(1, 1)
        content.ZIndex = viewport.ZIndex + 1
        content.Parent = viewport
        self.contentFrame = content
        self.columns = { left = content, right = content, top = content, bottom = content, full = content }
        return self
    end

    viewport.AutomaticCanvasSize = Enum.AutomaticSize.Y
    local content = createArea(viewport, "Sections", 0)
    content.Position = UDim2.fromOffset(5, 5)
    content.Size = UDim2.new(1, -10 - viewport.ScrollBarThickness, 0, 0)
    local top = createArea(content, "Top", 0)

    local row = Instance.new("Frame")
    row.Name = "Columns"
    row.BackgroundTransparency = 1
    row.Size = UDim2.new(1, 0, 0, 0)
    row.LayoutOrder = 1
    row.ZIndex = content.ZIndex + 1
    row.Parent = content

    local left, leftLayout = createArea(row, "Left", 0)
    local right, rightLayout = createArea(row, "Right", 1)
    left.Size = UDim2.new(0.5, -3, 0, 0)
    right.Size = UDim2.new(0.5, -3, 0, 0)
    right.Position = UDim2.new(0.5, 3, 0, 0)

    -- Keep bottom sections below the taller column on both kinds of host.
    local function updateRowHeight()
        local height = math.max(leftLayout.AbsoluteContentSize.Y, rightLayout.AbsoluteContentSize.Y)
        row.Size = UDim2.new(1, 0, 0, height)
    end
    self.scope:Connect(leftLayout:GetPropertyChangedSignal("AbsoluteContentSize"), updateRowHeight)
    self.scope:Connect(rightLayout:GetPropertyChangedSignal("AbsoluteContentSize"), updateRowHeight)
    updateRowHeight()

    local bottom = createArea(content, "Bottom", 2)
    self.columns = { left = left, right = right, top = top, bottom = bottom, full = bottom }
    self.contentFrame = bottom
    return self
end

return m
