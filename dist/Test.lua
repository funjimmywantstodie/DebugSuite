type Services__DARKLUA_TYPE_a = {[string]: Instance?}

type ctx__DARKLUA_TYPE_b = { services: Services__DARKLUA_TYPE_a }

type SectionSide__DARKLUA_TYPE_c = "left" | "right" | "top" | "bottom" | "full"

type Scope__DARKLUA_TYPE_d = {
    conns: {RBXScriptConnection},
    Connect: (self: Scope__DARKLUA_TYPE_d, signal: RBXScriptSignal, callback: (...any) -> ()) -> RBXScriptConnection,
    Add: (self: Scope__DARKLUA_TYPE_d, callback: () -> ()) -> (),
    Destroy: (self: Scope__DARKLUA_TYPE_d) -> (),
}

type Component__DARKLUA_TYPE_e = {
    frame: GuiObject,
    scope: Scope__DARKLUA_TYPE_d,
    conns: {RBXScriptConnection},
    components: {Component__DARKLUA_TYPE_e},
    destroyed: boolean,
    SetVisible: (self: any, value: boolean) -> (),
    Clear: (self: any) -> (),
    Destroy: (self: any) -> (),
}

type ComponentOpts__DARKLUA_TYPE_f = { text: string }

type RowOpts__DARKLUA_TYPE_g = { text: string?, gap: number? }

type RowComponentOpts__DARKLUA_TYPE_h = { text: string, width: number?, fill: boolean? }

type PanelOpts__DARKLUA_TYPE_i = {
    text: string?, size: UDim2?, position: UDim2?, height: number?, auto: boolean?,
    scroll: boolean?, layout: ("vertical" | "horizontal" | "none")?,
    gap: number?, padding: number?, clip: boolean?, minSize: Vector2?, maxSize: Vector2?,
}

type SplitPaneOpts__DARKLUA_TYPE_j = {
    size: UDim2?, height: number?, ratio: number?, vertical: boolean?, minSize: number?,
}

type ConsoleMessageType__DARKLUA_TYPE_k = "error" | "warning" | "info" | "success"

type ConsoleEntry__DARKLUA_TYPE_l = { text: string, messageType: ConsoleMessageType__DARKLUA_TYPE_k? }

type ConsoleOpts__DARKLUA_TYPE_m = { text: string?, height: number?, maxEntries: number?, autoScroll: boolean? }

type Record__DARKLUA_TYPE_n = { id: string | number, values: {[string]: any}, data: any? }

type Column__DARKLUA_TYPE_o = { key: string, text: string?, width: number? }

type ListOpts__DARKLUA_TYPE_p = {
    text: string?, size: UDim2?, height: number?, columns: {Column__DARKLUA_TYPE_o}?,
    rowHeight: number?, maxRecords: number?,
}

type TreeNode__DARKLUA_TYPE_q = {
    id: string | number, text: string, data: any?, children: {TreeNode__DARKLUA_TYPE_q}?,
    loadChildren: (() -> {TreeNode__DARKLUA_TYPE_q})?,
}

type TreeOpts__DARKLUA_TYPE_r = { text: string?, size: UDim2?, height: number?, maxDepth: number?, emptyText: string? }

type TextViewerOpts__DARKLUA_TYPE_s = { text: string?, size: UDim2?, height: number?, editable: boolean? }

type ToggleOpts__DARKLUA_TYPE_t = { text: string, value: boolean? }

type DropdownOpts__DARKLUA_TYPE_u = { text: string, options: {string}, value: string? }

type MenuItem__DARKLUA_TYPE_v = { text: string, callback: () -> (), enabled: boolean? }

type MenuOpts__DARKLUA_TYPE_w = { text: string, items: {MenuItem__DARKLUA_TYPE_v} }

type Container__DARKLUA_TYPE_x = Component__DARKLUA_TYPE_e & {
    contentFrame: GuiObject,
    NewButton: (self: any, opts: ComponentOpts__DARKLUA_TYPE_f, callback: (() -> any)?) -> Button__DARKLUA_TYPE_y,
    NewTextbox: (self: any, opts: ComponentOpts__DARKLUA_TYPE_f, callback: ((string) -> any)?) -> Textbox__DARKLUA_TYPE_z,
    NewRow: (self: any, opts: RowOpts__DARKLUA_TYPE_g?) -> Row__DARKLUA_TYPE_A,
    NewConsole: (self: any, opts: ConsoleOpts__DARKLUA_TYPE_m?) -> Console__DARKLUA_TYPE_C,
    NewPanel: (self: any, opts: PanelOpts__DARKLUA_TYPE_i?) -> Container__DARKLUA_TYPE_x,
    NewSplitPane: (self: any, opts: SplitPaneOpts__DARKLUA_TYPE_j?) -> SplitPane__DARKLUA_TYPE_B,
    NewList: (self: any, opts: ListOpts__DARKLUA_TYPE_p?) -> List__DARKLUA_TYPE_D,
    NewTree: (self: any, opts: TreeOpts__DARKLUA_TYPE_r?) -> Tree__DARKLUA_TYPE_E,
    NewTextViewer: (self: any, opts: TextViewerOpts__DARKLUA_TYPE_s?) -> TextViewer__DARKLUA_TYPE_F,
    NewToggle: (self: any, opts: ToggleOpts__DARKLUA_TYPE_t, callback: ((boolean) -> ())?) -> Toggle__DARKLUA_TYPE_G,
    NewDropdown: (self: any, opts: DropdownOpts__DARKLUA_TYPE_u, callback: ((string?) -> ())?) -> Dropdown__DARKLUA_TYPE_H,
    NewMenu: (self: any, opts: MenuOpts__DARKLUA_TYPE_w) -> Menu__DARKLUA_TYPE_I,
}

type Button__DARKLUA_TYPE_y = Component__DARKLUA_TYPE_e & {
    button: TextButton,
    callback: (() -> any)?,
    SetText: (self: Button__DARKLUA_TYPE_y, value: string) -> (),
    SetEnabled: (self: Button__DARKLUA_TYPE_y, value: boolean) -> (),
}

type Textbox__DARKLUA_TYPE_z = Component__DARKLUA_TYPE_e & {
    button: TextBox,
    callback: ((string) -> any)?,
    GetValue: (self: Textbox__DARKLUA_TYPE_z) -> string,
    SetValue: (self: Textbox__DARKLUA_TYPE_z, value: string) -> (),
    SetPlaceholder: (self: Textbox__DARKLUA_TYPE_z, value: string) -> (),
    SetEnabled: (self: Textbox__DARKLUA_TYPE_z, value: boolean) -> (),
    Focus: (self: Textbox__DARKLUA_TYPE_z) -> (),
    OnChanged: (self: Textbox__DARKLUA_TYPE_z, callback: (string) -> ()) -> RBXScriptConnection,
    OnSubmitted: (self: Textbox__DARKLUA_TYPE_z, callback: (string) -> ()) -> RBXScriptConnection,
}

type Row__DARKLUA_TYPE_A = Component__DARKLUA_TYPE_e & {
    rowFrame: Frame,
    componentWidths: {number},
    gap: number,
    NewButton: (self: Row__DARKLUA_TYPE_A, opts: RowComponentOpts__DARKLUA_TYPE_h, callback: (() -> any)?) -> Button__DARKLUA_TYPE_y,
    NewTextbox: (self: Row__DARKLUA_TYPE_A, opts: RowComponentOpts__DARKLUA_TYPE_h, callback: ((string) -> any)?) -> Textbox__DARKLUA_TYPE_z,
}

type SplitPane__DARKLUA_TYPE_B = Component__DARKLUA_TYPE_e & {
    first: Container__DARKLUA_TYPE_x, second: Container__DARKLUA_TYPE_x, ratio: number,
    SetRatio: (self: SplitPane__DARKLUA_TYPE_B, value: number) -> (),
}

type Console__DARKLUA_TYPE_C = Component__DARKLUA_TYPE_e & {
    consoleFrame: ScrollingFrame,
    NewEntry: (self: Console__DARKLUA_TYPE_C, text: string, messageType: ConsoleMessageType__DARKLUA_TYPE_k) -> (),
    Append: (self: Console__DARKLUA_TYPE_C, entries: {ConsoleEntry__DARKLUA_TYPE_l}) -> (),
    SetPaused: (self: Console__DARKLUA_TYPE_C, value: boolean) -> (),
    SetAutoScroll: (self: Console__DARKLUA_TYPE_C, value: boolean) -> (),
}

