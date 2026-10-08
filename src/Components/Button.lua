local m = {}
m.__index = m

local types = require("../Types")
local uiConstructor = require("../Util/UIConstructor")

function m.new(parentSection: types.Section, opts: types.ComponentOpts, callback: () -> (any), parent: Frame?): types.Button
    local self = setmetatable({}, m)
    self.button = uiConstructor.createButton(parent or parentSection.contentFrame, opts,
        (parent or parentSection.sectionFrame).ZIndex + 1)
    self.callback = callback

    local conn = self.button.MouseButton1Click:Connect(callback)
    table.insert(parentSection.parentTab.parentWindow.conns, conn)
    return self
end

return m
