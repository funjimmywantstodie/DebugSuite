export type Services = {[string]: Instance?}

export type ctx = {
    services: Services,
}

export type WindowGuis = {
    ScreenGui: ScreenGui,
    Root: Frame,
    Sidebar: ScrollingFrame,
}

export type SectionSide = "left" | "right" | "top" | "bottom" | "full"

export type Window = {
    ctx: ctx,
    guis: WindowGuis,
    conns: {RBXScriptConnection},
    currentTab: Tab?,
    tabs: {Tab},
    Show: (self: Window) -> (),
    Hide: (self: Window) -> (),
    Toggle: (self: Window) -> (),
    NewTab: (self: Window, name: string) -> Tab,
    SelectTab: (self: Window, tab: Tab) -> (),
}

export type Tab = {
    parentWindow: Window,
    tabBtn: TextButton,
    sections: {Section},
    container: ScrollingFrame,
    columns: {left: Frame, right: Frame, top: Frame, bottom: Frame, full: Frame},
    NewSection: (self: Tab, name: string, side: SectionSide?) -> Section,
    ShowCurrentTab: (self: Tab) -> (),
    HideCurrentTab: (self: Tab) -> (),
}

export type ComponentOpts = {
    text: string,
}

export type RowOpts = {
    text: string?,
    gap: number?,
}

export type RowComponentOpts = {
    text: string,
    width: number?, -- Pixels; omitted controls share the remaining width.
    fill: boolean?, -- Explicitly share remaining width, overriding width.
}

export type Row = {
    parentSection: Section,
    rowFrame: Frame,
    components: {Button | Textbox},
    componentWidths: {number},
    gap: number,
    NewButton: (self: Row, opts: RowComponentOpts, callback: () -> (any)) -> Button,
    NewTextbox: (self: Row, opts: RowComponentOpts, callback: (string) -> (any)) -> Textbox,
}

export type ConsoleOpts = {
    text: string,
    height: number?,
}

export type Section = {
    parentTab: Tab,
    sectionFrame: Frame,
    contentFrame: Frame,
    components: {Button | Textbox | Console | Row},
    NewButton: (self: Section, opts: ComponentOpts, callback: () -> (any)) -> Button,
    NewTextbox: (self: Section, opts: ComponentOpts, callback: (string) -> (any)) -> Textbox,
    NewConsole: (self: Section, opts: ConsoleOpts) -> Console,
    NewRow: (self: Section, opts: RowOpts?) -> Row,
}

export type Console = {
    consoleFrame: Frame,
    NewEntry: (self: Console, text: string, messageType: ConsoleMessageType) -> (),
}

export type ConsoleMessageType = "error" | "warning" | "info" | "success"

export type Button = {
    button: TextButton,
    callback: () -> (any),
}

export type Textbox = {
    button: TextBox,
    callback: (string) -> (any),
}

return {}
