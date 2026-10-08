local m = {}
m.__index = m

local colors = require("./Colors")

local types = require("./Types")
local button = require("./Components/Button")
local textbox =require("./Components/Textbox")
local console = require("./Components/Console")
local row = require("./Components/Row")

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
local function createSection(tab: types.Tab, name: string, side: types.SectionSide, order: number)
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

function m.new(tab: types.Tab, name: string, side: types.SectionSide, order: number): types.Section
    local self = setmetatable({}, m)
    local result = createSection(tab, name, side, order)
    self.sectionFrame = result.sectionFrame
    self.contentFrame = result.contentFrame
    self.components = result.components
    self.parentTab = tab
    
    return self :: types.Section
end

function m:NewButton(opts: types.ComponentOpts, callback: () -> (any)): types.Button
    local btn = button.new(self, opts, callback)
    btn.button.LayoutOrder = #self.contentFrame:GetChildren()

    table.insert(self.components, btn)
    return btn
end

function m:NewTextbox(opts: types.ComponentOpts, callback: (string) -> (any)): types.Textbox
    local textbox = textbox.new(self, opts, callback)
    textbox.button.LayoutOrder = #self.contentFrame:GetChildren()

    table.insert(self.components, textbox)
    return textbox
end

function m:NewConsole(opts: types.ConsoleOpts): types.Console
    local console = console.new(self, opts)
    console.consoleFrame.LayoutOrder = #self.contentFrame:GetChildren()

    table.insert(self.components, console)
    return console
end

function m:NewRow(opts: types.RowOpts?): types.Row
    local row = row.new(self, opts)
    row.rowFrame.LayoutOrder = #self.contentFrame:GetChildren()

    table.insert(self.components, row)
    return row
end

return m
