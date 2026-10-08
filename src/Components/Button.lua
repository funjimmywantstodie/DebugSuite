local m = {}
m.__index = m

local colors = require("../Colors")

local types = require("../Types")

local function createButton(section: types.Section, opts: types.ComponentOpts, callback: () -> (any)): TextButton
    local button = Instance.new("TextButton")
    button.Name = opts.text
    button.BackgroundColor3 = colors.component
    button.TextColor3 = colors.text
    button.Text = opts.text
    button.ZIndex = section.sectionFrame.ZIndex + 1
    button.Parent = section.contentFrame
    button.Size = UDim2.new(1, 0, 0, 28)

    local conn = button.MouseButton1Click:Connect(callback)
    table.insert(section.parentTab.parentWindow.conns, conn)
    return button
    
end

function m.new(parentSection: types.Section, opts: types.ComponentOpts, callback: () -> (any)): types.Button
    local self = setmetatable({}, m)

    self.button = createButton(parentSection, opts, callback)
    self.callback = callback
    return self
end

return m