type List__DARKLUA_TYPE_D = Component__DARKLUA_TYPE_e & {
    records: {Record__DARKLUA_TYPE_n}, selectedId: (string | number)?,
    SetRecords: (self: List__DARKLUA_TYPE_D, records: {Record__DARKLUA_TYPE_n}) -> (),
    Append: (self: List__DARKLUA_TYPE_D, records: {Record__DARKLUA_TYPE_n}) -> (),
    Refresh: (self: List__DARKLUA_TYPE_D) -> (),
    SetFilter: (self: List__DARKLUA_TYPE_D, value: string) -> (),
    SetSort: (self: List__DARKLUA_TYPE_D, key: string, ascending: boolean?) -> (),
    Select: (self: List__DARKLUA_TYPE_D, id: string | number) -> (),
    OnSelected: (self: List__DARKLUA_TYPE_D, callback: (Record__DARKLUA_TYPE_n?) -> ()) -> RBXScriptConnection,
}

type Tree__DARKLUA_TYPE_E = Component__DARKLUA_TYPE_e & {
    SetNodes: (self: Tree__DARKLUA_TYPE_E, nodes: {TreeNode__DARKLUA_TYPE_q}) -> (),
    Expand: (self: Tree__DARKLUA_TYPE_E, id: string | number, value: boolean) -> (),
    Select: (self: Tree__DARKLUA_TYPE_E, id: string | number) -> (),
    OnSelected: (self: Tree__DARKLUA_TYPE_E, callback: (TreeNode__DARKLUA_TYPE_q?) -> ()) -> RBXScriptConnection,
}

type TextViewer__DARKLUA_TYPE_F = Component__DARKLUA_TYPE_e & {
    textbox: TextBox,
    SetText: (self: TextViewer__DARKLUA_TYPE_F, value: string) -> (),
    GetText: (self: TextViewer__DARKLUA_TYPE_F) -> string,
    OnChanged: (self: TextViewer__DARKLUA_TYPE_F, callback: (string) -> ()) -> RBXScriptConnection,
}

type Toggle__DARKLUA_TYPE_G = Button__DARKLUA_TYPE_y & {
    SetValue: (self: Toggle__DARKLUA_TYPE_G, value: boolean) -> (),
    GetValue: (self: Toggle__DARKLUA_TYPE_G) -> boolean,
    OnChanged: (self: Toggle__DARKLUA_TYPE_G, callback: (boolean) -> ()) -> RBXScriptConnection,
}

type Dropdown__DARKLUA_TYPE_H = Component__DARKLUA_TYPE_e & {
    button: TextButton,
    SetOpen: (self: Dropdown__DARKLUA_TYPE_H, value: boolean) -> (),
    SetValue: (self: Dropdown__DARKLUA_TYPE_H, value: string?) -> (),
    GetValue: (self: Dropdown__DARKLUA_TYPE_H) -> string?,
    SetOptions: (self: Dropdown__DARKLUA_TYPE_H, options: {string}) -> (),
    SetEnabled: (self: Dropdown__DARKLUA_TYPE_H, value: boolean) -> (),
    OnChanged: (self: Dropdown__DARKLUA_TYPE_H, callback: (string?) -> ()) -> RBXScriptConnection,
}

type Menu__DARKLUA_TYPE_I = Button__DARKLUA_TYPE_y & { SetOpen: (self: Menu__DARKLUA_TYPE_I, value: boolean) -> () }

type Section__DARKLUA_TYPE_J = Container__DARKLUA_TYPE_x & { parentTab: Tab__DARKLUA_TYPE_K, sectionFrame: Frame }

type Tab__DARKLUA_TYPE_K = Container__DARKLUA_TYPE_x & {
    parentWindow: Window__DARKLUA_TYPE_P, tabBtn: TextButton, sections: {Component__DARKLUA_TYPE_e}, container: ScrollingFrame,
    columns: {left: Frame, right: Frame, top: Frame, bottom: Frame, full: Frame},
    NewSection: (self: Tab__DARKLUA_TYPE_K, name: string, side: SectionSide__DARKLUA_TYPE_c?) -> Section__DARKLUA_TYPE_J,
    ShowCurrentTab: (self: Tab__DARKLUA_TYPE_K) -> (), HideCurrentTab: (self: Tab__DARKLUA_TYPE_K) -> (),
}

type TabOpts__DARKLUA_TYPE_L = { layout: ("sections" | "free")? }

type WindowOpts__DARKLUA_TYPE_M = { size: UDim2?, minSize: Vector2? }

type WindowGuis__DARKLUA_TYPE_N = { ScreenGui: ScreenGui, Root: Frame, Topbar: Frame, Sidebar: ScrollingFrame }

type ShortcutOpts__DARKLUA_TYPE_O = { ctrl: boolean?, shift: boolean? }

