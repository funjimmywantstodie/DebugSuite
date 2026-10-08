local m = {}
m.__index = m

--local comps = script.Parent.Components

local colors = require("./Colors")

local types = require("./Types")
local tab = require("./Tab")

local lifecycle = require("./util/Lifecycle")
local dragUtil = require("./util/Drag")

local g = getgenv()

function m._createTopbar(self, root: Frame): Frame
    local frame = Instance.new("Frame")
    frame.Name = "Topbar"
    frame.Size = UDim2.new(1, 0, 0, 32)
    frame.BackgroundColor3 = colors.topbar
    frame.BorderSizePixel = 0
    frame.Parent = root
    frame.ZIndex = 10

    local startPosition, scale
    dragUtil.attach(self.scope, frame, function()
        startPosition = root.Position
        scale = dragUtil.scale(root.Parent)
    end, function(delta)
        root.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X / scale,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y / scale
        )
    end)

    local uiPadding = Instance.new("UIPadding")
    uiPadding.PaddingLeft = UDim.new(0, 5)
    uiPadding.PaddingRight = UDim.new(0, 5)
    uiPadding.PaddingTop = UDim.new(0, 5)
    uiPadding.PaddingBottom = UDim.new(0, 5)
    uiPadding.Parent = frame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "CloseButton"
    closeBtn.Size = UDim2.fromOffset(22, 22)
    closeBtn.Position = UDim2.new(1, -22, 0, 0)
    closeBtn.BackgroundColor3 = colors.closeButton
    closeBtn.Text = "X"
    closeBtn.Parent = frame
    closeBtn.ZIndex = 15

    self.scope:Connect(closeBtn.MouseButton1Click, function()
        self:Destroy()
    end)
    return frame
end

function m._createSidebar(root: Frame, topbarHeight: number): ScrollingFrame
    local frame = Instance.new("ScrollingFrame")
    frame.Name = "Sidebar"
    frame.Size = UDim2.new(.2, 0, 1, -topbarHeight)
    frame.Position = UDim2.fromOffset(0, topbarHeight)
    frame.BackgroundColor3 = colors.sidebar
    frame.BorderSizePixel = 0
    frame.Parent = root
    frame.ZIndex = 20

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.FillDirection = Enum.FillDirection.Vertical
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout.Padding = UDim.new(0, 5)
    uiListLayout.Parent = frame

    local uiPadding = Instance.new("UIPadding")
    uiPadding.PaddingLeft = UDim.new(0, 5)
    uiPadding.PaddingRight = UDim.new(0, 17)
    uiPadding.PaddingTop = UDim.new(0, 5)
    uiPadding.PaddingBottom = UDim.new(0, 5)
    uiPadding.Parent = frame

    frame.CanvasSize = UDim2.new()
    frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    return frame
end

