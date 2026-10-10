local m = {}
m.__index = m

local colors = require("./Colors")

local types = require("./Types")
local section = require("./Section")
local container = require("./Container")
local lifecycle = require("./util/Lifecycle")

local function updateRowHeight(row, leftLayout, rightLayout)
    local height = math.max(leftLayout.AbsoluteContentSize.Y, rightLayout.AbsoluteContentSize.Y)
    row.Size = UDim2.new(1, 0, 0, height)
end

function m:Destroy(skipFrame)
    local window = self.parentWindow
    local selected = window.currentTab == self
    if selected then window.currentTab = nil end
    self.baseDestroy(self, skipFrame)
    if selected and not window.destroyed and #window.tabs > 0 then
        window:SelectTab(window.tabs[1])
    end
end

local function createTabBar(root: Frame, name: string): TextButton
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = name
    tabBtn.Size = UDim2.new(1, 0, 0, 28)
    tabBtn.Position = UDim2.new(0, 0, 0, 0)
    tabBtn.BackgroundColor3 = colors.tabButton
    tabBtn.TextColor3 = colors.text
    tabBtn.Text = name
    tabBtn.Parent = root
    tabBtn.ZIndex = 30

    return tabBtn
end

local function createArea(parent: Instance, name: string, order: number): (Frame, UIListLayout)
    local area = Instance.new("Frame")
    area.Name = name
    area.BackgroundTransparency = 1
    area.Size = UDim2.new(1, 0, 0, 0)
    area.AutomaticSize = Enum.AutomaticSize.Y
    area.LayoutOrder = order
    area.ZIndex = 36
    area.Parent = parent

    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 5)
    layout.Parent = area
    return area, layout
end

local function createContainer(root: Frame, topbarHeight: number): ScrollingFrame
    local container = Instance.new("ScrollingFrame")
    container.Name = "TabContainer"
    container.Size = UDim2.new(0.8, 0, 1, -topbarHeight)
    container.Position = UDim2.new(0.2, 0, 0, topbarHeight)
    container.BackgroundColor3 = colors.tabContainer
    container.BorderSizePixel = 0
    container.ZIndex = 35
    container.Visible = false
    container.ScrollingDirection = Enum.ScrollingDirection.Y
    container.AutomaticCanvasSize = Enum.AutomaticSize.Y
    container.CanvasSize = UDim2.new()
    container.Parent = root

    return container
end

function m.new(window: types.Window, name: string, opts: types.TabOpts?): types.Tab
    local self = setmetatable({}, m)

    self.tabBtn = createTabBar(window.guis["Sidebar"], name)
    self.parentWindow = window
    self.container = createContainer(window.guis.Root, window.guis.Topbar.Size.Y.Offset)
    lifecycle.attach(self, self.container, window)
    if opts and opts.layout == "free" then
        local content = Instance.new("Frame")
        content.Name = "Content"
        content.BackgroundTransparency = 1
        content.Size = UDim2.fromScale(1, 1)
        content.ZIndex = self.container.ZIndex + 1
        content.Parent = self.container
        self.container.AutomaticCanvasSize = Enum.AutomaticSize.None
        self.contentFrame = content
        self.columns = { left = content, right = content, top = content, bottom = content, full = content }
    else
        local content = createArea(self.container, "Sections", 0)
        content.Position = UDim2.fromOffset(5, 5)
        -- Insets apply to the shared wrapper, including full-width sections.
        content.Size = UDim2.new(1, -10 - self.container.ScrollBarThickness, 0, 0)
        local top = createArea(content, "Top", 0)

        local row = Instance.new("Frame")
        row.Name = "Columns"
        row.BackgroundTransparency = 1
        row.Size = UDim2.new(1, 0, 0, 0)
        row.LayoutOrder = 1
        row.ZIndex = 36
        row.Parent = content

        local left, leftLayout = createArea(row, "Left", 0)
        local right, rightLayout = createArea(row, "Right", 1)
        left.Size = UDim2.new(0.5, -3, 0, 0)
        right.Size = UDim2.new(0.5, -3, 0, 0)
        right.Position = UDim2.new(0.5, 3, 0, 0)

        -- Reserve space for the taller column before placing bottom sections.
        self.scope:Connect(leftLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function() updateRowHeight(row, leftLayout, rightLayout) end)
        self.scope:Connect(rightLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function() updateRowHeight(row, leftLayout, rightLayout) end)
        updateRowHeight(row, leftLayout, rightLayout)

        local bottom = createArea(content, "Bottom", 2)
        self.columns = {
            left = left,
            right = right,
            top = top,
            bottom = bottom,
            full = bottom,
        }
        self.contentFrame = self.columns.bottom
    end
    self.sections = self.components
    self.scope:Add(function() self.tabBtn:Destroy() end)

    self.scope:Connect(self.tabBtn.MouseButton1Click, function()
        window:SelectTab(self)
    end)

    container.attach(self)
    self.baseDestroy = self.Destroy
    self.Destroy = m.Destroy
    return self :: types.Tab
end

function m.NewSection(self: types.Tab, name: string, side: types.SectionSide?): types.Section
    local columnSide = side or "left"
    self.nextOrder = (self.nextOrder or 0) + 1
    local order = self.nextOrder
    local newSection = section.new(self, name, columnSide, order)
    table.insert(self.components, newSection)
    self.sections = self.components
    return newSection
end

function m.ShowCurrentTab(self: types.Tab): ()
    self.container.Visible = true
end

function m.HideCurrentTab(self: types.Tab): ()
    self.container.Visible = false
end

return m
