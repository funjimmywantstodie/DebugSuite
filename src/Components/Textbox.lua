local m = {}
m.__index = m

local types = require("../Types")
local uiConstructor = require("../Util/UIConstructor")

function m.new(parentSection: types.Section, opts: types.ComponentOpts, callback: (string) -> (any), parent: Frame?): types.Textbox
    local self = setmetatable({}, m)
    self.button = uiConstructor.createTextbox(parent or parentSection.contentFrame, opts,
        (parent or parentSection.sectionFrame).ZIndex + 1)
    self.callback = callback

    local conn = self.button.FocusLost:Connect(function(enterPressed: boolean)
        if enterPressed then
            callback(self.button.Text)
        end
    end)
    table.insert(parentSection.parentTab.parentWindow.conns, conn)
    return self
end

return m
