type Services__DARKLUA_TYPE_a = {[string]: Instance?}

type ctx__DARKLUA_TYPE_b = {
    services: Services__DARKLUA_TYPE_a,
}

type WindowGuis__DARKLUA_TYPE_c = {
    ScreenGui: ScreenGui,
    Root: Frame,
    Sidebar: ScrollingFrame,
}

type SectionSide__DARKLUA_TYPE_d = "left" | "right" | "top" | "bottom" | "full"

type Window__DARKLUA_TYPE_e = {
    ctx: ctx__DARKLUA_TYPE_b,
    guis: WindowGuis__DARKLUA_TYPE_c,
    conns: {RBXScriptConnection},
    currentTab: Tab__DARKLUA_TYPE_f?,
    tabs: {Tab__DARKLUA_TYPE_f},
    Show: (self: Window__DARKLUA_TYPE_e) -> (),
    Hide: (self: Window__DARKLUA_TYPE_e) -> (),
    Toggle: (self: Window__DARKLUA_TYPE_e) -> (),
    NewTab: (self: Window__DARKLUA_TYPE_e, name: string) -> Tab__DARKLUA_TYPE_f,
    SelectTab: (self: Window__DARKLUA_TYPE_e, tab: Tab__DARKLUA_TYPE_f) -> (),
}

type Tab__DARKLUA_TYPE_f = {
    parentWindow: Window__DARKLUA_TYPE_e,
    tabBtn: TextButton,
    sections: {Section__DARKLUA_TYPE_i},
    container: ScrollingFrame,
    columns: {left: Frame, right: Frame, top: Frame, bottom: Frame, full: Frame},
    NewSection: (self: Tab__DARKLUA_TYPE_f, name: string, side: SectionSide__DARKLUA_TYPE_d?) -> Section__DARKLUA_TYPE_i,
    ShowCurrentTab: (self: Tab__DARKLUA_TYPE_f) -> (),
    HideCurrentTab: (self: Tab__DARKLUA_TYPE_f) -> (),
}

type ComponentOpts__DARKLUA_TYPE_g = {
    text: string,
}

type ConsoleOpts__DARKLUA_TYPE_h = {
    text: string,
    height: number?,
}

type Section__DARKLUA_TYPE_i = {
    parentTab: Tab__DARKLUA_TYPE_f,
    sectionFrame: Frame,
    contentFrame: Frame,
    components: {Button__DARKLUA_TYPE_l | Textbox__DARKLUA_TYPE_m | Console__DARKLUA_TYPE_j},
    NewButton: (self: Section__DARKLUA_TYPE_i, opts: ComponentOpts__DARKLUA_TYPE_g, callback: () -> (any)) -> Button__DARKLUA_TYPE_l,
    NewTextbox: (self: Section__DARKLUA_TYPE_i, opts: ComponentOpts__DARKLUA_TYPE_g, callback: (string) -> (any)) -> Textbox__DARKLUA_TYPE_m,
    NewConsole: (self: Section__DARKLUA_TYPE_i, opts: ConsoleOpts__DARKLUA_TYPE_h) -> Console__DARKLUA_TYPE_j,
}

type Console__DARKLUA_TYPE_j = {
    consoleFrame: Frame,
    NewEntry: (self: Console__DARKLUA_TYPE_j, text: string, messageType: ConsoleMessageType__DARKLUA_TYPE_k) -> (),
}

type ConsoleMessageType__DARKLUA_TYPE_k = "error" | "warning" | "info" | "success"

type Button__DARKLUA_TYPE_l = {
    button: TextButton,
    callback: () -> (any),
}

type Textbox__DARKLUA_TYPE_m = {
    button: TextBox,
    callback: (string) -> (any),
}
local __DARKLUA_BUNDLE_MODULES={cache={}::any}do do local function __modImpl()
return {
    topbar = Color3.fromRGB(30, 30, 30),
    closeButton = Color3.fromRGB(200, 50, 50),
    sidebar = Color3.fromRGB(88, 87, 87),
    tabButton = Color3.fromRGB(50, 50, 50),
    tabContainer = Color3.fromRGB(168, 168, 168),
    section = Color3.fromRGB(50, 50, 50),
    sectionHeader = Color3.fromRGB(70, 70, 70),
    component = Color3.fromRGB(70, 70, 70),
    text = Color3.fromRGB(255, 255, 255),
    console = {
        background = Color3.fromRGB(22, 27, 34),
        info = Color3.fromRGB(137, 196, 244),
        error = Color3.fromRGB(255, 128, 138),
        success = Color3.fromRGB(126, 211, 161),
        warning = Color3.fromRGB(240, 196, 112),
    },
}
end function __DARKLUA_BUNDLE_MODULES.a():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.a if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.a=v end return v.c end end do local function __modImpl()










































































