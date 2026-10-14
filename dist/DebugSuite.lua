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

type NotifyOpts__DARKLUA_TYPE_m = { text: string, messageType: ConsoleMessageType__DARKLUA_TYPE_k?, duration: number? }

type Notification__DARKLUA_TYPE_n = Component__DARKLUA_TYPE_e & { text: string, messageType: ConsoleMessageType__DARKLUA_TYPE_k }

type Syntax__DARKLUA_TYPE_o = "lua" | "luau" | false

type SyntaxTheme__DARKLUA_TYPE_p = {[string]: string}

type SyntaxToken__DARKLUA_TYPE_q = { kind: string, text: string, start: number, finish: number }

type ConsoleOpts__DARKLUA_TYPE_r = {
    text: string?, height: number?, maxEntries: number?, autoScroll: boolean?,
    syntax: Syntax__DARKLUA_TYPE_o?, syntaxTheme: SyntaxTheme__DARKLUA_TYPE_p?,
}

type Record__DARKLUA_TYPE_s = { id: string | number, values: {[string]: any}, data: any? }

type Column__DARKLUA_TYPE_t = { key: string, text: string?, width: number? }

type ListOpts__DARKLUA_TYPE_u = {
    text: string?, size: UDim2?, height: number?, columns: {Column__DARKLUA_TYPE_t}?,
    rowHeight: number?, maxRecords: number?,
}

type TreeNode__DARKLUA_TYPE_v = {
    id: string | number, text: string, data: any?, children: {TreeNode__DARKLUA_TYPE_v}?,
    loadChildren: (() -> {TreeNode__DARKLUA_TYPE_v})?,
}

type TreeOpts__DARKLUA_TYPE_w = { text: string?, size: UDim2?, height: number?, maxDepth: number?, emptyText: string? }

type TextViewerOpts__DARKLUA_TYPE_x = {
    text: string?, size: UDim2?, height: number?, editable: boolean?,
    syntax: Syntax__DARKLUA_TYPE_o?, syntaxTheme: SyntaxTheme__DARKLUA_TYPE_p?,
}

type ToggleOpts__DARKLUA_TYPE_y = { text: string, value: boolean? }

type DropdownOpts__DARKLUA_TYPE_z = { text: string, options: {string}, value: string? }

type MenuItem__DARKLUA_TYPE_A = { text: string, callback: () -> (), enabled: boolean? }

type MenuOpts__DARKLUA_TYPE_B = { text: string, items: {MenuItem__DARKLUA_TYPE_A} }

type Container__DARKLUA_TYPE_C = Component__DARKLUA_TYPE_e & {
    contentFrame: GuiObject,
    NewButton: (self: any, opts: ComponentOpts__DARKLUA_TYPE_f, callback: (() -> any)?) -> Button__DARKLUA_TYPE_D,
    NewTextbox: (self: any, opts: ComponentOpts__DARKLUA_TYPE_f, callback: ((string) -> any)?) -> Textbox__DARKLUA_TYPE_E,
    NewRow: (self: any, opts: RowOpts__DARKLUA_TYPE_g?) -> Row__DARKLUA_TYPE_F,
    NewConsole: (self: any, opts: ConsoleOpts__DARKLUA_TYPE_r?) -> Console__DARKLUA_TYPE_H,
    NewPanel: (self: any, opts: PanelOpts__DARKLUA_TYPE_i?) -> Container__DARKLUA_TYPE_C,
    NewSplitPane: (self: any, opts: SplitPaneOpts__DARKLUA_TYPE_j?) -> SplitPane__DARKLUA_TYPE_G,
    NewList: (self: any, opts: ListOpts__DARKLUA_TYPE_u?) -> List__DARKLUA_TYPE_I,
    NewTree: (self: any, opts: TreeOpts__DARKLUA_TYPE_w?) -> Tree__DARKLUA_TYPE_J,
    NewTextViewer: (self: any, opts: TextViewerOpts__DARKLUA_TYPE_x?) -> TextViewer__DARKLUA_TYPE_K,
    NewToggle: (self: any, opts: ToggleOpts__DARKLUA_TYPE_y, callback: ((boolean) -> ())?) -> Toggle__DARKLUA_TYPE_L,
    NewDropdown: (self: any, opts: DropdownOpts__DARKLUA_TYPE_z, callback: ((string?) -> ())?) -> Dropdown__DARKLUA_TYPE_M,
    NewMenu: (self: any, opts: MenuOpts__DARKLUA_TYPE_B) -> Menu__DARKLUA_TYPE_N,
}

type Button__DARKLUA_TYPE_D = Component__DARKLUA_TYPE_e & {
    button: TextButton,
    callback: (() -> any)?,
    SetText: (self: Button__DARKLUA_TYPE_D, value: string) -> (),
    SetEnabled: (self: Button__DARKLUA_TYPE_D, value: boolean) -> (),
}

type Textbox__DARKLUA_TYPE_E = Component__DARKLUA_TYPE_e & {
    button: TextBox,
    callback: ((string) -> any)?,
    GetValue: (self: Textbox__DARKLUA_TYPE_E) -> string,
    SetValue: (self: Textbox__DARKLUA_TYPE_E, value: string) -> (),
    SetPlaceholder: (self: Textbox__DARKLUA_TYPE_E, value: string) -> (),
    SetEnabled: (self: Textbox__DARKLUA_TYPE_E, value: boolean) -> (),
    Focus: (self: Textbox__DARKLUA_TYPE_E) -> (),
    OnChanged: (self: Textbox__DARKLUA_TYPE_E, callback: (string) -> ()) -> RBXScriptConnection,
    OnSubmitted: (self: Textbox__DARKLUA_TYPE_E, callback: (string) -> ()) -> RBXScriptConnection,
}

type Row__DARKLUA_TYPE_F = Component__DARKLUA_TYPE_e & {
    rowFrame: Frame,
    componentWidths: {number},
    gap: number,
    NewButton: (self: Row__DARKLUA_TYPE_F, opts: RowComponentOpts__DARKLUA_TYPE_h, callback: (() -> any)?) -> Button__DARKLUA_TYPE_D,
    NewTextbox: (self: Row__DARKLUA_TYPE_F, opts: RowComponentOpts__DARKLUA_TYPE_h, callback: ((string) -> any)?) -> Textbox__DARKLUA_TYPE_E,
}

type SplitPane__DARKLUA_TYPE_G = Component__DARKLUA_TYPE_e & {
    first: Container__DARKLUA_TYPE_C, second: Container__DARKLUA_TYPE_C, ratio: number,
    SetRatio: (self: SplitPane__DARKLUA_TYPE_G, value: number) -> (),
}

type Console__DARKLUA_TYPE_H = Component__DARKLUA_TYPE_e & {
    consoleFrame: ScrollingFrame,
    NewEntry: (self: Console__DARKLUA_TYPE_H, text: string, messageType: ConsoleMessageType__DARKLUA_TYPE_k) -> (),
    Append: (self: Console__DARKLUA_TYPE_H, entries: {ConsoleEntry__DARKLUA_TYPE_l}) -> (),
    SetPaused: (self: Console__DARKLUA_TYPE_H, value: boolean) -> (),
    SetAutoScroll: (self: Console__DARKLUA_TYPE_H, value: boolean) -> (),
}

type List__DARKLUA_TYPE_I = Component__DARKLUA_TYPE_e & {
    records: {Record__DARKLUA_TYPE_s}, selectedId: (string | number)?,
    SetRecords: (self: List__DARKLUA_TYPE_I, records: {Record__DARKLUA_TYPE_s}) -> (),
    Append: (self: List__DARKLUA_TYPE_I, records: {Record__DARKLUA_TYPE_s}) -> (),
    Refresh: (self: List__DARKLUA_TYPE_I) -> (),
    SetFilter: (self: List__DARKLUA_TYPE_I, value: string) -> (),
    SetSort: (self: List__DARKLUA_TYPE_I, key: string, ascending: boolean?) -> (),
    Select: (self: List__DARKLUA_TYPE_I, id: string | number) -> (),
    OnSelected: (self: List__DARKLUA_TYPE_I, callback: (Record__DARKLUA_TYPE_s?) -> ()) -> RBXScriptConnection,
}

