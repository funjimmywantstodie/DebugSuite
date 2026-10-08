local Window = require("./Window")
local tab = require("./Tab")

local window = Window.new({})
local testTab = window:NewTab("test")
local testTab2 = window:NewTab("test2")

local testSection = testTab:NewSection("test section", "left")
local testSection2 = testTab:NewSection("test section2", "right")
local testSection3 = testTab:NewSection("test section3", "left")
local testSection4 = testTab:NewSection("test section4", "right")
local testSection5 = testTab:NewSection("test section5", "left")
local testSection6 = testTab:NewSection("test section6", "right")
local testSection7 = testTab:NewSection("test section7", "left")
local testSection8 = testTab:NewSection("test section8", "right")

testSection:NewButton({ text = "test button" }, function()
    print("test button clicked")
end)
testSection:NewButton({ text = "test button2" }, function()
    print("test button2 clicked")
end)
testSection:NewButton({ text = "test button3" }, function()
    print("test button3 clicked")
end)
testSection2:NewButton({ text = "test button4" }, function()
    print("test button4 clicked")
end)
testSection3:NewTextbox({ text = "test textbox" }, function(value)
    print("test textbox value: " .. value)
end)
local topSection = testTab:NewSection("Overview", "top")
topSection:NewButton({ text = "Full-width button" }, function()
    print("full-width button clicked")
end)
local logsSection = testTab:NewSection("Logs", "bottom")
local console = logsSection:NewConsole({ text = "test console", height = 200 })
console:NewEntry("test console entry", "info")
console:NewEntry("test console entry", "warning")
console:NewEntry("test console entry", "error")
console:NewEntry("test console entry 112937192837129837189237912739817398127398127398127391273981273981273", "success")
local testSection9 = testTab2:NewSection("a", "left")
testTab2:NewSection("b", "right")
testTab2:NewSection("c", "left")
testTab2:NewSection("d", "right")
testTab2:NewSection("e", "left")
testTab2:NewSection("f", "right")
testTab2:NewSection("g", "left")
testTab2:NewSection("h", "right")
testSection9:NewButton({ text = "test button5" }, function()
    print("test button5 clicked")
end)
local testRow = testSection9:NewRow({ text = "test row" })
testRow:NewButton({ text = "test row button", width = 120 }, function()
    print("test row button clicked")
end)
testRow:NewTextbox({ text = "test row textbox" }, function(value)
    print("test row textbox value: " .. value)
end)

window:SelectTab(testTab)
window:Show()

local searchRow = topSection:NewRow({ text = "Search", gap = 6 })
local function search(value: string)
    print("search: " .. value)
end
local searchInput = searchRow:NewTextbox({ text = "Search...", fill = true }, search)
searchRow:NewButton({ text = "Search", width = 70 }, function()
    search(searchInput.button.Text)
end)

local debugTab = window:NewTab("debug")
local tools = debugTab:NewSection("Search", "top")
local eventSection = debugTab:NewSection("Events", "left")
local argumentSection = debugTab:NewSection("Arguments", "right")
local codeSection = debugTab:NewSection("Code", "right")
local options = debugTab:NewSection("Options", "left")
local logSection = debugTab:NewSection("Logs", "bottom")
local events = eventSection:NewList({
    height = 220,
    columns = {
        { key = "name", text = "name" },
        { key = "count", text = "calls", width = 60 },
    },
})
local arguments = argumentSection:NewTree({ height = 120, emptyText = "Select an event to inspect its arguments" })
local code = codeSection:NewTextViewer({ height = 120, text = "select an event" })
local searchRow = tools:NewRow()
local filter = searchRow:NewTextbox({ text = "filter events" })
searchRow:NewButton({ text = "Clear", width = 70 }, function() events:Clear() end)
searchRow:NewButton({ text = "Sample", width = 70 }, function()
    events:Append({ { id = "sample", values = { name = "sample event", count = 3 } } })
end)
filter:OnChanged(function(value) events:SetFilter(value) end)
events:OnSelected(function(record)
    if not record then arguments:Clear() code:SetText("select an event") return end
    arguments:SetNodes({
        { id = "args", text = "arguments", loadChildren = function()
            return { { id = "value", text = "value = " .. record.values.count } }
        end },
    })
    code:SetText("print(" .. string.format("%q", record.values.name) .. ")")
end)
local history = logSection:NewConsole({ height = 100, maxEntries = 100 })
options:NewToggle({ text = "pause logs" }, function(value) history:SetPaused(value) end)
options:NewDropdown({ text = "level", options = { "info", "warning", "error" }, value = "info" }, function(value)
    history:NewEntry("level: " .. tostring(value), "info")
end)
options:NewMenu({ text = "actions", items = {
    { text = "clear logs", callback = function() history:Clear() end },
    { text = "sample log", callback = function() history:NewEntry("sample log", "info") end },
} })
events:SetRecords({
    { id = "one", values = { name = "first event", count = 12 } },
    { id = "two", values = { name = "second event", count = 4 } },
})
window:BindShortcut(Enum.KeyCode.F, function() filter:Focus() end, { ctrl = true })