return {}
end function __DARKLUA_BUNDLE_MODULES.b():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.b if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.b=v end return v.c end end do local function __modImpl()
local m = {}
m.__index = m

local colors = __DARKLUA_BUNDLE_MODULES.a()

local types = __DARKLUA_BUNDLE_MODULES.b()

local function createButton(section: Section__DARKLUA_TYPE_i, opts: ComponentOpts__DARKLUA_TYPE_g, callback: () -> (any)): TextButton
    local button = Instance.new("TextButton")
    button.Name = opts.text
    button.BackgroundColor3 = colors.component
    button.TextColor3 = colors.text
    button.Text = opts.text
    button.ZIndex = section.sectionFrame.ZIndex + 1
    button.Parent = section.contentFrame
    button.Size = UDim2.new(1, 0, 0, 28)

    local conn = button.MouseButton1Click:Connect(callback)
    table.insert(section.parentTab.parentWindow.conns, conn)
    return button
    
end

function m.new(parentSection: Section__DARKLUA_TYPE_i, opts: ComponentOpts__DARKLUA_TYPE_g, callback: () -> (any)): Button__DARKLUA_TYPE_l    
local self = setmetatable({}, m)

    self.button = createButton(parentSection, opts, callback)
    self.callback = callback
    return self
end

return m end function __DARKLUA_BUNDLE_MODULES.c():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.c if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.c=v end return v.c end end do local function __modImpl()
local m = {}
m.__index = m

local colors = __DARKLUA_BUNDLE_MODULES.a()

local types = __DARKLUA_BUNDLE_MODULES.b()

local function createTextbox(section: Section__DARKLUA_TYPE_i, opts: ComponentOpts__DARKLUA_TYPE_g, callback: (string) -> (any)): TextBox
    local button = Instance.new("TextBox")
    button.Name = opts.text
    button.BackgroundColor3 = colors.component
    button.TextColor3 = colors.text
    button.PlaceholderText = opts.text
    button.Text = ""
    button.ZIndex = section.sectionFrame.ZIndex + 1
    button.Parent = section.contentFrame
    button.Size = UDim2.new(1, 0, 0, 28)

   local conn = button.FocusLost:Connect(function(enterPressed: boolean)
        if enterPressed then
            callback(button.Text)
        end
    end)
    table.insert(section.parentTab.parentWindow.conns, conn)
    return button
    
end

function m.new(parentSection: Section__DARKLUA_TYPE_i, opts: ComponentOpts__DARKLUA_TYPE_g, callback: (string) -> (any)): Textbox__DARKLUA_TYPE_m    
local self = setmetatable({}, m)

    self.button = createTextbox(parentSection, opts, callback)
    self.callback = callback
    return self
end

return m end function __DARKLUA_BUNDLE_MODULES.d():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.d if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.d=v end return v.c end end do local function __modImpl()
local m = {}
m.__index = m

local colors = __DARKLUA_BUNDLE_MODULES.a()

local types = __DARKLUA_BUNDLE_MODULES.b()

local function updateSize(section: Section__DARKLUA_TYPE_i, consoleFrame: Frame, height: number?): ()
    local width = section.contentFrame.AbsoluteSize.X
    local padding = section.contentFrame:FindFirstChildOfClass("UIPadding")
    if padding then
        width -= width * (padding.PaddingLeft.Scale + padding.PaddingRight.Scale)
            + padding.PaddingLeft.Offset + padding.PaddingRight.Offset
    end
    local side = math.max(0, width)
    local size = UDim2.fromOffset(side, height or side)
    if consoleFrame.Size ~= size then
        consoleFrame.Size = size
    end
end


