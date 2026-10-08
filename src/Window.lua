local m = {}
m.__index = m

--local comps = script.Parent.Components

local colors = require("./Colors")

local types = require("./Types")
local tab = require("./Tab")

local conns = {} :: {RBXScriptConnection}

local g = getgenv()

function m._cleanup(root: Frame): ()
    root:Destroy()
    for _, conn in conns do
        conn:Disconnect()
    end
    conns = {}
end

function m._createTopbar(root: Frame): ()
    local frame = Instance.new("Frame")
    frame.Name = "Topbar"
    frame.Size = UDim2.new(1, 0, .15, 0)
    frame.BackgroundColor3 = colors.topbar
    frame.BorderSizePixel = 0
    frame.Parent = root
    frame.ZIndex = 10

    local drag = Instance.new("UIDragDetector")
    drag.ResponseStyle = Enum.UIDragDetectorResponseStyle.CustomOffset
    drag.Parent = frame

    local startPointer = Vector2.zero
    local startPosition = root.Position

    table.insert(conns, drag.DragStart:Connect(function(pointer)
        startPointer = pointer
        startPosition = root.Position
    end))

    table.insert(conns, drag.DragContinue:Connect(function(pointer)
        local delta = pointer - startPointer

        root.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end))

    local uiPadding = Instance.new("UIPadding")
    uiPadding.PaddingLeft = UDim.new(0, 5)
    uiPadding.PaddingRight = UDim.new(0, 5)
    uiPadding.PaddingTop = UDim.new(0, 5)
    uiPadding.PaddingBottom = UDim.new(0, 5)
    uiPadding.Parent = frame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "CloseButton"
    closeBtn.Size = UDim2.new(.07, 0, 1, 0)
    closeBtn.Position = UDim2.new(.93, 0, 0, 0)
    closeBtn.BackgroundColor3 = colors.closeButton
    closeBtn.Text = "X"
    closeBtn.Parent = frame
    closeBtn.ZIndex = 15

    local conn = closeBtn.MouseButton1Click:Connect(function()
        m._cleanup(root)
    end)
    table.insert(conns, conn)
end

function m._createSidebar(root: Frame): ScrollingFrame
    local frame = Instance.new("ScrollingFrame")
    frame.Name = "Sidebar"
    frame.Size = UDim2.new(.2, 0, .85, 0)
    frame.Position = UDim2.new(0, 0, .15, 0)
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

    return frame
end

function m.new(opts: {}?): types.Window
    if g.ui then
        g.ui:Destroy()
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
    sgui.Parent = game:GetService("CoreGui")
    guis.ScreenGui = sgui

    local root = Instance.new("Frame")
    root.Name = "Root"
    root.Size = UDim2.new(.5, 0, .5, 0)
    root.AnchorPoint = Vector2.new(.5, .5)
    root.Position = UDim2.fromScale(.5, .5)
    root.Parent = sgui
    root.ZIndex = 5
    guis.Root = root

    self.guis = guis
    self.tabs = {}

    m._createTopbar(root)
    guis.Sidebar = m._createSidebar(root)

    g.ui = root
    self.conns = conns
    self.currentTab = nil
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

function m.NewTab(self: types.Window, name: string): types.Tab
    local newTab = tab.new(self, name)
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

return m