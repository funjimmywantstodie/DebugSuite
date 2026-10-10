local Window = require("./ui/Window")

local mainWindow = Window.new({})
local funcsTab = mainWindow:NewTab("Functions")
funcsTab:NewSection("Search Functions", "full")


mainWindow:Show()
