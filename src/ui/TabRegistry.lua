local m = {}

local types = require("./Types")

local tabs = {} :: {types.Tab}

function m.Store(tab: types.Tab): ()
    table.insert(tabs, tab)
end

function m.Get(target: types.Tab): types.Tab?
    for _, tab in tabs do
        if tab == target then
            return tab
        end
    end
end

return m