local function createConsole(section: Section__DARKLUA_TYPE_i, opts: ConsoleOpts__DARKLUA_TYPE_h): Frame
    local consoleFrame = Instance.new("Frame")
    consoleFrame.Name = "Console"
    consoleFrame.BackgroundColor3 = colors.console.background
    consoleFrame.Parent = section.contentFrame
    consoleFrame.Size = UDim2.new(1, 0, 0, 0)
    consoleFrame.ZIndex = section.contentFrame.ZIndex + 1

    local conn = section.contentFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        updateSize(section, consoleFrame, opts.height)
    end)
    table.insert(section.parentTab.parentWindow.conns, conn)
    updateSize(section, consoleFrame, opts.height)

    local uilistlayout = Instance.new("UIListLayout")
    uilistlayout.SortOrder = Enum.SortOrder.LayoutOrder
    uilistlayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    uilistlayout.Parent = consoleFrame
    return consoleFrame
end

function m.new(parentSection: Section__DARKLUA_TYPE_i, opts: ConsoleOpts__DARKLUA_TYPE_h): Console__DARKLUA_TYPE_j    
local self = setmetatable({}, m)

    self.consoleFrame = createConsole(parentSection, opts)
    return self
end

function m.NewEntry(self: Console__DARKLUA_TYPE_j, text: string, messageType: ConsoleMessageType__DARKLUA_TYPE_k): ()
    local entry = Instance.new("TextLabel")
    entry.Name = "Entry"
    entry.BackgroundTransparency = 1
    entry.TextColor3 = colors.console[messageType]
    entry.TextXAlignment = Enum.TextXAlignment.Left
    entry.TextYAlignment = Enum.TextYAlignment.Top
    entry.Font = Enum.Font.Code
    entry.TextSize = 14
    entry.TextWrapped = true
    entry.Text = text
    entry.Size = UDim2.new(1, -10, 0, 0)
    entry.AutomaticSize = Enum.AutomaticSize.Y
    entry.LayoutOrder = #self.consoleFrame:GetChildren()
    entry.Parent = self.consoleFrame
    entry.ZIndex = self.consoleFrame.ZIndex + 1
end

return m
end function __DARKLUA_BUNDLE_MODULES.e():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.e if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.e=v end return v.c end end do local function __modImpl()
local m = {}
m.__index = m

local colors = __DARKLUA_BUNDLE_MODULES.a()

local types = __DARKLUA_BUNDLE_MODULES.b()
local button = __DARKLUA_BUNDLE_MODULES.c()
local textbox =__DARKLUA_BUNDLE_MODULES.d()
local console = __DARKLUA_BUNDLE_MODULES.e()

local function updateHeight(frame: Frame, uiListLayout: UIListLayout, uiPadding: UIPadding)
    local height = 24--header height
        + uiPadding.PaddingTop.Offset
        + uiListLayout.AbsoluteContentSize.Y
        + uiPadding.PaddingBottom.Offset

    frame.Size = UDim2.new(frame.Size.X.Scale,frame.Size.X.Offset,0,height)
end

local function createHeader(frame: Frame): ()
    local header = Instance.new("TextLabel")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 24)
    header.Position = UDim2.new(0, 0, 0, 0)
    header.BorderSizePixel = 0
    header.BackgroundColor3 = colors.sectionHeader
    header.TextColor3 = colors.text
    header.Text = frame.Name
    header.ZIndex = frame.ZIndex + 1
    header.Parent = frame

end


--make height automatic based on the amount of stuff in it
local function createSection(tab: Tab__DARKLUA_TYPE_f, name: string, side: SectionSide__DARKLUA_TYPE_d, order: number)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.BackgroundColor3 = colors.section
    frame.Size = UDim2.new(1, 0, 0, 40)
    frame.LayoutOrder = order
    frame.Parent = tab.columns[side]
    frame.ZIndex = 40

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Position = UDim2.fromOffset(0, 24)
    content.Size = UDim2.new(1, 0, 1, -24)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.ZIndex = frame.ZIndex + 1
    content.Parent = frame

    local uiListLayout = Instance.new("UIListLayout")
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    uiListLayout.Parent = content
    uiListLayout.Padding = UDim.new(0, 6)

    local uiPadding = Instance.new("UIPadding")
    uiPadding.PaddingLeft = UDim.new(0, 8)
    uiPadding.PaddingRight = UDim.new(0, 8)
    uiPadding.PaddingTop = UDim.new(0, 8)
    uiPadding.PaddingBottom = UDim.new(0, 8)
    uiPadding.Parent = content
    
    createHeader(frame)
    updateHeight(frame, uiListLayout, uiPadding)
    local conn = uiListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        updateHeight(frame, uiListLayout, uiPadding)
    end)
    table.insert(tab.parentWindow.conns, conn)

    return {
        sectionFrame = frame,
        contentFrame = content,
        components = {}
    }
