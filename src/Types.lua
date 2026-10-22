--ui------
export type Services = {[string]: Instance?}
export type ctx = { services: Services }
export type SectionSide = "left" | "right" | "top" | "bottom" | "full"
export type Scope = {
    conns: {RBXScriptConnection},
    Connect: (self: Scope, signal: RBXScriptSignal, callback: (...any) -> ()) -> RBXScriptConnection,
    Add: (self: Scope, callback: () -> ()) -> (),
    Destroy: (self: Scope) -> (),
}

export type Component = {
    frame: GuiObject,
    scope: Scope,
    conns: {RBXScriptConnection},
    components: {Component},
    destroyed: boolean,
    SetVisible: (self: any, value: boolean) -> (),
    Clear: (self: any) -> (),
    Destroy: (self: any) -> (),
}

export type ComponentOpts = { text: string }
export type RowOpts = { text: string?, gap: number? }
export type RowComponentOpts = { text: string, width: number?, fill: boolean? }
export type PanelOpts = {
    text: string?, size: UDim2?, position: UDim2?, height: number?, auto: boolean?,
    scroll: boolean?, layout: ("vertical" | "horizontal" | "none")?,
    gap: number?, padding: number?, clip: boolean?, minSize: Vector2?, maxSize: Vector2?,
}
export type SplitPaneOpts = {
    size: UDim2?, height: number?, ratio: number?, vertical: boolean?, minSize: number?,
}
export type ConsoleMessageType = "error" | "warning" | "info" | "success"
export type ConsoleEntry = { text: string, messageType: ConsoleMessageType? }
export type NotifyOpts = { text: string, messageType: ConsoleMessageType?, duration: number? }
export type Notification = Component & { text: string, messageType: ConsoleMessageType }
export type Syntax = "lua" | "luau" | false
export type SyntaxTheme = {[string]: string}
export type SyntaxToken = { kind: string, text: string, start: number, finish: number }
export type ConsoleOpts = {
    text: string?, height: number?, maxEntries: number?, autoScroll: boolean?,
    syntax: Syntax?, syntaxTheme: SyntaxTheme?,
}
export type Record = { id: string | number, values: {[string]: any}, data: any? }
export type Column = { key: string, text: string?, width: number?, syntax: Syntax? }
export type ListOpts = {
    text: string?, size: UDim2?, height: number?, columns: {Column}?,
    rowHeight: number?, maxRecords: number?,
}
export type TreeNode = {
    id: string | number, text: string, data: any?, value: any?, inspectable: boolean?, children: {TreeNode}?,
    loadChildren: (() -> {TreeNode})?,
}
export type TreeOpts = { text: string?, size: UDim2?, height: number?, maxDepth: number?, emptyText: string? }
export type TextViewerOpts = {
    text: string?, size: UDim2?, height: number?, editable: boolean?,
    syntax: Syntax?, syntaxTheme: SyntaxTheme?,
}
export type ToggleOpts = { text: string, value: boolean? }
export type DropdownOpts = { text: string, options: {string}, value: string? }
export type MenuItem = { text: string, callback: () -> (), enabled: boolean? }
export type MenuOpts = { text: string, items: {MenuItem} }

export type Container = Component & {
    contentFrame: GuiObject,
    NewButton: (self: any, opts: ComponentOpts, callback: (() -> any)?) -> Button,
    NewTextbox: (self: any, opts: ComponentOpts, callback: ((string) -> any)?) -> Textbox,
    NewRow: (self: any, opts: RowOpts?) -> Row,
    NewConsole: (self: any, opts: ConsoleOpts?) -> Console,
    NewPanel: (self: any, opts: PanelOpts?) -> Container,
    NewSplitPane: (self: any, opts: SplitPaneOpts?) -> SplitPane,
    NewList: (self: any, opts: ListOpts?) -> List,
    NewTree: (self: any, opts: TreeOpts?) -> Tree,
    NewTextViewer: (self: any, opts: TextViewerOpts?) -> TextViewer,
    NewToggle: (self: any, opts: ToggleOpts, callback: ((boolean) -> ())?) -> Toggle,
    NewDropdown: (self: any, opts: DropdownOpts, callback: ((string?) -> ())?) -> Dropdown,
    NewMenu: (self: any, opts: MenuOpts) -> Menu,
}