type Window__DARKLUA_TYPE_P = {
    ctx: ctx__DARKLUA_TYPE_b, guis: WindowGuis__DARKLUA_TYPE_N, scope: Scope__DARKLUA_TYPE_d, conns: {RBXScriptConnection},
    currentTab: Tab__DARKLUA_TYPE_K?, tabs: {Tab__DARKLUA_TYPE_K},
    Show: (self: Window__DARKLUA_TYPE_P) -> (), Hide: (self: Window__DARKLUA_TYPE_P) -> (), Toggle: (self: Window__DARKLUA_TYPE_P) -> (),
    SetVisible: (self: Window__DARKLUA_TYPE_P, value: boolean) -> (),
    Clear: (self: Window__DARKLUA_TYPE_P) -> (), Destroy: (self: Window__DARKLUA_TYPE_P) -> (),
    NewTab: (self: Window__DARKLUA_TYPE_P, name: string, opts: TabOpts__DARKLUA_TYPE_L?) -> Tab__DARKLUA_TYPE_K,
    SelectTab: (self: Window__DARKLUA_TYPE_P, tab: Tab__DARKLUA_TYPE_K) -> (),
    BindShortcut: (self: Window__DARKLUA_TYPE_P, key: Enum.KeyCode, callback: () -> (), opts: ShortcutOpts__DARKLUA_TYPE_O?) -> RBXScriptConnection,
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

local colors = __DARKLUA_BUNDLE_MODULES.a()
local types = __DARKLUA_BUNDLE_MODULES.b()

function m.createButton(parent: GuiObject, opts: ComponentOpts__DARKLUA_TYPE_f, zIndex: number?): TextButton
    local button = Instance.new("TextButton")
    button.Name = opts.text
    button.BackgroundColor3 = colors.component
    button.TextColor3 = colors.text
    button.Text = opts.text
    button.ZIndex = zIndex or parent.ZIndex + 1
    button.Size = UDim2.new(1, 0, 0, 28)
    button.Parent = parent
    return button
end

function m.createTextbox(parent: GuiObject, opts: ComponentOpts__DARKLUA_TYPE_f, zIndex: number?): TextBox
    local textbox = Instance.new("TextBox")
    textbox.Name = opts.text
    textbox.BackgroundColor3 = colors.component
    textbox.TextColor3 = colors.text
    textbox.PlaceholderText = opts.text
    textbox.Text = ""
    textbox.ZIndex = zIndex or parent.ZIndex + 1
    textbox.Size = UDim2.new(1, 0, 0, 28)
    textbox.Parent = parent
    return textbox
end

return m
end function __DARKLUA_BUNDLE_MODULES.c():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.c if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.c=v end return v.c end end do local function __modImpl()
local m = {}
m.__index = m

function m.new()
    return setmetatable({ conns = {}, cleanups = {}, destroyed = false }, m)
end

function m:Connect(signal, callback)
    assert(not self.destroyed, "scope destroyed")
    local conn = signal:Connect(callback)
    table.insert(self.conns, conn)
    return conn
end

function m:Add(callback)
    assert(not self.destroyed, "scope destroyed")
    table.insert(self.cleanups, callback)
end

function m:Destroy()
    if self.destroyed then return end
    self.destroyed = true
    for _, conn in self.conns do conn:Disconnect() end
    for i = #self.cleanups, 1, -1 do self.cleanups[i]() end
    table.clear(self.conns)
    table.clear(self.cleanups)
end

return m
end function __DARKLUA_BUNDLE_MODULES.d():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.d if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.d=v end return v.c end end do local function __modImpl()
local m = {}
local scope = __DARKLUA_BUNDLE_MODULES.d()

function m.attach(self, frame, owner)
    self.frame = frame
    self.scope = scope.new()
    self.conns = self.scope.conns
    self.components = self.components or {}
    self.owner = owner
    self.destroyed = false

    function self:SetVisible(value: boolean)
        self.frame.Visible = value
    end

    if not self.Clear then
        function self:Clear()
            while #self.components > 0 do
                self.components[#self.components]:Destroy()
            end
        end
    end

    function self:Destroy(skipFrame)
        if self.destroyed then return end
        self.destroyed = true
        self:Clear()
        self.scope:Destroy()
        if not skipFrame then self.frame:Destroy() end
        if self.owner then
            local index = table.find(self.owner.components, self)
            if index then table.remove(self.owner.components, index) end
            if self.owner.onRemove then self.owner.onRemove(index) end
        end
    end

    self.scope:Connect(frame.Destroying, function() self:Destroy(true) end)
    return self
end

function m.event(self)
    local event = Instance.new("BindableEvent")
    self.scope:Add(function() event:Destroy() end)
    return event
end

return m
end function __DARKLUA_BUNDLE_MODULES.e():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.e if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.e=v end return v.c end end do local function __modImpl()
local m = {}
local ui = __DARKLUA_BUNDLE_MODULES.c()
local lifecycle = __DARKLUA_BUNDLE_MODULES.e()

function m.button(owner, opts, callback, parent)
    local gui = ui.createButton(parent or owner.contentFrame, opts)
    local self = lifecycle.attach({ button = gui, callback = callback, enabled = true }, gui, owner)
    self.scope:Connect(gui.MouseButton1Click, function()
        if self.enabled and self.callback then self.callback() end
    end)

    function self:SetText(value: string)
        gui.Text = value
    end

    function self:SetEnabled(value: boolean)
        self.enabled = value
        gui.Active = value
        gui.AutoButtonColor = value
        gui.TextTransparency = if value then 0 else 0.5
    end

    return self
end

function m.textbox(owner, opts, callback, parent)
    local gui = ui.createTextbox(parent or owner.contentFrame, opts)
    gui.ClearTextOnFocus = false
    local self = lifecycle.attach({ button = gui, callback = callback }, gui, owner)
    local changed = lifecycle.event(self)
    local submitted = lifecycle.event(self)
    self.scope:Connect(gui:GetPropertyChangedSignal("Text"), function()
        changed:Fire(gui.Text)
    end)
    self.scope:Connect(gui.FocusLost, function(enterPressed)
        if enterPressed then
            if self.callback then self.callback(gui.Text) end
            submitted:Fire(gui.Text)
        end
    end)

    function self:GetValue(): string
        return gui.Text
    end

    function self:SetValue(value: string)
        gui.Text = value
    end

    function self:SetPlaceholder(value: string)
        gui.PlaceholderText = value
    end

    function self:SetEnabled(value: boolean)
        gui.TextEditable = value
    end

    function self:Focus()
        gui:CaptureFocus()
    end

    function self:OnChanged(callback)
        return self.scope:Connect(changed.Event, callback)
    end

    function self:OnSubmitted(callback)
        return self.scope:Connect(submitted.Event, callback)
    end

    return self
end

return m
end function __DARKLUA_BUNDLE_MODULES.f():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.f if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.f=v end return v.c end end do local function __modImpl()
local m = {}
local controls = __DARKLUA_BUNDLE_MODULES.f()
local types = __DARKLUA_BUNDLE_MODULES.b()

function m.new(owner: Container__DARKLUA_TYPE_x, opts: ComponentOpts__DARKLUA_TYPE_f, callback, parent: GuiObject?): Button__DARKLUA_TYPE_y    
return controls.button(owner, opts, callback, parent)
end

return m
end function __DARKLUA_BUNDLE_MODULES.g():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.g if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.g=v end return v.c end end do local function __modImpl()
local m = {}
local controls = __DARKLUA_BUNDLE_MODULES.f()
local types = __DARKLUA_BUNDLE_MODULES.b()

function m.new(owner: Container__DARKLUA_TYPE_x, opts: ComponentOpts__DARKLUA_TYPE_f, callback, parent: GuiObject?): Textbox__DARKLUA_TYPE_z    
return controls.textbox(owner, opts, callback, parent)
end

return m
end function __DARKLUA_BUNDLE_MODULES.h():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.h if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.h=v end return v.c end end do local function __modImpl()
local m = {}
m.__index = m

local types = __DARKLUA_BUNDLE_MODULES.b()
local controls = __DARKLUA_BUNDLE_MODULES.f()
local lifecycle = __DARKLUA_BUNDLE_MODULES.e()

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

function m.new(owner: Container__DARKLUA_TYPE_x, opts: RowOpts__DARKLUA_TYPE_g?): Row__DARKLUA_TYPE_A    
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
    self.onRemove = function(index)
        if index then table.remove(self.componentWidths, index) end
        updateWidths(self)
    end
    self.scope:Connect(frame:GetPropertyChangedSignal("AbsoluteSize"), function() updateWidths(self) end)
    return self
end

function m:NewButton(opts: RowComponentOpts__DARKLUA_TYPE_h, callback): Button__DARKLUA_TYPE_y    
return add(self, controls.button(self, opts, callback, self.rowFrame), opts)
end

function m:NewTextbox(opts: RowComponentOpts__DARKLUA_TYPE_h, callback): Textbox__DARKLUA_TYPE_z    
return add(self, controls.textbox(self, opts, callback, self.rowFrame), opts)
end

return m
end function __DARKLUA_BUNDLE_MODULES.i():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.i if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.i=v end return v.c end end do local function __modImpl()
local m = {}
m.__index = m

local colors = __DARKLUA_BUNDLE_MODULES.a()
local lifecycle = __DARKLUA_BUNDLE_MODULES.e()

function m.new(owner, opts)
    opts = opts or {}
    local frame = Instance.new("ScrollingFrame")
    frame.Name = opts.text or "Console"
    frame.BackgroundColor3 = colors.console.background
    frame.BorderSizePixel = 0
    frame.Size = UDim2.new(1, 0, 0, opts.height or 200)
    frame.CanvasSize = UDim2.new()
    frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    frame.ScrollBarThickness = 6
    frame.ScrollingDirection = Enum.ScrollingDirection.Y
    frame.ZIndex = owner.contentFrame.ZIndex + 1
    frame.Parent = owner.contentFrame
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 8)
    padding.PaddingRight = UDim.new(0, 8)
    padding.PaddingTop = UDim.new(0, 8)
    padding.PaddingBottom = UDim.new(0, 8)
    padding.Parent = frame
    local self = lifecycle.attach(setmetatable({}, m), frame, owner)
    self.consoleFrame = frame
    self.entries = {}
    self.maxEntries = math.max(1, opts.maxEntries or 1000)
    self.autoScroll = opts.autoScroll ~= false
    self.paused = false
    self.order = 0
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = frame
    self.scope:Connect(layout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
        if self.autoScroll then
            frame.CanvasPosition = Vector2.new(0, math.max(0, layout.AbsoluteContentSize.Y + 16 - frame.AbsoluteSize.Y))
        end
    end)
    return self
end

function m:NewEntry(text: string, messageType: string)
    if self.paused or self.destroyed then return end
    local entry = Instance.new("TextLabel")
    entry.Name = "Entry"
    entry.BackgroundTransparency = 1
    entry.TextColor3 = colors.console[messageType] or colors.text
    entry.TextXAlignment = Enum.TextXAlignment.Left
    entry.TextYAlignment = Enum.TextYAlignment.Top
    entry.Font = Enum.Font.Code
    entry.TextSize = 14
    entry.TextWrapped = true
    entry.Text = text
    entry.Size = UDim2.new(1, -10, 0, 0)
    entry.AutomaticSize = Enum.AutomaticSize.Y
    self.order += 1
    entry.LayoutOrder = self.order
    entry.ZIndex = self.frame.ZIndex + 1
    entry.Parent = self.frame
    table.insert(self.entries, entry)
    if #self.entries > self.maxEntries then table.remove(self.entries, 1):Destroy() end
end

function m:Append(entries)
    for _, entry in entries do self:NewEntry(entry.text, entry.messageType or "info") end
end

function m:SetPaused(value: boolean)
    self.paused = value
end

function m:SetAutoScroll(value: boolean)
    self.autoScroll = value
end

function m:Clear()
    for _, entry in self.entries do entry:Destroy() end
    table.clear(self.entries)
    self.frame.CanvasPosition = Vector2.zero
end

return m
end function __DARKLUA_BUNDLE_MODULES.j():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.j if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.j=v end return v.c end end do local function __modImpl()
local m = {}
local lifecycle = __DARKLUA_BUNDLE_MODULES.e()

function m.new(owner, opts)
    opts = opts or {}
    local frame = Instance.new(if opts.scroll then "ScrollingFrame" else "Frame")
    frame.Name = opts.text or "Panel"
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = opts.clip ~= false
    frame.ZIndex = owner.contentFrame.ZIndex + 1
    frame.Position = opts.position or UDim2.new()
    frame.Size = opts.size or UDim2.new(1, 0, 0, opts.height or 200)
    if opts.auto then
        frame.Size = UDim2.new(1, 0, 0, 0)
        frame.AutomaticSize = Enum.AutomaticSize.Y
    end
    if opts.scroll then
        frame.CanvasSize = UDim2.new()
        frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        frame.ScrollingDirection = Enum.ScrollingDirection.Y
        frame.ScrollBarThickness = 6
    end
    if opts.minSize or opts.maxSize then
        local constraint = Instance.new("UISizeConstraint")
        if opts.minSize then constraint.MinSize = opts.minSize end
        if opts.maxSize then constraint.MaxSize = opts.maxSize end
        constraint.Parent = frame
    end
    frame.Parent = owner.contentFrame
    local self = lifecycle.attach({}, frame, owner)
    self.contentFrame = frame
    local padding = Instance.new("UIPadding")
    local inset = opts.padding or 8
    padding.PaddingLeft = UDim.new(0, inset)
    padding.PaddingRight = UDim.new(0, inset + (if opts.scroll then 8 else 0))
    padding.PaddingTop = UDim.new(0, inset)
    padding.PaddingBottom = UDim.new(0, inset)
    padding.Parent = frame
    if opts.layout ~= "none" then
        local layout = Instance.new("UIListLayout")
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, opts.gap or 6)
        layout.FillDirection = if opts.layout == "horizontal" then Enum.FillDirection.Horizontal else Enum.FillDirection.Vertical
        layout.Parent = frame
    end
    return self
