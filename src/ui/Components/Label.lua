local m = {}
m.__index = m

local colors = require("../Colors")
local types = require("../../Types")
local lifecycle = require("../util/Lifecycle")

function m:SetText(value: string)
    self.frame.Text = value
end

function m:GetText(): string
    return self.frame.Text
end

function m.new(owner: types.Container, opts: types.LabelOpts): types.Label
    local frame = Instance.new("TextLabel")
    frame.Name = "Label"
    frame.Size = UDim2.new(1, 0, 0, opts.height or 20)
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.Text = opts.text
    frame.TextColor3 = colors.text
    --Use the same default font and text size as buttons, textboxes and headers.
    frame.TextXAlignment = Enum.TextXAlignment.Center
    frame.TextWrapped = true
    frame.RichText = false
    frame.ZIndex = owner.contentFrame.ZIndex + 1
    frame.Parent = owner.contentFrame
    return lifecycle.attach(setmetatable({}, m), frame, owner)
end

return m
