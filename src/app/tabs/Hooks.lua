local m = {}
m.Name = "Hooks"

local types = require("../../Types")
function m.init(window: types.Window)
    local tab = window:NewTab("Hooks")
    return tab
end

return m