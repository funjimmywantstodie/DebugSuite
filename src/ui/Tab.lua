local m = {}
m.__index = m

local colors = require("./Colors")

local types = require("../Types")
local sectionLayout = require("./SectionLayout")
local container = require("./Container")
local lifecycle = require("./util/Lifecycle")

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
    sectionLayout.attach(self, self.container, opts and opts.layout)
    self.scope:Add(function() self.tabBtn:Destroy() end)

    self.scope:Connect(self.tabBtn.MouseButton1Click, function()
        window:SelectTab(self)
    end)

    container.attach(self)
    self.baseDestroy = self.Destroy
    self.Destroy = m.Destroy
    return self :: types.Tab
end

function m.ShowCurrentTab(self: types.Tab): ()
    self.container.Visible = true
end

function m.HideCurrentTab(self: types.Tab): ()
    self.container.Visible = false
end

return m
