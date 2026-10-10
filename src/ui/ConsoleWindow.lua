local m = {}

local colors = require("./Colors")

function m.new(window)
    local self = window:NewWindow({
        name = "ConsoleWindow",
        title = "Console",
        closeBehavior = "hide",
        visible = false,
        size = UDim2.fromScale(.6, .5),
        position = UDim2.fromScale(.55, .55),
        minSize = Vector2.new(360, 200),
        backgroundColor = colors.console.background
    })
    self.console = self:NewConsole({ maxEntries = 1000 })
    self.console.frame.Size = UDim2.fromScale(1, 1)
    self:AddTopbarButton("Clear", "Clear", function()
        self.console:Clear()
    end)
    return self
end

return m