end

function m.new(tab: Tab__DARKLUA_TYPE_f, name: string, side: SectionSide__DARKLUA_TYPE_d, order: number): Section__DARKLUA_TYPE_i    
local self = setmetatable({}, m)
    local result = createSection(tab, name, side, order)
    self.sectionFrame = result.sectionFrame
    self.contentFrame = result.contentFrame
    self.components = result.components
    self.parentTab = tab
    
    return self :: Section__DARKLUA_TYPE_i
end

function m:NewButton(opts: ComponentOpts__DARKLUA_TYPE_g, callback: () -> (any)): Button__DARKLUA_TYPE_l    
local btn = button.new(self, opts, callback)
    btn.button.LayoutOrder = #self.contentFrame:GetChildren()

    table.insert(self.components, btn)
    return btn
end

function m:NewTextbox(opts: ComponentOpts__DARKLUA_TYPE_g, callback: (string) -> (any)): Textbox__DARKLUA_TYPE_m    
local textbox = textbox.new(self, opts, callback)
    textbox.button.LayoutOrder = #self.contentFrame:GetChildren()

    table.insert(self.components, textbox)
    return textbox
end

function m:NewConsole(opts: ConsoleOpts__DARKLUA_TYPE_h): Console__DARKLUA_TYPE_j    
local console = console.new(self, opts)
    console.consoleFrame.LayoutOrder = #self.contentFrame:GetChildren()

    table.insert(self.components, console)
    return console
end

return m
end function __DARKLUA_BUNDLE_MODULES.f():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.f if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.f=v end return v.c end end do local function __modImpl()
local m = {}
m.__index = m

local colors = __DARKLUA_BUNDLE_MODULES.a()

local types = __DARKLUA_BUNDLE_MODULES.b()
local section = __DARKLUA_BUNDLE_MODULES.f()

local function createTabBar(root: Frame, name: string): TextButton
    local tabBtn = Instance.new("TextButton")
    tabBtn.Name = name
    tabBtn.Size = UDim2.new(1, 0, .05, 0)
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

local function createContainer(root: Frame): ScrollingFrame
    local container = Instance.new("ScrollingFrame")
    container.Name = "TabContainer"
    container.Size = UDim2.new(0.8, 0, 0.85, 0)
    container.Position = UDim2.new(0.2, 0, 0.15, 0)
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

function m.new(window: Window__DARKLUA_TYPE_e, name: string): Tab__DARKLUA_TYPE_f    
local self = setmetatable({}, m)

    self.tabBtn = createTabBar(window.guis["Sidebar"], name)
    self.parentWindow = window
    self.container = createContainer(window.guis.Root)
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
    local function updateRowHeight()
        local height = math.max(leftLayout.AbsoluteContentSize.Y, rightLayout.AbsoluteContentSize.Y)
        row.Size = UDim2.new(1, 0, 0, height)
    end
    table.insert(window.conns, leftLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateRowHeight))
    table.insert(window.conns, rightLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateRowHeight))
    updateRowHeight()

    local bottom = createArea(content, "Bottom", 2)
    self.columns = {
        left = left,
        right = right,
        top = top,
        bottom = bottom,
        full = bottom,
    }
    self.sections = {} :: {Section__DARKLUA_TYPE_i}

    local conn = self.tabBtn.MouseButton1Click:Connect(function()
        window:SelectTab(self)
    end)

    table.insert(window.conns, conn)
    return self :: Tab__DARKLUA_TYPE_f
end

function m.NewSection(self: Tab__DARKLUA_TYPE_f, name: string, side: SectionSide__DARKLUA_TYPE_d?): Section__DARKLUA_TYPE_i    
local columnSide = side or "left"
    local order = #self.columns[columnSide]:GetChildren()
    local newSection = section.new(self, name, columnSide, order)
    table.insert(self.sections, newSection)
    return newSection
