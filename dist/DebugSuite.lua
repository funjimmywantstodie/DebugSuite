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

type Column__DARKLUA_TYPE_t = { key: string, text: string?, width: number?, syntax: Syntax__DARKLUA_TYPE_o? }

type ListOpts__DARKLUA_TYPE_u = {
    text: string?, size: UDim2?, height: number?, columns: {Column__DARKLUA_TYPE_t}?,
    rowHeight: number?, maxRecords: number?,
}

type TreeNode__DARKLUA_TYPE_v = {
    id: string | number, text: string, data: any?, value: any?, inspectable: boolean?, children: {TreeNode__DARKLUA_TYPE_v}?,
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
    SetRecords: (self: List__DARKLUA_TYPE_I, records: {Record__DARKLUA_TYPE_s}, notify: boolean?) -> (),
    Append: (self: List__DARKLUA_TYPE_I, records: {Record__DARKLUA_TYPE_s}) -> (),
    Refresh: (self: List__DARKLUA_TYPE_I, notify: boolean?) -> (),
    SetFilter: (self: List__DARKLUA_TYPE_I, value: string, notify: boolean?) -> (),
    SetSort: (self: List__DARKLUA_TYPE_I, key: string, ascending: boolean?) -> (),
    Select: (self: List__DARKLUA_TYPE_I, id: string | number, notify: boolean?) -> (),
    OnSelected: (self: List__DARKLUA_TYPE_I, callback: (Record__DARKLUA_TYPE_s?) -> ()) -> RBXScriptConnection,
}

