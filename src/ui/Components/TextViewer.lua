local m = {}
local ui = require("../util/UIConstructor")
local lifecycle = require("../util/Lifecycle")
local colors = require("../Colors")
local syntaxHighlight = require("../SyntaxHighlight")
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
