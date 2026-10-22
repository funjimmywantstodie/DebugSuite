local Workbench = require("../Workbench")
local Catalog = require("../Catalog")
local Values = require("../Values")
local m = {}
function m.init(window, context)
    local c = Workbench.scanner(context, "GC", "Literal search across raw table keys and value previews. Capture a baseline, then compare after reproducing a bug.")
    local results = c.tab:NewSection("Tables", "left"):NewList({ height = 350, columns = {
        { key = "name", text = "Table", width = 90 }, { key = "entries", text = "Keys", width = 45 }, { key = "preview", text = "Preview", syntax = "lua" },
    } })
    local detail = c.tab:NewSection("Table contents", "right")
    local baselineStatus = detail:NewTextViewer({ height = 45, text = "No baseline captured." })
    local tree = detail:NewTree({ height = 250 })
    local selected, baseline, baselineValue, baselineLabel, selectedValue
    local compare, release, capture, open, metadata, showRaw
    local output = Workbench.viewer(context, c.tab:NewSection("Raw value / snapshot diff", "bottom"), { height = 180, text = "Select a table.", syntax = "lua" })
    local function updateActions()
        if c.tab.destroyed then return end
        capture:SetEnabled(selected ~= nil)
        compare:SetEnabled(baseline ~= nil and selected == baselineValue)
        release:SetEnabled(baseline ~= nil)
        open:SetEnabled(selectedValue ~= nil)
        showRaw:SetEnabled(selectedValue ~= nil)
        metadata:SetEnabled(selected ~= nil and getmetatable(selected) ~= nil)
        baselineStatus:SetText(if baseline then "Baseline: " .. baselineLabel .. (if selected ~= baselineValue then "\nSelect this table to compare." else "\nReady to compare.") else "No baseline captured.")
    end
    results:OnSelected(function(record)
        if c.tab.destroyed then return end
        selected = if record then record.value else nil
        selectedValue = selected
        tree:Clear()
        if record then
            tree:SetNodes(Values.nodes(selected, record.values.name))
            tree:Expand(1, true)
            output:SetText(Workbench.preview(selected))
        else output:SetText("-- Select a table.") end
        output.copyButton:SetEnabled(false)
        updateActions()
    end)
    tree:OnSelected(function(node)
        if c.tab.destroyed then return end
        if node and not node.inspectable then return end
        selectedValue = if node then node.value else selected
        if node then output:SetText(Workbench.preview(node.value)) end
        output.copyButton:SetEnabled(node ~= nil and type(node.value) ~= "table" and type(node.value) ~= "function" and context.compat:Has("setclipboard"))
        updateActions()
    end)
    capture = detail:NewButton({ text = "Capture baseline" }, Workbench.action(context, function()
        baseline = Values.snapshot(selected)
        baselineValue = selected
        baselineLabel = results.selectedRecord.values.name .. (if baseline.truncated then " (partial)" else "")
        updateActions()
    end))
    compare = detail:NewButton({ text = "Compare with baseline" }, Workbench.action(context, function()
        assert(baseline and selected == baselineValue, "Select the table used for the baseline")
        output:SetSyntax(false)
        output:SetText(Values.diff(baseline, Values.snapshot(selected)))
        output.copyButton:SetEnabled(context.compat:Has("setclipboard"))
    end))
    release = detail:NewButton({ text = "Clear baseline" }, function()
        baseline, baselineValue, baselineLabel = nil, nil, nil
        updateActions()
    end)
    open = detail:NewButton({ text = "Inspect selected" }, Workbench.action(context, function()
        assert(selectedValue ~= nil, "Select a non-nil value first")
        Workbench.inspect(context, selectedValue, "GC value")
    end))
    metadata = detail:NewButton({ text = "Inspect accessible metatable" }, Workbench.action(context, function()
        assert(selected, "Select a table first")
        local metadata = getmetatable(selected)
        assert(metadata ~= nil, "Selected table has no accessible metatable")
        Workbench.inspect(context, metadata, "Metatable (may be a protected marker)")
    end))
    showRaw = detail:NewButton({ text = "Show raw value" }, function()
        output:SetText(Values.serialize(selectedValue))
        output.copyButton:SetEnabled(context.compat:Has("setclipboard"))
    end)
    c.row:NewButton({ text = "Clear", width = 60 }, function()
        c.jobs:Cancel()
        results:Clear()
        baseline, baselineValue = nil, nil
        updateActions()
        c.status:SetText("Results and baseline cleared.")
    end)
    c.scan = function()
        local query = c.search:GetValue()
        c.jobs:Run(function(checkpoint) return Catalog.tables(context.compat, query, checkpoint) end, function(records) results:SetRecords(records) end)
    end
    c.tab.controller = c
    updateActions()
    output.copyButton:SetEnabled(false)
    return c.tab
end
return m