type Tree__DARKLUA_TYPE_J = Component__DARKLUA_TYPE_e & {
    SetNodes: (self: Tree__DARKLUA_TYPE_J, nodes: {TreeNode__DARKLUA_TYPE_v}, preserveState: boolean?, notify: boolean?) -> (),
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
    OnSyntaxChanged: (self: TextViewer__DARKLUA_TYPE_K, callback: (boolean) -> ()) -> RBXScriptConnection,
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
    button.RichText = false
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
    textbox.RichText = false
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
local syntaxHighlight = __DARKLUA_BUNDLE_MODULES.j()

local function render(self, scrolling)
    if self.destroyed then return end
    if not scrolling then
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
        self.viewport.CanvasSize = UDim2.fromOffset(if self.width > available then self.width else 0, #self.filtered * self.rowHeight)
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
    local active = {}
    table.clear(self.rows)
    for index = first, math.min(#self.filtered, first + count) do
        local record = self.filtered[index]
        local view = self.rowViews[record.id]
        local created = view == nil
        if created then
            local row = Instance.new("Frame")
            row.BorderSizePixel = 0
            row.ClipsDescendants = true
            row.ZIndex = self.viewport.ZIndex + 1
            view = { frame = row, cells = {}, scope = scope.new(), record = record }
            self.rowViews[record.id] = view
            for _, column in self.columns do
                local cell = ui.createButton(row, { text = "" })
                cell.TextXAlignment = Enum.TextXAlignment.Left
                cell.RichText = syntaxHighlight.ValidateSyntax(column.syntax)
                if cell.RichText then cell.Font = Enum.Font.Code end
                cell.TextTruncate = Enum.TextTruncate.AtEnd
                cell.BackgroundTransparency = 1
                cell.BorderSizePixel = 0
                view.scope:Connect(cell.MouseButton1Click, function() self:Select(view.record.id) end)
                local padding = Instance.new("UIPadding")
                padding.PaddingLeft = UDim.new(0, 8)
                padding.PaddingRight = UDim.new(0, 8)
                padding.Parent = cell
                table.insert(view.cells, cell)
            end
        end
        active[record.id] = true
        table.insert(self.rows, view.frame)
        if created or not scrolling then
            view.record = record
            local row = view.frame
            row.Size = UDim2.fromOffset(math.max(self.width, self.viewport.AbsoluteSize.X - 8), height)
            row.Position = UDim2.fromOffset(0, (index - 1) * height)
            row.BackgroundColor3 = if record.id == self.selectedId then colors.sectionHeader else colors.section
            local offset = 0
            for i, column in self.columns do
                local value = record.values[column.key]
                local cell = view.cells[i]
                local raw = if value == nil then "" else tostring(value)
                -- Styling is display-only: filtering, selection and sorting use raw values.
                cell.Text = if cell.RichText then syntaxHighlight.Highlight(raw) else raw
                cell.Name = raw
                cell.Position = UDim2.fromOffset(offset, 0)
                cell.Size = UDim2.new(0, self.widths[i], 1, 0)
                offset += self.widths[i]
            end
            if created then row.Parent = self.viewport end
        end
    end
    for id, view in self.rowViews do
        if not active[id] then
            view.scope:Destroy()
            view.frame:Destroy()
            self.rowViews[id] = nil
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
    self.rowViews = {}
    self.headers = {}
    self.columns = opts.columns or { { key = "text", text = "Text" } }
    self.rowHeight = math.max(16, opts.rowHeight or 26)
    self.maxRecords = math.max(1, opts.maxRecords or 5000)
    self.filter = ""
    self.selected = lifecycle.event(self)
    self.scope:Add(function()
        for _, view in self.rowViews do view.scope:Destroy() end
        table.clear(self.rowViews)
    end)
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
    self.scope:Connect(viewport:GetPropertyChangedSignal("CanvasPosition"), function() render(self, true) end)
    self.scope:Connect(viewport:GetPropertyChangedSignal("AbsoluteSize"), function() render(self) end)
    return self
end

-- notify=false updates selection state without dispatching a selection event.
function m:Refresh(notify: boolean?)
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
    local previous, hadSelection = self.selectedRecord, self.selectedId ~= nil
    self.selectedId = if selected then selected.id else nil
    self.selectedRecord = selected
    if notify ~= false and (selected ~= previous or (hadSelection and not selected)) then
        self.selected:Fire(selected)
    end
    self.viewport.CanvasPosition = Vector2.new(self.viewport.CanvasPosition.X, math.min(self.viewport.CanvasPosition.Y,
        math.max(0, #self.filtered * self.rowHeight - self.viewport.AbsoluteSize.Y)))
    render(self)
end

function m:SetRecords(records, notify: boolean?)
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
    self:Refresh(notify)
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

function m:SetFilter(value: string, notify: boolean?)
    self.filter = string.lower(value)
    self:Refresh(notify)
end

function m:SetSort(key: string, ascending: boolean?)
    self.sortKey = key
    self.ascending = ascending ~= false
    self:Refresh()
end

function m:Select(id, notify: boolean?)
    for _, record in self.filtered do
        if record.id == id then
            self.selectedId = id
            self.selectedRecord = record
            render(self)
            if notify ~= false then self.selected:Fire(record) end
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

local function render(self, scrolling)
    if self.destroyed then return end
    if not scrolling then
        flatten(self)
        self.emptyLabel.Visible = #self.visibleNodes == 0
        self.frame.CanvasSize = UDim2.fromOffset(0, #self.visibleNodes * 34 + 16)
    end
    local first = math.max(1, math.floor(self.frame.CanvasPosition.Y / 34) + 1)
    local count = math.ceil(self.frame.AbsoluteSize.Y / 34) + 2
    local active = {}
    table.clear(self.rows)
    for i = first, math.min(#self.visibleNodes, first + count) do
        local entry = self.visibleNodes[i]
        local node = entry.node
        local children = self.loaded[node.id] or node.children
        local canExpand = (node.loadChildren ~= nil and self.loaded[node.id] == nil) or (children ~= nil and #children > 0)
        local indent = entry.depth * 16
        local view = self.rowViews[node.id]
        local created = view == nil
        if created then
            local row = Instance.new("Frame")
            row.Name = "Node"
            row.BackgroundTransparency = 1
            row.BorderSizePixel = 0
            row.ZIndex = self.frame.ZIndex + 1
            local button = ui.createButton(row, { text = "" })
            button.TextXAlignment = Enum.TextXAlignment.Left
            button.TextTruncate = Enum.TextTruncate.AtEnd
            local padding = Instance.new("UIPadding")
            padding.PaddingLeft = UDim.new(0, 8)
            padding.Parent = button
            view = { frame = row, button = button, padding = padding, scope = scope.new(), node = node, canExpand = canExpand }
            view.scope:Add(function() if view.stateConnection then view.stateConnection:Disconnect() end end)
            self.rowViews[node.id] = view
            view.scope:Connect(button.MouseButton1Click, function()
                self:Select(view.node.id)
            end)
        end
        active[node.id] = true
        table.insert(self.rows, view.frame)
        if created or not scrolling then
            view.node = node
            view.canExpand = canExpand
            local row, button = view.frame, view.button
            row.Position = UDim2.fromOffset(8 + indent, 8 + (i - 1) * 34)
            row.Size = UDim2.new(1, -24 - indent, 0, 28)
            button.Text = node.text
            button.Name = node.text
            button.Size = UDim2.new(1, if canExpand then -88 else 0, 1, 0)
            button.BackgroundTransparency = if node.id == self.selectedId then 0 else 1
            button.BorderSizePixel = 0
            view.padding.PaddingRight = UDim.new(0, 8)
            if canExpand then
                local state = view.state
                if not state then
                    state = ui.createButton(row, { text = "Expand v" })
                    view.stateConnection = state.MouseButton1Click:Connect(function()
                        local id = view.node.id
                        self:Expand(id, not self.expanded[id])
                    end)
                end
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
                view.state = state
            elseif view.state then
                view.stateConnection:Disconnect()
                view.state:Destroy()
                view.state = nil
                view.stateConnection = nil
            end
            if created then row.Parent = self.frame end
        end
    end
    for id, view in self.rowViews do
        if not active[id] then
            view.scope:Destroy()
            view.frame:Destroy()
            self.rowViews[id] = nil
        end
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
    self.rowViews = {}
    self.visibleNodes = {}
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
    self.selected = lifecycle.event(self)
    self.scope:Add(function()
        for _, view in self.rowViews do view.scope:Destroy() end
        table.clear(self.rowViews)
    end)
    self.scope:Connect(frame:GetPropertyChangedSignal("CanvasPosition"), function() render(self, true) end)
    self.scope:Connect(frame:GetPropertyChangedSignal("AbsoluteSize"), function() render(self) end)
    return self
end

-- preserveState is intended for eager children with stable IDs (live properties).
function m:SetNodes(nodes, preserveState, notify: boolean?)
    validate(nodes, {})
    local selectedId = if preserveState then self.selectedId else nil
    self.nodes = nodes
    if not preserveState then self.expanded = {} end
    self.loaded = {}
    local hadSelection = self.selectedId ~= nil
    self.selectedId = nil
    flatten(self)
    local selected
    for _, entry in self.visibleNodes do
        if entry.node.id == selectedId then selected = entry.node self.selectedId = selectedId break end
    end
    self.frame.CanvasPosition = if preserveState then Vector2.new(self.frame.CanvasPosition.X,
        math.min(self.frame.CanvasPosition.Y, math.max(0, #self.visibleNodes * 34 + 16 - self.frame.AbsoluteSize.Y))) else Vector2.zero
    render(self)
    if notify ~= false then
        if selected then self.selected:Fire(selected)
        elseif hadSelection then self.selected:Fire(nil) end
    end
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
            local children = self.loaded[id] or node.children
            self.expanded[id] = value and children ~= nil and #children > 0 or nil
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
    local highlighted = syntaxHighlight.ValidateSyntax(value)
    local changed = self.highlighted ~= highlighted
    self.highlighted = highlighted
    self:render()
    if changed then self.syntaxChanged:Fire(highlighted) end
end

function m:OnSyntaxChanged(callback)
    return self.scope:Connect(self.syntaxChanged.Event, callback)
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
    self.syntaxChanged = lifecycle.event(self)
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
end function __DARKLUA_BUNDLE_MODULES.C():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.C if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.C=v end return v.c end end do local function __modImpl()-- Passive discovery: never hook or mutate a probe function.

local m = {}
m.__index = m
local definitions = {
    { "getgenv", "Required by the UI library" },
    { "cloneref", "Required by the UI service cache" },
    { "getgc", "Function and table inventory" },
    { "filtergc", "Inventory fallback" },
    { "debug.info", "Function metadata" },
    { "debug.getinfo", "Executor metadata fallback" },
    { "debug.getconstants", "Constant inspection" },
    { "debug.getupvalues", "Upvalue inspection" },
    { "debug.getprotos", "Nested prototype inspection" },
    { "setclipboard", "Copy raw reports and paths" },
    { "identifyexecutor", "Runtime identification" },
    { "hookfunction", "Opt-in function tracing" },
    { "restorefunction", "Remove ordinary hooks" },
    { "newcclosure", "Ordinary hook callback wrapper" },
    { "iscclosure", "Skip C-closure constants / validate OTH targets" },
    { "islclosure", "Identify Luau closures for constant search" },
    { "isfunctionhooked", "Avoid replacing existing hooks" },
    { "getrawmetatable", "Outgoing remote namecall target" },
    { "getnamecallmethod", "Outgoing remote method filter" },
    { "setnamecallmethod", "Preserve outgoing remote method during capture" },
    { "oth.hook", "Volt C-closure tracing backend" },
    { "oth.unhook", "Remove Volt OTH hooks" },
    { "oth.is_hook_thread", "Volt hook-context diagnostics" },
    { "oth.get_original_thread", "Volt original-thread diagnostics" },
    { "oth.get_root_callback", "Volt root-callback diagnostics" },
}
function m.new()
    return setmetatable({ functions = {}, records = {} }, m):Refresh()
end
function m:Refresh()
    local env = {}
    if type(getgenv) == "function" then
        local ok, value = pcall(getgenv)
        if ok and type(value) == "table" then env = value end
    end
    local direct = { getgenv = getgenv, cloneref = cloneref, getgc = getgc, filtergc = filtergc,
        setclipboard = setclipboard, identifyexecutor = identifyexecutor,
        hookfunction = hookfunction, restorefunction = restorefunction, newcclosure = newcclosure,
        iscclosure = iscclosure, islclosure = islclosure, isfunctionhooked = isfunctionhooked,
        getrawmetatable = getrawmetatable, getnamecallmethod = getnamecallmethod, setnamecallmethod = setnamecallmethod }
    self.functions, self.records = {}, {}
    for _, definition in definitions do
        local name = definition[1]
        local library, member = name:match("^(%w+)%.(.+)$")
        local value
        if member then
            local namespace = rawget(env, library)
            if type(namespace) == "table" then value = rawget(namespace, member) end
            local fallback = if library == "debug" then debug elseif library == "oth" then oth else nil
            if type(value) ~= "function" and type(fallback) == "table" then value = rawget(fallback, member) end
        else
            value = rawget(env, name)
            if type(value) ~= "function" then value = direct[name] end
        end
        if type(value) == "function" then self.functions[name] = value end
        table.insert(self.records, { id = name, values = { name = name,
            status = if self.functions[name] then "available" else "missing", feature = definition[2] } })
    end
    return self
end
function m:Has(name) return self.functions[name] ~= nil end
function m:Call(name, ...)
    local fn = self.functions[name]
    if not fn then return false, "Unavailable API: " .. name end
    return pcall(fn, ...)
end
function m:IsLuaClosure(fn)
    local ok, value = self:Call("islclosure", fn)
    if ok and type(value) == "boolean" then return value end
    ok, value = self:Call("iscclosure", fn)
    if ok and type(value) == "boolean" then return not value end
    -- An unavailable classifier must not hide otherwise readable functions.
    return nil
end
function m:Inventory(kind)
    local ok, values
    if self:Has("getgc") then ok, values = self:Call("getgc", kind == "table")
    else ok, values = self:Call("filtergc", kind, {}, false) end
    if not ok then error(values, 0) end
    if type(values) ~= "table" then error("GC inventory returned a non-table", 0) end
    return values
end
return m
end function __DARKLUA_BUNDLE_MODULES.D():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.D if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.D=v end return v.c end end do local function __modImpl()-- Bounded raw traversal; never invoke table __pairs, __index or __tostring.

local m = {}
function m.kind(value) return typeof(value) end
local function typedText(value, kind)
    local args
    if kind == "Vector3" then args = { value.X, value.Y, value.Z }
    elseif kind == "Vector2" then args = { value.X, value.Y }
    elseif kind == "Color3" then args = { value.R, value.G, value.B }
    elseif kind == "UDim" then args = { value.Scale, value.Offset }
    elseif kind == "UDim2" then args = { value.X.Scale, value.X.Offset, value.Y.Scale, value.Y.Offset }
    elseif kind == "CFrame" then args = { value:GetComponents() }
    elseif kind == "NumberRange" then args = { value.Min, value.Max }
    elseif kind == "EnumItem" then return tostring(value)
    elseif kind == "BrickColor" then return "BrickColor.new(" .. value.Number .. ")" end
    if not args then return nil end
    local text = {}
    for _, number in args do table.insert(text, tostring(number)) end
    return kind .. ".new(" .. table.concat(text, ", ") .. ")"
end
function m.path(instance)
    if instance == game then return "game" end
    local pieces, current = {}, instance
    for _ = 1, 128 do
        if current == game then
            local expression = "game"
            for i = #pieces, 1, -1 do expression ..= ":FindFirstChild(" .. string.format("%q", pieces[i]) .. ")" end
            return expression
        end
        if not current then return "nil --[[unparented instance]]" end
        local ok, name, parent = pcall(function() return current.Name, current.Parent end)
        if not ok then return "nil --[[unreadable instance]]" end
        table.insert(pieces, name)
        current = parent
    end
    return "nil --[[instance path too deep]]"
end
function m.preview(value, limit)
    limit = limit or 140
    local kind = m.kind(value)
    if kind == "table" then return if next(value) == nil then "table (empty)" else "table" end
    if kind == "function" then return "function" end
    if kind == "thread" then return "thread" end
    if kind == "Instance" then
        local ok, text = pcall(function() return value.Name .. " [" .. value.ClassName .. "]" end)
        return if ok then text:sub(1, limit) else "Instance (unreadable)"
    end
    if kind == "string" then return string.format("%q", value:sub(1, limit)) .. (if #value > limit then "..." else "") end
    if kind == "nil" or kind == "number" or kind == "boolean" then return tostring(value) end
    if type(value) == "userdata" and kind == "userdata" then return "userdata" end
    local ok, text = pcall(tostring, value)
    return if ok then text:sub(1, limit) else kind .. " (unreadable)"
end
function m.serialize(value, opts)
    opts = opts or {}
    local seen, count, truncated = {}, 0, false
    local depthLimit, entryLimit, stringLimit = opts.depth or 5, opts.entries or 300, opts.string or 4096
    local function visit(item, depth)
        local kind = m.kind(item)
        if kind == "Instance" then return m.path(item) end
        if kind == "string" then
            if #item > stringLimit then truncated = true end
            return string.format("%q", item:sub(1, stringLimit)) .. (if #item > stringLimit then " --[[string truncated]]" else "")
        end
        if kind == "number" then
            if item ~= item then return "(0/0)" end
            if item == math.huge then return "math.huge" end
            if item == -math.huge then return "-math.huge" end
            return tostring(item)
        end
        if kind == "nil" or kind == "boolean" then return tostring(item) end
        if kind ~= "table" then
            local typed = typedText(item, kind)
            if typed then return typed end
            truncated = true
            return "nil --[[" .. kind .. "; not serialized]]"
        end
        if seen[item] then truncated = true return "nil --[[cycle/shared reference]]" end
        if depth >= depthLimit or count >= entryLimit then truncated = true return "{} --[[truncated]]" end
        seen[item] = true
        local entries, lines = {}, { "{" }
        local key, val = next(item)
        while key ~= nil do
            if #entries >= entryLimit - count then truncated = true break end
            table.insert(entries, { key = key, value = val, order = #entries + 1 })
            key, val = next(item, key)
        end
        table.sort(entries, function(a, b)
            local ak, bk = m.kind(a.key), m.kind(b.key)
            if ak ~= bk then return ak < bk end
            if ak == "string" or ak == "number" then return a.key < b.key end
            if ak == "boolean" then return a.key == false and b.key == true end
            return a.order < b.order
        end)
        for _, entry in entries do
            if count >= entryLimit then truncated = true table.insert(lines, "  -- entry limit reached") break end
            count += 1
            table.insert(lines, string.rep("  ", depth + 1) .. "[" .. visit(entry.key, depth + 1) .. "] = " .. visit(entry.value, depth + 1) .. ",")
        end
        if key ~= nil then table.insert(lines, "  -- entry limit reached") end
        table.insert(lines, string.rep("  ", depth) .. "}")
        return table.concat(lines, "\n")
    end
    local text = visit(value, 0)
    local bytes = opts.bytes or 65536
    if #text > bytes then text = text:sub(1, bytes) .. "\n-- output truncated" truncated = true end
    return text, truncated
end
function m.nodes(value, label, opts)
    opts = opts or {}
    local serial, budget = 0, opts.entries or 500
    local function node(item, text, ancestors, depth)
        serial += 1
        local entry = { id = serial, text = text .. " = " .. m.preview(item), value = item, inspectable = true }
        if m.kind(item) == "table" and next(item) ~= nil and not ancestors[item] and depth < (opts.depth or 8) then
            local path = table.clone(ancestors)
            path[item] = true
            entry.loadChildren = function()
                local children = {}
                local key, val = next(item)
                while key ~= nil and budget > 0 do
                    budget -= 1
                    table.insert(children, node(val, "[" .. m.preview(key, 60) .. "]", path, depth + 1))
                    key, val = next(item, key)
                end
                if key ~= nil then
                    serial += 1
                    table.insert(children, { id = serial, text = "... inspection limit reached" })
                end
                return children
            end
        end
        return entry
    end
    return { node(value, label or "value", {}, 0) }
end
function m.snapshot(value, limit)
    assert(type(value) == "table", "Select a table first")
    local result = { entries = {}, truncated = false }
    local key, val = next(value)
    while key ~= nil do
        if #result.entries >= (limit or 200) then result.truncated = true break end
        local text, truncated = m.serialize(val, { depth = 3, entries = 60, string = 512, bytes = 4096 })
        result.truncated = result.truncated or truncated
        local kind = m.kind(val)
        local identity = if kind == "function" or kind == "thread" or kind == "Instance" or kind == "userdata" then val else nil
        table.insert(result.entries, { key = key, label = m.preview(key), text = text, identity = identity })
        key, val = next(value, key)
    end
    return result
end
function m.diff(before, after)
    local old, new, lines = {}, {}, {}
    for _, entry in before.entries do old[entry.key] = entry end
    for _, entry in after.entries do new[entry.key] = entry end
    for _, entry in before.entries do
        local current = new[entry.key]
        if not current then table.insert(lines, "REMOVED " .. entry.label .. " = " .. entry.text)
        elseif entry.text ~= current.text or not rawequal(entry.identity, current.identity) then
            table.insert(lines, "CHANGED " .. entry.label .. "\n  before: " .. entry.text .. "\n  after: " .. current.text)
        end
    end
    for _, entry in after.entries do
        if not old[entry.key] then table.insert(lines, "ADDED " .. entry.label .. " = " .. entry.text) end
    end
    if #lines == 0 then table.insert(lines, "No changes in captured values.") end
    if before.truncated or after.truncated then table.insert(lines, "PARTIAL SNAPSHOT: limits or unsupported values; changes outside captured values may be omitted.") end
    return table.concat(lines, "\n")
end
return m
end function __DARKLUA_BUNDLE_MODULES.E():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.E if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.E=v end return v.c end end do local function __modImpl()-- Freeze arguments at receipt; retain no live argument tables in the history.

local Values = __DARKLUA_BUNDLE_MODULES.E()
local m = {}
m.__index = m
function m.new(limit, rate)
    return setmetatable({ records = {}, limit = limit or 500, rate = rate or 100, sequence = 0, dropped = 0, bucket = -1, received = 0, version = 0 }, m)
end
function m:Push(path, arguments, now, kind)
    local bucket = math.floor(now)
    if bucket ~= self.bucket then self.bucket, self.received = bucket, 0 end
    self.received += 1
    self.version += 1
    if self.received > self.rate then self.dropped += 1 return nil end
    if type(path) == "function" then path = path() end
    self.sequence += 1
    local text, truncated = Values.serialize(arguments, { depth = 4, entries = 100, string = 512, bytes = 8192 })
    kind = kind or "incoming event"
    local record = { id = self.sequence, text = string.format("-- Call #%d | %.3fs | %s\n-- %s, %d arguments (n preserves nil slots)\n%s",
            self.sequence, now, path, kind, arguments.n, text),
        values = { time = string.format("%.3f", now), path = path, args = arguments.n, kind = kind, partial = if truncated then "partial" else "" } }
    table.insert(self.records, record)
    if #self.records > self.limit then table.remove(self.records, 1) end
    return record
end
function m:Finish(record, ok, results, duration, modified)
    local text, truncated = Values.serialize(results, { depth = 4, entries = 100, string = 512, bytes = 8192 })
    record.text ..= string.format("\n-- %s | %.3f ms\n%s", if modified then "original returns (n preserves nil slots)"
        elseif ok then "returns (n preserves nil slots)" else "error", duration * 1000, text)
    if modified then
        local replacement, partial = Values.serialize(modified, { depth = 4, entries = 100, string = 512, bytes = 8192 })
        record.text ..= "\n-- modified returns (n preserves nil slots)\n" .. replacement
        truncated = truncated or partial
    end
    record.values.outcome = if modified then "overridden" elseif ok then "returned" else "error"
    record.values.duration = string.format("%.3f", duration * 1000)
    if truncated then record.values.partial = "partial" end
    self.version += 1
end
function m:Clear()
    table.clear(self.records)
    self.dropped, self.received, self.bucket = 0, 0, -1
    self.version += 1
end
return m
end function __DARKLUA_BUNDLE_MODULES.F():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.F if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.F=v end return v.c end end do local function __modImpl()-- Literal scalar values only; never evaluate editor text as code.

local m = { limit = 16 }
function m.parse(kind, text)
    if kind == "nil" then return nil end
    if kind == "string" then return text end
    if kind == "boolean" then
        assert(text == "true" or text == "false", "Boolean must be true or false")
        return text == "true"
    end
    assert(kind == "number", "Unknown return type")
    local value = tonumber(text)
    assert(value and value == value and math.abs(value) < math.huge, "Number must be finite")
    return value
end
function m.copy(values)
    assert(type(values) == "table" and type(values.n) == "number" and values.n % 1 == 0
        and values.n >= 0 and values.n <= m.limit, "Return count must be 0 to 16")
    local result = { n = values.n }
    for i = 1, values.n do
        local value = values[i]
        local kind = type(value)
        assert(kind == "nil" or kind == "string" or kind == "boolean" or kind == "number", "Return #" .. i .. " must be a scalar")
        if kind == "number" then assert(value == value and math.abs(value) < math.huge, "Return #" .. i .. " must be finite") end
        result[i] = value
    end
    return result
end
return m
end function __DARKLUA_BUNDLE_MODULES.G():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.G if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.G=v end return v.c end end do local function __modImpl()-- Explicit tracing and optional scalar return overrides. Discovery installs nothing.

local Recorder = __DARKLUA_BUNDLE_MODULES.F()
local Values = __DARKLUA_BUNDLE_MODULES.E()
local ReturnValues = __DARKLUA_BUNDLE_MODULES.G()
local m = {}
m.__index = m
local protected = { [coroutine.running] = true, [os.clock] = true }
for _, library in { table, string } do
    for _, value in library do if type(value) == "function" then protected[value] = true end end
end
for _, value in { pcall, xpcall, type, typeof, next, tostring, error, math.floor, math.max, math.min } do protected[value] = true end

function m.new(compat, started)
    return setmetatable({ compat = compat, started = started, entries = {}, sequence = 0,
        recorder = Recorder.new(), busy = setmetatable({}, { __mode = "k" }),
        paused = false, capturing = false, dirty = false, failures = 0, destroyed = false }, m)
end
function m:Available(backend)
    if backend == "Volt OTH" then
        return self.compat:Has("oth.hook") and self.compat:Has("oth.unhook") and self.compat:Has("iscclosure")
    end
    return self.compat:Has("hookfunction") and self.compat:Has("restorefunction") and self.compat:Has("newcclosure")
end
function m:CanTrace(target, backend)
    if self.destroyed then return false, "Hook manager is closed" end
    if type(target) ~= "function" then return false, "Select a function first" end
    local required = if backend == "Volt OTH" then { "oth.hook", "oth.unhook", "iscclosure" }
        else { "hookfunction", "restorefunction", "newcclosure" }
    local missing = {}
    for _, name in required do if not self.compat:Has(name) then table.insert(missing, name) end end
    if #missing > 0 then return false, "Missing APIs: " .. table.concat(missing, ", ") end
    if protected[target] then return false, "Target is a tracing dependency" end
    for _, fn in self.compat.functions do
        if fn == target then return false, "Target is an executor API used by this tool" end
    end
    if self.entries[target] then return false, "Target already managed by this session" end
    if self.compat:Has("isfunctionhooked") then
        local ok, hooked = self.compat:Call("isfunctionhooked", target)
        if not ok or hooked then return false, "Existing hook or hook status unavailable" end
    end
    if backend == "Volt OTH" then
        local ok, isC = self.compat:Call("iscclosure", target)
        if not ok or not isC then return false, "Volt OTH requires a C closure" end
    end
    local count = 0
    for _ in self.entries do count += 1 end
    if count >= 32 then return false, "32-hook limit reached" end
    return true
end
function m:Add(target, label, backend, opts)
    local allowed, reason = self:CanTrace(target, backend)
    assert(allowed, reason)
    opts = opts or {}
    self.sequence += 1
    local api = self.compat.functions
    -- Capture installation/restoration APIs; a later compatibility refresh cannot
    -- change which backend owns an installed hook.
    local entry = { id = self.sequence, target = target, label = label, backend = backend, active = true,
        hits = 0, recorder = opts.recorder or self.recorder, editable = opts.recorder == nil,
        remove = if backend == "Volt OTH" then api["oth.unhook"] else api.restorefunction,
        restoreContext = opts.restoreContext }
    local function callback(...)
        if not entry.active or self.destroyed then return entry.original(...) end
        if opts.match and not opts.match(...) then return entry.original(...) end
        local thread = coroutine.running()
        if self.capturing or self.busy[thread] then return entry.original(...) end
        local override = entry.override
        local capture = not (self.paused or (opts.paused and opts.paused()))
        if not capture and not override then return entry.original(...) end
        self.busy[thread] = true
        -- OTH can dispatch nested hooks on another thread. Serialization does
        -- not intentionally yield; suppress its nested hooks across threads.
        self.capturing = true
        local record, contextValue, started
        local captured = pcall(function(...)
            if not capture then return end
            if opts.context then contextValue = opts.context() end
            local path, kind, arguments
            if opts.select then path, kind, arguments = opts.select(contextValue, ...)
            else path, kind, arguments = entry.label, "function call", table.pack(...) end
            if not path then return end
            entry.hits += 1
            started = os.clock()
            record = entry.recorder:Push(path, arguments, started - self.started, kind)
            self.dirty = true
            if record then record.values.outcome = "running" end
            if record and backend == "Volt OTH" then
                local parts = {}
                for _, name in { "oth.is_hook_thread", "oth.get_original_thread", "oth.get_root_callback" } do
                    if api[name] then
                        local ok, value = pcall(api[name])
                        table.insert(parts, name .. " = " .. (if ok then Values.preview(value) else "unavailable"))
                    end
                end
                record.text ..= "\n-- " .. table.concat(parts, "; ")
            end
        end, ...)
        self.capturing = false
        self.busy[thread] = nil
        if not captured then self.failures += 1 self.dirty = true end
        -- Serialization may make its own namecalls (e.g. CFrame:GetComponents).
        if entry.restoreContext and contextValue then entry.restoreContext(contextValue) end
        if not record and not override then return entry.original(...) end
        local callStarted = os.clock()
        local results = table.pack(pcall(entry.original, ...))
        -- Replacing or disabling the rule, stopping, or closing cancels pending
        -- overrides too. A yielded call cannot apply an obsolete configuration.
        local modified = if results[1] and entry.active and not self.destroyed
            and override and entry.override == override then override.values else nil
        self.busy[thread] = true
        self.capturing = true
        local finished = pcall(function()
            if not record then return end
            local values = { n = results.n - 1 }
            for i = 2, results.n do values[i - 1] = results[i] end
            entry.recorder:Finish(record, results[1], values, os.clock() - callStarted, modified)
        end)
        self.capturing = false
        self.busy[thread] = nil
        if not finished then self.failures += 1 end
        self.dirty = true
        if entry.restoreContext and contextValue then entry.restoreContext(contextValue) end
        if not results[1] then error(results[2], 0) end
        if modified then return table.unpack(modified, 1, modified.n) end
        return table.unpack(results, 2, results.n)
    end
    local replacement = callback
    if backend ~= "Volt OTH" then replacement = api.newcclosure(callback) end
    local install = if backend == "Volt OTH" then api["oth.hook"] else api.hookfunction
    entry.original = install(target, replacement)
    if type(entry.original) ~= "function" then
        entry.active = false
        pcall(entry.remove, target)
        error("Hook API did not return an original function", 0)
    end
    self.entries[target] = entry
    self.dirty = true
    return entry
end
function m:SetReturnOverride(target, values)
    local entry = self.entries[target]
    assert(not self.destroyed and entry and entry.active, "Select an active managed hook")
    assert(entry.editable, "Return overrides are only available for function traces")
    local copy = ReturnValues.copy(values)
    entry.returnValues = copy
    entry.override = { values = copy }
    self.dirty = true
end
function m:DisableReturnOverride(target)
    local entry = self.entries[target]
    assert(entry, "Select a managed hook")
    entry.override = nil
    self.dirty = true
end
function m:Stop(target)
    local entry = self.entries[target]
    if not entry then return true end
    entry.active = false
    entry.override, entry.returnValues = nil, nil
    local ok, result = pcall(entry.remove, target)
    if not ok or (entry.backend == "Volt OTH" and result ~= true) then
        entry.error = if ok then "OTH unhook failed" else tostring(result)
        self.dirty = true
        return false, entry.error
    end
    self.entries[target] = nil
    self.dirty = true
    return true
end
function m:StopAll()
    local targets, errors = {}, {}
    for target in self.entries do table.insert(targets, target) end
    for _, target in targets do
        local ok, err = self:Stop(target)
        if not ok then table.insert(errors, err) end
    end
    return #errors == 0, table.concat(errors, "\n")
end
function m:Destroy()
    if self.destroyed then return end
    self.destroyed = true
    local ok, err = self:StopAll()
    if not ok then warn("DebugSuite hook cleanup: " .. err) end
    self.recorder:Clear()
    table.clear(self.busy)
end
return m
end function __DARKLUA_BUNDLE_MODULES.H():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.H if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.H=v end return v.c end end do local function __modImpl()
local m = {}
m.__index = m
function m.new(owner, status, onBusyChanged)
    local self = setmetatable({ generation = 0, owner = owner, status = status, busy = false, onBusyChanged = onBusyChanged }, m)
    owner.scope:Add(function() self.generation += 1 end)
    return self
end
function m:SetBusy(value)
    self.busy = value
    if self.onBusyChanged then self.onBusyChanged(value) end
end
function m:Cancel()
    if not self.busy then return end
    self.generation += 1
    if not self.owner.destroyed then
        self:SetBusy(false)
        self.status("Cancelled. Previous results retained.")
    end
end
function m:Run(work, commit)
    self.generation += 1
    local generation = self.generation
    local function alive() return not self.owner.destroyed and generation == self.generation end
    self.status("Scanning...")
    self:SetBusy(true)
    task.spawn(function()
        if not alive() then return end
        local steps = 0
        local function checkpoint()
            if not alive() then return false end
            steps += 1
            if steps % 100 == 0 then task.wait() end
            return alive()
        end
        local ok, result, summary = pcall(work, checkpoint)
        if not alive() then return end
        self:SetBusy(false)
        if not ok then self.status("Scan failed: " .. tostring(result)) return end
        local committed, err = pcall(commit, result)
        self.status(if committed then summary or "Ready" else "Display failed: " .. tostring(err))
    end)
end
return m
end function __DARKLUA_BUNDLE_MODULES.I():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.I if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.I=v end return v.c end end do local function __modImpl()
local Values = __DARKLUA_BUNDLE_MODULES.E()
local m = { scanLimit = 30000, resultLimit = 1000, aliasEntryLimit = 30000, constantLimit = 300, filterLimit = 16 }
local identities, nextIdentity = setmetatable({}, { __mode = "k" }), 0
local function identity(value)
    if not identities[value] then nextIdentity += 1 identities[value] = nextIdentity end
    return identities[value]
end
function m.functionId(fn)
    assert(type(fn) == "function", "Expected a function")
    return identity(fn)
end
local function contains(text, query) return string.find(string.lower(text), query, 1, true) ~= nil end
local function searchText(value)
    return if type(value) == "string" then value:sub(1, 4096) else Values.preview(value, 4096)
end
function m.metadata(compat, fn)
    local ok, source, line, name, arguments, variadic = compat:Call("debug.info", fn, "slna")
    if ok then return { name = if name == "" then "(anonymous)" else name, source = source, line = line, arguments = arguments, variadic = variadic } end
    local fallback, info = compat:Call("debug.getinfo", fn)
    if fallback and type(info) == "table" then
        return { name = info.name or "(anonymous)", source = info.source or info.short_src or "?",
            line = info.linedefined or -1, arguments = info.numparams or info.nparams or "?", variadic = info.is_vararg }
    end
    return { name = "(metadata unavailable)", source = "?", line = -1, arguments = "?" }
end
function m.functions(compat, query, constantQuery, checkpoint)
    -- Keep the single text filter accepted by older callers.
    local filters = if type(constantQuery) == "table" then constantQuery else {}
    local rules = filters.constants or {}
    if type(constantQuery) == "string" and constantQuery ~= "" then
        rules = { { kind = "text", value = constantQuery } }
    end
    assert(#rules <= m.filterLimit, "At most 16 constant filters")
    for _, rule in rules do
        assert((rule.kind == "text" or rule.kind == "string") and type(rule.value) == "string"
            or rule.kind == "number" and type(rule.value) == "number" and rule.value == rule.value and math.abs(rule.value) < math.huge
            or rule.kind == "boolean" and type(rule.value) == "boolean", "Invalid constant filter")
    end
    if #rules > 0 then assert(compat:Has("debug.getconstants"), "Constant search requires debug.getconstants") end
    local function textMatches(text, needle, exact, ignoreCase)
        if ignoreCase or not filters.caseSensitive then text, needle = string.lower(text), string.lower(needle) end
        return if exact then text == needle else string.find(text, needle, 1, true) ~= nil
    end
    local function metadataMatches(info)
        return textMatches(tostring(info.source), filters.source or "")
            and (filters.arguments == nil or info.arguments == filters.arguments)
    end
    local records, seen, visited, errors, partial, cancelled = {}, {}, 0, 0, false, false
    local skipped, reads, firstError = 0, 0, nil
    local inventory = compat:Inventory("function")
    local exhausted = true
    local function constantsMatch(value)
        if #rules == 0 then return true end
        if compat:IsLuaClosure(value) == false then skipped += 1 return false end
        local ok, constants = compat:Call("debug.getconstants", value)
        if not ok or type(constants) ~= "table" then
            errors += 1
            firstError = firstError or (if ok then "debug.getconstants returned " .. type(constants) .. ", expected a table" else tostring(constants))
            return false
        end
        reads += 1
        local matched, found, count = {}, 0, 0
        local key, constant = next(constants)
        while key ~= nil do
            if not checkpoint() then cancelled = true return false end
            count += 1
            for i, rule in rules do
                if not matched[i] then
                    local matches = false
                    if rule.kind == "text" then
                        matches = textMatches(if type(constant) == "string" then constant else searchText(constant), rule.value, false, true)
                    elseif type(constant) == rule.kind then
                        if rule.kind == "string" then
                            matches = textMatches(constant, rule.value, filters.exactConstants, true)
                        else matches = constant == rule.value end
                    end
                    if matches then
                        matched[i], found = true, found + 1
                        if filters.constantMode == "Any" or found == #rules then return true end
                    end
                end
            end
            key, constant = next(constants, key)
            if count >= m.constantLimit then
                if key ~= nil then partial = true end
                break
            end
        end
        return false
    end
    local function add(value, info, alias)
        if seen[value] then return end
        seen[value] = true
        if metadataMatches(info) and constantsMatch(value) then
            if alias then info.debugName, info.name, info.alias = info.name, alias, alias end
            table.insert(records, { id = identity(value), value = value, values = info })
        end
    end
    for _, value in next, inventory do
        visited += 1
        if not checkpoint() then return {} end
        if type(value) == "function" then
            local info = m.metadata(compat, value)
            if textMatches(tostring(info.name) .. " " .. tostring(info.source), query) then
                add(value, info)
            end
        end
        if cancelled then return {} end
        if visited >= m.scanLimit or #records >= m.resultLimit then exhausted = false break end
    end
    -- Exported table keys are separate from closure debug names (which can be stripped).
    -- Only inspect raw fields: resolving a proxy's __index could execute game code.
    local aliasEntries, aliasStatus = 0, ""
    if query ~= "" and #records < m.resultLimit then
        local ok, tables = pcall(compat.Inventory, compat, "table")
        if ok then
            local tableValues = 0
            for _, value in next, tables do
                tableValues += 1
                if not checkpoint() then return {} end
                if type(value) == "table" then
                    local count, key, fn = 0, next(value)
                    while key ~= nil do
                        if not checkpoint() then return {} end
                        count += 1
                        aliasEntries += 1
                        if type(key) == "string" and type(fn) == "function" then
                            if #key > 4096 then partial = true end
                            if not seen[fn] and textMatches(key:sub(1, 4096), query) then add(fn, m.metadata(compat, fn), key) end
                            if cancelled then return {} end
                        end
                        key, fn = next(value, key)
                        if count >= 200 or aliasEntries >= m.aliasEntryLimit or #records >= m.resultLimit then
                            if key ~= nil then partial = true end
                            break
                        end
                    end
                end
                if tableValues >= m.scanLimit or aliasEntries >= m.aliasEntryLimit or #records >= m.resultLimit then partial = true break end
            end
            aliasStatus = string.format(" %d raw table fields checked for aliases.", aliasEntries)
        else
            partial = true
            aliasStatus = " Table alias inventory unavailable; name/source search only."
        end
    end
    local summary = string.format("%d functions / %d values checked. %s", #records, visited,
        if exhausted and not partial and errors == 0 then "Scan complete." else "PARTIAL.") .. aliasStatus
    if not exhausted or partial then summary ..= " Scan/result/constant/alias limits reached or alias inventory unavailable." end
    if #rules > 0 then
        summary ..= string.format("\n%d constant tables read; %d C closures skipped; %d constant reads failed.", reads, skipped, errors)
        if firstError then summary ..= "\nFirst constant read error: " .. firstError end
    end
    return records, summary
end
function m.tables(compat, query, checkpoint)
    query = string.lower(query)
    local records, visited, partial = {}, 0, false
    for _, value in next, compat:Inventory("table") do
        visited += 1
        if not checkpoint() then return {} end
        if type(value) == "table" then
            local count, matches, samples = 0, query == "", {}
            local key, val = next(value)
            while key ~= nil and count < 200 do
                count += 1
                local text = Values.preview(key, 120) .. " = " .. Values.preview(val, 120)
                if #samples < 3 then table.insert(samples, text) end
                if contains(searchText(key) .. " " .. searchText(val), query) then matches = true end
                if (type(key) == "string" and #key > 4096) or (type(val) == "string" and #val > 4096) then partial = true end
                key, val = next(value, key)
            end
            if key ~= nil then partial = true end
            if matches then
                local id = identity(value)
                table.insert(records, { id = id, value = value,
                    values = { name = "Table " .. id, entries = tostring(count) .. (if key ~= nil then "+" else ""), preview = table.concat(samples, "; ") } })
            end
        end
        if visited >= m.scanLimit or #records >= m.resultLimit then partial = true break end
    end
    return records, string.format("%d tables / %d values checked. %s", #records, visited,
        if partial then "PARTIAL: limits reached (200 entries per table)." else "Scan complete.")
end
function m.isRemote(value)
    return value.ClassName == "RemoteEvent" or value.ClassName == "UnreliableRemoteEvent" or value.ClassName == "RemoteFunction"
end
function m.isScript(value)
    return value.ClassName == "LocalScript" or value.ClassName == "ModuleScript" or value.ClassName == "Script"
end
function m.instances(root, query, mode, excluded, checkpoint)
    query = string.lower(query)
    local queue, head, records, partial, errors = { root }, 1, {}, false, 0
    while head <= #queue do
        if not checkpoint() then return {} end
        local value = queue[head]
        local ok, name, class = pcall(function() return value.Name, value.ClassName end)
        if ok then
            local path = Values.path(value)
            local kindMatches = mode == "All" or (mode == "Scripts" and m.isScript(value)) or (mode == "Remotes" and m.isRemote(value))
            if kindMatches and contains(name .. " " .. class .. " " .. path, query) then
                table.insert(records, { id = identity(value), value = value, values = { name = name, class = class, path = path } })
            end
            local childrenOk, children = pcall(function() return value:GetChildren() end)
            if childrenOk then
                for _, child in children do
                    if child ~= excluded then
                        if #queue >= m.scanLimit then partial = true break end
                        table.insert(queue, child)
                    end
                end
            else errors += 1 end
        else errors += 1 end
        if #records >= m.resultLimit then partial = true break end
        head += 1
    end
    return records, string.format("%d matches / %d instances checked. %d reads failed. %s", #records, math.min(head, #queue), errors,
        if partial then "PARTIAL: limits reached. Narrow the filter." else "Scan complete (client-visible instances).")
end
return m
end function __DARKLUA_BUNDLE_MODULES.J():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.J if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.J=v end return v.c end end do local function __modImpl()
local Values = __DARKLUA_BUNDLE_MODULES.E()
local m = {}
local properties = {
    "Name", "ClassName", "Parent", "Archivable", "Value", "Enabled", "Visible", "Text",
    "Position", "Size", "CFrame", "Color", "Material", "Transparency", "Anchored", "CanCollide",
    "AssemblyLinearVelocity", "Health", "MaxHealth", "WalkSpeed", "RunContext", "DisplayOrder",
}
function m.describe(instance)
    local data = { path = Values.path(instance), properties = {}, attributes = {} }
    for _, name in properties do
        local ok, value = pcall(function() return instance[name] end)
        if ok and value ~= nil then data.properties[name] = value end
    end
    local ok, attributes = pcall(function() return instance:GetAttributes() end)
    if ok then data.attributes = attributes else data.attributeError = tostring(attributes) end
    return data
end
-- Property/attribute names are stable IDs, so live refresh preserves the branch.
function m.propertyNodes(instance, data)
    local function fields(values, prefix)
        local keys, nodes, partial = {}, {}, false
        for key in next, values do
            if #keys >= 200 then partial = true break end
            table.insert(keys, key)
        end
        table.sort(keys)
        for index, key in keys do
            local value = rawget(values, key)
            table.insert(nodes, { id = prefix .. ":" .. key, text = key .. " = " .. Values.preview(value), value = value, inspectable = true })
        end
        if partial then table.insert(nodes, { id = prefix .. ":limit", text = "... first 200 fields shown" }) end
        return nodes
    end
    local children = {
        { id = "path", text = "Path = " .. data.path, value = data.path, inspectable = true },
        { id = "properties", text = "Properties", value = data.properties, inspectable = true, children = fields(data.properties, "property") },
        { id = "attributes", text = "Attributes", value = data.attributes, inspectable = true, children = fields(data.attributes, "attribute") },
    }
    if data.attributeError then table.insert(children, { id = "attributeError", text = "Attributes unavailable: " .. data.attributeError, value = data.attributeError, inspectable = true }) end
    return { { id = "instance", text = Values.preview(instance), value = data, inspectable = true, children = children } }
end
function m.nodes(root, excluded)
    local serial, budget = 0, 2000
    local function node(instance, depth)
        serial += 1
        local entry = { id = serial, text = Values.preview(instance), value = instance }
        local hasChildren = false
        if depth < 32 then
            for _, child in instance:GetChildren() do
                if child ~= excluded then hasChildren = true break end
            end
        end
        if hasChildren then
            entry.loadChildren = function()
                local children, nodes, candidates, partial = instance:GetChildren(), {}, {}, false
                for _, child in children do
                    if child ~= excluded then
                        if #candidates >= budget then partial = true break end
                        table.insert(candidates, child)
                    end
                end
                table.sort(candidates, function(a, b) return a.Name < b.Name end)
                for _, child in candidates do budget -= 1 table.insert(nodes, node(child, depth + 1)) end
                if partial then
                    serial += 1
                    table.insert(nodes, { id = serial, text = "... 2,000-node limit; refresh or use search" })
                end
                return nodes
            end
        end
        return entry
    end
    return { node(root, 0) }
end
return m
end function __DARKLUA_BUNDLE_MODULES.K():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.K if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.K=v end return v.c end end do local function __modImpl()
local Jobs = __DARKLUA_BUNDLE_MODULES.I()
local Values = __DARKLUA_BUNDLE_MODULES.E()
local Catalog = __DARKLUA_BUNDLE_MODULES.J()
local Instances = __DARKLUA_BUNDLE_MODULES.K()
local m = {}
function m.action(context, callback)
    return function(...)
        local ok, err = pcall(callback, ...)
        if not ok then context.window:Notify({ text = tostring(err), messageType = "error" }) end
    end
end
function m.copy(context, text)
    local ok, err = context.compat:Call("setclipboard", text)
    if not ok then error(err, 0) end
    context.window:Log("Copied raw text to clipboard.", "success")
end
function m.viewer(context, section, opts)
    local viewer = section:NewTextViewer(opts or { height = 200, text = "Select an item." })
    local row = section:NewRow()
    local copy = row:NewButton({ text = "Copy report", width = 100 }, m.action(context, function() m.copy(context, viewer:GetText()) end))
    copy:SetEnabled(context.compat:Has("setclipboard"))
    viewer.copyButton = copy
    if opts and opts.syntax then
        local toggle = row:NewButton({ text = "Plain text", width = 100 }, function()
            viewer:SetSyntax(if viewer.highlighted then false else opts.syntax)
        end)
        m.bindSyntax(viewer, toggle)
    end
    return viewer
end
function m.bindSyntax(viewer, button)
    local function update() button:SetText(if viewer.highlighted then "Plain text" else "Syntax colors") end
    viewer:OnSyntaxChanged(update)
    update()
end
function m.hint(section, opts)
    local viewer = section:NewTextViewer(opts)
    -- Instruction text follows the panel width; raw reports retain their layout.
    viewer.textbox.TextWrapped = true
    viewer.textbox.AutomaticSize = Enum.AutomaticSize.Y
    viewer.textbox.Size = UDim2.new(1, -24, 0, 20)
    viewer.frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    viewer.frame.ScrollingDirection = Enum.ScrollingDirection.Y
    return viewer
end
function m.preview(value)
    local kind = Values.kind(value)
    if kind == "table" then
        if next(value) == nil then return "-- Empty table (no raw fields)." end
        return "-- Table selected. Expand it to browse its fields.\n-- Show raw value to see or copy the serialized table."
    end
    if kind == "function" then return "-- Function selected. Inspect selected to browse its closure." end
    return Values.serialize(value)
end
function m.scanner(context, name, description)
    local tab = context.window:NewTab(name)
    local tools = tab:NewSection("Search and controls", "top")
    local help = m.hint(tools, { height = 58, text = description })
    local status = m.hint(tools, { height = 48, text = "Ready. Enter a filter or leave it empty, then click Scan." })
    local row = tools:NewRow()
    local search = row:NewTextbox({ text = "Literal filter (Enter to scan)", fill = true })
    local cancel, scan
    local jobs = Jobs.new(tab, function(text)
        status:SetText(if text == "Scanning..." then "Scanning... Previous results stay visible until the scan finishes.\nCancel stops between batches." else text)
    end, function(busy)
        cancel:SetEnabled(busy)
        scan:SetEnabled(not busy)
    end)
    local controller = { tab = tab, tools = tools, row = row, search = search, jobs = jobs, status = status, help = help }
    controller.invalidate = function()
        jobs:Cancel()
        status:SetText("Search changed. Click Scan or press Enter to apply it.")
    end
    search:OnChanged(controller.invalidate)
    controller.scan = function() end
    scan = row:NewButton({ text = "Scan", width = 65 }, function() controller.scan() end)
    cancel = row:NewButton({ text = "Cancel", width = 65 }, function() jobs:Cancel() end)
    controller.scanButton, controller.cancelButton = scan, cancel
    cancel:SetEnabled(false)
    search:OnSubmitted(function() controller.scan() end)
    tab.searchInput = search
    return controller
end
function m.inspect(context, value, label)
    local inspector = context.inspector
    if not inspector or inspector.shell.destroyed then
        local shell = context.window:NewWindow({ title = "Value inspector", size = UDim2.fromOffset(700, 500) })
        local navigation = shell:NewRow()
        navigation.frame.Position = UDim2.fromOffset(8, 8)
        navigation.frame.Size = UDim2.new(1, -16, 0, 28)
        local valueActions = shell:NewRow()
        valueActions.frame.Position = UDim2.fromOffset(8, 42)
        valueActions.frame.Size = UDim2.new(1, -16, 0, 28)
        local split = shell:NewSplitPane({ size = UDim2.new(1, -16, 1, -86), vertical = true, ratio = .6 })
        split.frame.Position = UDim2.fromOffset(8, 78)
        inspector = { shell = shell, history = {}, tree = split.first:NewTree({ size = UDim2.fromScale(1, 1) }),
            viewer = split.second:NewTextViewer({ size = UDim2.fromScale(1, 1), syntax = "lua" }) }
        context.inspector = inspector
        local tree, viewer = inspector.tree, inspector.viewer
        local copy, drill, back, hooks
        local function preview(item)
            inspector.selected = item
            viewer:SetText(m.preview(item))
            local kind = Values.kind(item)
            drill:SetEnabled(kind == "function" or kind == "Instance")
            hooks:SetEnabled(kind == "function" and context.selectHook ~= nil)
        end
        local function load(item, title)
            inspector.source, inspector.label = item, title
            if Values.kind(item) == "Instance" then item = Instances.describe(item)
            elseif type(item) == "function" then
                local data = { metadata = Catalog.metadata(context.compat, item) }
                for _, field in { "constants", "upvalues", "protos" } do
                    local ok, result = context.compat:Call("debug.get" .. field, item)
                    data[field] = if ok then result else tostring(result)
                end
                item = data
            end
            shell.title.Text = title
            tree:SetNodes(Values.nodes(item, title))
            tree:Expand(1, true)
            preview(item)
            back:SetEnabled(#inspector.history > 0)
        end
        inspector.load = load
        tree:OnSelected(function(node) if node and node.inspectable then preview(node.value) end end)
        back = navigation:NewButton({ text = "Back" }, function()
            local previous = table.remove(inspector.history)
            if previous then load(previous.value, previous.label) end
        end)
        drill = navigation:NewButton({ text = "Inspect selected" }, m.action(context, function()
            local kind = Values.kind(inspector.selected)
            if kind ~= "function" and kind ~= "Instance" then return end
            if #inspector.history >= 16 then table.remove(inspector.history, 1) end
            table.insert(inspector.history, { value = inspector.source, label = inspector.label })
            load(inspector.selected, kind .. " inspector")
        end))
        hooks = navigation:NewButton({ text = "Send to Hooks" }, function()
            if type(inspector.selected) == "function" and context.selectHook then
                context.selectHook(inspector.selected, inspector.label .. " / selected function")
            end
        end)
        valueActions:NewButton({ text = "Show raw value" }, function()
            viewer:SetText(Values.serialize(inspector.selected))
        end)
        local raw = valueActions:NewButton({ text = "Plain text" }, function() viewer:SetSyntax(not viewer.highlighted and "lua" or false) end)
        m.bindSyntax(viewer, raw)
        copy = valueActions:NewButton({ text = "Copy value" }, m.action(context, function()
            if not context.compat:Has("setclipboard") then return end
            m.copy(context, Values.serialize(inspector.selected))
        end))
        copy:SetEnabled(context.compat:Has("setclipboard"))
        shell.scope:Add(function() if context.inspector == inspector then context.inspector = nil end end)
    end
    table.clear(inspector.history)
    inspector.load(value, label or "Value inspector")
    inspector.shell:Show()
    return inspector.shell
end
return m
end function __DARKLUA_BUNDLE_MODULES.L():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.L if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.L=v end return v.c end end do local function __modImpl()
local Workbench = __DARKLUA_BUNDLE_MODULES.L()
local m = {}
function m.init(window, context)
    local tab = window:NewTab("Overview")
    local welcome = tab:NewSection("DebugSuite", "top")
    Workbench.hint(welcome, { height = 110, text = "Choose what you want to investigate below.\nFor a function: discover in Functions -> select a result -> Send to Hooks -> start tracing -> trigger it in-game -> inspect calls.\nFor state changes: select a table or instance -> capture a baseline -> reproduce -> compare.\nCtrl+F focuses search (captured-call filtering in Hooks). Scans and tracing start when you request them." })
    local function open(name)
        local target = context.tabs[name]
        if not target then window:Notify({ text = name .. " is unavailable. Open the console for initialization details.", messageType = "error" }) return end
        window:SelectTab(target)
        if name ~= "Hooks" and target.searchInput then target.searchInput:Focus() end
    end
    local function taskRow(entries)
        local row = welcome:NewRow()
        for _, entry in entries do
            row:NewButton({ text = entry[1] }, function() open(entry[2]) end)
        end
    end
    taskRow({ { "Find functions", "Functions" }, { "Trace / manage hooks", "Hooks" }, { "Watch remotes", "Remotes" } })
    taskRow({ { "Browse instances", "Explorer" }, { "Search tables", "GC" }, { "Read logs", "Logs" }, { "Check performance", "Runtime" } })
    local tools = tab:NewSection("What each tool shows", "left")
    Workbench.hint(tools, { height = 225, text = "Explorer: hierarchy, properties, attributes, source.\nFunctions: names, constants, upvalues, nested functions.\nHooks: arguments, returns, errors; Standard / Volt OTH.\nGC: table search, field inspection, snapshot diffs.\nRemotes: incoming events, selected outgoing calls.\nLogs: client output; level and text filters.\nRuntime: frame timing and memory.\n\nDisabled actions need a selection or an executor API. Check Capabilities below." })
    local reportSection = tab:NewSection("Session", "right")
    local report = Workbench.viewer(context, reportSection, { height = 190 })
    local function update()
        local ok, name, version = context.compat:Call("identifyexecutor")
        local managed, active = 0, 0
        for _, entry in context.hooks.entries do
            managed += 1
            if entry.active then active += 1 end
        end
        report:SetText(string.format("Place: %s\nGame: %s\nJob: %s\nRuntime: %s\nHooks at last refresh: %d/32; capture %s\nCalls retained at refresh: %d/500\n\nAPI checks are passive; calls can still fail.\nClient tools show client-visible state only.",
            tostring(game.PlaceId), tostring(game.GameId), tostring(game.JobId), if ok then tostring(name) .. " " .. tostring(version or "") else "unidentified",
            managed, if context.hooks.paused then "paused" elseif active > 0 then "enabled" else "stopped", #context.hooks.recorder.records))
    end
    reportSection:NewButton({ text = "Refresh session" }, update)
    local limits = tab:NewSection("Working limits", "right")
    Workbench.hint(limits, { height = 170, text = "Inventories: 30,000 visited values / 1,000 results.\nGC search: first 200 raw entries per table.\nInspectors: bounded depth, strings and entries; truncation is reported.\nHooks: 32 targets; capture: 100 calls/sec; history: 500.\nRemote watches: 32 incoming + 32 outgoing; shared capture: 100 events/sec; history: 500.\nLogs: 1,000 entries. Frame samples: latest 120.\n\nCancel takes effect between batches. The executor's native GC call itself cannot be interrupted.\nReports are diagnostic, lossy Lua-style text, not executable reconstruction." })
    local capabilities = tab:NewSection("Capabilities", "bottom")
    local list = capabilities:NewList({ height = 280, columns = {
        { key = "name", text = "API", width = 170 }, { key = "status", text = "Status", width = 90 }, { key = "feature", text = "Used for" },
    } })
    list:SetRecords(context.compat.records)
    update()
    return tab
end
return m
end function __DARKLUA_BUNDLE_MODULES.M():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.M if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.M=v end return v.c end end do local function __modImpl()
local Workbench = __DARKLUA_BUNDLE_MODULES.L()
local Catalog = __DARKLUA_BUNDLE_MODULES.J()
local Values = __DARKLUA_BUNDLE_MODULES.E()
local Instances = __DARKLUA_BUNDLE_MODULES.K()
local Scope = __DARKLUA_BUNDLE_MODULES.d()
local m = {}
function m.init(window, context)
    local c = Workbench.scanner(context, "Explorer", "Browse the lazy hierarchy or scan client-visible names/classes/paths. Properties are read-only. Select Scripts to find readable source.")
    local mode = c.tools:NewDropdown({ text = "Kind", options = { "All", "Scripts", "Remotes" }, value = "All" })
    mode:OnChanged(c.invalidate)
    local hierarchy = c.tab:NewSection("Hierarchy", "left")
    local tree = hierarchy:NewTree({ height = 250 })
    local results = c.tab:NewSection("Search results", "left"):NewList({ height = 250, columns = {
        { key = "name", text = "Name" }, { key = "class", text = "Class", width = 100 },
    } })
    local detail = c.tab:NewSection("Properties and attributes", "right")
    local propertyTree = detail:NewTree({ height = 220 })
    local output = Workbench.viewer(context, detail, { height = 200, syntax = "lua", text = "-- Select an instance." })
    local selected, selectedValue, baseline, baselineValue, baselineLabel, dirty, elapsed = nil, nil, nil, nil, nil, false, 0
    local viewMode = "selection"
    local refreshButton, copyPath, readSource, capture, compare, clearBaseline, showRaw
    local baselineStatus = detail:NewTextViewer({ height = 45, text = "No baseline captured." })
    local function updateActions()
        if c.tab.destroyed then return end
        refreshButton:SetEnabled(selected ~= nil)
        copyPath:SetEnabled(selected ~= nil and context.compat:Has("setclipboard"))
        readSource:SetEnabled(selected ~= nil and Catalog.isScript(selected))
        capture:SetEnabled(selected ~= nil)
        compare:SetEnabled(baseline ~= nil and selected == baselineValue)
        clearBaseline:SetEnabled(baseline ~= nil)
        showRaw:SetEnabled(selectedValue ~= nil)
        baselineStatus:SetText(if baseline then "Baseline: " .. baselineLabel .. (if selected == baselineValue then "\nReady to compare." else "\nSelect this instance to compare.") else "No baseline captured.")
    end
    local watch = Scope.new()
    c.tab.scope:Add(function() watch:Destroy() end)
    local function showProperty(node, refreshing)
        if c.tab.destroyed then return end
        if node and not node.inspectable then return end
        selectedValue = if node then node.value else nil
        if node and not (refreshing and (viewMode == "source" or viewMode == "diff")) then
            if refreshing and viewMode == "raw" then
                output:SetText(Values.serialize(node.value))
                output.copyButton:SetEnabled(context.compat:Has("setclipboard"))
            else
                viewMode = "value"
                output:SetText(Workbench.preview(node.value))
                output.copyButton:SetEnabled(type(node.value) ~= "table" and type(node.value) ~= "function" and context.compat:Has("setclipboard"))
            end
        end
        updateActions()
    end
    local function refresh()
        if not selected then return end
        local data = Instances.describe(selected)
        propertyTree:SetNodes(Instances.propertyNodes(selected, data), true, false)
        propertyTree:Expand("instance", true)
        local selectedNode
        for _, entry in propertyTree.visibleNodes do
            if entry.node.id == propertyTree.selectedId then selectedNode = entry.node break end
        end
        showProperty(selectedNode, true)
        if (viewMode == "selection" or viewMode == "value" or viewMode == "raw") and selectedValue == nil then
            viewMode = "selection"
            output:SetText("-- " .. Values.preview(selected) .. "\n-- Select a property or attribute to preview its value.")
            output.copyButton:SetEnabled(false)
        end
        updateActions()
    end
    local function select(instance)
        if c.tab.destroyed then return end
        watch:Destroy()
        watch = Scope.new()
        selected = instance
        selectedValue = nil
        viewMode = "selection"
        propertyTree:SetNodes({}, false, false)
        dirty = false
        if not selected then
            output:SetText("-- Select an instance.")
            output.copyButton:SetEnabled(false)
            updateActions()
            return
        end
        refresh()
        watch:Connect(selected.Changed, function() dirty = true end)
        watch:Connect(selected.AttributeChanged, function() dirty = true end)
        watch:Connect(selected.Destroying, function()
            watch:Destroy()
            selected = nil
            selectedValue = nil
            propertyTree:SetNodes({}, false, false)
            output:SetText("-- Selected instance was destroyed.")
            output.copyButton:SetEnabled(false)
            updateActions()
        end)
    end
    tree:OnSelected(Workbench.action(context, function(node) if node and node.value then select(node.value) end end))
    results:OnSelected(Workbench.action(context, function(record) select(if record then record.value else nil) end))
    propertyTree:OnSelected(function(node)
        showProperty(node, false)
    end)
    local live = detail:NewToggle({ text = "Live property refresh (5 Hz)", value = false })
    c.tab.scope:Connect(window.ctx.services.RunService.RenderStepped, function(dt)
        elapsed += dt
        if elapsed >= .2 then
            elapsed = 0
            if dirty and live:GetValue() and window.currentTab == c.tab then dirty = false refresh() end
        end
    end)
    refreshButton = detail:NewButton({ text = "Refresh properties" }, Workbench.action(context, refresh))
    copyPath = detail:NewButton({ text = "Copy instance path" }, Workbench.action(context, function()
        assert(selected, "Select an instance first")
        Workbench.copy(context, Values.path(selected))
    end))
    readSource = detail:NewButton({ text = "Read script source" }, Workbench.action(context, function()
        assert(selected and Catalog.isScript(selected), "Select a Script, LocalScript or ModuleScript")
        local ok, source = pcall(function() return selected.Source end)
        assert(ok and type(source) == "string", "Source is not readable in this runtime")
        output:SetSyntax("lua")
        viewMode = "source"
        output:SetText(source:sub(1, 131072) .. (if #source > 131072 then "\n-- Source truncated at 128 KiB" else ""))
        output.copyButton:SetEnabled(context.compat:Has("setclipboard"))
    end))
    capture = detail:NewButton({ text = "Capture property baseline" }, Workbench.action(context, function()
        assert(selected, "Select an instance first")
        local data = Instances.describe(selected)
        baseline = Values.snapshot({ properties = data.properties, attributes = data.attributes })
        baselineValue = selected
        baselineLabel = Values.preview(selected) .. (if baseline.truncated then " (partial)" else "")
        updateActions()
    end))
    compare = detail:NewButton({ text = "Compare properties" }, Workbench.action(context, function()
        assert(baseline and selected == baselineValue, "Select the instance used for the baseline")
        local data = Instances.describe(selected)
        output:SetSyntax(false)
        viewMode = "diff"
        output:SetText(Values.diff(baseline, Values.snapshot({ properties = data.properties, attributes = data.attributes })))
        output.copyButton:SetEnabled(context.compat:Has("setclipboard"))
    end))
    clearBaseline = detail:NewButton({ text = "Clear baseline" }, function()
        baseline, baselineValue, baselineLabel = nil, nil, nil
        updateActions()
    end)
    showRaw = detail:NewButton({ text = "Show raw value" }, function()
        viewMode = "raw"
        output:SetText(Values.serialize(selectedValue))
        output.copyButton:SetEnabled(context.compat:Has("setclipboard"))
    end)
    hierarchy:NewButton({ text = "Refresh hierarchy" }, function() tree:SetNodes(Instances.nodes(game, window.guis.ScreenGui)) end)
    c.row:NewButton({ text = "Clear", width = 60 }, function()
        c.jobs:Cancel()
        results:Clear()
        select(nil)
        baseline, baselineValue = nil, nil
        updateActions()
        c.status:SetText("Results and baseline cleared.")
    end)
    c.scan = function()
        local query, kind = c.search:GetValue(), mode:GetValue()
        c.jobs:Run(function(checkpoint) return Catalog.instances(game, query, kind, window.guis.ScreenGui, checkpoint) end,
            function(records) results:SetRecords(records) end)
    end
    tree:SetNodes(Instances.nodes(game, window.guis.ScreenGui))
    tree:Expand(1, true)
    c.tab.controller = c
    updateActions()
    output.copyButton:SetEnabled(false)
    return c.tab
end
return m
end function __DARKLUA_BUNDLE_MODULES.N():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.N if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.N=v end return v.c end end do local function __modImpl()-- Comma-separated literals, with CSV-style double quotes; never evaluate input.

local m = {}
function m.parse(text, limit)
    local rules, position, length = {}, 1, #text
    local function skipSpace()
        while position <= length and text:sub(position, position):match("%s") do position += 1 end
    end
    while position <= length do
        skipSpace()
        if position > length then break end
        if text:sub(position, position) == "," then position += 1 continue end
        local kind, value
        local label = "Constant #" .. (#rules + 1) .. ": "
        if text:sub(position, position) == '"' then
            local pieces = {}
            position += 1
            while true do
                local closing = text:find('"', position, true)
                assert(closing, label .. "missing closing double quote")
                table.insert(pieces, text:sub(position, closing - 1))
                position = closing + 1
                if text:sub(position, position) ~= '"' then break end
                table.insert(pieces, '"')
                position += 1
            end
            kind, value = "string", table.concat(pieces)
            skipSpace()
            assert(position > length or text:sub(position, position) == ",", label .. "expected a comma after the quoted string")
        else
            local comma = text:find(",", position, true) or length + 1
            local token = text:sub(position, comma - 1):match("^%s*(.-)%s*$")
            assert(not token:find('"', 1, true), label .. 'wrap text containing double quotes in quotes and double each inner quote')
            position = comma
            if token == "true" or token == "false" then
                kind, value = "boolean", token == "true"
            else
                local number = tonumber(token)
                if number then
                    assert(number == number and math.abs(number) < math.huge, label .. "number must be finite")
                    kind, value = "number", number
                else kind, value = "string", token end
            end
        end
        assert(#rules < (limit or 16), "At most " .. (limit or 16) .. " constant filters; remove some comma-separated values")
        table.insert(rules, { kind = kind, value = value })
        position += 1
    end
    return rules
end
return m
end function __DARKLUA_BUNDLE_MODULES.O():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.O if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.O=v end return v.c end end do local function __modImpl()
local Workbench = __DARKLUA_BUNDLE_MODULES.L()
local Catalog = __DARKLUA_BUNDLE_MODULES.J()
local Values = __DARKLUA_BUNDLE_MODULES.E()
local ConstantFilters = __DARKLUA_BUNDLE_MODULES.O()
local m = {}
function m.init(window, context)
    local c = Workbench.scanner(context, "Functions", "1. Enter optional filters and Scan, or type constants below and click Scan constants only.  2. Select a result.\n3. Inspect its values or Send to Hooks. Scanning and inspection do not run the function.")
    c.status.frame.Size = UDim2.new(1, 0, 0, 85)
    c.search:SetPlaceholder("Name, source or table field contains... (optional; Enter to scan)")
    local metadataRow = c.tools:NewRow()
    local source = metadataRow:NewTextbox({ text = "Source contains... (optional)", fill = true })
    local arguments = metadataRow:NewTextbox({ text = "Parameter count (any)", width = 170 })
    for _, input in { source, arguments } do
        input:OnChanged(c.invalidate)
        input:OnSubmitted(function() c.scan() end)
    end
    local caseSensitive = c.tools:NewToggle({ text = "Case-sensitive names / sources", value = false })
    caseSensitive:OnChanged(c.invalidate)
    local filters = c.tab:NewSection("Search constants (comma-separated)", "top")
    local constantRow = filters:NewRow()
    local constants = constantRow:NewTextbox({ text = "e.g. integrity, Damage, 100, true (optional)", fill = true })
    constants:OnChanged(c.invalidate)
    constants:OnSubmitted(function() c.scan() end)
    local scanConstants = constantRow:NewButton({ text = "Scan constants only", width = 160 }, function() c.scan(true) end)
    scanConstants:SetEnabled(context.compat:Has("debug.getconstants"))
    local onBusyChanged = c.jobs.onBusyChanged
    c.jobs.onBusyChanged = function(busy)
        onBusyChanged(busy)
        scanConstants:SetEnabled(not busy and context.compat:Has("debug.getconstants"))
    end
    constantRow:NewButton({ text = "Clear constants", width = 115 }, function() constants:SetValue("") end)
    Workbench.hint(filters, { height = 90, text = 'Scan constants only ignores the name, source and parameter filters above. Regular Scan / Enter combines all filters.\nStrings always ignore case and match part of a constant: integrity finds Integrity-3212zx.\nSeparate values with commas. Numbers and true/false keep their types; quote text like "42" or "a,b".\nAll = every listed constant; Any = at least one. Leave blank to skip constants during a regular scan.' })
    local constantMode = filters:NewDropdown({ text = "Match constants", options = { "All", "Any" }, value = "All" })
    constantMode:OnChanged(c.invalidate)
    if not context.compat:Has("debug.getconstants") then
        constants:SetEnabled(false)
        constants:SetPlaceholder("Constant search unavailable: missing debug.getconstants")
        Workbench.hint(filters, { height = 40, text = "Constant filters unavailable: this executor has no debug.getconstants." })
    end
    local selected
    local actions = {}
    local resultSection = c.tab:NewSection("Functions", "left")
    local sendToHooks = resultSection:NewButton({ text = "Send to Hooks" }, function()
        if selected and context.selectHook then context.selectHook(selected.value, selected.values.name .. " / " .. selected.values.source) end
    end)
    sendToHooks:SetEnabled(false)
    table.insert(actions, { button = sendToHooks, handoff = true })
    local results = resultSection:NewList({ height = 310, columns = {
        { key = "name", text = "Name" }, { key = "line", text = "Line", width = 55 }, { key = "source", text = "Source" },
    } })
    local detail = c.tab:NewSection("Function details", "right")
    local viewer = Workbench.viewer(context, detail, { height = 130, syntax = "lua", text = "-- Select a function." })
    local selection = Workbench.hint(detail, { height = 85, text = "No function selected. Scan, then click a result on the left." })
    c.row:NewButton({ text = "Clear", width = 60 }, function()
        c.jobs:Cancel()
        results:Clear()
        c.status:SetText("Results cleared.")
    end)
    local function inspect(record)
        if c.tab.destroyed then return end
        selected = record
        for _, action in actions do action.button:SetEnabled(record ~= nil and (not action.api or context.compat:Has(action.api))
            and (not action.handoff or context.selectHook ~= nil)) end
        viewer.copyButton:SetEnabled(record ~= nil and context.compat:Has("setclipboard"))
        if not record then
            viewer:SetText("-- Select a function.")
            selection:SetText("No function selected. Scan, then click a result on the left.")
            return
        end
        local metadata = Catalog.metadata(context.compat, record.value)
        metadata.functionId = Catalog.functionId(record.value)
        metadata.alias = record.values.alias
        viewer:SetText(Values.serialize(metadata))
        local unavailable = {}
        for _, field in { "constants", "upvalues", "protos" } do
            if not context.compat:Has("debug.get" .. field) then table.insert(unavailable, if field == "protos" then "nested functions" else field) end
        end
        selection:SetText("Selected: function #" .. metadata.functionId .. " / " .. tostring(record.values.name) .. "\nSend to Hooks above the results transfers this exact function. Start tracing there."
            .. (if #unavailable > 0 then "\nUnavailable in this executor: " .. table.concat(unavailable, ", ") .. "." else "\nInspect buttons open a shared value browser."))
    end
    results:OnSelected(inspect)
    local primary = detail:NewRow()
    local open = primary:NewButton({ text = "Inspect function" }, Workbench.action(context, function()
        if selected then Workbench.inspect(context, selected.value, selected.values.name .. " / function") end
    end))
    open:SetEnabled(false)
    table.insert(actions, { button = open })
    local categories = detail:NewRow()
    for _, field in { { "constants", "Inspect constants", "Constants" }, { "upvalues", "Inspect upvalues", "Upvalues" }, { "protos", "Inspect nested functions", "Nested functions" } } do
        local api = "debug.get" .. field[1]
        local owner = if field[1] == "protos" then detail else categories
        local button = owner:NewButton({ text = field[2] }, Workbench.action(context, function()
            if not selected then return end
            local ok, value = context.compat:Call(api, selected.value)
            if not ok then error(value, 0) end
            Workbench.inspect(context, value, selected.values.name .. " / " .. field[3])
        end))
        button:SetEnabled(false)
        table.insert(actions, { button = button, api = api })
    end
    local refresh = detail:NewButton({ text = "Refresh function details" }, function() inspect(selected) end)
    refresh:SetEnabled(false)
    table.insert(actions, { button = refresh })
    Workbench.hint(detail, { height = 65, text = "In the inspector: expand arrows to browse tables; click a value to preview it. Copy value always copies raw data." })
    c.scan = function(constantsOnly)
        local query = if constantsOnly then "" else c.search:GetValue()
        c.jobs:Run(function(checkpoint)
            local countText = if constantsOnly then "" else arguments:GetValue():match("^%s*(.-)%s*$")
            local count = if countText == "" then nil else tonumber(countText)
            assert(countText == "" or count and count >= 0 and count < math.huge and count % 1 == 0, "Parameter count must be a nonnegative integer")
            local rules = ConstantFilters.parse(constants:GetValue(), Catalog.filterLimit)
            assert(not constantsOnly or #rules > 0, "Enter at least one constant in the comma-separated box before scanning constants only")
            local records, summary = Catalog.functions(context.compat, query, { constants = rules,
                constantMode = constantMode:GetValue(),
                caseSensitive = caseSensitive:GetValue(), source = if constantsOnly then "" else source:GetValue(), arguments = count }, checkpoint)
            if constantsOnly then summary ..= "\nConstants-only scan: name/source/parameter filters ignored." end
            return records, summary .. (if #records == 0 then "\nNo matches. Try fewer constants, Match constants: Any, or a broader name/source/parameter filter." else "\nSelect a result to inspect it or send it to Hooks.")
        end, function(records) results:SetRecords(records) end)
    end
    c.tab.controller = c
    c.results, c.viewer, c.selection = results, viewer, selection
    c.constants, c.constantMode, c.scanConstantsButton = constants, constantMode, scanConstants
    c.source, c.arguments, c.caseSensitive = source, arguments, caseSensitive
    inspect(nil)
    return c.tab
end
return m
end function __DARKLUA_BUNDLE_MODULES.P():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.P if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.P=v end return v.c end end do local function __modImpl()
local ReturnValues = __DARKLUA_BUNDLE_MODULES.G()
local m = {}
m.__index = m

function m:Refresh()
    local kind = self.kind:GetValue()
    self.value:SetVisible(kind == "string" or kind == "number")
    self.boolean:SetVisible(kind == "boolean")
    self.kind:SetEnabled(self.enabled)
    self.value:SetEnabled(self.enabled and (kind == "string" or kind == "number"))
    self.boolean:SetEnabled(self.enabled and kind == "boolean")
end

function m:SetEnabled(enabled)
    self.enabled = enabled
    self:Refresh()
end

function m:GetValue()
    return ReturnValues.parse(self.kind:GetValue(),
        if self.kind:GetValue() == "boolean" then self.boolean:GetValue() else self.value:GetValue())
end

function m.new(owner, label, kind, value, options)
    local panel = owner:NewPanel({ auto = true, padding = 0, clip = false })
    local self = setmetatable({ panel = panel, enabled = true }, m)
    self.kind = panel:NewDropdown({ text = label, options = options or { "nil", "string", "number", "boolean" }, value = kind or "nil" })
    self.value = panel:NewTextbox({ text = "Literal value (strings need no quotes)" })
    self.value:SetValue(if value == nil then "" else tostring(value))
    self.boolean = panel:NewDropdown({ text = "Value", options = { "false", "true" }, value = if value == true then "true" else "false" })
    self.kind:OnChanged(function() self:Refresh() end)
    self:Refresh()
    return self
end

return m
end function __DARKLUA_BUNDLE_MODULES.Q():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.Q if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.Q=v end return v.c end end do local function __modImpl()
local Workbench = __DARKLUA_BUNDLE_MODULES.L()
local ReturnValues = __DARKLUA_BUNDLE_MODULES.G()
local LiteralEditor = __DARKLUA_BUNDLE_MODULES.Q()
local m = {}
m.__index = m
function m:AddSlot(kind, value)
    assert(#self.slots < ReturnValues.limit, "16 return-slot limit reached")
    local index = #self.slots + 1
    local slot = LiteralEditor.new(self.fields, "Return #" .. index, kind, value)
    slot:SetEnabled(self:CanEdit())
    table.insert(self.slots, slot)
end
function m:CanEdit()
    local entry = self.entry
    return entry ~= nil and entry.active and entry.editable and self.manager.entries[entry.target] == entry
end
function m:SetEntry(entry)
    if self.entry ~= entry then
        self.entry = entry
        self.fields:Clear()
        table.clear(self.slots)
        local values = entry and entry.returnValues
        if values then
            for i = 1, values.n do self:AddSlot(type(values[i]), values[i]) end
        else self:AddSlot() end
    end
    local editable = self:CanEdit()
    self.apply:SetEnabled(editable)
    self.disable:SetEnabled(editable and entry.override ~= nil)
    self.add:SetEnabled(editable and #self.slots < ReturnValues.limit)
    self.remove:SetEnabled(editable and #self.slots > 0)
    for _, slot in self.slots do
        slot:SetEnabled(editable)
    end
    self.status:SetText(if not entry then "OFF: start tracing a function, then configure its returns."
        elseif not editable then "Unavailable: select an active function trace."
        else "Target: " .. entry.label .. "\n" .. (if entry.override then "ON: replacing all returns with " .. entry.override.values.n .. " slots."
            else "OFF: original return values pass through.") .. "\nEdits take effect when you click Apply and enable override.")
end
function m.new(section, manager, action)
    local self = setmetatable({ manager = manager, slots = {} }, m)
    self.status = Workbench.hint(section, { height = 85 })
    Workbench.hint(section, { height = 85, text = "The original function still runs. Replace its entire successful return tuple (0-16 slots); nil slots count. Strings are literal text; choose true or false for booleans. Errors pass through. Pause capture leaves overrides active." })
    self.fields = section:NewPanel({ auto = true, padding = 0 })
    self:AddSlot()
    local row = section:NewRow()
    self.add = row:NewButton({ text = "Add return slot" }, action(function()
        assert(self:CanEdit(), "Select an active function trace")
        self:AddSlot()
        return "Return slot added to draft."
    end))
    self.remove = row:NewButton({ text = "Remove last slot" }, action(function()
        assert(self:CanEdit(), "Select an active function trace")
        local slot = table.remove(self.slots)
        if slot then slot.panel:Destroy() end
        return "Draft has " .. #self.slots .. " return slots."
    end))
    self.apply = section:NewButton({ text = "Apply and enable override" }, action(function()
        assert(self:CanEdit(), "Select an active function trace")
        local values = { n = #self.slots }
        for i, slot in self.slots do
            local ok, value = pcall(slot.GetValue, slot)
            assert(ok, "Return #" .. i .. ": " .. tostring(value))
            values[i] = value
        end
        manager:SetReturnOverride(self.entry.target, values)
        return "Return override enabled for " .. self.entry.label .. " (" .. values.n .. " slots)."
    end))
    self.disable = section:NewButton({ text = "Disable override" }, action(function()
        assert(self:CanEdit(), "Select an active function trace")
        manager:DisableReturnOverride(self.entry.target)
        return "Return override disabled; tracing continues."
    end))
    return self
end
return m
end function __DARKLUA_BUNDLE_MODULES.R():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.R if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.R=v end return v.c end end do local function __modImpl()
local Workbench = __DARKLUA_BUNDLE_MODULES.L()
local Catalog = __DARKLUA_BUNDLE_MODULES.J()
local Values = __DARKLUA_BUNDLE_MODULES.E()
local OverrideEditor = __DARKLUA_BUNDLE_MODULES.R()
local m = {}
function m.init(window, context)
    local c = { tab = window:NewTab("Hooks") }
    local workflow = c.tab:NewSection("Hooks workflow", "top")
    c.help = Workbench.hint(workflow, { height = 65, text = "1. Find a function in Functions and click Send to Hooks. Its exact function reference arrives here.\n2. Choose a backend and Trace selected function.  3. Trigger it in-game, then read captured calls below." })
    workflow:NewButton({ text = "Find / change function" }, Workbench.action(context, function()
        local functions = context.tabs.Functions
        assert(functions and not functions.destroyed, "Functions is unavailable; check the console for initialization errors")
        window:SelectTab(functions)
        window.shell:Focus()
    end))
    local manager = context.hooks
    local targetSection = c.tab:NewSection("Selected function", "left")
    targetSection.frame:FindFirstChild("Header").Text = "1. Function from discovery"
    local targetReport = Workbench.viewer(context, targetSection, { height = 155, syntax = "lua",
        text = "-- No function selected.\n-- Open Functions, select a result, then click Send to Hooks." })
    targetReport.copyButton:SetEnabled(false)
    local controls = c.tab:NewSection("Tracing", "right")
    controls.frame:FindFirstChild("Header").Text = "2. Start or stop tracing"
    local targetStatus = Workbench.hint(controls, { height = 115, text = "Select a function." })
    local backend = controls:NewDropdown({ text = "Backend", options = { "Standard", "Volt OTH" },
        value = if manager:Available("Standard") or not manager:Available("Volt OTH") then "Standard" else "Volt OTH" })
    local pause = controls:NewToggle({ text = "Pause hook capture", value = false })
    local activeSection = c.tab:NewSection("Managed hooks", "left")
    local active = activeSection:NewList({ height = 150, columns = {
        { key = "name", text = "Target" }, { key = "backend", text = "Backend", width = 85 },
        { key = "hits", text = "Calls", width = 55 }, { key = "state", text = "State", width = 100 },
    } })
    local history = c.tab:NewSection("Captured calls", "bottom")
    history.frame:FindFirstChild("Header").Text = "3. Read captured calls"
    local summary = Workbench.hint(history, { height = 60 })
    local filter = history:NewTextbox({ text = "Filter captured calls" })
    c.tab.searchInput = filter
    local calls = history:NewList({ height = 180, columns = {
        { key = "time", text = "Seconds", width = 80 }, { key = "path", text = "Function" },
        { key = "args", text = "Args", width = 40 }, { key = "outcome", text = "Outcome", width = 75 },
        { key = "duration", text = "ms", width = 65 }, { key = "partial", text = "Data", width = 60 },
    } })
    local follow = history:NewToggle({ text = "Follow latest matching call", value = true })
    local output = Workbench.viewer(context, history, { height = 190, syntax = "lua", text = "-- No calls yet. Start tracing, then reproduce the action." })
    local target, label, selectedEntry, start, stop, stopAll, lastAction, editor
    local function showCall(record)
        output:SetText(if record then record.text .. (if record.values.outcome == "running" then "\n-- Still running; waiting for returns or an error." else "")
            else "-- No call selected. Start tracing and reproduce the action, or select a captured row.")
    end
    local function refreshCalls()
        calls:SetRecords(manager.recorder.records, false)
        if follow:GetValue() and #calls.filtered > 0 then
            local latest = calls.filtered[1]
            for _, record in calls.filtered do if record.id > latest.id then latest = record end end
            calls:Select(latest.id, false)
        end
        -- The recorder finishes yielded calls in place; list identity does not change.
        showCall(calls.selectedRecord)
    end
    filter:OnChanged(function(value) calls:SetFilter(value, false) refreshCalls() end)
    follow:OnChanged(refreshCalls)
    calls:OnSelected(function(record)
        if record then follow:SetValue(false) end
        showCall(record)
    end)
    local function update()
        if c.tab.destroyed then return end
        local canTrace, reason = manager:CanTrace(target, backend:GetValue())
        local state
        if selectedEntry and manager.entries[selectedEntry.target] == selectedEntry then
            state = if selectedEntry.error then "STOP FAILED: capture off. Retry Stop selected hook.\n" .. selectedEntry.error
                elseif manager.paused then "PAUSED: hook installed; new calls are not recorded."
                elseif selectedEntry.hits == 0 then "TRACING: waiting for a call. Reproduce the action now."
                else "TRACING: " .. selectedEntry.hits .. " calls observed."
            state ..= "\nInstalled backend: " .. selectedEntry.backend
            if selectedEntry.override then state ..= " | Return override ON (" .. selectedEntry.override.values.n .. " slots)." end
            if selectedEntry.hits > 0 then
                state ..= if selectedEntry.recorder == manager.recorder then " | Calls below." else " | Traffic in Remotes."
            end
        else
            state = if not target then "Choose a function in Functions, then click Send to Hooks."
                elseif canTrace then "READY: click Trace selected function (" .. backend:GetValue() .. ")." else "BLOCKED: " .. reason
            if canTrace and manager.paused then state ..= "\nCapture is paused; turn off Pause hook capture to record." end
        end
        targetStatus:SetText("Target: " .. (label or "none") .. "\n" .. state .. (if lastAction then "\nLast action: " .. lastAction else ""))
        start:SetEnabled(canTrace)
        local records = {}
        local tracing, retry = 0, 0
        for _, entry in manager.entries do
            if entry.active then tracing += 1 else retry += 1 end
            table.insert(records, { id = entry.id, value = entry, values = { name = entry.label, backend = entry.backend, hits = entry.hits,
                state = if entry.error then "retry stop" elseif not entry.active then "stopped" elseif manager.paused then "paused"
                    elseif entry.override then "overriding" elseif entry.hits == 0 then "waiting" else "tracing" } })
        end
        table.sort(records, function(a, b) return a.id < b.id end)
        active.selectedId = if selectedEntry then selectedEntry.id else nil
        -- Programmatic refreshes must not feed back into the selection handler,
        -- including when Roblox dispatches BindableEvent callbacks later.
        active:SetRecords(records, false)
        stop:SetEnabled(selectedEntry ~= nil and manager.entries[selectedEntry.target] == selectedEntry)
        stopAll:SetEnabled(#records > 0)
        if editor then editor:SetEntry(if selectedEntry and manager.entries[selectedEntry.target] == selectedEntry then selectedEntry else nil) end
        summary:SetText(string.format("%s | %d tracing | %d need stop retry | %d/32 managed\n%d/500 retained calls | %d rate-limited | %d capture failures",
            if manager.paused then "Capture paused" elseif tracing > 0 then "Capture live" else "Capture stopped",
            tracing, retry, #records, #manager.recorder.records, manager.recorder.dropped, manager.failures))
    end
    local function setTarget(value, name)
        target, label = value, name
        c.target, c.label = value, name
        if value then
            local metadata = Catalog.metadata(context.compat, value)
            metadata.functionId, metadata.label = Catalog.functionId(value), name
            targetReport:SetText(Values.serialize(metadata))
        else
            targetReport:SetText("-- No function selected.\n-- Open Functions, select a result, then click Send to Hooks.")
        end
        targetReport.copyButton:SetEnabled(value ~= nil and context.compat:Has("setclipboard"))
    end
    c.select = function(value, name)
        assert(value == nil or type(value) == "function", "Select a function")
        setTarget(value, name or (if value then "Inspected function" else nil))
        lastAction = nil
        selectedEntry = if value then manager.entries[value] else nil
        update()
    end
    context.selectHook = function(value, name)
        c.select(value, name or "Inspected function")
        window:SelectTab(c.tab)
        c.tab.container.CanvasPosition = Vector2.new(0, 0)
        window.shell:Focus()
    end
    active:OnSelected(function(record)
        selectedEntry = if record then record.value else nil
        if selectedEntry then setTarget(selectedEntry.target, selectedEntry.label) end
        lastAction = nil
        update()
    end)
    local function action(callback)
        return function()
            local ok, message = pcall(callback)
            lastAction = if ok then message else "Failed: " .. tostring(message)
            update()
            if ok then window:Log(message, "success")
            else window:Notify({ text = tostring(message), messageType = "error" }) end
        end
    end
    start = controls:NewButton({ text = "Trace selected function" }, action(function()
        selectedEntry = manager:Add(target, label, backend:GetValue())
        return "Hook installed. " .. (if manager.paused then "Capture is paused." else "Reproduce the action to capture calls.")
    end))
    stop = controls:NewButton({ text = "Stop selected hook" }, action(function()
        assert(selectedEntry, "Select a managed hook first")
        local ok, err = manager:Stop(selectedEntry.target)
        assert(ok, err)
        selectedEntry = nil
        return "Original function restored; captured history kept."
    end))
    stopAll = controls:NewButton({ text = "Stop all hooks" }, action(function()
        local ok, err = manager:StopAll()
        assert(ok, err)
        selectedEntry = nil
        return "All managed hooks restored (including outgoing remote hooks)."
    end))
    pause:OnChanged(function(value)
        manager.paused = value
        lastAction = if value then "Capture paused; calls still run." else "Capture resumed."
        update()
    end)
    controls:NewButton({ text = "Refresh hook status" }, update)
    Workbench.hint(controls, { height = 65, text = "Tracing records arguments, returns, errors and time while the original function runs. Pause skips new captures; Stop restores the function. Volt OTH accepts C functions only." })
    editor = OverrideEditor.new(c.tab:NewSection("Return overrides", "right"), manager, action)
    history:NewButton({ text = "Clear captured calls" }, function()
        manager.recorder:Clear()
        calls:Clear()
        showCall(nil)
        update()
    end)
    backend:OnChanged(update)
    local elapsed = 0
    c.tab.scope:Connect(window.ctx.services.RunService.RenderStepped, function(dt)
        elapsed += dt
        if elapsed >= .2 and manager.dirty then
            elapsed, manager.dirty = 0, false
            refreshCalls()
            update()
        end
    end)
    c.tab.scope:Add(function()
        context.selectHook = nil
        local targets = {}
        for targetValue, entry in manager.entries do
            if entry.recorder == manager.recorder then table.insert(targets, targetValue) end
        end
        for _, targetValue in targets do
            local ok, err = manager:Stop(targetValue)
            if not ok then warn("DebugSuite hook cleanup: " .. err) end
        end
    end)
    c.tab.controller = c
    c.targetStatus, c.targetReport, c.calls, c.output, c.follow, c.pause, c.backend = targetStatus, targetReport, calls, output, follow, pause, backend
    c.overrideEditor = editor
    update()
    return c.tab
end
return m
end function __DARKLUA_BUNDLE_MODULES.S():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.S if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.S=v end return v.c end end do local function __modImpl()
local Workbench = __DARKLUA_BUNDLE_MODULES.L()
local Catalog = __DARKLUA_BUNDLE_MODULES.J()
local Values = __DARKLUA_BUNDLE_MODULES.E()
local m = {}
function m.init(window, context)
    local c = Workbench.scanner(context, "GC", "Literal search across raw table keys and value previews. Capture a baseline, then compare after reproducing a bug.")
    local results = c.tab:NewSection("Tables", "left"):NewList({ height = 350, columns = {
        { key = "name", text = "Table", width = 90 }, { key = "entries", text = "Keys", width = 45 }, { key = "preview", text = "Preview", syntax = "lua" },
    } })
    local detail = c.tab:NewSection("Table contents", "right")
    local baselineStatus = detail:NewTextViewer({ height = 45, text = "No baseline captured." })
    local tree = detail:NewTree({ height = 250 })
    local selected, baseline, baselineValue, baselineLabel, selectedValue
    local compare, release, capture, open, metadata, showRaw
    local output = Workbench.viewer(context, c.tab:NewSection("Raw value / snapshot diff", "bottom"), { height = 180, text = "Select a table.", syntax = "lua" })
    local function updateActions()
        if c.tab.destroyed then return end
        capture:SetEnabled(selected ~= nil)
        compare:SetEnabled(baseline ~= nil and selected == baselineValue)
        release:SetEnabled(baseline ~= nil)
        open:SetEnabled(selectedValue ~= nil)
        showRaw:SetEnabled(selectedValue ~= nil)
        metadata:SetEnabled(selected ~= nil and getmetatable(selected) ~= nil)
        baselineStatus:SetText(if baseline then "Baseline: " .. baselineLabel .. (if selected ~= baselineValue then "\nSelect this table to compare." else "\nReady to compare.") else "No baseline captured.")
    end
    results:OnSelected(function(record)
        if c.tab.destroyed then return end
        selected = if record then record.value else nil
        selectedValue = selected
        tree:Clear()
        if record then
            tree:SetNodes(Values.nodes(selected, record.values.name))
            tree:Expand(1, true)
            output:SetText(Workbench.preview(selected))
        else output:SetText("-- Select a table.") end
        output.copyButton:SetEnabled(false)
        updateActions()
    end)
    tree:OnSelected(function(node)
        if c.tab.destroyed then return end
        if node and not node.inspectable then return end
        selectedValue = if node then node.value else selected
        if node then output:SetText(Workbench.preview(node.value)) end
        output.copyButton:SetEnabled(node ~= nil and type(node.value) ~= "table" and type(node.value) ~= "function" and context.compat:Has("setclipboard"))
        updateActions()
    end)
    capture = detail:NewButton({ text = "Capture baseline" }, Workbench.action(context, function()
        baseline = Values.snapshot(selected)
        baselineValue = selected
        baselineLabel = results.selectedRecord.values.name .. (if baseline.truncated then " (partial)" else "")
        updateActions()
    end))
    compare = detail:NewButton({ text = "Compare with baseline" }, Workbench.action(context, function()
        assert(baseline and selected == baselineValue, "Select the table used for the baseline")
        output:SetSyntax(false)
        output:SetText(Values.diff(baseline, Values.snapshot(selected)))
        output.copyButton:SetEnabled(context.compat:Has("setclipboard"))
    end))
    release = detail:NewButton({ text = "Clear baseline" }, function()
        baseline, baselineValue, baselineLabel = nil, nil, nil
        updateActions()
    end)
    open = detail:NewButton({ text = "Inspect selected" }, Workbench.action(context, function()
        assert(selectedValue ~= nil, "Select a non-nil value first")
        Workbench.inspect(context, selectedValue, "GC value")
    end))
    metadata = detail:NewButton({ text = "Inspect accessible metatable" }, Workbench.action(context, function()
        assert(selected, "Select a table first")
        local metadata = getmetatable(selected)
        assert(metadata ~= nil, "Selected table has no accessible metatable")
        Workbench.inspect(context, metadata, "Metatable (may be a protected marker)")
    end))
    showRaw = detail:NewButton({ text = "Show raw value" }, function()
        output:SetText(Values.serialize(selectedValue))
        output.copyButton:SetEnabled(context.compat:Has("setclipboard"))
    end)
    c.row:NewButton({ text = "Clear", width = 60 }, function()
        c.jobs:Cancel()
        results:Clear()
        baseline, baselineValue = nil, nil
        updateActions()
        c.status:SetText("Results and baseline cleared.")
    end)
    c.scan = function()
        local query = c.search:GetValue()
        c.jobs:Run(function(checkpoint) return Catalog.tables(context.compat, query, checkpoint) end, function(records) results:SetRecords(records) end)
    end
    c.tab.controller = c
    updateActions()
    output.copyButton:SetEnabled(false)
    return c.tab
end
return m
end function __DARKLUA_BUNDLE_MODULES.T():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.T if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.T=v end return v.c end end do local function __modImpl()
local Scope = __DARKLUA_BUNDLE_MODULES.d()
local Values = __DARKLUA_BUNDLE_MODULES.E()
local Catalog = __DARKLUA_BUNDLE_MODULES.J()
local m = {}
m.__index = m
function m.new(manager, recorder, paused)
    return setmetatable({ manager = manager, recorder = recorder, paused = paused, watches = {}, count = 0, version = 0 }, m)
end
function m:Sync()
    if self.entry and self.manager.entries[self.entry.target] ~= self.entry then
        for _, watch in self.watches do watch:Destroy() end
        table.clear(self.watches)
        self.entry, self.count = nil, 0
        self.version += 1
    end
end
function m:Available(backend)
    local compat = self.manager.compat
    return self.manager:Available(backend) and compat:Has("getrawmetatable")
        and compat:Has("getnamecallmethod") and compat:Has("setnamecallmethod")
end
function m:Watch(instance, backend)
    assert(Catalog.isRemote(instance) and instance:IsDescendantOf(game), "Select a remote in the DataModel")
    self:Sync()
    assert(not self.entry or self.entry.active, "Retry stopping the outgoing hook before watching again")
    assert(self:Available(backend), "Outgoing capture requires backend APIs and getrawmetatable/getnamecallmethod/setnamecallmethod")
    assert(not self.entry or self.entry.backend == backend, "Stop outgoing watches before switching backend")
    if self.watches[instance] then return end
    assert(self.count < 32, "32 outgoing-watch limit reached")
    if not self.entry then
        local ok, mt = self.manager.compat:Call("getrawmetatable", game)
        assert(ok and type(mt) == "table", "DataModel metatable unavailable")
        local target = rawget(mt, "__namecall")
        assert(type(target) == "function", "DataModel __namecall unavailable")
        self.entry = self.manager:Add(target, "Outgoing remote __namecall", backend, {
            recorder = self.recorder, paused = self.paused,
            match = function(remote) return self.watches[remote] ~= nil end,
            context = self.manager.compat.functions.getnamecallmethod,
            restoreContext = self.manager.compat.functions.setnamecallmethod,
            select = function(method, remote, ...)
                if not self.watches[remote] then return nil end
                if (remote.ClassName == "RemoteFunction" and method ~= "InvokeServer")
                    or (remote.ClassName ~= "RemoteFunction" and method ~= "FireServer") then return nil end
                return function() return Values.path(remote) end, "outgoing " .. method, table.pack(...)
            end,
        })
    end
    local watch = Scope.new()
    local ok, err = pcall(function()
        watch:Connect(instance.AncestryChanged, function()
            if not instance:IsDescendantOf(game) then self:Stop(instance) end
        end)
        watch:Connect(instance.Destroying, function() self:Stop(instance) end)
    end)
    if not ok then
        watch:Destroy()
        if self.count == 0 then self:StopAll() end
        error(err, 0)
    end
    self.watches[instance] = watch
    self.count += 1
    self.version += 1
end
function m:Stop(instance)
    self:Sync()
    local watch = self.watches[instance]
    if watch then
        self.watches[instance] = nil
        self.count -= 1
        watch:Destroy()
        self.version += 1
    end
    if self.count == 0 and self.entry then
        local ok, err = self.manager:Stop(self.entry.target)
        if ok then self.entry = nil end
        return ok, err
    end
    return true
end
function m:StopAll()
    self:Sync()
    local instances = {}
    for instance in self.watches do table.insert(instances, instance) end
    for _, instance in instances do
        self.watches[instance]:Destroy()
        self.watches[instance] = nil
    end
    self.count = 0
    self.version += 1
    return self:Stop(nil)
end
function m:Destroy()
    local ok, err = self:StopAll()
    if not ok then warn("DebugSuite outgoing hook cleanup: " .. err) end
end
return m
end function __DARKLUA_BUNDLE_MODULES.U():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.U if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.U=v end return v.c end end do local function __modImpl()
local Workbench = __DARKLUA_BUNDLE_MODULES.L()
local Catalog = __DARKLUA_BUNDLE_MODULES.J()
local Values = __DARKLUA_BUNDLE_MODULES.E()
local Recorder = __DARKLUA_BUNDLE_MODULES.F()
local Outgoing = __DARKLUA_BUNDLE_MODULES.U()
local Scope = __DARKLUA_BUNDLE_MODULES.d()
local m = {}
function m.init(window, context)
    local c = Workbench.scanner(context, "Remotes", "Inventory + opt-in incoming events and selected outgoing FireServer/InvokeServer namecalls. Arguments and return values are frozen; calls pass through.")
    local list = c.tab:NewSection("Remote inventory", "left"):NewList({ height = 280, columns = {
        { key = "name", text = "Name" }, { key = "class", text = "Class", width = 115 },
    } })
    local actions = c.tab:NewSection("Observation", "right")
    local status = actions:NewTextViewer({ height = 90, text = "No watches. Select an event, then Watch selected.\nWatches add ordinary OnClientEvent listeners." })
    local historySection = c.tab:NewSection("Captured traffic", "bottom")
    local events = historySection:NewList({ height = 200, columns = {
        { key = "time", text = "Seconds", width = 85 }, { key = "args", text = "Args", width = 45 },
        { key = "kind", text = "Direction / method", width = 150 },
        { key = "outcome", text = "Outcome", width = 75 },
        { key = "duration", text = "ms", width = 65 },
        { key = "partial", text = "Data", width = 65 }, { key = "path", text = "Remote path" },
    } })
    local output = Workbench.viewer(context, historySection, { height = 180, text = "-- Select a captured event.", syntax = "lua" })
    local recorder = Recorder.new()
    local selected, watches, watchCount, dirty, elapsed = nil, {}, 0, false, 0
    local watchButton, stopButton, stopAllButton, copyPath, outgoingStart, outgoingStop, outgoingStopAll
    local paused = actions:NewToggle({ text = "Pause capture", value = false })
    local backend = actions:NewDropdown({ text = "Outgoing backend", options = { "Standard", "Volt OTH" }, value = "Standard" })
    local outgoing = Outgoing.new(context.hooks, recorder, function() return paused:GetValue() end)
    local renderedVersion, watchVersion, wasTracing = -1, -1, false
    c.tab.scope:Add(function() outgoing:Destroy() end)
    local function updateStatus()
        if c.tab.destroyed then return end
        outgoing:Sync()
        local paths = {}
        for instance in watches do table.insert(paths, Values.path(instance)) end
        table.sort(paths)
        local canWatch = selected ~= nil and selected.ClassName ~= "RemoteFunction" and selected:IsDescendantOf(game)
        local hint = if selected and selected.ClassName == "RemoteFunction" then "RemoteFunction callbacks are not observed."
            elseif selected and not canWatch then "Event left the DataModel. Scan again."
            elseif watchCount == 0 then "Select an event, then Watch selected incoming event." else table.concat(paths, "\n")
        local entry = outgoing.entry
        local tracing = entry and context.hooks.entries[entry.target] == entry and entry.active
        status:SetText(string.format("%d/32 watches incoming | %d/32 outgoing (%s) | %d retained | %d rate-limited\n%s%s", watchCount, outgoing.count,
            if tracing then "tracing" else "stopped", #recorder.records, recorder.dropped, hint,
            if entry and entry.error then "\n" .. entry.error else ""))
        watchButton:SetEnabled(canWatch and not watches[selected] and watchCount < 32)
        stopButton:SetEnabled(selected ~= nil and watches[selected] ~= nil)
        stopAllButton:SetEnabled(watchCount > 0)
        copyPath:SetEnabled(selected ~= nil and context.compat:Has("setclipboard"))
        outgoingStart:SetEnabled(selected ~= nil and selected:IsDescendantOf(game) and outgoing:Available(backend:GetValue())
            and not outgoing.watches[selected] and outgoing.count < 32
            and (outgoing.entry == nil or (tracing and outgoing.entry.backend == backend:GetValue())))
        outgoingStop:SetEnabled(selected ~= nil and outgoing.watches[selected] ~= nil)
        outgoingStopAll:SetEnabled(outgoing.count > 0 or outgoing.entry ~= nil)
    end
    local function stop(instance)
        local scope = watches[instance]
        if scope then
            watches[instance] = nil
            watchCount -= 1
            scope:Destroy()
            updateStatus()
        end
    end
    local function stopAll()
        local instances = {}
        for instance in watches do table.insert(instances, instance) end
        for _, instance in instances do stop(instance) end
    end
    c.tab.scope:Add(stopAll)
    list:OnSelected(function(record)
        selected = if record then record.value else nil
        updateStatus()
    end)
    watchButton = actions:NewButton({ text = "Watch selected incoming event" }, Workbench.action(context, function()
        assert(selected and Catalog.isRemote(selected) and selected.ClassName ~= "RemoteFunction", "Select a RemoteEvent or UnreliableRemoteEvent")
        assert(selected:IsDescendantOf(game), "Selected event is no longer in the DataModel; scan again")
        if watches[selected] then updateStatus() return end
        assert(watchCount < 32, "32-watch limit reached; stop a watch first")
        local instance, scope = selected, Scope.new()
        local ok, err = pcall(function()
            scope:Connect(instance.OnClientEvent, function(...)
                if paused:GetValue() then return end
                recorder:Push(function() return Values.path(instance) end, table.pack(...), os.clock() - context.started)
                dirty = true
            end)
            scope:Connect(instance.AncestryChanged, function()
                if not instance:IsDescendantOf(game) then stop(instance) dirty = true end
            end)
            scope:Connect(instance.Destroying, function() stop(instance) dirty = true end)
        end)
        if not ok then scope:Destroy() error(err, 0) end
        watches[instance] = scope
        watchCount += 1
        updateStatus()
    end))
    stopButton = actions:NewButton({ text = "Stop selected watch" }, function() if selected then stop(selected) end updateStatus() end)
    stopAllButton = actions:NewButton({ text = "Stop all watches" }, function() stopAll() updateStatus() end)
    copyPath = actions:NewButton({ text = "Copy selected remote path" }, Workbench.action(context, function()
        assert(selected, "Select a remote first")
        Workbench.copy(context, Values.path(selected))
    end))
    outgoingStart = actions:NewButton({ text = "Watch selected outgoing calls" }, Workbench.action(context, function()
        outgoing:Watch(selected, backend:GetValue())
        updateStatus()
    end))
    outgoingStop = actions:NewButton({ text = "Stop selected outgoing watch" }, Workbench.action(context, function()
        local ok, err = outgoing:Stop(selected)
        updateStatus()
        assert(ok, err)
    end))
    outgoingStopAll = actions:NewButton({ text = "Stop all outgoing watches" }, Workbench.action(context, function()
        local ok, err = outgoing:StopAll()
        updateStatus()
        assert(ok, err)
    end))
    backend:OnChanged(updateStatus)
    actions:NewTextViewer({ height = 75, text = "Outgoing watches observe selected :FireServer / :InvokeServer calls through one shared __namecall hook. Direct method calls and incoming RemoteFunction callbacks are outside this capture. Stop all outgoing watches to change backend." })
    local filter = historySection:NewTextbox({ text = "Filter captured paths" })
    filter:OnChanged(function(value) events:SetFilter(value) end)
    local function showEvent(record)
        output:SetText(if record then record.text else "-- Select a captured event.")
    end
    events:OnSelected(showEvent)
    historySection:NewButton({ text = "Clear captured events" }, function()
        recorder:Clear()
        events:SetRecords({}, false)
        showEvent(nil)
        updateStatus()
    end)
    c.tab.scope:Connect(window.ctx.services.RunService.RenderStepped, function(dt)
        elapsed += dt
        local entry = outgoing.entry
        local tracing = entry ~= nil and context.hooks.entries[entry.target] == entry and entry.active
        if elapsed >= .2 and (dirty or recorder.version ~= renderedVersion or outgoing.version ~= watchVersion or tracing ~= wasTracing) then
            elapsed, dirty = 0, false
            events:SetRecords(recorder.records, false)
            -- Finished outgoing calls update the same record object.
            showEvent(events.selectedRecord)
            updateStatus()
            renderedVersion, watchVersion, wasTracing = recorder.version, outgoing.version, tracing
        end
    end)
    c.scan = function()
        local query = c.search:GetValue()
        c.jobs:Run(function(checkpoint) return Catalog.instances(game, query, "Remotes", window.guis.ScreenGui, checkpoint) end,
            function(records) list:SetRecords(records) end)
    end
    c.tab.controller = c
    c.outgoing = outgoing
    updateStatus()
    return c.tab
end
return m
end function __DARKLUA_BUNDLE_MODULES.V():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.V if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.V=v end return v.c end end do local function __modImpl()
local Workbench = __DARKLUA_BUNDLE_MODULES.L()
local m = {}
function m.init(window, context)
    local tab = window:NewTab("Logs")
    local tools = tab:NewSection("Client output", "top")
    tools:NewTextViewer({ height = 48, text = "Latest 1,000 client messages. Pause discards new messages. Select a row for raw text; the floating console remains available." })
    local search = tools:NewTextbox({ text = "Literal text filter" })
    tab.searchInput = search
    local level = tools:NewDropdown({ text = "Level", options = { "All", "info", "warning", "error" }, value = "All" })
    local paused = tools:NewToggle({ text = "Pause log capture", value = false })
    local list = tab:NewSection("History", "full"):NewList({ height = 260, columns = {
        { key = "time", text = "Time", width = 100 }, { key = "level", text = "Level", width = 80 }, { key = "message", text = "Message" },
    } })
    local detail = Workbench.viewer(context, tab:NewSection("Raw message", "bottom"), { height = 180, text = "Select a message." })
    local records, sequence, elapsed, dirty = {}, 0, 0, false
    local function render()
        local visible = {}
        for _, record in records do
            if level:GetValue() == "All" or record.values.level == level:GetValue() then table.insert(visible, record) end
        end
        list:SetRecords(visible)
        dirty = false
    end
    local function push(message, messageType, stamp)
        if paused:GetValue() then return end
        sequence += 1
        local name = if messageType == Enum.MessageType.MessageError then "error"
            elseif messageType == Enum.MessageType.MessageWarning then "warning" else "info"
        local text = tostring(message)
        text = text:sub(1, 16384) .. (if #text > 16384 then "\n[message truncated at 16 KiB]" else "")
        table.insert(records, { id = sequence, text = text,
            values = { time = stamp or string.format("+%.3fs", os.clock() - context.started), level = name, message = text } })
        if #records > 1000 then table.remove(records, 1) end
        dirty = true
    end
    local logService = window.ctx.services.LogService
    local ok, history = pcall(function() return logService:GetLogHistory() end)
    if ok and type(history) == "table" then
        for i = math.max(1, #history - 999), #history do
            local entry = history[i]
            push(entry.message, entry.messageType, tostring(entry.timestamp or "history"))
        end
    end
    tab.scope:Connect(logService.MessageOut, function(message, messageType) push(message, messageType) end)
    tab.scope:Connect(window.ctx.services.RunService.RenderStepped, function(dt)
        elapsed += dt
        if dirty and elapsed >= .2 then elapsed = 0 render() end
    end)
    search:OnChanged(function(value) list:SetFilter(value) end)
    level:OnChanged(render)
    list:OnSelected(function(record) detail:SetText(if record then record.text else "Select a message.") end)
    local row = tools:NewRow()
    row:NewButton({ text = "Clear history", width = 100 }, function() table.clear(records) render() end)
    row:NewButton({ text = "Copy filtered logs", width = 130 }, Workbench.action(context, function()
        local lines = {}
        for _, record in list.filtered do
            table.insert(lines, record.values.time .. " [" .. record.values.level .. "] " .. record.text)
        end
        Workbench.copy(context, table.concat(lines, "\n"))
    end))
    render()
    return tab
end
return m
end function __DARKLUA_BUNDLE_MODULES.W():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.W if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.W=v end return v.c end end do local function __modImpl()
local m = {}
m.__index = m
function m.new() return setmetatable({ samples = {}, sequence = 0 }, m) end
function m:Push(dt)
    if type(dt) ~= "number" or dt <= 0 or dt ~= dt or dt == math.huge then return end
    self.sequence += 1
    table.insert(self.samples, { id = self.sequence, dt = dt,
        values = { frame = self.sequence, ms = dt * 1000, fps = 1 / dt, stall = if dt >= .05 then "stall" else "" } })
    if #self.samples > 120 then table.remove(self.samples, 1) end
end
function m:Report()
    if #self.samples == 0 then return "No frame samples. Enable sampling, then reproduce the problem." end
    local sorted, total, stalls = {}, 0, 0
    for _, sample in self.samples do
        total += sample.dt
        table.insert(sorted, sample.dt)
        if sample.dt >= .05 then stalls += 1 end
    end
    table.sort(sorted)
    return string.format("Latest %d frames\nAverage: %.1f FPS / %.2f ms\nP95: %.2f ms | Worst: %.2f ms\nFrames >= 50 ms: %d\n", #sorted, #sorted / total, total / #sorted * 1000,
        sorted[math.ceil(#sorted * .95)] * 1000, sorted[#sorted] * 1000, stalls)
end
function m:Clear() table.clear(self.samples) end
return m
end function __DARKLUA_BUNDLE_MODULES.X():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.X if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.X=v end return v.c end end do local function __modImpl()
local Workbench = __DARKLUA_BUNDLE_MODULES.L()
local Timing = __DARKLUA_BUNDLE_MODULES.X()
local m = {}
function m.init(window, context)
    local tab = window:NewTab("Runtime")
    local controls = tab:NewSection("Frame diagnostics", "top")
    controls:NewTextViewer({ height = 64, text = "Opt-in client frame sampling. Latest 120 frames; P95 and >=50 ms stalls help identify hitches. Memory is sampled once per second. Values include the debugger's overhead." })
    local timing = Timing.new()
    local enabled = controls:NewToggle({ text = "Sample frame timing", value = false })
    local report = Workbench.viewer(context, tab:NewSection("Summary", "left"), { height = 210, text = timing:Report() })
    local list = tab:NewSection("Recent frames", "right"):NewList({ height = 310, columns = {
        { key = "frame", text = "Frame", width = 60 }, { key = "ms", text = "ms" }, { key = "fps", text = "FPS" }, { key = "stall", text = "Stall", width = 50 },
    } })
    local elapsed = 0
    local function update()
        local ok, memory = pcall(function() return game:GetService("Stats"):GetTotalMemoryUsageMb() end)
        local luaOk, luaMemory = pcall(gcinfo)
        report:SetText(timing:Report() .. "\nTotal client memory: " .. (if ok then string.format("%.1f MiB", memory) else "unavailable")
            .. "\nLuau heap: " .. (if luaOk then string.format("%.1f KiB", luaMemory) else "unavailable"))
        list:SetRecords(timing.samples)
    end
    tab.scope:Connect(window.ctx.services.RunService.RenderStepped, function(dt)
        if not enabled:GetValue() then return end
        timing:Push(dt)
        elapsed += dt
        if elapsed >= 1 then elapsed = 0 update() end
    end)
    enabled:OnChanged(function(value) if not value then update() end end)
    controls:NewButton({ text = "Reset samples" }, function() timing:Clear() update() end)
    controls:NewButton({ text = "Refresh summary" }, Workbench.action(context, update))
    return tab
end
return m
end function __DARKLUA_BUNDLE_MODULES.Y():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.Y if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.Y=v end return v.c end end do local function __modImpl()
local Window = __DARKLUA_BUNDLE_MODULES.C()
local Compatibility = __DARKLUA_BUNDLE_MODULES.D()
local Hooks = __DARKLUA_BUNDLE_MODULES.H()
local m = {}
local modules = {
    { "Overview", __DARKLUA_BUNDLE_MODULES.M() },
    { "Explorer", __DARKLUA_BUNDLE_MODULES.N() },
    { "Functions", __DARKLUA_BUNDLE_MODULES.P() },
    { "Hooks", __DARKLUA_BUNDLE_MODULES.S() },
    { "GC", __DARKLUA_BUNDLE_MODULES.T() },
    { "Remotes", __DARKLUA_BUNDLE_MODULES.V() },
    { "Logs", __DARKLUA_BUNDLE_MODULES.W() },
    { "Runtime", __DARKLUA_BUNDLE_MODULES.Y() },
}
function m.start()
    local window = Window.new({ size = UDim2.fromOffset(1120, 760), minSize = Vector2.new(760, 480) })
    window.shell.title.Text = "DebugSuite"
    local context = { window = window, compat = Compatibility.new(), started = os.clock(), tabs = {} }
    context.hooks = Hooks.new(context.compat, context.started)
    window.scope:Add(function() context.hooks:Destroy() end)
    window.app = context
    for _, entry in modules do
        local count = #window.tabs
        local ok, tab = pcall(entry[2].init, window, context)
        if ok then context.tabs[entry[1] ] = tab
        else
            while #window.tabs > count do window.tabs[#window.tabs]:Destroy() end
            window:Notify({ text = entry[1] .. " failed to initialize: " .. tostring(tab), messageType = "error" })
        end
    end
    if #window.tabs > 0 then window:SelectTab(window.tabs[1]) end
    window:BindShortcut(Enum.KeyCode.F, function()
        local tab = window.currentTab
        if tab and tab.searchInput then tab.searchInput:Focus() end
    end, { ctrl = true })
    window:Log("DebugSuite ready. Select a tab and scan to begin.", "success")
    window:Show()
    return window
end
return m
end function __DARKLUA_BUNDLE_MODULES.Z():typeof(__modImpl())local v=__DARKLUA_BUNDLE_MODULES.cache.Z if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.Z=v end return v.c end end end
local App = __DARKLUA_BUNDLE_MODULES.Z()
return App.start()
