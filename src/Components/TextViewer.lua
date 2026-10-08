local m = {}
local ui = require("../util/UIConstructor")
local lifecycle = require("../util/Lifecycle")
local colors = require("../Colors")

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