type Tree__DARKLUA_TYPE_J = Component__DARKLUA_TYPE_e & {
    SetNodes: (self: Tree__DARKLUA_TYPE_J, nodes: {TreeNode__DARKLUA_TYPE_v}) -> (),
    Expand: (self: Tree__DARKLUA_TYPE_J, id: string | number, value: boolean) -> (),
    Select: (self: Tree__DARKLUA_TYPE_J, id: string | number) -> (),
    OnSelected: (self: Tree__DARKLUA_TYPE_J, callback: (TreeNode__DARKLUA_TYPE_v?) -> ()) -> RBXScriptConnection,
}

type TextViewer__DARKLUA_TYPE_K = Component__DARKLUA_TYPE_e & {
    textbox: TextBox,
    SetText: (self: TextViewer__DARKLUA_TYPE_K, value: string) -> (),
    GetText: (self: TextViewer__DARKLUA_TYPE_K) -> string,
    SetSyntax: (self: TextViewer__DARKLUA_TYPE_K, value: Syntax__DARKLUA_TYPE_o?) -> (),
    OnChanged: (self: TextViewer__DARKLUA_TYPE_K, callback: (string) -> ()) -> RBXScriptConnection,
}

type Toggle__DARKLUA_TYPE_L = Button__DARKLUA_TYPE_D & {
    SetValue: (self: Toggle__DARKLUA_TYPE_L, value: boolean) -> (),
    GetValue: (self: Toggle__DARKLUA_TYPE_L) -> boolean,
    OnChanged: (self: Toggle__DARKLUA_TYPE_L, callback: (boolean) -> ()) -> RBXScriptConnection,
}

type Dropdown__DARKLUA_TYPE_M = Component__DARKLUA_TYPE_e & {
    button: TextButton,
    SetOpen: (self: Dropdown__DARKLUA_TYPE_M, value: boolean) -> (),
    SetValue: (self: Dropdown__DARKLUA_TYPE_M, value: string?) -> (),
    GetValue: (self: Dropdown__DARKLUA_TYPE_M) -> string?,
    SetOptions: (self: Dropdown__DARKLUA_TYPE_M, options: {string}) -> (),
    SetEnabled: (self: Dropdown__DARKLUA_TYPE_M, value: boolean) -> (),
    OnChanged: (self: Dropdown__DARKLUA_TYPE_M, callback: (string?) -> ()) -> RBXScriptConnection,
}

type Menu__DARKLUA_TYPE_N = Button__DARKLUA_TYPE_D & { SetOpen: (self: Menu__DARKLUA_TYPE_N, value: boolean) -> () }

type Section__DARKLUA_TYPE_O = Container__DARKLUA_TYPE_C & { parentTab: Tab__DARKLUA_TYPE_P, sectionFrame: Frame }

type Tab__DARKLUA_TYPE_P = Container__DARKLUA_TYPE_C & {
    parentWindow: Window__DARKLUA_TYPE_W, tabBtn: TextButton, sections: {Component__DARKLUA_TYPE_e}, container: ScrollingFrame,
    columns: {left: Frame, right: Frame, top: Frame, bottom: Frame, full: Frame},
    NewSection: (self: Tab__DARKLUA_TYPE_P, name: string, side: SectionSide__DARKLUA_TYPE_c?) -> Section__DARKLUA_TYPE_O,
    ShowCurrentTab: (self: Tab__DARKLUA_TYPE_P) -> (), HideCurrentTab: (self: Tab__DARKLUA_TYPE_P) -> (),
}

type TabOpts__DARKLUA_TYPE_Q = { layout: ("sections" | "free")? }

type WindowOpts__DARKLUA_TYPE_R = { size: UDim2?, minSize: Vector2?, captureLogs: boolean? }

type FloatingWindowOpts__DARKLUA_TYPE_S = {
    name: string?, title: string?, size: UDim2?, position: UDim2?, minSize: Vector2?,
    visible: boolean?, closeBehavior: ("hide" | "destroy")?, backgroundColor: Color3?,
}

type FloatingWindow__DARKLUA_TYPE_T = Container__DARKLUA_TYPE_C & {
    guis: { ScreenGui: ScreenGui, Root: Frame, Topbar: Frame },
    Show: (self: FloatingWindow__DARKLUA_TYPE_T) -> (), Hide: (self: FloatingWindow__DARKLUA_TYPE_T) -> (),
    Toggle: (self: FloatingWindow__DARKLUA_TYPE_T) -> (), Focus: (self: FloatingWindow__DARKLUA_TYPE_T) -> (),
    AddTopbarButton: (self: FloatingWindow__DARKLUA_TYPE_T, name: string, text: string, callback: () -> (), width: number?) -> TextButton,
}

type WindowGuis__DARKLUA_TYPE_U = { ScreenGui: ScreenGui, Root: Frame, Topbar: Frame, Sidebar: ScrollingFrame }

type ShortcutOpts__DARKLUA_TYPE_V = { ctrl: boolean?, shift: boolean? }

