local m = {}
m.Name = "GC"

local types = require("../../Types")
function m.init(window: types.Window)
    local tab = window:NewTab("GC")
    local section = tab:NewSection("Search GC", "full")

    section:NewTextbox({ text = "Search..." }, function(value)
        print("Search:", value)
    end)

    section:NewButton({ text = "Refresh" }, function()
        print("Refresh clicked")
    end)

    return tab
end

return m