export type Button = Component & {
    button: TextButton,
    callback: (() -> any)?,
    SetText: (self: Button, value: string) -> (),
    SetEnabled: (self: Button, value: boolean) -> (),
}
export type Textbox = Component & {
    button: TextBox,
    callback: ((string) -> any)?,
    GetValue: (self: Textbox) -> string,
    SetValue: (self: Textbox, value: string) -> (),
    SetPlaceholder: (self: Textbox, value: string) -> (),
    SetEnabled: (self: Textbox, value: boolean) -> (),
    Focus: (self: Textbox) -> (),
    OnChanged: (self: Textbox, callback: (string) -> ()) -> RBXScriptConnection,
    OnSubmitted: (self: Textbox, callback: (string) -> ()) -> RBXScriptConnection,
}
export type Row = Component & {
    rowFrame: Frame,
    componentWidths: {number},
    gap: number,
    NewButton: (self: Row, opts: RowComponentOpts, callback: (() -> any)?) -> Button,
    NewTextbox: (self: Row, opts: RowComponentOpts, callback: ((string) -> any)?) -> Textbox,
}
export type SplitPane = Component & {
    first: Container, second: Container, ratio: number,
    SetRatio: (self: SplitPane, value: number) -> (),
}
export type Console = Component & {
    consoleFrame: ScrollingFrame,
    NewEntry: (self: Console, text: string, messageType: ConsoleMessageType) -> (),
    Append: (self: Console, entries: {ConsoleEntry}) -> (),
    SetPaused: (self: Console, value: boolean) -> (),
    SetAutoScroll: (self: Console, value: boolean) -> (),
}
export type List = Component & {
    records: {Record}, selectedId: (string | number)?,
    SetRecords: (self: List, records: {Record}, notify: boolean?) -> (),
    Append: (self: List, records: {Record}) -> (),
    Refresh: (self: List, notify: boolean?) -> (),
    SetFilter: (self: List, value: string, notify: boolean?) -> (),
    SetSort: (self: List, key: string, ascending: boolean?) -> (),
    Select: (self: List, id: string | number, notify: boolean?) -> (),
    OnSelected: (self: List, callback: (Record?) -> ()) -> RBXScriptConnection,
}
export type Tree = Component & {
    SetNodes: (self: Tree, nodes: {TreeNode}, preserveState: boolean?, notify: boolean?) -> (),
    Expand: (self: Tree, id: string | number, value: boolean) -> (),
    Select: (self: Tree, id: string | number) -> (),
    OnSelected: (self: Tree, callback: (TreeNode?) -> ()) -> RBXScriptConnection,
}
export type TextViewer = Component & {
    textbox: TextBox,
    SetText: (self: TextViewer, value: string) -> (),
    GetText: (self: TextViewer) -> string,
    SetSyntax: (self: TextViewer, value: Syntax?) -> (),
    OnChanged: (self: TextViewer, callback: (string) -> ()) -> RBXScriptConnection,
    OnSyntaxChanged: (self: TextViewer, callback: (boolean) -> ()) -> RBXScriptConnection,
}
export type Toggle = Button & {
    SetValue: (self: Toggle, value: boolean) -> (),
    GetValue: (self: Toggle) -> boolean,
    OnChanged: (self: Toggle, callback: (boolean) -> ()) -> RBXScriptConnection,
}
export type Dropdown = Component & {
    button: TextButton,
    SetOpen: (self: Dropdown, value: boolean) -> (),
    SetValue: (self: Dropdown, value: string?) -> (),
    GetValue: (self: Dropdown) -> string?,
    SetOptions: (self: Dropdown, options: {string}) -> (),
    SetEnabled: (self: Dropdown, value: boolean) -> (),
    OnChanged: (self: Dropdown, callback: (string?) -> ()) -> RBXScriptConnection,
}
export type Menu = Button & { SetOpen: (self: Menu, value: boolean) -> () }
export type Section = Container & { parentTab: Tab, sectionFrame: Frame }
export type Tab = Container & {
    parentWindow: Window, tabBtn: TextButton, sections: {Component}, container: ScrollingFrame,
    columns: {left: Frame, right: Frame, top: Frame, bottom: Frame, full: Frame},
    NewSection: (self: Tab, name: string, side: SectionSide?) -> Section,
    ShowCurrentTab: (self: Tab) -> (), HideCurrentTab: (self: Tab) -> (),
}
export type TabOpts = { layout: ("sections" | "free")? }
export type WindowOpts = { size: UDim2?, minSize: Vector2?, captureLogs: boolean? }
export type FloatingWindowOpts = {
    name: string?, title: string?, size: UDim2?, position: UDim2?, minSize: Vector2?,
    visible: boolean?, closeBehavior: ("hide" | "destroy")?, backgroundColor: Color3?,
}
export type FloatingWindow = Container & {
    guis: { ScreenGui: ScreenGui, Root: Frame, Topbar: Frame },
    Show: (self: FloatingWindow) -> (), Hide: (self: FloatingWindow) -> (),
    Toggle: (self: FloatingWindow) -> (), Focus: (self: FloatingWindow) -> (),
    AddTopbarButton: (self: FloatingWindow, name: string, text: string, callback: () -> (), width: number?) -> TextButton,
}
export type WindowGuis = { ScreenGui: ScreenGui, Root: Frame, Topbar: Frame, Sidebar: ScrollingFrame }
export type ShortcutOpts = { ctrl: boolean?, shift: boolean? }
export type Window = {
    ctx: ctx, guis: WindowGuis, scope: Scope, conns: {RBXScriptConnection},
    currentTab: Tab?, tabs: {Tab},
    Show: (self: Window) -> (), Hide: (self: Window) -> (), Toggle: (self: Window) -> (),
    SetVisible: (self: Window, value: boolean) -> (),
    Clear: (self: Window) -> (), Destroy: (self: Window) -> (),
    NewTab: (self: Window, name: string, opts: TabOpts?) -> Tab,
    NewWindow: (self: Window, opts: FloatingWindowOpts?) -> FloatingWindow,
    SelectTab: (self: Window, tab: Tab) -> (),
    OpenConsole: (self: Window) -> Console,
    Log: (self: Window, text: string, messageType: ConsoleMessageType?) -> (),
    Notify: (self: Window, opts: NotifyOpts) -> Notification?,
    BindShortcut: (self: Window, key: Enum.KeyCode, callback: () -> (), opts: ShortcutOpts?) -> RBXScriptConnection,
}

return {}
