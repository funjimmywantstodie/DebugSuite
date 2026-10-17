local m = {}

local colors = require("../Colors")
local types = require("../../Types")

function m.createButton(parent: GuiObject, opts: types.ComponentOpts, zIndex: number?): TextButton
    assert(type(opts) == "table" and type(opts.text) == "string", 'NewButton expects { text = "..." }')
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

function m.createTextbox(parent: GuiObject, opts: types.ComponentOpts, zIndex: number?): TextBox
    assert(type(opts) == "table" and type(opts.text) == "string", 'NewTextbox expects { text = "..." }')
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
