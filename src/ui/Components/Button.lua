local m = {}
local controls = require("../util/Controls")
local types = require("../Types")

function m.new(owner: types.Container, opts: types.ComponentOpts, callback, parent: GuiObject?): types.Button
    return controls.button(owner, opts, callback, parent)
end

return m
