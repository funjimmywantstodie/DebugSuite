local m = {}

local types = require("../../Types")
function m.init(window: types.Window)
    local tab = window:NewTab("Functions")
    local section = tab:NewSection("Search Functions", "full")

    section:NewTextbox({ text = "Search..." }, function(value)
        print("Search:", value)
    end)

    section:NewButton({ text = "Refresh" }, function()
        print("Refresh clicked")
    end)

    return tab
end

return m