end

return m
end function __DARKLUA_BUNDLE_MODULES.k():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.k if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.k=v end return v.c end end do local function __modImpl()
local m = {}

function m.scale(gui)
    local scale = 1
    while gui do
        for _, child in gui:GetChildren() do
            if child:IsA("UIScale") then scale *= child.Scale end
        end
        gui = gui.Parent
    end
    return math.max(0.001, scale)
end

function m.attach(scope, handle, started, moved)
    local input = game:GetService("UserInputService")
    local active, origin
    handle.Active = true
    scope:Connect(handle.InputBegan, function(event)
        if active then return end
        if event.UserInputType ~= Enum.UserInputType.MouseButton1 and event.UserInputType ~= Enum.UserInputType.Touch then return end
        active = event
        origin = Vector2.new(event.Position.X, event.Position.Y)
        started()
    end)
    scope:Connect(input.InputChanged, function(event)
        if not active then return end
        local mouse = active.UserInputType == Enum.UserInputType.MouseButton1
        if (mouse and event.UserInputType == Enum.UserInputType.MouseMovement) or event == active then
            moved(Vector2.new(event.Position.X, event.Position.Y) - origin)
        end
    end)
    scope:Connect(input.InputEnded, function(event)
        if event == active then active = nil end
    end)
    scope:Connect(input.WindowFocusReleased, function() active = nil end)
end

return m
end function __DARKLUA_BUNDLE_MODULES.l():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.l if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.l=v end return v.c end end do local function __modImpl()
local m = {}
local lifecycle = __DARKLUA_BUNDLE_MODULES.e()
local colors = __DARKLUA_BUNDLE_MODULES.a()
local dragUtil = __DARKLUA_BUNDLE_MODULES.l()

function m.new(owner, opts)
    opts = opts or {}
    local frame = Instance.new("Frame")
    frame.Name = "SplitPane"
    frame.BackgroundTransparency = 1
    frame.Size = opts.size or UDim2.new(1, 0, 0, opts.height or 320)
    frame.ZIndex = owner.contentFrame.ZIndex + 1
    frame.Parent = owner.contentFrame
    local self = lifecycle.attach({}, frame, owner)
    self.ratio = opts.ratio or 0.5
    local vertical = opts.vertical or false
    local first = Instance.new("Frame")
    first.Name = "First"
    first.BackgroundTransparency = 1
    first.ZIndex = frame.ZIndex + 1
    first.Parent = frame
    local second = first:Clone()
    second.Name = "Second"
    second.Parent = frame
    self.first = lifecycle.attach({ contentFrame = first }, first, self)
    self.second = lifecycle.attach({ contentFrame = second }, second, self)
    self.components = { self.first, self.second }
    local divider = Instance.new("Frame")
    divider.BackgroundColor3 = colors.sectionHeader
    divider.BorderSizePixel = 0
    divider.ZIndex = frame.ZIndex + 2
    divider.Parent = frame

    function self:SetRatio(value: number)
        local scale = dragUtil.scale(frame)
        local length = (if vertical then frame.AbsoluteSize.Y else frame.AbsoluteSize.X) / scale
        local minimum = math.min(opts.minSize or 80, math.max(0, (length - 6) / 2))
        local available = math.max(0, length - 6)
        local position = math.clamp(available * value, minimum, math.max(minimum, available - minimum))
        self.ratio = if available > 0 then position / available else value
        if vertical then
            first.Size = UDim2.new(1, 0, 0, position)
            divider.Position = UDim2.fromOffset(0, position)
            divider.Size = UDim2.new(1, 0, 0, 6)
            second.Position = UDim2.fromOffset(0, position + 6)
            second.Size = UDim2.new(1, 0, 1, -position - 6)
        else
            first.Size = UDim2.new(0, position, 1, 0)
            divider.Position = UDim2.fromOffset(position, 0)
            divider.Size = UDim2.new(0, 6, 1, 0)
            second.Position = UDim2.fromOffset(position + 6, 0)
            second.Size = UDim2.new(1, -position - 6, 1, 0)
        end
    end

    local start, scale, available
    dragUtil.attach(self.scope, divider, function()
        scale = dragUtil.scale(frame)
        local length = (if vertical then frame.AbsoluteSize.Y else frame.AbsoluteSize.X) / scale
        available = math.max(1, length - 6)
        start = self.ratio * available
    end, function(delta)
        local offset = (if vertical then delta.Y else delta.X) / scale
        self:SetRatio((start + offset) / available)
    end)
    self.scope:Connect(frame:GetPropertyChangedSignal("AbsoluteSize"), function() self:SetRatio(self.ratio) end)
    self:SetRatio(self.ratio)
    return self
end

return m
end function __DARKLUA_BUNDLE_MODULES.m():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.m if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.m=v end return v.c end end do local function __modImpl()
local m = {}
m.__index = m

local colors = __DARKLUA_BUNDLE_MODULES.a()
local ui = __DARKLUA_BUNDLE_MODULES.c()
local lifecycle = __DARKLUA_BUNDLE_MODULES.e()
local scope = __DARKLUA_BUNDLE_MODULES.d()