type Window__DARKLUA_TYPE_W = {
    ctx: ctx__DARKLUA_TYPE_b, guis: WindowGuis__DARKLUA_TYPE_U, scope: Scope__DARKLUA_TYPE_d, conns: {RBXScriptConnection},
    currentTab: Tab__DARKLUA_TYPE_P?, tabs: {Tab__DARKLUA_TYPE_P},
    Show: (self: Window__DARKLUA_TYPE_W) -> (), Hide: (self: Window__DARKLUA_TYPE_W) -> (), Toggle: (self: Window__DARKLUA_TYPE_W) -> (),
    SetVisible: (self: Window__DARKLUA_TYPE_W, value: boolean) -> (),
    Clear: (self: Window__DARKLUA_TYPE_W) -> (), Destroy: (self: Window__DARKLUA_TYPE_W) -> (),
    NewTab: (self: Window__DARKLUA_TYPE_W, name: string, opts: TabOpts__DARKLUA_TYPE_Q?) -> Tab__DARKLUA_TYPE_P,
    NewWindow: (self: Window__DARKLUA_TYPE_W, opts: FloatingWindowOpts__DARKLUA_TYPE_S?) -> FloatingWindow__DARKLUA_TYPE_T,
    SelectTab: (self: Window__DARKLUA_TYPE_W, tab: Tab__DARKLUA_TYPE_P) -> (),
    OpenConsole: (self: Window__DARKLUA_TYPE_W) -> Console__DARKLUA_TYPE_H,
    Log: (self: Window__DARKLUA_TYPE_W, text: string, messageType: ConsoleMessageType__DARKLUA_TYPE_k?) -> (),
    Notify: (self: Window__DARKLUA_TYPE_W, opts: NotifyOpts__DARKLUA_TYPE_m) -> Notification__DARKLUA_TYPE_n?,
    BindShortcut: (self: Window__DARKLUA_TYPE_W, key: Enum.KeyCode, callback: () -> (), opts: ShortcutOpts__DARKLUA_TYPE_V?) -> RBXScriptConnection,
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

local function setVisible(self, value: boolean)
    self.frame.Visible = value
end

local function clear(self)
    while #self.components > 0 do
        self.components[#self.components]:Destroy()
    end
end

local function destroy(self, skipFrame)
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

function m.attach(self, frame, owner)
    self.frame = frame
    self.scope = scope.new()
    self.conns = self.scope.conns
    self.components = self.components or {}
    self.owner = owner
    self.destroyed = false

    self.SetVisible = setVisible
    if not self.Clear then self.Clear = clear end
    self.Destroy = destroy

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
local buttonMethods = {}
local textboxMethods = {}

function buttonMethods:SetText(value: string)
    self.button.Text = value
end

function buttonMethods:SetEnabled(value: boolean)
    self.enabled = value
    self.button.Active = value
    self.button.AutoButtonColor = value
    self.button.TextTransparency = if value then 0 else 0.5
end

function textboxMethods:GetValue(): string
    return self.button.Text
end

function textboxMethods:SetValue(value: string)
    self.button.Text = value
end

function textboxMethods:SetPlaceholder(value: string)
    self.button.PlaceholderText = value
end

function textboxMethods:SetEnabled(value: boolean)
    self.button.TextEditable = value
end

function textboxMethods:Focus()
    self.button:CaptureFocus()
end

function textboxMethods:OnChanged(callback)
    return self.scope:Connect(self.changed.Event, callback)
end

function textboxMethods:OnSubmitted(callback)
    return self.scope:Connect(self.submitted.Event, callback)
end

function m.button(owner, opts, callback, parent)
    local gui = ui.createButton(parent or owner.contentFrame, opts)
    local self = lifecycle.attach({ button = gui, callback = callback, enabled = true }, gui, owner)
    self.scope:Connect(gui.MouseButton1Click, function()
        if self.enabled and self.callback then self.callback() end
    end)
    for name, method in buttonMethods do self[name] = method end

    return self
end

function m.textbox(owner, opts, callback, parent)
    local gui = ui.createTextbox(parent or owner.contentFrame, opts)
    gui.ClearTextOnFocus = false
    local self = lifecycle.attach({ button = gui, callback = callback }, gui, owner)
    self.changed = lifecycle.event(self)
    self.submitted = lifecycle.event(self)
    self.scope:Connect(gui:GetPropertyChangedSignal("Text"), function()
        self.changed:Fire(gui.Text)
    end)
    self.scope:Connect(gui.FocusLost, function(enterPressed)
        if enterPressed then
            if self.callback then self.callback(gui.Text) end
            self.submitted:Fire(gui.Text)
        end
    end)
    for name, method in textboxMethods do self[name] = method end

    return self
end

return m
end function __DARKLUA_BUNDLE_MODULES.f():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.f if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.f=v end return v.c end end do local function __modImpl()
local m = {}
local controls = __DARKLUA_BUNDLE_MODULES.f()
local types = __DARKLUA_BUNDLE_MODULES.b()

function m.new(owner: Container__DARKLUA_TYPE_C, opts: ComponentOpts__DARKLUA_TYPE_f, callback, parent: GuiObject?): Button__DARKLUA_TYPE_D    
return controls.button(owner, opts, callback, parent)
end

return m
end function __DARKLUA_BUNDLE_MODULES.g():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.g if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.g=v end return v.c end end do local function __modImpl()
local m = {}
local controls = __DARKLUA_BUNDLE_MODULES.f()
local types = __DARKLUA_BUNDLE_MODULES.b()

function m.new(owner: Container__DARKLUA_TYPE_C, opts: ComponentOpts__DARKLUA_TYPE_f, callback, parent: GuiObject?): Textbox__DARKLUA_TYPE_E    
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

local function onRemove(self, index)
    if index then table.remove(self.componentWidths, index) end
    updateWidths(self)
end

function m.new(owner: Container__DARKLUA_TYPE_C, opts: RowOpts__DARKLUA_TYPE_g?): Row__DARKLUA_TYPE_F    
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
    self.onRemove = function(index) onRemove(self, index) end
    self.scope:Connect(frame:GetPropertyChangedSignal("AbsoluteSize"), function() updateWidths(self) end)
    return self
end

function m:NewButton(opts: RowComponentOpts__DARKLUA_TYPE_h, callback): Button__DARKLUA_TYPE_D    
return add(self, controls.button(self, opts, callback, self.rowFrame), opts)
end

function m:NewTextbox(opts: RowComponentOpts__DARKLUA_TYPE_h, callback): Textbox__DARKLUA_TYPE_E    
return add(self, controls.textbox(self, opts, callback, self.rowFrame), opts)
end

return m
end function __DARKLUA_BUNDLE_MODULES.i():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.i if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.i=v end return v.c end end do local function __modImpl()
local m = {}

m.theme = {
    keyword = "#C586C0", builtin = "#4EC9B0", string = "#CE9178",
    comment = "#6A9955", number = "#B5CEA8", operator = "#D4D4D4",
}

local function words(value)
    local result = {}
    for word in value:gmatch("%S+") do result[word] = true end
    return result
end

local keywords = words("and break do else elseif end false for function if in local nil not or repeat return then true until while continue")
local builtins = words("assert error ipairs next pairs pcall print rawequal rawget rawset select setmetatable getmetatable tonumber tostring type unpack xpcall collectgarbage require warn typeof game workspace script Enum Instance Color3 Vector2 Vector3 UDim UDim2 CFrame math string table coroutine utf8 os bit32 task buffer")
local operators = words("... .. ..= // //= == ~= <= >= += -= *= /= %= ^= :: ->")

function m.Escape(value: string): string
    local escaped = value:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
        :gsub('"', "&quot;"):gsub("'", "&apos;")
    return escaped
end

--skip to the end of a long string or comment
local function longBracket(source, position)
    local equals = source:sub(position):match("^%[(=*)%[")
    if not equals then return nil end
    local _, finish = source:find("]" .. equals .. "]", position + #equals + 2, true)
    return finish and finish + 1 or #source + 1
end

function m.Tokenize(source: string)
    local tokens = {}
    local position, length = 1, #source
    while position <= length do
        local start = position
        local char = source:sub(position, position)
        local kind
        if char:match("%s") then
            kind = "whitespace"
            repeat position += 1 until position > length or not source:sub(position, position):match("%s")
        elseif source:sub(position, position + 1) == "--" then
            kind = "comment"
            position = longBracket(source, position + 2) or source:find("[\r\n]", position + 2) or length + 1
        elseif char == '"' or char == "'" or char == "`" then
            kind = "string"
            position += 1
            while position <= length do
                local current = source:sub(position, position)
                if current == "\\" then
                    position = math.min(position + 2, length + 1)
                elseif current == char then
                    position += 1
                    break
                elseif char ~= "`" and (current == "\n" or current == "\r") then
                    break
                else
                    position += 1
                end
            end
        elseif char == "[" and longBracket(source, position) then
            kind = "string"
            position = longBracket(source, position)
        elseif char:match("[%a_]") then
            position += 1
            while position <= length and source:sub(position, position):match("[%w_]") do position += 1 end
            local word = source:sub(start, position - 1)
            kind = keywords[word] and "keyword" or builtins[word] and "builtin" or "identifier"
        elseif char:match("%d") or (char == "." and source:sub(position + 1, position + 1):match("%d")) then
            kind = "number"
            local rest = source:sub(position)
            local number = rest:match("^0[xX][%da-fA-F_]+") or rest:match("^0[bB][01_]+")
            if number then
                position += #number
                if number:match("^0[xX]") then
                    if source:sub(position, position) == "." and source:sub(position + 1, position + 1) ~= "." then
                        position += 1
                        position += #(source:sub(position):match("^[%da-fA-F_]+") or "")
                    end
                    position += #(source:sub(position):match("^[pP][+-]?%d[%d_]*") or "")
                end
            else
                local whole = rest:match("^%d[%d_]*") or ""
                position += #whole
                if source:sub(position, position) == "." and source:sub(position + 1, position + 1) ~= "." then
                    position += 1
                    local fraction = source:sub(position):match("^[%d_]+") or ""
                    position += #fraction
                end
                local exponent = source:sub(position):match("^[eE][+-]?%d[%d_]*")
                if exponent then position += #exponent end
            end
        else
            kind = "operator"
            local three = source:sub(position, position + 2)
            local two = source:sub(position, position + 1)
            position += operators[three] and 3 or operators[two] and 2 or 1
        end
        table.insert(tokens, { kind = kind, text = source:sub(start, position - 1), start = start, finish = position - 1 })
    end
    return tokens
end

function m.Highlight(source: string, theme): string
    local output = {}
    for _, token in m.Tokenize(source) do
        local value = m.Escape(token.text)
        local color = (theme and theme[token.kind]) or m.theme[token.kind]
        if color then
            assert(type(color) == "string" and color:match("^#%x%x%x%x%x%x$"), "syntax colors must be #RRGGBB strings")
            value = '<font color="' .. color .. '">' .. value .. '</font>'
        end
        table.insert(output, value)
    end
    return table.concat(output)
end

function m.ValidateSyntax(syntax)
    assert(syntax == nil or syntax == false or syntax == "lua" or syntax == "luau", "syntax must be lua, luau, false, or nil")
    return syntax == "lua" or syntax == "luau"
end

return m
end function __DARKLUA_BUNDLE_MODULES.j():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.j if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.j=v end return v.c end end do local function __modImpl()
local m = {}
m.__index = m

local colors = __DARKLUA_BUNDLE_MODULES.a()
local lifecycle = __DARKLUA_BUNDLE_MODULES.e()
local syntaxHighlight = __DARKLUA_BUNDLE_MODULES.j()

function m.new(owner, opts)
    opts = opts or {}
    local highlighted = syntaxHighlight.ValidateSyntax(opts.syntax)
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
    self.highlighted = highlighted
    self.syntaxTheme = opts.syntaxTheme
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
    entry.RichText = self.highlighted
    entry.Text = self.highlighted and syntaxHighlight.Highlight(text, self.syntaxTheme) or text
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
end function __DARKLUA_BUNDLE_MODULES.k():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.k if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.k=v end return v.c end end do local function __modImpl()
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
end function __DARKLUA_BUNDLE_MODULES.l():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.l if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.l=v end return v.c end end do local function __modImpl()
local m = {}

local activeOwner

local function visible(handle)
    while handle do
        if handle:IsA("GuiObject") and not handle.Visible then return false end
        if handle:IsA("ScreenGui") and not handle.Enabled then return false end
        handle = handle.Parent
    end
    return true
end

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

function m.attach(scope, handle, started, moved, canStart)
    local input = game:GetService("UserInputService")
    local active, origin
    local token = {}

    local function release()
        active = nil
        if activeOwner == token then activeOwner = nil end
    end
    scope:Add(release)

    --stop dragging when the window gets hidden
    local ancestor = handle
    while ancestor do
        if ancestor:IsA("GuiObject") then
            local object = ancestor
            scope:Connect(object:GetPropertyChangedSignal("Visible"), function()
                if not object.Visible then release() end
            end)
        elseif ancestor:IsA("ScreenGui") then
            local screen = ancestor
            scope:Connect(screen:GetPropertyChangedSignal("Enabled"), function()
                if not screen.Enabled then release() end
            end)
        end
        ancestor = ancestor.Parent
    end

    handle.Active = true
    scope:Connect(handle.InputBegan, function(event)
        if activeOwner or not visible(handle) then return end
        if event.UserInputType ~= Enum.UserInputType.MouseButton1 and event.UserInputType ~= Enum.UserInputType.Touch then return end
        if event.UserInputState == Enum.UserInputState.End or event.UserInputState == Enum.UserInputState.Cancel then return end
        if canStart and not canStart(event) then return end
        activeOwner = token
        active = event
        origin = Vector2.new(event.Position.X, event.Position.Y)
        started()
    end)

    scope:Connect(input.InputChanged, function(event)
        if not active then return end
        if not visible(handle) then
            release()
            return
        end
        if event == active and (event.UserInputState == Enum.UserInputState.End
            or event.UserInputState == Enum.UserInputState.Cancel) then
            release()
            return
        end
        local mouse = active.UserInputType == Enum.UserInputType.MouseButton1
        if (mouse and event.UserInputType == Enum.UserInputType.MouseMovement) or event == active then
            moved(Vector2.new(event.Position.X, event.Position.Y) - origin)
        end
    end)

    scope:Connect(input.InputEnded, function(event)
        --mouse events can use different objects, touch needs the same finger
        if event == active or (active and active.UserInputType == Enum.UserInputType.MouseButton1
            and event.UserInputType == Enum.UserInputType.MouseButton1) then
            release()
        end
    end)
    scope:Connect(input.WindowFocusReleased, release)
end

function m.attachResize(scope, handle, root, minimum, canStart)
    local resizeScale, parentScale, sizeStart, positionStart
    m.attach(scope, handle, function()
        resizeScale = m.scale(root)
        parentScale = m.scale(root.Parent)
        sizeStart = Vector2.new(root.AbsoluteSize.X / resizeScale, root.AbsoluteSize.Y / resizeScale)
        positionStart = root.Position
    end, function(delta)
        local width = math.max(minimum.X, sizeStart.X + delta.X / resizeScale)
        local height = math.max(minimum.Y, sizeStart.Y + delta.Y / resizeScale)
        root.Size = UDim2.fromOffset(width, height)
        root.Position = UDim2.new(
            positionStart.X.Scale,
            positionStart.X.Offset + (width - sizeStart.X) * resizeScale / parentScale * root.AnchorPoint.X,
            positionStart.Y.Scale,
            positionStart.Y.Offset + (height - sizeStart.Y) * resizeScale / parentScale * root.AnchorPoint.Y
        )
    end, canStart)
end

return m
end function __DARKLUA_BUNDLE_MODULES.m():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.m if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.m=v end return v.c end end do local function __modImpl()
local m = {}
local lifecycle = __DARKLUA_BUNDLE_MODULES.e()
local colors = __DARKLUA_BUNDLE_MODULES.a()
local dragUtil = __DARKLUA_BUNDLE_MODULES.m()
m.__index = m

function m:SetRatio(value: number)
    local frame = self.frame
    local first, second, divider = self.first.frame, self.second.frame, self.divider
    local vertical = self.vertical
    local scale = dragUtil.scale(frame)
    local length = (if vertical then frame.AbsoluteSize.Y else frame.AbsoluteSize.X) / scale
    local minimum = math.min(self.minSize, math.max(0, (length - 6) / 2))
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

function m:_startDrag()
    self.dragScale = dragUtil.scale(self.frame)
    local length = (if self.vertical then self.frame.AbsoluteSize.Y else self.frame.AbsoluteSize.X) / self.dragScale
    self.dragAvailable = math.max(1, length - 6)
    self.dragStart = self.ratio * self.dragAvailable
end

function m:_drag(delta)
    local offset = (if self.vertical then delta.Y else delta.X) / self.dragScale
    self:SetRatio((self.dragStart + offset) / self.dragAvailable)
end

function m.new(owner, opts)
    opts = opts or {}
    local frame = Instance.new("Frame")
    frame.Name = "SplitPane"
    frame.BackgroundTransparency = 1
    frame.Size = opts.size or UDim2.new(1, 0, 0, opts.height or 320)
    frame.ZIndex = owner.contentFrame.ZIndex + 1
    frame.Parent = owner.contentFrame
    local self = lifecycle.attach(setmetatable({}, m), frame, owner)
    self.ratio = opts.ratio or 0.5
    local vertical = opts.vertical or false
    self.vertical = vertical
    self.minSize = opts.minSize or 80
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
    self.divider = divider

    dragUtil.attach(self.scope, divider, function() self:_startDrag() end, function(delta) self:_drag(delta) end)
    self.scope:Connect(frame:GetPropertyChangedSignal("AbsoluteSize"), function() self:SetRatio(self.ratio) end)
    self:SetRatio(self.ratio)
    return self
end

return m
end function __DARKLUA_BUNDLE_MODULES.n():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.n if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.n=v end return v.c end end do local function __modImpl()
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
end function __DARKLUA_BUNDLE_MODULES.o():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.o if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.o=v end return v.c end end do local function __modImpl()
local m = {}
m.__index = m

local colors = __DARKLUA_BUNDLE_MODULES.a()
local ui = __DARKLUA_BUNDLE_MODULES.c()
local lifecycle = __DARKLUA_BUNDLE_MODULES.e()
local scope = __DARKLUA_BUNDLE_MODULES.d()

local function validateVisit(children, ancestors, loaded, seen)
    for _, node in children do
        if not ancestors[node] then
            assert(type(node.id) == "string" or type(node.id) == "number", "tree nodes need ids")
            assert(not seen[node.id], "tree nodes need unique ids")
            seen[node.id] = true
            local path = table.clone(ancestors)
            path[node] = true
            validateVisit(loaded[node.id] or node.children or {}, path, loaded, seen)
        end
    end
end

local function validate(nodes, loaded)
    validateVisit(nodes, {}, loaded, {})
end

local function flattenVisit(self, nodes, depth, ancestors)
    if depth > self.maxDepth then return end
    for _, node in nodes do
        if not ancestors[node] then
            table.insert(self.visibleNodes, { node = node, depth = depth })
            if self.expanded[node.id] then
                local path = table.clone(ancestors)
                path[node] = true
                flattenVisit(self, self.loaded[node.id] or node.children or {}, depth + 1, path)
            end
        end
    end
end

local function flatten(self)
    self.visibleNodes = {}
    flattenVisit(self, self.nodes, 0, {})
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
end function __DARKLUA_BUNDLE_MODULES.p():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.p if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.p=v end return v.c end end do local function __modImpl()
local m = {}
local ui = __DARKLUA_BUNDLE_MODULES.c()
local lifecycle = __DARKLUA_BUNDLE_MODULES.e()
local colors = __DARKLUA_BUNDLE_MODULES.a()
local syntaxHighlight = __DARKLUA_BUNDLE_MODULES.j()
m.__index = m

function m:render()
    self.highlightLabel.Visible = self.highlighted
    self.textbox.TextTransparency = self.highlighted and 1 or 0
    self.highlightLabel.Text = self.highlighted and syntaxHighlight.Highlight(self.textbox.Text, self.syntaxTheme) or ""
end

function m:SetSyntax(value)
    self.highlighted = syntaxHighlight.ValidateSyntax(value)
    self:render()
end

function m:SetText(value: string)
    self.textbox.Text = value
end

function m:GetText(): string
    return self.textbox.Text
end

function m:OnChanged(callback)
    return self.scope:Connect(self.changed.Event, callback)
end

function m:Clear()
    self.textbox.Text = ""
end

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
    local self = lifecycle.attach(setmetatable({}, m), frame, owner)
    self.highlighted = syntaxHighlight.ValidateSyntax(opts.syntax)
    self.syntaxTheme = opts.syntaxTheme
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
    text.RichText = false
    local display = Instance.new("TextLabel")
    display.Name = "Highlight"
    display.BackgroundTransparency = 1
    display.BorderSizePixel = 0
    display.Active = false
    display.Selectable = false
    display.Size = UDim2.fromScale(1, 1)
    display.Font = text.Font
    display.TextSize = text.TextSize
    display.TextColor3 = colors.text
    display.TextWrapped = false
    display.TextXAlignment = text.TextXAlignment
    display.TextYAlignment = text.TextYAlignment
    display.RichText = true
    display.ZIndex = text.ZIndex + 1
    display.Parent = text
    self.highlightLabel = display
    self.changed = lifecycle.event(self)
    self.scope:Connect(text:GetPropertyChangedSignal("Text"), function()
        self:render()
        self.changed:Fire(text.Text)
    end)

    self:SetText(opts.text or "")
    self:render()
    return self
end

return m
end function __DARKLUA_BUNDLE_MODULES.q():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.q if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.q=v end return v.c end end do local function __modImpl()
local m = {}
local controls = __DARKLUA_BUNDLE_MODULES.f()
local lifecycle = __DARKLUA_BUNDLE_MODULES.e()
m.__index = m

function m:SetValue(value: boolean)
    if self.value == value then return end
    self.value = value
    self.button.Text = (if value then "[x] " else "[ ] ") .. self.label
    if self.onToggle then self.onToggle(value) end
    self.changed:Fire(value)
end

function m:GetValue(): boolean
    return self.value
end

function m:OnChanged(fn)
    return self.scope:Connect(self.changed.Event, fn)
end

local function toggle(self)
    self:SetValue(not self.value)
end

function m.new(owner, opts, callback)
    local self = controls.button(owner, opts)
    setmetatable(self, m)
    self.value = opts.value or false
    self.label = opts.text
    self.onToggle = callback
    self.changed = lifecycle.event(self)
    self.callback = function() toggle(self) end
    self.button.Text = (if self.value then "[x] " else "[ ] ") .. opts.text
    return self
end

return m
end function __DARKLUA_BUNDLE_MODULES.r():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.r if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.r=v end return v.c end end do local function __modImpl()
local m = {}
local colors = __DARKLUA_BUNDLE_MODULES.a()

local function visible(self)
    local current = self.popupAnchor
    while current do
        if current:IsA("GuiObject") and not current.Visible then return false end
        if current:IsA("ScreenGui") and not current.Enabled then return false end
        current = current.Parent
    end
    return true
end

local function setOpen(self, value: boolean)
    local popup = self.popupFrame
    self.open = value and self.enabled ~= false and popup.Size.Y.Offset > 0 and visible(self)
    popup.Visible = self.open
    self.stateLabel.Text = if self.open then "Close ^" else "Open v"
    self.frame.Size = UDim2.new(self.frame.Size.X.Scale, self.frame.Size.X.Offset, 0,
        if self.open then 34 + popup.Size.Y.Offset else 28)
    if self.updateText then self:updateText() end
end

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
    self.popupFrame = popup
    self.popupAnchor = anchor
    local input = game:GetService("UserInputService")
    local run = game:GetService("RunService")

    self.SetOpen = setOpen
    self:SetOpen(false)
    self.scope:Connect(run.RenderStepped, function()
        if self.open and not visible(self) then self:SetOpen(false) end
    end)
    self.scope:Connect(input.InputBegan, function(key)
        if self.open and key.KeyCode == Enum.KeyCode.Escape then self:SetOpen(false) end
    end)
end

return m
end function __DARKLUA_BUNDLE_MODULES.s():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.s if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.s=v end return v.c end end do local function __modImpl()
local m = {}
local colors = __DARKLUA_BUNDLE_MODULES.a()
local ui = __DARKLUA_BUNDLE_MODULES.c()
local lifecycle = __DARKLUA_BUNDLE_MODULES.e()
local scope = __DARKLUA_BUNDLE_MODULES.d()
local popupUtil = __DARKLUA_BUNDLE_MODULES.s()
m.__index = m

function m:updateText()
    self.button.Text = self.label .. (if self.value then ": " .. self.value else ": select")
    for _, item in self.items do
        local selected = item.value == self.value
        item.button.Text = item.value .. (if selected then "  (selected)" else "")
        item.button.BackgroundColor3 = if selected then colors.sectionHeader else colors.component
    end
end

function m:SetValue(value: string?)
    assert(value == nil or table.find(self.options, value), "unknown dropdown value")
    local different = self.value ~= value
    self.value = value
    self:SetOpen(false)
    if different then
        if self.callback then self.callback(value) end
        self.changed:Fire(value)
    end
end

function m:GetValue()
    return self.value
end

function m:SetEnabled(value: boolean)
    self.enabled = value
    self.button.Active = value
    self.button.AutoButtonColor = value
    if not value then self:SetOpen(false) end
end

function m:SetOptions(options)
    self.optionScope:Destroy()
    self.optionScope = scope.new()
    for _, child in self.popup:GetChildren() do child:Destroy() end
    self.items = {}
    self.options = table.clone(options)
    local height = if #options > 0 then #options * 34 + 10 else 0
    self.popup.CanvasSize = UDim2.fromOffset(0, height)
    self.popup.Size = UDim2.new(1, -16, 0, math.min(180, height))
    self.popup.ScrollBarThickness = if height > 180 then 6 else 0
    for i, value in options do
        local item = ui.createButton(self.popup, { text = value }, self.popup.ZIndex + 1)
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

function m:OnChanged(fn)
    return self.scope:Connect(self.changed.Event, fn)
end

function m.new(owner, opts, callback)
    local frame = Instance.new("Frame")
    frame.Name = opts.text
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, 28)
    frame.ZIndex = owner.contentFrame.ZIndex + 1
    frame.Parent = owner.contentFrame
    local self = lifecycle.attach(setmetatable({}, m), frame, owner)
    self.label = opts.text
    self.callback = callback
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
    self.popup = popup
    self.changed = lifecycle.event(self)
    self.optionScope = scope.new()
    self.scope:Add(function() self.optionScope:Destroy() end)

    popupUtil.attach(self, popup, button)

    self.scope:Connect(button.MouseButton1Click, function() self:SetOpen(not self.open) end)
    self.scope:Connect(frame:GetPropertyChangedSignal("Visible"), function()
        if not frame.Visible then self:SetOpen(false) end
    end)
    self:SetOptions(self.options)
    return self
end

return m
end function __DARKLUA_BUNDLE_MODULES.t():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.t if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.t=v end return v.c end end do local function __modImpl()
local m = {}
local ui = __DARKLUA_BUNDLE_MODULES.c()
local lifecycle = __DARKLUA_BUNDLE_MODULES.e()
local popupUtil = __DARKLUA_BUNDLE_MODULES.s()
m.__index = m

function m:updateText()
    self.button.Text = self.text
end

function m:SetText(value: string)
    self.text = value
    self:updateText()
end

function m:SetEnabled(value: boolean)
    self.enabled = value
    self.button.Active = value
    self.button.AutoButtonColor = value
    self.button.TextTransparency = if value then 0 else 0.5
    if not value then self:SetOpen(false) end
end

function m.new(owner, opts)
    local frame = Instance.new("Frame")
    frame.Name = opts.text
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, 28)
    frame.ZIndex = owner.contentFrame.ZIndex + 1
    frame.Parent = owner.contentFrame
    local self = lifecycle.attach(setmetatable({ enabled = true }, m), frame, owner)
    local button = ui.createButton(frame, opts)
    self.button = button
    self.text = opts.text
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

    self.callback = function() self:SetOpen(not self.open) end
    self.scope:Connect(button.MouseButton1Click, function()
        if self.enabled then self.callback() end
    end)
    return self
end

return m
end function __DARKLUA_BUNDLE_MODULES.u():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.u if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.u=v end return v.c end end do local function __modImpl()
local m = {}
local button = __DARKLUA_BUNDLE_MODULES.g()
local textbox = __DARKLUA_BUNDLE_MODULES.h()
local row = __DARKLUA_BUNDLE_MODULES.i()
local console = __DARKLUA_BUNDLE_MODULES.k()
local panel = __DARKLUA_BUNDLE_MODULES.l()
local split = __DARKLUA_BUNDLE_MODULES.n()
local list = __DARKLUA_BUNDLE_MODULES.o()
local tree = __DARKLUA_BUNDLE_MODULES.p()
local viewer = __DARKLUA_BUNDLE_MODULES.q()
local toggle = __DARKLUA_BUNDLE_MODULES.r()
local dropdown = __DARKLUA_BUNDLE_MODULES.t()
local menu = __DARKLUA_BUNDLE_MODULES.u()
m.__index = m

local function add(self, component)
    self.nextOrder = (self.nextOrder or 0) + 1
    component.frame.LayoutOrder = self.nextOrder
    table.insert(self.components, component)
    return component
end

function m:NewButton(opts, callback)
    return add(self, button.new(self, opts, callback))
end

function m:NewTextbox(opts, callback)
    return add(self, textbox.new(self, opts, callback))
end

function m:NewRow(opts)
    return add(self, row.new(self, opts))
end

function m:NewConsole(opts)
    return add(self, console.new(self, opts))
end

function m:NewPanel(opts)
    return add(self, m.attach(panel.new(self, opts)))
end

function m:NewSplitPane(opts)
    local component = split.new(self, opts)
    m.attach(component.first)
    m.attach(component.second)
    return add(self, component)
end

function m:NewList(opts)
    return add(self, list.new(self, opts))
end

function m:NewTree(opts)
    return add(self, tree.new(self, opts))
end

function m:NewTextViewer(opts)
    return add(self, viewer.new(self, opts))
end

function m:NewToggle(opts, callback)
    return add(self, toggle.new(self, opts, callback))
end

function m:NewDropdown(opts, callback)
    return add(self, dropdown.new(self, opts, callback))
end

function m:NewMenu(opts)
    return add(self, menu.new(self, opts))
end

function m.attach(self)
    --dont overwrite methods the component already has
    for name, method in m do
        if name ~= "attach" and self[name] == nil then self[name] = method end
    end
    return self
end

return m
end function __DARKLUA_BUNDLE_MODULES.v():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.v if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.v=v end return v.c end end do local function __modImpl()
local m = {}
m.__index = m

local colors = __DARKLUA_BUNDLE_MODULES.a()
local types = __DARKLUA_BUNDLE_MODULES.b()
local container = __DARKLUA_BUNDLE_MODULES.v()
local lifecycle = __DARKLUA_BUNDLE_MODULES.e()

local function updateHeight(self)
    self.frame.Size = UDim2.new(1, 0, 0, 40 + self.layout.AbsoluteContentSize.Y)
end

function m.new(tab: Tab__DARKLUA_TYPE_P, name: string, side: SectionSide__DARKLUA_TYPE_c, order: number): Section__DARKLUA_TYPE_O    
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
end function __DARKLUA_BUNDLE_MODULES.w():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.w if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.w=v end return v.c end end do local function __modImpl()
local m = {}
m.__index = m

local colors = __DARKLUA_BUNDLE_MODULES.a()

local types = __DARKLUA_BUNDLE_MODULES.b()
local section = __DARKLUA_BUNDLE_MODULES.w()
local container = __DARKLUA_BUNDLE_MODULES.v()
local lifecycle = __DARKLUA_BUNDLE_MODULES.e()

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

function m.new(window: Window__DARKLUA_TYPE_W, name: string, opts: TabOpts__DARKLUA_TYPE_Q?): Tab__DARKLUA_TYPE_P    
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

        --use the taller column so the bottom sections dont overlap
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
    return self :: Tab__DARKLUA_TYPE_P
end

function m.NewSection(self: Tab__DARKLUA_TYPE_P, name: string, side: SectionSide__DARKLUA_TYPE_c?): Section__DARKLUA_TYPE_O    
local columnSide = side or "left"
    self.nextOrder = (self.nextOrder or 0) + 1
    local order = self.nextOrder
    local newSection = section.new(self, name, columnSide, order)
    table.insert(self.components, newSection)
    self.sections = self.components
    return newSection
end

function m.ShowCurrentTab(self: Tab__DARKLUA_TYPE_P): ()
    self.container.Visible = true
end

function m.HideCurrentTab(self: Tab__DARKLUA_TYPE_P): ()
    self.container.Visible = false
end

return m
end function __DARKLUA_BUNDLE_MODULES.x():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.x if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.x=v end return v.c end end do local function __modImpl()
local m = {}

m.__index = m

local colors = __DARKLUA_BUNDLE_MODULES.a()
local lifecycle = __DARKLUA_BUNDLE_MODULES.e()
local drag = __DARKLUA_BUNDLE_MODULES.m()
local ui = __DARKLUA_BUNDLE_MODULES.c()
local container = __DARKLUA_BUNDLE_MODULES.v()

function m:Focus()
    self.focusManager:Focus(self)
end

function m:SetVisible(value)
    if self.destroyed then return end
    self.frame.Visible = value
    if value then self:Focus() end
end

function m:Show()
    self:SetVisible(true)
end

function m:Hide()
    self:SetVisible(false)
end

function m:Toggle()
    self:SetVisible(not self.frame.Visible)
end

function m:AddTopbarButton(name, text, callback, width)
    local button = ui.createButton(self.guis.Topbar, { text = text }, 15)
    button.Name = name
    button.Size = UDim2.fromOffset(width or 60, 22)
    self.actionWidth += (width or 60) + 5
    button.Position = UDim2.new(1, -self.actionWidth, 0, 5)
    self.title.Size = UDim2.new(1, -self.actionWidth - 15, 1, 0)
    self.scope:Connect(button.MouseButton1Click, callback)
    self.focusManager:BindPress(self.scope, button)
    return button
end

function m.new(screen, opts, focusManager, owner)
    opts = opts or {}
    local root = Instance.new("Frame")
    root.Name = opts.name or "Root"
    root.Size = opts.size or UDim2.fromScale(.5, .5)
    root.AnchorPoint = Vector2.new(.5, .5)
    root.Position = opts.position or UDim2.fromScale(.5, .5)
    root.BackgroundColor3 = opts.backgroundColor or colors.component
    root.BorderSizePixel = 0
    root.Active = true
    root.Visible = opts.visible ~= false
    root.Parent = screen

    local self = lifecycle.attach(setmetatable({}, m), root, owner)
    self.SetVisible = m.SetVisible
    self.focusManager = focusManager
    focusManager:BindPress(self.scope, root)
    self.minimum = opts.minSize or Vector2.new(400, 260)
    self.guis = { ScreenGui = screen, Root = root }
    local constraint = Instance.new("UISizeConstraint")
    constraint.MinSize = self.minimum
    constraint.Parent = root

    local topbar = Instance.new("Frame")
    topbar.Name = "Topbar"
    topbar.Size = UDim2.new(1, 0, 0, 32)
    topbar.BackgroundColor3 = colors.topbar
    topbar.BorderSizePixel = 0
    topbar.ZIndex = 10
    topbar.Parent = root
    self.guis.Topbar = topbar

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Text = opts.title or ""
    title.TextColor3 = colors.text
    title.BackgroundTransparency = 1
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Position = UDim2.fromOffset(10, 0)
    title.Size = UDim2.new(1, -42, 1, 0)
    title.ZIndex = 11
    title.Parent = topbar
    self.title = title
    self.actionWidth = 27

    local close = ui.createButton(topbar, { text = "X" }, 15)
    close.Name = "CloseButton"
    close.Size = UDim2.fromOffset(22, 22)
    close.Position = UDim2.new(1, -27, 0, 5)
    close.BackgroundColor3 = colors.closeButton
    focusManager:BindPress(self.scope, close)
    self.scope:Connect(close.MouseButton1Click, function()
        if opts.onClose then
            opts.onClose(self)
        elseif opts.closeBehavior == "hide" then
            self:Hide()
        else
            self:Destroy()
        end
    end)

    local start, scale
    drag.attach(self.scope, topbar, function()
        start = root.Position
        scale = drag.scale(root.Parent)
    end, function(delta)
        root.Position = UDim2.new(start.X.Scale, start.X.Offset + delta.X / scale,
            start.Y.Scale, start.Y.Offset + delta.Y / scale)
    end, function(event)
        return focusManager:CanStartDrag(self, topbar, event)
    end)

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.BackgroundTransparency = 1
    content.Position = UDim2.fromOffset(0, 32)
    content.Size = UDim2.new(1, 0, 1, -32)
    content.ZIndex = 9
    content.Parent = root
    self.contentFrame = content
    container.attach(self)

    local resize = Instance.new("Frame")
    resize.Name = "Resize"
    resize.Size = UDim2.fromOffset(16, 16)
    resize.Position = UDim2.new(1, -16, 1, -16)
    resize.BackgroundColor3 = colors.sectionHeader
    resize.BorderSizePixel = 0
    resize.ZIndex = 200
    resize.Parent = root
    drag.attachResize(self.scope, resize, root, self.minimum, function(event)
        return focusManager:CanStartDrag(self, resize, event)
    end)
    focusManager:Register(self)
    return self
end

return m
end function __DARKLUA_BUNDLE_MODULES.y():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.y if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.y=v end return v.c end end do local function __modImpl()
local m = {}

m.__index = m

local function contains(frame, position)
    if not frame.Visible then return false end
    local origin, size = frame.AbsolutePosition, frame.AbsoluteSize
    return position.X >= origin.X and position.Y >= origin.Y
        and position.X <= origin.X + size.X and position.Y <= origin.Y + size.Y
end

function m:HitTest(position)
    if not self.screen.Enabled then return nil end
    for overlay in self.overlays do
        if not overlay.Visible then continue end
        for _, child in overlay:GetChildren() do
            if child:IsA("GuiObject") and contains(child, position) then return nil end
        end
    end
    for index = #self.windows, 1, -1 do
        local window = self.windows[index]
        if contains(window.frame, position) then return window end
    end
    return nil
end

function m:CanStartDrag(window, handle, event)
    if self:BeginPress(event) ~= window or self.focused ~= window then return false end
    --dont drag when clicking the topbar buttons
    for _, child in handle:GetChildren() do
        if (child:IsA("TextButton") or child:IsA("ImageButton") or child:IsA("TextBox"))
            and contains(child, event.Position) then
            return false
        end
    end
    return true
end

function m:BeginPress(event)
    if event.UserInputType ~= Enum.UserInputType.MouseButton1
        and event.UserInputType ~= Enum.UserInputType.Touch then
        return nil
    end
    if not self.screen.Enabled or event.UserInputState == Enum.UserInputState.End
        or event.UserInputState == Enum.UserInputState.Cancel then
        return nil
    end

    local mouse = event.UserInputType == Enum.UserInputType.MouseButton1
    local press = if mouse then self.mousePress else self.presses[event]
    --only focus once per click so opening the console doesnt undo itself
    if press then return press.window end

    local window = self:HitTest(event.Position)
    press = { window = window }
    if mouse then
        self.mousePress = press
    else
        self.presses[event] = press
    end
    if window then self:Focus(window) end
    return window
end

function m:BindPress(scope, object)
    scope:Connect(object.InputBegan, function(event)
        self:BeginPress(event)
    end)
end

function m.new(screen, scope)
    local self = setmetatable({
        screen = screen,
        windows = {},
        overlays = {},
        presses = setmetatable({}, { __mode = "k" })
    }, m)

    local function resetPresses()
        table.clear(self.presses)
        self.mousePress = nil
    end
    scope:Add(function()
        resetPresses()
        self.focused = nil
    end)

    local input = game:GetService("UserInputService")
    scope:Connect(input.InputBegan, function(event)
        if not screen.Enabled then return end
        if event.UserInputType ~= Enum.UserInputType.MouseButton1
            and event.UserInputType ~= Enum.UserInputType.Touch then
            return
        end
        self:BeginPress(event)
    end)
    scope:Connect(input.InputEnded, function(event)
        if event.UserInputType == Enum.UserInputType.MouseButton1 then
            self.mousePress = nil
        else
            self.presses[event] = nil
        end
    end)
    scope:Connect(input.WindowFocusReleased, resetPresses)
    scope:Connect(screen:GetPropertyChangedSignal("Enabled"), function()
        if not screen.Enabled then resetPresses() end
    end)
    return self
end

function m:_restack()
    for index, window in self.windows do window.frame.ZIndex = index + 4 end
    for overlay in self.overlays do overlay.ZIndex = #self.windows + 10 end
end

function m:RegisterOverlay(frame, scope)
    self.overlays[frame] = true
    scope:Add(function() self.overlays[frame] = nil end)
    self:_restack()
end

function m:Register(window)
    table.insert(self.windows, window)
    window.scope:Add(function()
        local index = table.find(self.windows, window)
        if index then table.remove(self.windows, index) end
        if self.focused == window then self.focused = nil end
        self:_restack()
    end)
    self:_restack()
end

function m:Focus(window)
    if window.destroyed or not window.frame.Visible then return end
    local index = table.find(self.windows, window)
    if not index then return end
    table.remove(self.windows, index)
    table.insert(self.windows, window)
    self.focused = window
    self:_restack()
end

return m
end function __DARKLUA_BUNDLE_MODULES.z():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.z if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.z=v end return v.c end end do local function __modImpl()
local m = {}

local colors = __DARKLUA_BUNDLE_MODULES.a()

function m.new(window)
    local self = window:NewWindow({
        name = "ConsoleWindow",
        title = "Console",
        closeBehavior = "hide",
        visible = false,
        size = UDim2.fromScale(.6, .5),
        position = UDim2.fromScale(.55, .55),
        minSize = Vector2.new(360, 200),
        backgroundColor = colors.console.background
    })
    self.console = self:NewConsole({ maxEntries = 1000 })
    self.console.frame.Size = UDim2.fromScale(1, 1)
    self:AddTopbarButton("Clear", "Clear", function()
        self.console:Clear()
    end)
    return self
end

return m
end function __DARKLUA_BUNDLE_MODULES.A():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.A if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.A=v end return v.c end end do local function __modImpl()
local m = {}
local colors = __DARKLUA_BUNDLE_MODULES.a()
local lifecycle = __DARKLUA_BUNDLE_MODULES.e()
local ui = __DARKLUA_BUNDLE_MODULES.c()

function m.new(owner, opts)
    opts = opts or {}
    local level = opts.messageType or "info"
    assert(colors.console[level] and level ~= "background", "invalid notification level")
    local frame = Instance.new("Frame")
    frame.Name = "Notification"
    frame.Size = UDim2.new(1, 0, 0, 106)
    frame.BackgroundColor3 = colors.console.background
    frame.BorderSizePixel = 0
    frame.ZIndex = 310
    frame.Parent = owner.contentFrame
    local self = lifecycle.attach({ text = opts.text, messageType = level }, frame, owner)
    local accent = Instance.new("Frame")
    accent.Size = UDim2.new(0, 3, 1, 0)
    accent.BackgroundColor3 = colors.console[level]
    accent.BorderSizePixel = 0
    accent.ZIndex = 311
    accent.Parent = frame
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Position = UDim2.fromOffset(12, 8)
    label.Size = UDim2.new(1, -24, 0, 60)
    label.Font = Enum.Font.SourceSans
    label.TextSize = 16
    label.TextColor3 = colors.console[level]
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Top
    label.TextWrapped = true
    label.TextTruncate = Enum.TextTruncate.AtEnd
    label.RichText = false
    label.Text = string.upper(level) .. ": " .. (opts.text:match("[^\r\n]*") or "")
    label.ZIndex = 311
    label.Parent = frame
    local dismiss = ui.createButton(frame, { text = "Dismiss" }, 312)
    dismiss.Size = UDim2.fromOffset(76, 24)
    dismiss.Position = UDim2.new(1, -88, 1, -32)
    self.scope:Connect(dismiss.MouseButton1Click, function() self:Destroy() end)
    if opts.onDetails then
        local details = ui.createButton(frame, { text = "Details" }, 312)
        details.Size = UDim2.fromOffset(76, 24)
        details.Position = UDim2.fromOffset(12, 74)
        self.scope:Connect(details.MouseButton1Click, opts.onDetails)
    end
    local duration = opts.duration
    if duration == nil then duration = if level == "error" then 0 else 5 end
    if duration > 0 then
        local elapsed = 0
        self.scope:Connect(game:GetService("RunService").RenderStepped, function(dt)
            elapsed += dt
            if elapsed >= duration then self:Destroy() end
        end)
    end
    return self
end

return m
end function __DARKLUA_BUNDLE_MODULES.B():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.B if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.B=v end return v.c end end do local function __modImpl()
local m = {}
m.__index = m

--local comps = script.Parent.Components

local colors = __DARKLUA_BUNDLE_MODULES.a()

local types = __DARKLUA_BUNDLE_MODULES.b()
local tab = __DARKLUA_BUNDLE_MODULES.x()

local lifecycle = __DARKLUA_BUNDLE_MODULES.e()
local WindowFrame = __DARKLUA_BUNDLE_MODULES.y()
local WindowFocus = __DARKLUA_BUNDLE_MODULES.z()
local ConsoleWindow = __DARKLUA_BUNDLE_MODULES.A()
local Notify = __DARKLUA_BUNDLE_MODULES.B()

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

function m.new(opts: WindowOpts__DARKLUA_TYPE_R?): Window__DARKLUA_TYPE_W    
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
    return self :: Window__DARKLUA_TYPE_W
end

function m.Show(self: Window__DARKLUA_TYPE_W): ()
    self.guis["ScreenGui"].Enabled = true
end

function m.Hide(self: Window__DARKLUA_TYPE_W): ()
    self.guis["ScreenGui"].Enabled = false
end

function m.Toggle(self: Window__DARKLUA_TYPE_W): ()
    self.guis["ScreenGui"].Enabled = not self.guis["ScreenGui"].Enabled
end

function m.NewTab(self: Window__DARKLUA_TYPE_W, name: string, opts: TabOpts__DARKLUA_TYPE_Q?): Tab__DARKLUA_TYPE_P    
local newTab = tab.new(self, name, opts)
    table.insert(self.tabs, newTab)
    return newTab
end

function m.SelectTab(self: Window__DARKLUA_TYPE_W, tab: Tab__DARKLUA_TYPE_P): ()
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
end function __DARKLUA_BUNDLE_MODULES.C():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.C if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.C=v end return v.c end end do local function __modImpl()
return {
    InitTimes = true,--whether to show init times for each module
    InitLogs = true --weather to show init logs for each module
    
}end function __DARKLUA_BUNDLE_MODULES.D():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.D if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.D=v end return v.c end end do local function __modImpl()
local m = {}
m.Name = "Functions"

local types = __DARKLUA_BUNDLE_MODULES.b()
function m.init(window: Window__DARKLUA_TYPE_W)
    local tab = window:NewTab("Functions")
    local section = tab:NewSection("Search Functions", "full")

    section:NewTextbox({ text = "Search..." }, function(value)
        print("Search:", value)
    end)

    section:NewButton({ text = "Refresh" }, function()
        print("Refresh clicked")
    end)

    return tab
end

return m end function __DARKLUA_BUNDLE_MODULES.E():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.E if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.E=v end return v.c end end do local function __modImpl()
local m = {}
m.Name = "GC"

local types = __DARKLUA_BUNDLE_MODULES.b()
function m.init(window: Window__DARKLUA_TYPE_W)
    local tab = window:NewTab("GC")
    local section = tab:NewSection("Search GC", "full")

    section:NewTextbox({ text = "Search..." }, function(value)
        print("Search:", value)
    end)

    section:NewButton({ text = "Refresh" }, function()
        print("Refresh clicked")
    end)

    return tab
end

return m end function __DARKLUA_BUNDLE_MODULES.F():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.F if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.F=v end return v.c end end do local function __modImpl()
local m = {}
m.Name = "Compatibility"

--things for testing
local upvalue
local tbl = {}
local function luaClosure()
    return "fail", upvalue
end
--only assign if exec supports newcclosure
local cClosure: () -> string
upvalue = "fail"

--only check the most used globals that i actually need, no point in remaking sunc lol
local execGlobals = {
    "hookfunction",
    "restorefunction",
    "filtergc",
    "hookmetamethod",
    "islclosure",
    "iscclosure",
    "newcclosure",
}

local debugGlobals = {
    "setconstant",
    "setupvalue",
    "getconstant",
    "getconstants",
    "getupvalue",
    "getupvalues",
}

function m.init()
    --REQUIRED GLOBALS
    if not getgenv then return false, "missing getgenv" end
    for namespace, name in {
        [getgenv()] = execGlobals,
        [debug] = debugGlobals,
    } do
        for _, f in name do
            if typeof(rawget(namespace, f)) ~= "function" then
                return false, `Missing global: {f}`
            end
        end
    end
    
    --CONSTANT
    local const1 = debug.getconstant(luaClosure, 1)
    if not const1 then
        return false, "Failed to get constant"
    end

    if const1 ~= debug.getconstants(luaClosure)[1] then
        return false, "getconstants mismatch"
    end

    debug.setconstant(luaClosure, 1, "yes")
    if debug.getconstant(luaClosure, 1) ~= "yes" then
        return false, "Failed to set constant"
    end
    --reset for later tests
    debug.setconstant(luaClosure, 1, "fail")

    --UPVALUE
    local uv = debug.getupvalue(luaClosure,1)
    if not uv then
        return false, "Failed to get upvalue"
    end
    if uv ~= debug.getupvalues(luaClosure)[1] then
        return false, "getupvalues mismatch"
    end

    debug.setupvalue(luaClosure, 1, "yes")
    if debug.getupvalue(luaClosure, 1) ~= "yes" then
        return false, "Failed to set upvalue"
    end
    --reset for later tests
    debug.setupvalue(luaClosure, 1, "fail")

    --GC
    --run gc tests before function tests since the function ones add referances to gc that get in the way
    local found = filtergc("function", {IgnoreExecutor = false, Constants = {"fail"}, UpvalueCount = 1})
    if not next(found) then
        return false, "Failed to find function in filtergc"
    end

    if not table.find(found, luaClosure) then
        return false, "filtergc did not return the correct function"
    end

    --CLOSURES
    cClosure = newcclosure(function ()
        return "fail", upvalue
    end)

    hookfunction(luaClosure, function()
        return "yes"
    end)
    if luaClosure() ~= "yes" then
        return false, "Failed to hook function"
    end

    restorefunction(luaClosure)
    if luaClosure() ~= "fail" then
        return false, "Failed to restore function"
    end

    setmetatable(tbl, {
        __index = function()
            return "fail"
        end
    })
    local mt = getmetatable(tbl)
    mt.__namecall = function()
        return "fail"
    end
    hookmetamethod(tbl, "__index", function()
        return "yes"
    end)
    local result = tbl.nonsense
    
    if result ~= "yes" then
        return false, "Failed to hook metamethod"
    end
    restorefunction(getmetatable(tbl).__index)

    if not islclosure(luaClosure) then
        return false, "Failed to identify lua closure"
    end

    if not iscclosure(cClosure) then
        return false, "Failed to identify c closure"
    end

    local tests = #execGlobals + #debugGlobals
    return true, `{tests}/{tests} compatibility tests passed`
end

return m end function __DARKLUA_BUNDLE_MODULES.G():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.G if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.G=v end return v.c end end end--[[
every module passes fails as 
(false, reason: string)
and some do optional msgs at the end for debugging
]]


local Window = __DARKLUA_BUNDLE_MODULES.C()
local Config = __DARKLUA_BUNDLE_MODULES.D()

local mainWindow = Window.new({})

local modules = {
__DARKLUA_BUNDLE_MODULES.E()
,
__DARKLUA_BUNDLE_MODULES.F(),
__DARKLUA_BUNDLE_MODULES.G()


} 

local loadedModules = 0
for _, mod in modules do
    local startTime = os.clock()
    local callOk, initOk, initMsg = pcall(function() return mod.init(mainWindow) end)
    if not callOk then
        warn(`Error initializing module {mod.Name}: {initOk}`)
        continue
    elseif not initOk then
        warn(`Module initialization failed: {initMsg}`)
        continue
    end
    local deltaTime = os.clock() - startTime
    if Config.InitTimes then
        print(`[INIT]: {mod.Name} initialized in {deltaTime} seconds.`)
    end
    if Config.InitLogs and initMsg then
        if Config.InitLogs and initMsg then
            print(`[INIT] {mod.Name} - {initMsg}`)
        end
    end
    loadedModules += 1
end 

print(`[INIT]:{loadedModules}/{#modules} modules loaded successfully.`)

mainWindow:Show()
