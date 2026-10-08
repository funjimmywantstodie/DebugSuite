local m = {}
m.__index = m

local colors = require("../Colors")

local types = require("../Types")

local function updateSize(section: types.Section, consoleFrame: Frame, height: number?): ()
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


local function createConsole(section: types.Section, opts: types.ConsoleOpts): Frame
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

function m.new(parentSection: types.Section, opts: types.ConsoleOpts): types.Console
    local self = setmetatable({}, m)

    self.consoleFrame = createConsole(parentSection, opts)
    return self
end

function m.NewEntry(self: types.Console, text: string, messageType: types.ConsoleMessageType): ()
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