end

function m.ShowCurrentTab(self: Tab__DARKLUA_TYPE_f): ()
    self.container.Visible = true
end

function m.HideCurrentTab(self: Tab__DARKLUA_TYPE_f): ()
    self.container.Visible = false
end

return m
end function __DARKLUA_BUNDLE_MODULES.g():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.g if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.g=v end return v.c end end do local function __modImpl()
local m = {}
m.__index = m

--local comps = script.Parent.Components

local colors = __DARKLUA_BUNDLE_MODULES.a()

local types = __DARKLUA_BUNDLE_MODULES.b()
local tab = __DARKLUA_BUNDLE_MODULES.g()

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

function m.new(opts: {}?): Window__DARKLUA_TYPE_e    
if g.ui then
        g.ui:Destroy()
    end

    local self = setmetatable({}, m)
    local ctx: ctx__DARKLUA_TYPE_b= { services = {} }
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
    return self :: Window__DARKLUA_TYPE_e
end

function m.Show(self: Window__DARKLUA_TYPE_e): ()
    self.guis["ScreenGui"].Enabled = true
end

function m.Hide(self: Window__DARKLUA_TYPE_e): ()
    self.guis["ScreenGui"].Enabled = false
end

function m.Toggle(self: Window__DARKLUA_TYPE_e): ()
    self.guis["ScreenGui"].Enabled = not self.guis["ScreenGui"].Enabled
end

function m.NewTab(self: Window__DARKLUA_TYPE_e, name: string): Tab__DARKLUA_TYPE_f    
local newTab = tab.new(self, name)
    table.insert(self.tabs, newTab)
    return newTab
end

function m.SelectTab(self: Window__DARKLUA_TYPE_e, tab: Tab__DARKLUA_TYPE_f): ()
    if self.currentTab then
        self.currentTab:HideCurrentTab()
    end
    
    self.currentTab = tab
    tab:ShowCurrentTab()
end

return m end function __DARKLUA_BUNDLE_MODULES.h():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.h if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.h=v end return v.c end end end
local Window = __DARKLUA_BUNDLE_MODULES.h()
local tab = __DARKLUA_BUNDLE_MODULES.g()

local window = Window.new({})
local testTab = window:NewTab("test")
local testTab2 = window:NewTab("test2")

local testSection = testTab:NewSection("test section", "left")
local testSection2 = testTab:NewSection("test section2", "right")
local testSection3 = testTab:NewSection("test section3", "left")
local testSection4 = testTab:NewSection("test section4", "right")
local testSection5 = testTab:NewSection("test section5", "left")
local testSection6 = testTab:NewSection("test section6", "right")
local testSection7 = testTab:NewSection("test section7", "left")
local testSection8 = testTab:NewSection("test section8", "right")

testSection:NewButton({ text = "test button" }, function()
    print("test button clicked")
end)
testSection:NewButton({ text = "test button2" }, function()
    print("test button2 clicked")
end)
testSection:NewButton({ text = "test button3" }, function()
    print("test button3 clicked")
end)
testSection2:NewButton({ text = "test button4" }, function()
    print("test button4 clicked")
end)
testSection3:NewTextbox({ text = "test textbox" }, function(value)
    print("test textbox value: " .. value)
end)
local topSection = testTab:NewSection("Overview", "top")
topSection:NewButton({ text = "Full-width button" }, function()
    print("full-width button clicked")
end)
local logsSection = testTab:NewSection("Logs", "bottom")
local console = logsSection:NewConsole({ text = "test console", height = 200 })
console:NewEntry("test console entry", "info")
console:NewEntry("test console entry", "warning")
console:NewEntry("test console entry", "error")
console:NewEntry("test console entry 112937192837129837189237912739817398127398127398127391273981273981273", "success")
local testSection9 = testTab2:NewSection("a", "left")
testTab2:NewSection("b", "right")
testTab2:NewSection("c", "left")
testTab2:NewSection("d", "right")
testTab2:NewSection("e", "left")
testTab2:NewSection("f", "right")
testTab2:NewSection("g", "left")
testTab2:NewSection("h", "right")
testSection9:NewButton({ text = "test button5" }, function()
    print("test button5 clicked")
end)

window:SelectTab(testTab)
window:Show()