local function render(self)
    if self.destroyed then return end
    self.renderScope:Destroy()
    self.renderScope = scope.new()
    for _, frame in self.rows do frame:Destroy() end
    table.clear(self.rows)
    local fixed, flexible = 0, 0
    for _, column in self.columns do
        if column.width then fixed += column.width else flexible += 1 end
    end
    local available = math.max(0, self.viewport.AbsoluteSize.X - 8)
    local fillWidth = if flexible > 0 then math.max(60, (available - fixed) / flexible) else 0
    self.widths = {}
    self.width = 0
    for i, column in self.columns do
        self.widths[i] = column.width or fillWidth
        self.width += self.widths[i]
    end
    local offset = 0
    for i, header in self.headers do
        header.Position = UDim2.fromOffset(offset - self.viewport.CanvasPosition.X, 0)
        header.Size = UDim2.fromOffset(self.widths[i], 28)
        offset += self.widths[i]
    end
    local height = self.rowHeight
    local first = math.max(1, math.floor(self.viewport.CanvasPosition.Y / height) + 1)
    local count = math.ceil(self.viewport.AbsoluteSize.Y / height) + 2
    self.viewport.CanvasSize = UDim2.fromOffset(if self.width > available then self.width else 0, #self.filtered * height)
    for index = first, math.min(#self.filtered, first + count) do
        local record = self.filtered[index]
        local row = Instance.new("Frame")
        row.Size = UDim2.fromOffset(math.max(self.width, self.viewport.AbsoluteSize.X - 8), height)
        row.Position = UDim2.fromOffset(0, (index - 1) * height)
        row.BackgroundColor3 = if record.id == self.selectedId then colors.sectionHeader else colors.section
        row.BorderSizePixel = 0
        row.ClipsDescendants = true
        row.ZIndex = self.viewport.ZIndex + 1
        row.Parent = self.viewport
        table.insert(self.rows, row)
        local offset = 0
        for i, column in self.columns do
            local value = record.values[column.key]
            local cell = ui.createButton(row, { text = if value == nil then "" else tostring(value) })
            cell.TextXAlignment = Enum.TextXAlignment.Left
            cell.TextTruncate = Enum.TextTruncate.AtEnd
            cell.BackgroundTransparency = 1
            cell.BorderSizePixel = 0
            cell.Position = UDim2.fromOffset(offset, 0)
            cell.Size = UDim2.new(0, self.widths[i], 1, 0)
            self.renderScope:Connect(cell.MouseButton1Click, function() self:Select(record.id) end)
            local padding = Instance.new("UIPadding")
            padding.PaddingLeft = UDim.new(0, 8)
            padding.PaddingRight = UDim.new(0, 8)
            padding.Parent = cell
            offset += self.widths[i]
        end
    end
end

function m.new(owner, opts)
    opts = opts or {}
    local frame = Instance.new("Frame")
    frame.Name = opts.text or "List"
    frame.BackgroundColor3 = colors.console.background
    frame.BorderSizePixel = 0
    frame.Size = opts.size or UDim2.new(1, 0, 0, opts.height or 240)
    frame.ZIndex = owner.contentFrame.ZIndex + 1
    frame.Parent = owner.contentFrame
    local self = lifecycle.attach(setmetatable({}, m), frame, owner)
    self.records = {}
    self.filtered = {}
    self.rows = {}
    self.headers = {}
    self.columns = opts.columns or { { key = "text", text = "Text" } }
    self.rowHeight = math.max(16, opts.rowHeight or 26)
    self.maxRecords = math.max(1, opts.maxRecords or 5000)
    self.filter = ""
    self.renderScope = scope.new()
    self.selected = lifecycle.event(self)
    self.scope:Add(function() self.renderScope:Destroy() end)
    local viewport = Instance.new("ScrollingFrame")
    viewport.BackgroundTransparency = 1
    viewport.BorderSizePixel = 0
    viewport.Position = UDim2.fromOffset(8, 42)
    viewport.Size = UDim2.new(1, -16, 1, -50)
    viewport.CanvasSize = UDim2.new()
    viewport.ScrollBarThickness = 6
    viewport.ZIndex = frame.ZIndex + 1
    viewport.Parent = frame
    self.viewport = viewport
    local headerFrame = Instance.new("Frame")
    headerFrame.BackgroundTransparency = 1
    headerFrame.ClipsDescendants = true
    headerFrame.Position = UDim2.fromOffset(8, 8)
    headerFrame.Size = UDim2.new(1, -24, 0, 28)
    headerFrame.ZIndex = frame.ZIndex + 1
    headerFrame.Parent = frame
    local offset = 0
    for _, column in self.columns do
        local header = ui.createButton(headerFrame, { text = column.text or column.key })
        table.insert(self.headers, header)
        header.Position = UDim2.fromOffset(offset, 0)
        header.Size = UDim2.fromOffset(column.width or 120, 28)
        header.TextXAlignment = Enum.TextXAlignment.Left
        local padding = Instance.new("UIPadding")
        padding.PaddingLeft = UDim.new(0, 8)
        padding.PaddingRight = UDim.new(0, 8)
        padding.Parent = header
        self.scope:Connect(header.MouseButton1Click, function()
            self:SetSort(column.key, self.sortKey ~= column.key or not self.ascending)
        end)
        offset += column.width or 120
    end
    self.width = offset
    render(self)
    self.scope:Connect(viewport:GetPropertyChangedSignal("CanvasPosition"), function() render(self) end)
    self.scope:Connect(viewport:GetPropertyChangedSignal("AbsoluteSize"), function() render(self) end)
    return self
end

function m:Refresh()
    table.clear(self.filtered)
    for _, record in self.records do
        local matches = self.filter == ""
        for _, value in record.values do
            if string.find(string.lower(tostring(value)), self.filter, 1, true) then matches = true end
        end
        if matches then table.insert(self.filtered, record) end
    end
    if self.sortKey then
        table.sort(self.filtered, function(a, b)
            local av, bv = a.values[self.sortKey], b.values[self.sortKey]
            if type(av) ~= "number" or type(bv) ~= "number" then
                av, bv = tostring(av or ""), tostring(bv or "")
            end
            return if self.ascending then av < bv else av > bv
        end)
    end
    local selected
    for _, record in self.filtered do if record.id == self.selectedId then selected = record end end
    if self.selectedId and not selected then
        self.selectedId = nil
        self.selectedRecord = nil
        self.selected:Fire(nil)
    end
    if selected and selected ~= self.selectedRecord then
        self.selectedRecord = selected
        self.selected:Fire(selected)
    end
    self.viewport.CanvasPosition = Vector2.new(self.viewport.CanvasPosition.X, math.min(self.viewport.CanvasPosition.Y,
        math.max(0, #self.filtered * self.rowHeight - self.viewport.AbsoluteSize.Y)))
    render(self)
end

function m:SetRecords(records)
    local seen = {}
    local nextRecords = {}
    local start = math.max(1, #records - self.maxRecords + 1)
    for i, record in records do
        assert(type(record.id) == "string" or type(record.id) == "number", "list records need ids")
        assert(not seen[record.id], "list records need unique ids")
        assert(type(record.values) == "table", "list records need values")
        seen[record.id] = true
        if i >= start then table.insert(nextRecords, record) end
    end
    self.records = nextRecords
    self:Refresh()
end

function m:Append(records)
    local nextRecords = table.clone(self.records)
    local positions = {}
    for i, record in nextRecords do positions[record.id] = i end
    for _, record in records do
        assert(record.id ~= nil, "list records need ids")
        local index = positions[record.id]
        if index then
            nextRecords[index] = record
        else
            table.insert(nextRecords, record)
            positions[record.id] = #nextRecords
        end
    end
    self:SetRecords(nextRecords)
end

function m:SetFilter(value: string)
    self.filter = string.lower(value)
    self:Refresh()
end

function m:SetSort(key: string, ascending: boolean?)
    self.sortKey = key
    self.ascending = ascending ~= false
    self:Refresh()
end

function m:Select(id)
    for _, record in self.filtered do
        if record.id == id then
            self.selectedId = id
            self.selectedRecord = record
            render(self)
            self.selected:Fire(record)
            return
        end
    end
end

function m:OnSelected(callback)
    return self.scope:Connect(self.selected.Event, callback)
end

function m:Clear()
    self:SetRecords({})
end

return m
end function __DARKLUA_BUNDLE_MODULES.n():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.n if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.n=v end return v.c end end do local function __modImpl()
local m = {}
m.__index = m

local colors = __DARKLUA_BUNDLE_MODULES.a()
local ui = __DARKLUA_BUNDLE_MODULES.c()
local lifecycle = __DARKLUA_BUNDLE_MODULES.e()
local scope = __DARKLUA_BUNDLE_MODULES.d()

local function validate(nodes, loaded)
    local seen = {}
    local function visit(children, ancestors)
        for _, node in children do
            if not ancestors[node] then
                assert(type(node.id) == "string" or type(node.id) == "number", "tree nodes need ids")
                assert(not seen[node.id], "tree nodes need unique ids")
                seen[node.id] = true
                local path = table.clone(ancestors)
                path[node] = true
                visit(loaded[node.id] or node.children or {}, path)
            end
        end
    end
    visit(nodes, {})
end

local function flatten(self)
    self.visibleNodes = {}
    local function visit(nodes, depth, ancestors)
        if depth > self.maxDepth then return end
        for _, node in nodes do
            if not ancestors[node] then
                table.insert(self.visibleNodes, { node = node, depth = depth })
                if self.expanded[node.id] then
                    local path = table.clone(ancestors)
                    path[node] = true
                    visit(self.loaded[node.id] or node.children or {}, depth + 1, path)
                end
            end
        end
    end
    visit(self.nodes, 0, {})
end

local function render(self)
    if self.destroyed then return end
    self.renderScope:Destroy()
    self.renderScope = scope.new()
    for _, row in self.rows do row:Destroy() end
    table.clear(self.rows)
    flatten(self)
    self.emptyLabel.Visible = #self.visibleNodes == 0
    self.frame.CanvasSize = UDim2.fromOffset(0, #self.visibleNodes * 34 + 16)
    local first = math.max(1, math.floor(self.frame.CanvasPosition.Y / 34) + 1)
    local count = math.ceil(self.frame.AbsoluteSize.Y / 34) + 2
    for i = first, math.min(#self.visibleNodes, first + count) do
        local entry = self.visibleNodes[i]
        local node = entry.node
        local canExpand = node.loadChildren ~= nil or (node.children ~= nil and #node.children > 0)
        local indent = entry.depth * 16
        local row = Instance.new("Frame")
        row.Name = "Node"
        row.BackgroundTransparency = 1
        row.BorderSizePixel = 0
        row.Position = UDim2.fromOffset(8 + indent, 8 + (i - 1) * 34)
        row.Size = UDim2.new(1, -24 - indent, 0, 28)
        row.ZIndex = self.frame.ZIndex + 1
        row.Parent = self.frame
        local button = ui.createButton(row, { text = node.text })
        button.TextXAlignment = Enum.TextXAlignment.Left
        button.TextTruncate = Enum.TextTruncate.AtEnd
        button.BackgroundTransparency = if canExpand or node.id == self.selectedId then 0 else 1
        button.BorderSizePixel = if canExpand then 1 else 0
        local padding = Instance.new("UIPadding")
        padding.PaddingLeft = UDim.new(0, 8)
        padding.PaddingRight = UDim.new(0, if canExpand then 88 else 8)
        padding.Parent = button
        if canExpand then
            local state = Instance.new("TextLabel")
            state.Name = "State"
            state.BackgroundTransparency = 1
            state.Size = UDim2.fromOffset(80, 28)
            state.Position = UDim2.new(1, -84, 0, 0)
            state.Text = if self.expanded[node.id] then "Collapse ^" else "Expand v"
            state.TextColor3 = colors.text
            state.Font = button.Font
            state.TextSize = button.TextSize
            state.ZIndex = button.ZIndex + 1
            state.Parent = row
        end
        table.insert(self.rows, row)
        self.renderScope:Connect(button.MouseButton1Click, function()
            if canExpand then self:Expand(node.id, not self.expanded[node.id]) end
            self:Select(node.id)
        end)
    end
end

function m.new(owner, opts)
    opts = opts or {}
    local frame = Instance.new("ScrollingFrame")
    frame.Name = opts.text or "Tree"
    frame.BackgroundColor3 = colors.console.background
    frame.BorderSizePixel = 0
    frame.Size = opts.size or UDim2.new(1, 0, 0, opts.height or 240)
    frame.CanvasSize = UDim2.new()
    frame.ScrollBarThickness = 6
    frame.ZIndex = owner.contentFrame.ZIndex + 1
    frame.Parent = owner.contentFrame
    local self = lifecycle.attach(setmetatable({}, m), frame, owner)
    self.nodes = {}
    self.expanded = {}
    self.loaded = {}
    self.rows = {}
    self.maxDepth = opts.maxDepth or 32
    local empty = Instance.new("TextLabel")
    empty.Name = "Empty"
    empty.BackgroundTransparency = 1
    empty.Size = UDim2.new(1, -16, 0, 28)
    empty.Position = UDim2.fromOffset(8, 8)
    empty.Text = opts.emptyText or "No items"
    empty.TextXAlignment = Enum.TextXAlignment.Left
    empty.TextColor3 = colors.text
    empty.TextTransparency = 0.35
    empty.TextSize = 14
    empty.ZIndex = frame.ZIndex + 1
    empty.Parent = frame
    self.emptyLabel = empty
    self.renderScope = scope.new()
    self.selected = lifecycle.event(self)
    self.scope:Add(function() self.renderScope:Destroy() end)
    self.scope:Connect(frame:GetPropertyChangedSignal("CanvasPosition"), function() render(self) end)
    self.scope:Connect(frame:GetPropertyChangedSignal("AbsoluteSize"), function() render(self) end)
    return self
end

function m:SetNodes(nodes)
    validate(nodes, {})
    self.nodes = nodes
    self.expanded = {}
    self.loaded = {}
    local hadSelection = self.selectedId ~= nil
    self.selectedId = nil
    self.frame.CanvasPosition = Vector2.zero
    render(self)
    if hadSelection then self.selected:Fire(nil) end
end

function m:Expand(id, value: boolean)
    flatten(self)
    for _, entry in self.visibleNodes do
        local node = entry.node
        if node.id == id then
            if value and node.loadChildren and not self.loaded[id] then
                local ok, children = pcall(node.loadChildren)
                if not ok then warn(children) return end
                local nextLoaded = table.clone(self.loaded)
                nextLoaded[id] = children or {}
                local valid, err = pcall(validate, self.nodes, nextLoaded)
                if not valid then warn(err) return end
                self.loaded = nextLoaded
            end
            self.expanded[id] = value
            render(self)
            return
        end
    end
end

function m:Select(id)
    flatten(self)
    for _, entry in self.visibleNodes do
        if entry.node.id == id then
            self.selectedId = id
            render(self)
            self.selected:Fire(entry.node)
            return
        end
    end
end

function m:OnSelected(callback)
    return self.scope:Connect(self.selected.Event, callback)
end

function m:Clear()
    self:SetNodes({})
end

return m
end function __DARKLUA_BUNDLE_MODULES.o():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.o if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.o=v end return v.c end end do local function __modImpl()
local m = {}
local ui = __DARKLUA_BUNDLE_MODULES.c()
local lifecycle = __DARKLUA_BUNDLE_MODULES.e()
local colors = __DARKLUA_BUNDLE_MODULES.a()

function m.new(owner, opts)
    opts = opts or {}
    local frame = Instance.new("ScrollingFrame")
    frame.Name = "TextViewer"
    frame.BackgroundColor3 = colors.console.background
    frame.BorderSizePixel = 0
    frame.Size = opts.size or UDim2.new(1, 0, 0, opts.height or 200)
    frame.CanvasSize = UDim2.new()
    frame.AutomaticCanvasSize = Enum.AutomaticSize.XY
    frame.ScrollBarThickness = 6
    frame.ZIndex = owner.contentFrame.ZIndex + 1
    frame.Parent = owner.contentFrame
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 8)
    padding.PaddingRight = UDim.new(0, 8)
    padding.PaddingTop = UDim.new(0, 8)
    padding.PaddingBottom = UDim.new(0, 8)
    padding.Parent = frame
    local self = lifecycle.attach({}, frame, owner)
    local text = ui.createTextbox(frame, { text = "" })
    text.BackgroundTransparency = 1
    text.BorderSizePixel = 0
    text.ClearTextOnFocus = false
    text.MultiLine = true
    text.TextEditable = opts.editable == true
    text.TextWrapped = false
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.TextYAlignment = Enum.TextYAlignment.Top
    text.Font = Enum.Font.Code
    text.TextSize = 14
    text.Size = UDim2.fromOffset(1, 20)
    text.AutomaticSize = Enum.AutomaticSize.XY
    self.textbox = text
    local changed = lifecycle.event(self)
    self.scope:Connect(text:GetPropertyChangedSignal("Text"), function() changed:Fire(text.Text) end)

    function self:SetText(value: string)
        text.Text = value
    end

    function self:GetText(): string
        return text.Text
    end

    function self:OnChanged(callback)
        return self.scope:Connect(changed.Event, callback)
    end

    function self:Clear()
        text.Text = ""
    end

    self:SetText(opts.text or "")
    return self
end

return m
end function __DARKLUA_BUNDLE_MODULES.p():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.p if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.p=v end return v.c end end do local function __modImpl()
local m = {}
local controls = __DARKLUA_BUNDLE_MODULES.f()
local lifecycle = __DARKLUA_BUNDLE_MODULES.e()

function m.new(owner, opts, callback)
    local self = controls.button(owner, opts)
    self.value = opts.value or false
    local changed = lifecycle.event(self)

    function self:SetValue(value: boolean)
        if self.value == value then return end
        self.value = value
        self.button.Text = (if value then "[x] " else "[ ] ") .. opts.text
        if callback then callback(value) end
        changed:Fire(value)
    end

    function self:GetValue(): boolean
        return self.value
    end

    function self:OnChanged(fn)
        return self.scope:Connect(changed.Event, fn)
    end

    self.callback = function() self:SetValue(not self.value) end
    self.button.Text = (if self.value then "[x] " else "[ ] ") .. opts.text
    return self
end

return m
end function __DARKLUA_BUNDLE_MODULES.q():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.q if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.q=v end return v.c end end do local function __modImpl()
local m = {}
local colors = __DARKLUA_BUNDLE_MODULES.a()

function m.attach(self, popup, anchor)
    popup.Parent = self.frame
    popup.Position = UDim2.fromOffset(8, 34)
    popup.BackgroundTransparency = 0
    popup.BackgroundColor3 = colors.console.background
    popup.BorderSizePixel = 1
    popup.BorderColor3 = colors.sectionHeader
    anchor.TextXAlignment = Enum.TextXAlignment.Left
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 8)
    padding.PaddingRight = UDim.new(0, 76)
    padding.Parent = anchor
    local state = Instance.new("TextLabel")
    state.Name = "State"
    state.BackgroundTransparency = 1
    state.Size = UDim2.fromOffset(64, 28)
    state.Position = UDim2.new(1, -72, 0, 0)
    state.TextColor3 = colors.text
    state.Font = anchor.Font
    state.TextSize = anchor.TextSize
    state.ZIndex = anchor.ZIndex + 1
    state.Parent = self.frame
    self.stateLabel = state
    local input = game:GetService("UserInputService")
    local run = game:GetService("RunService")

    local function visible()
        local current = anchor
        while current do
            if current:IsA("GuiObject") and not current.Visible then return false end
            if current:IsA("ScreenGui") and not current.Enabled then return false end
            current = current.Parent
        end
        return true
    end

    function self:SetOpen(value: boolean)
        self.open = value and self.enabled ~= false and popup.Size.Y.Offset > 0 and visible()
        popup.Visible = self.open
        state.Text = if self.open then "Close ^" else "Open v"
        self.frame.Size = UDim2.new(self.frame.Size.X.Scale, self.frame.Size.X.Offset, 0,
            if self.open then 34 + popup.Size.Y.Offset else 28)
        if self.updateText then self.updateText() end
    end

    self:SetOpen(false)
    self.scope:Connect(run.RenderStepped, function()
        if self.open and not visible() then self:SetOpen(false) end
    end)
    self.scope:Connect(input.InputBegan, function(key)
        if self.open and key.KeyCode == Enum.KeyCode.Escape then self:SetOpen(false) end
    end)
end

return m
end function __DARKLUA_BUNDLE_MODULES.r():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.r if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.r=v end return v.c end end do local function __modImpl()
local m = {}
local colors = __DARKLUA_BUNDLE_MODULES.a()
local ui = __DARKLUA_BUNDLE_MODULES.c()
local lifecycle = __DARKLUA_BUNDLE_MODULES.e()
local scope = __DARKLUA_BUNDLE_MODULES.d()
local popupUtil = __DARKLUA_BUNDLE_MODULES.r()

function m.new(owner, opts, callback)
    local frame = Instance.new("Frame")
    frame.Name = opts.text
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, 28)
    frame.ZIndex = owner.contentFrame.ZIndex + 1
    frame.Parent = owner.contentFrame
    local self = lifecycle.attach({}, frame, owner)
    self.options = opts.options or {}
    self.value = opts.value
    self.items = {}
    self.open = false
    self.enabled = true
    local button = ui.createButton(frame, opts)
    self.button = button
    local popup = Instance.new("ScrollingFrame")
    popup.BackgroundTransparency = 1
    popup.BorderSizePixel = 0
    popup.Size = UDim2.new(1, 0, 0, math.min(180, math.max(0, #self.options * 34 - 6)))
    popup.Position = UDim2.fromOffset(0, 28)
    popup.ZIndex = frame.ZIndex + 1
    popup.Visible = false
    popup.ScrollBarThickness = 6
    popup.CanvasSize = UDim2.fromOffset(0, #self.options * 28)
    popup.Parent = frame
    local changed = lifecycle.event(self)
    self.optionScope = scope.new()
    self.scope:Add(function() self.optionScope:Destroy() end)

    self.updateText = function()
        button.Text = opts.text .. (if self.value then ": " .. self.value else ": select")
        for _, item in self.items do
            local selected = item.value == self.value
            item.button.Text = item.value .. (if selected then "  (selected)" else "")
            item.button.BackgroundColor3 = if selected then colors.sectionHeader else colors.component
        end
    end
    popupUtil.attach(self, popup, button)

    function self:SetValue(value: string?)
        assert(value == nil or table.find(self.options, value), "unknown dropdown value")
        local different = self.value ~= value
        self.value = value
        self:SetOpen(false)
        if different then
            if callback then callback(value) end
            changed:Fire(value)
        end
    end

    function self:GetValue()
        return self.value
    end

    function self:SetEnabled(value: boolean)
        self.enabled = value
        button.Active = value
        button.AutoButtonColor = value
        if not value then self:SetOpen(false) end
    end

    function self:SetOptions(options)
        self.optionScope:Destroy()
        self.optionScope = scope.new()
        for _, child in popup:GetChildren() do child:Destroy() end
        self.items = {}
        self.options = table.clone(options)
        local height = if #options > 0 then #options * 34 + 10 else 0
        popup.CanvasSize = UDim2.fromOffset(0, height)
        popup.Size = UDim2.new(1, -16, 0, math.min(180, height))
        popup.ScrollBarThickness = if height > 180 then 6 else 0
        for i, value in options do
            local item = ui.createButton(popup, { text = value }, popup.ZIndex + 1)
            item.Position = UDim2.fromOffset(8, 8 + (i - 1) * 34)
            item.Size = UDim2.new(1, if height > 180 then -24 else -16, 0, 28)
            item.TextXAlignment = Enum.TextXAlignment.Left
            local padding = Instance.new("UIPadding")
            padding.PaddingLeft = UDim.new(0, 8)
            padding.PaddingRight = UDim.new(0, 8)
            padding.Parent = item
            table.insert(self.items, { button = item, value = value })
            self.optionScope:Connect(item.MouseButton1Click, function() if self.enabled then self:SetValue(value) end end)
        end
        self:SetValue(if table.find(options, self.value) then self.value else nil)
    end

    function self:OnChanged(fn)
        return self.scope:Connect(changed.Event, fn)
    end

    self.scope:Connect(button.MouseButton1Click, function() self:SetOpen(not self.open) end)
    self.scope:Connect(frame:GetPropertyChangedSignal("Visible"), function()
        if not frame.Visible then self:SetOpen(false) end
    end)
    self:SetOptions(self.options)
    return self
end

return m
end function __DARKLUA_BUNDLE_MODULES.s():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.s if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.s=v end return v.c end end do local function __modImpl()
local m = {}
local ui = __DARKLUA_BUNDLE_MODULES.c()
local lifecycle = __DARKLUA_BUNDLE_MODULES.e()
local popupUtil = __DARKLUA_BUNDLE_MODULES.r()

function m.new(owner, opts)
    local frame = Instance.new("Frame")
    frame.Name = opts.text
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, 28)
    frame.ZIndex = owner.contentFrame.ZIndex + 1
    frame.Parent = owner.contentFrame
    local self = lifecycle.attach({ enabled = true }, frame, owner)
    local button = ui.createButton(frame, opts)
    self.button = button
    local text = opts.text
    self.updateText = function()
        button.Text = text
    end
    local popup = Instance.new("Frame")
    popup.BackgroundTransparency = 1
    popup.BorderSizePixel = 0
    popup.Size = UDim2.new(1, -16, 0, if #opts.items > 0 then #opts.items * 34 + 10 else 0)
    popup.ZIndex = frame.ZIndex + 1
    popup.Visible = false
    popupUtil.attach(self, popup, button)
    for i, item in opts.items do
        local action = ui.createButton(popup, { text = item.text })
        action.Position = UDim2.fromOffset(8, 8 + (i - 1) * 34)
        action.Size = UDim2.new(1, -16, 0, 28)
        action.TextXAlignment = Enum.TextXAlignment.Left
        local padding = Instance.new("UIPadding")
        padding.PaddingLeft = UDim.new(0, 8)
        padding.PaddingRight = UDim.new(0, 8)
        padding.Parent = action
        action.Active = item.enabled ~= false
        action.TextTransparency = if item.enabled == false then 0.5 else 0
        self.scope:Connect(action.MouseButton1Click, function()
            if not self.enabled or item.enabled == false then return end
            self:SetOpen(false)
            item.callback()
        end)
    end

    function self:SetText(value: string)
        text = value
        self.updateText()
    end

    function self:SetEnabled(value: boolean)
        self.enabled = value
        button.Active = value
        button.AutoButtonColor = value
        button.TextTransparency = if value then 0 else 0.5
        if not value then self:SetOpen(false) end
    end

    self.callback = function() self:SetOpen(not self.open) end
    self.scope:Connect(button.MouseButton1Click, function()
        if self.enabled then self.callback() end
    end)
    return self
end

return m
end function __DARKLUA_BUNDLE_MODULES.t():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.t if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.t=v end return v.c end end do local function __modImpl()
local m = {}
local button = __DARKLUA_BUNDLE_MODULES.g()
local textbox = __DARKLUA_BUNDLE_MODULES.h()
local row = __DARKLUA_BUNDLE_MODULES.i()
local console = __DARKLUA_BUNDLE_MODULES.j()
local panel = __DARKLUA_BUNDLE_MODULES.k()
local split = __DARKLUA_BUNDLE_MODULES.m()
local list = __DARKLUA_BUNDLE_MODULES.n()
local tree = __DARKLUA_BUNDLE_MODULES.o()
local viewer = __DARKLUA_BUNDLE_MODULES.p()
local toggle = __DARKLUA_BUNDLE_MODULES.q()
local dropdown = __DARKLUA_BUNDLE_MODULES.s()
local menu = __DARKLUA_BUNDLE_MODULES.t()

function m.attach(self)
    local function add(component)
        self.nextOrder = (self.nextOrder or 0) + 1
        component.frame.LayoutOrder = self.nextOrder
        table.insert(self.components, component)
        return component
    end

    function self:NewButton(opts, callback)
        return add(button.new(self, opts, callback))
    end

    function self:NewTextbox(opts, callback)
        return add(textbox.new(self, opts, callback))
    end

    function self:NewRow(opts)
        return add(row.new(self, opts))
    end

    function self:NewConsole(opts)
        return add(console.new(self, opts))
    end

    function self:NewPanel(opts)
        return add(m.attach(panel.new(self, opts)))
    end

    function self:NewSplitPane(opts)
        local component = split.new(self, opts)
        m.attach(component.first)
        m.attach(component.second)
        return add(component)
    end

    function self:NewList(opts)
        return add(list.new(self, opts))
    end

    function self:NewTree(opts)
        return add(tree.new(self, opts))
    end

    function self:NewTextViewer(opts)
        return add(viewer.new(self, opts))
    end

    function self:NewToggle(opts, callback)
        return add(toggle.new(self, opts, callback))
    end

    function self:NewDropdown(opts, callback)
        return add(dropdown.new(self, opts, callback))
    end

    function self:NewMenu(opts)
        return add(menu.new(self, opts))
    end

    return self
end

return m
end function __DARKLUA_BUNDLE_MODULES.u():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.u if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.u=v end return v.c end end do local function __modImpl()
local m = {}
m.__index = m

local colors = __DARKLUA_BUNDLE_MODULES.a()
local types = __DARKLUA_BUNDLE_MODULES.b()
local container = __DARKLUA_BUNDLE_MODULES.u()
local lifecycle = __DARKLUA_BUNDLE_MODULES.e()

function m.new(tab: Tab__DARKLUA_TYPE_K, name: string, side: SectionSide__DARKLUA_TYPE_c, order: number): Section__DARKLUA_TYPE_J    
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
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 8)
    padding.PaddingRight = UDim.new(0, 8)
    padding.PaddingTop = UDim.new(0, 8)
    padding.PaddingBottom = UDim.new(0, 8)
    padding.Parent = content
    local function updateHeight()
        frame.Size = UDim2.new(1, 0, 0, 40 + layout.AbsoluteContentSize.Y)
    end
    self.scope:Connect(layout:GetPropertyChangedSignal("AbsoluteContentSize"), updateHeight)
    updateHeight()
    return container.attach(self)
end

return m
end function __DARKLUA_BUNDLE_MODULES.v():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.v if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.v=v end return v.c end end do local function __modImpl()
local m = {}
m.__index = m

local colors = __DARKLUA_BUNDLE_MODULES.a()

local types = __DARKLUA_BUNDLE_MODULES.b()
local section = __DARKLUA_BUNDLE_MODULES.v()
local container = __DARKLUA_BUNDLE_MODULES.u()
local lifecycle = __DARKLUA_BUNDLE_MODULES.e()

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

function m.new(window: Window__DARKLUA_TYPE_P, name: string, opts: TabOpts__DARKLUA_TYPE_L?): Tab__DARKLUA_TYPE_K    
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
        local function updateRowHeight()
            local height = math.max(leftLayout.AbsoluteContentSize.Y, rightLayout.AbsoluteContentSize.Y)
            row.Size = UDim2.new(1, 0, 0, height)
        end
        self.scope:Connect(leftLayout:GetPropertyChangedSignal("AbsoluteContentSize"), updateRowHeight)
        self.scope:Connect(rightLayout:GetPropertyChangedSignal("AbsoluteContentSize"), updateRowHeight)
        updateRowHeight()

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
    local destroy = self.Destroy
    function self:Destroy(skipFrame)
        local selected = window.currentTab == self
        if selected then window.currentTab = nil end
        destroy(self, skipFrame)
        if selected and not window.destroyed and #window.tabs > 0 then
            window:SelectTab(window.tabs[1])
        end
    end
    return self :: Tab__DARKLUA_TYPE_K
end

function m.NewSection(self: Tab__DARKLUA_TYPE_K, name: string, side: SectionSide__DARKLUA_TYPE_c?): Section__DARKLUA_TYPE_J    
local columnSide = side or "left"
    self.nextOrder = (self.nextOrder or 0) + 1
    local order = self.nextOrder
    local newSection = section.new(self, name, columnSide, order)
    table.insert(self.components, newSection)
    self.sections = self.components
    return newSection
end

function m.ShowCurrentTab(self: Tab__DARKLUA_TYPE_K): ()
    self.container.Visible = true
end

function m.HideCurrentTab(self: Tab__DARKLUA_TYPE_K): ()
    self.container.Visible = false
end

return m
end function __DARKLUA_BUNDLE_MODULES.w():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.w if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.w=v end return v.c end end do local function __modImpl()
local m = {}
m.__index = m

--local comps = script.Parent.Components

local colors = __DARKLUA_BUNDLE_MODULES.a()

local types = __DARKLUA_BUNDLE_MODULES.b()
local tab = __DARKLUA_BUNDLE_MODULES.w()

local lifecycle = __DARKLUA_BUNDLE_MODULES.e()
local dragUtil = __DARKLUA_BUNDLE_MODULES.l()

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

function m.new(opts: WindowOpts__DARKLUA_TYPE_M?): Window__DARKLUA_TYPE_P    
if g.simpleuiWindow then
        g.simpleuiWindow:Destroy()
    elseif g.ui then
        local screen = g.ui:FindFirstAncestorWhichIsA("ScreenGui")
        if screen then screen:Destroy() else g.ui:Destroy() end
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
    return self :: Window__DARKLUA_TYPE_P
end

function m.Show(self: Window__DARKLUA_TYPE_P): ()
    self.guis["ScreenGui"].Enabled = true
end

function m.Hide(self: Window__DARKLUA_TYPE_P): ()
    self.guis["ScreenGui"].Enabled = false
end

function m.Toggle(self: Window__DARKLUA_TYPE_P): ()
    self.guis["ScreenGui"].Enabled = not self.guis["ScreenGui"].Enabled
end

function m.NewTab(self: Window__DARKLUA_TYPE_P, name: string, opts: TabOpts__DARKLUA_TYPE_L?): Tab__DARKLUA_TYPE_K    
local newTab = tab.new(self, name, opts)
    table.insert(self.tabs, newTab)
    return newTab
end

function m.SelectTab(self: Window__DARKLUA_TYPE_P, tab: Tab__DARKLUA_TYPE_K): ()
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
end function __DARKLUA_BUNDLE_MODULES.x():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.x if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.x=v end return v.c end end end
local Window = __DARKLUA_BUNDLE_MODULES.x()
local tab = __DARKLUA_BUNDLE_MODULES.w()

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
local testRow = testSection9:NewRow({ text = "test row" })
testRow:NewButton({ text = "test row button", width = 120 }, function()
    print("test row button clicked")
end)
testRow:NewTextbox({ text = "test row textbox" }, function(value)
    print("test row textbox value: " .. value)
end)

window:SelectTab(testTab)
window:Show()

local searchRow = topSection:NewRow({ text = "Search", gap = 6 })
local function search(value: string)
    print("search: " .. value)
end
local searchInput = searchRow:NewTextbox({ text = "Search...", fill = true }, search)
searchRow:NewButton({ text = "Search", width = 70 }, function()
    search(searchInput.button.Text)
end)

local debugTab = window:NewTab("debug")
local tools = debugTab:NewSection("Search", "top")
local eventSection = debugTab:NewSection("Events", "left")
local argumentSection = debugTab:NewSection("Arguments", "right")
local codeSection = debugTab:NewSection("Code", "right")
local options = debugTab:NewSection("Options", "left")
local logSection = debugTab:NewSection("Logs", "bottom")
local events = eventSection:NewList({
    height = 220,
    columns = {
        { key = "name", text = "name" },
        { key = "count", text = "calls", width = 60 },
    },
})
local arguments = argumentSection:NewTree({ height = 120, emptyText = "Select an event to inspect its arguments" })
local code = codeSection:NewTextViewer({ height = 120, text = "select an event" })
local searchRow = tools:NewRow()
local filter = searchRow:NewTextbox({ text = "filter events" })
searchRow:NewButton({ text = "Clear", width = 70 }, function() events:Clear() end)
searchRow:NewButton({ text = "Sample", width = 70 }, function()
    events:Append({ { id = "sample", values = { name = "sample event", count = 3 } } })
end)
filter:OnChanged(function(value) events:SetFilter(value) end)
events:OnSelected(function(record)
    if not record then arguments:Clear() code:SetText("select an event") return end
    arguments:SetNodes({
        { id = "args", text = "arguments", loadChildren = function()
            return { { id = "value", text = "value = " .. record.values.count } }
        end },
    })
    code:SetText("print(" .. string.format("%q", record.values.name) .. ")")
end)
local history = logSection:NewConsole({ height = 100, maxEntries = 100 })
options:NewToggle({ text = "pause logs" }, function(value) history:SetPaused(value) end)
options:NewDropdown({ text = "level", options = { "info", "warning", "error" }, value = "info" }, function(value)
    history:NewEntry("level: " .. tostring(value), "info")
end)
options:NewMenu({ text = "actions", items = {
    { text = "clear logs", callback = function() history:Clear() end },
    { text = "sample log", callback = function() history:NewEntry("sample log", "info") end },
} })
events:SetRecords({
    { id = "one", values = { name = "first event", count = 12 } },
    { id = "two", values = { name = "second event", count = 4 } },
})
window:BindShortcut(Enum.KeyCode.F, function() filter:Focus() end, { ctrl = true })