function m.new(opts: types.WindowOpts?): types.Window
    if g.simpleuiWindow then
        g.simpleuiWindow:Destroy()
    elseif g.ui then
        local screen = g.ui:FindFirstAncestorWhichIsA("ScreenGui")
        if screen then screen:Destroy() else g.ui:Destroy() end
    end

    local self = setmetatable({}, m)
    local ctx: types.ctx = { services = {} }
    setmetatable(ctx.services, {
        __index = function(_, svcName: string): Instance?
            local succ, svc = pcall(function()
                return cloneref(game:GetService(svcName))
            end)
            if succ then
                ctx.services[svcName] = svc
                return svc
            else
                warn(`invalid service: {svcName}`)
                return nil
            end
        end})

    self.ctx = ctx

    local guis = {}
    local sgui = Instance.new("ScreenGui")
    sgui.Name = "Window"
    sgui.ResetOnSpawn = false
    sgui.IgnoreGuiInset = true
    sgui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    sgui.Parent = game:GetService("CoreGui")
    guis.ScreenGui = sgui

    local root = Instance.new("Frame")
    root.Name = "Root"
    root.Size = (opts and opts.size) or UDim2.new(.5, 0, .5, 0)
    root.AnchorPoint = Vector2.new(.5, .5)
    root.Position = UDim2.fromScale(.5, .5)
    root.Parent = sgui
    root.ZIndex = 5
    local minimum = (opts and opts.minSize) or Vector2.new(400, 260)
    minimum = Vector2.new(math.max(400, minimum.X), math.max(260, minimum.Y))
    local constraint = Instance.new("UISizeConstraint")
    constraint.MinSize = minimum
    constraint.Parent = root
    guis.Root = root

    self.guis = guis
    self.tabs = {}

    lifecycle.attach(self, sgui)
    self.tabs = self.components
    guis.Topbar = m._createTopbar(self, root)
    guis.Sidebar = m._createSidebar(root, guis.Topbar.Size.Y.Offset)

    g.ui = root
    g.simpleuiWindow = self
    self.scope:Add(function()
        if g.simpleuiWindow == self then g.simpleuiWindow = nil g.ui = nil end
    end)
    self.currentTab = nil
    self.SetVisible = function(_, value) sgui.Enabled = value end
    local resize = Instance.new("Frame")
    resize.Name = "Resize"
    resize.Size = UDim2.fromOffset(16, 16)
    resize.Position = UDim2.new(1, -16, 1, -16)
    resize.BackgroundColor3 = colors.sectionHeader
    resize.ZIndex = 200
    resize.Parent = root
    local sizeStart, positionStart, scale, parentScale
    dragUtil.attach(self.scope, resize, function()
        scale = dragUtil.scale(root)
        parentScale = dragUtil.scale(root.Parent)
        sizeStart = Vector2.new(root.AbsoluteSize.X / scale, root.AbsoluteSize.Y / scale)
        positionStart = root.Position
    end, function(delta)
        local width = math.max(minimum.X, sizeStart.X + delta.X / scale)
        local height = math.max(minimum.Y, sizeStart.Y + delta.Y / scale)
        root.Size = UDim2.fromOffset(width, height)
        root.Position = UDim2.new(
            positionStart.X.Scale, positionStart.X.Offset + (width - sizeStart.X) * scale / parentScale * root.AnchorPoint.X,
            positionStart.Y.Scale, positionStart.Y.Offset + (height - sizeStart.Y) * scale / parentScale * root.AnchorPoint.Y
        )
    end)
    return self :: types.Window
end

function m.Show(self: types.Window): ()
    self.guis["ScreenGui"].Enabled = true
end

function m.Hide(self: types.Window): ()
    self.guis["ScreenGui"].Enabled = false
end

function m.Toggle(self: types.Window): ()
    self.guis["ScreenGui"].Enabled = not self.guis["ScreenGui"].Enabled
end

function m.NewTab(self: types.Window, name: string, opts: types.TabOpts?): types.Tab
    local newTab = tab.new(self, name, opts)
    table.insert(self.tabs, newTab)
    return newTab
end

function m.SelectTab(self: types.Window, tab: types.Tab): ()
    if self.currentTab then
        self.currentTab:HideCurrentTab()
    end

    self.currentTab = tab
    tab:ShowCurrentTab()
end

function m:BindShortcut(key, callback, opts)
    opts = opts or {}
    local input = game:GetService("UserInputService")
    return self.scope:Connect(input.InputBegan, function(event, processed)
        if processed or input:GetFocusedTextBox() or not self.guis.ScreenGui.Enabled then return end
        if event.KeyCode ~= key then return end
        local ctrl = input:IsKeyDown(Enum.KeyCode.LeftControl) or input:IsKeyDown(Enum.KeyCode.RightControl)
        local shift = input:IsKeyDown(Enum.KeyCode.LeftShift) or input:IsKeyDown(Enum.KeyCode.RightShift)
        if ctrl ~= (opts.ctrl == true) or shift ~= (opts.shift == true) then return end
        callback()
    end)
end

return m
