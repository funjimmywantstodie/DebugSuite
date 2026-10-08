local m = {}
m.__index = m

local colors = require("../Colors")

local types = require("../Types")

local function createTextbox(section: types.Section, opts: types.ComponentOpts, callback: (string) -> (any)): TextBox
    local button = Instance.new("TextBox")
    button.Name = opts.text
    button.BackgroundColor3 = colors.component
    button.TextColor3 = colors.text
    button.PlaceholderText = opts.text
    button.Text = ""
    button.ZIndex = section.sectionFrame.ZIndex + 1
    button.Parent = section.contentFrame
    button.Size = UDim2.new(1, 0, 0, 28)

   local conn = button.FocusLost:Connect(function(enterPressed: boolean)
        if enterPressed then
            callback(button.Text)
        end
    end)
    table.insert(section.parentTab.parentWindow.conns, conn)
    return button
    
end

function m.new(parentSection: types.Section, opts: types.ComponentOpts, callback: (string) -> (any)): types.Textbox
    local self = setmetatable({}, m)

    self.button = createTextbox(parentSection, opts, callback)
    self.callback = callback
    return self
end

return m