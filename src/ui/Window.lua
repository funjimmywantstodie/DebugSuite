local m = {}
m.__index = m

--local comps = script.Parent.Components

local colors = require("./Colors")

local types = require("../Types")
local tab = require("./Tab")

local lifecycle = require("./util/Lifecycle")
local WindowFrame = require("./WindowFrame")
local WindowFocus = require("./util/WindowFocus")
local ConsoleWindow = require("./ConsoleWindow")
local Notify = require("./Components/Notify")

local g = getgenv()

function m:SetVisible(value)
    self.guis.ScreenGui.Enabled = value
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
    --keep each window's content together when focusing
    sgui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sgui.Parent = game:GetService("CoreGui")
    guis.ScreenGui = sgui

    self.guis = guis
    lifecycle.attach(self, sgui)
    self.tabs = self.components
    self.childWindowOwner = { components = {} }
    self.focusManager = WindowFocus.new(sgui, self.scope)
    local minimum = (opts and opts.minSize) or Vector2.new(400, 260)
    minimum = Vector2.new(math.max(400, minimum.X), math.max(260, minimum.Y))
    self.shell = WindowFrame.new(sgui, {
        size = opts and opts.size, minSize = minimum,
        onClose = function() self:Destroy() end,
    }, self.focusManager)
    local root = self.shell.frame
    guis.Root = root
    guis.Topbar = self.shell.guis.Topbar
    guis.Sidebar = m._createSidebar(root, guis.Topbar.Size.Y.Offset)
    self.shell:AddTopbarButton("ConsoleButton", "</> Console", function() self:OpenConsole() end, 76)
    self.scope:Add(function()
        while #self.childWindowOwner.components > 0 do
            self.childWindowOwner.components[#self.childWindowOwner.components]:Destroy()
        end
        self.shell:Destroy()
    end)

    --separate owners so these dont end up in the tab list
    self.consoleWindow = ConsoleWindow.new(self)
    local notifications = Instance.new("Frame")
    notifications.Name = "Notifications"
    notifications.BackgroundTransparency = 1
    notifications.AnchorPoint = Vector2.new(1, 1)
    notifications.Position = UDim2.new(1, -16, 1, -16)
    notifications.Size = UDim2.new(1, -32, 1, -32)
    notifications.ZIndex = 300
    notifications.Parent = sgui
    local notificationSize = Instance.new("UISizeConstraint")
    notificationSize.MaxSize = Vector2.new(340, 10000)
    notificationSize.Parent = notifications
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    layout.Padding = UDim.new(0, 8)
    layout.Parent = notifications
    self.notifications = lifecycle.attach({ contentFrame = notifications }, notifications)
    self.scope:Add(function()
        self.notifications:Destroy()
    end)
    self.focusManager:RegisterOverlay(notifications, self.notifications.scope)
    self.shell:Focus()
    if not opts or opts.captureLogs ~= false then
        self.scope:Connect(game:GetService("LogService").MessageOut, function(message, messageType)
            local level = if messageType == Enum.MessageType.MessageError then "error"
                elseif messageType == Enum.MessageType.MessageWarning then "warning" else "info"
            if level == "error" or level == "warning" then
                self:Notify({ text = message, messageType = level })
            else
                self:Log(message, level)
            end
        end)
    end

    g.ui = root
    g.simpleuiWindow = self
    self.scope:Add(function()
        if g.simpleuiWindow == self then g.simpleuiWindow = nil g.ui = nil end
    end)
    self.currentTab = nil
    self.SetVisible = m.SetVisible
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

function m:NewWindow(opts)
    assert(not self.destroyed, "window destroyed")
    local window = WindowFrame.new(self.guis.ScreenGui, opts, self.focusManager, self.childWindowOwner)
    table.insert(self.childWindowOwner.components, window)
    return window
end

function m:OpenConsole()
    if not self.destroyed then
        self.consoleWindow:SetVisible(true)
    end
    return self.consoleWindow.console
end

function m:Log(text, messageType)
    if self.destroyed then return end
    self.consoleWindow.console:NewEntry(text, messageType or "info")
end

function m:Notify(opts)
    if self.destroyed then return end
    local notification = Notify.new(self.notifications, {
        text = opts.text, messageType = opts.messageType, duration = opts.duration,
        onDetails = function() self:OpenConsole() end,
    })
    local owner = self.notifications
    owner.nextOrder = (owner.nextOrder or 0) + 1
    notification.frame.LayoutOrder = owner.nextOrder
    table.insert(owner.components, notification)
    if #owner.components > 3 then owner.components[1]:Destroy() end
    self:Log(opts.text, opts.messageType)
    return notification
end

return m
