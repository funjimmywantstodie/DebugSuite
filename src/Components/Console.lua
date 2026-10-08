local m = {}
m.__index = m

local colors = require("../Colors")
local lifecycle = require("../util/Lifecycle")

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
