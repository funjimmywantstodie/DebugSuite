local Workbench = require("../Workbench")
local Catalog = require("../Catalog")
local Values = require("../Values")
local ConstantFilters = require("../ConstantFilters")
local m = {}
function m.init(window, context)
    local c = Workbench.scanner(context, "Functions", "1. Enter optional filters and Scan, or type constants below and click Scan constants only.  2. Select a result.\n3. Inspect its values or Send to Hooks. Scanning and inspection do not run the function.")
    c.status.frame.Size = UDim2.new(1, 0, 0, 85)
    c.search:SetPlaceholder("Name, source or table field contains... (optional; Enter to scan)")
    local metadataRow = c.tools:NewRow()
    local source = metadataRow:NewTextbox({ text = "Source contains... (optional)", fill = true })
    local arguments = metadataRow:NewTextbox({ text = "Parameter count (any)", width = 170 })
    for _, input in { source, arguments } do
        input:OnChanged(c.invalidate)
        input:OnSubmitted(function() c.scan() end)
    end
    local caseSensitive = c.tools:NewToggle({ text = "Case-sensitive names / sources", value = false })
    caseSensitive:OnChanged(c.invalidate)
    local filters = c.tab:NewSection("Search constants (comma-separated)", "top")
    local constantRow = filters:NewRow()
    local constants = constantRow:NewTextbox({ text = "e.g. integrity, Damage, 100, true (optional)", fill = true })
    constants:OnChanged(c.invalidate)
    constants:OnSubmitted(function() c.scan() end)
    local scanConstants = constantRow:NewButton({ text = "Scan constants only", width = 160 }, function() c.scan(true) end)
    scanConstants:SetEnabled(context.compat:Has("debug.getconstants"))
    local onBusyChanged = c.jobs.onBusyChanged
    c.jobs.onBusyChanged = function(busy)
        onBusyChanged(busy)
        scanConstants:SetEnabled(not busy and context.compat:Has("debug.getconstants"))
    end
    constantRow:NewButton({ text = "Clear constants", width = 115 }, function() constants:SetValue("") end)
    Workbench.hint(filters, { height = 90, text = 'Scan constants only ignores the name, source and parameter filters above. Regular Scan / Enter combines all filters.\nStrings always ignore case and match part of a constant: integrity finds Integrity-3212zx.\nSeparate values with commas. Numbers and true/false keep their types; quote text like "42" or "a,b".\nAll = every listed constant; Any = at least one. Leave blank to skip constants during a regular scan.' })
    local constantMode = filters:NewDropdown({ text = "Match constants", options = { "All", "Any" }, value = "All" })
    constantMode:OnChanged(c.invalidate)
    if not context.compat:Has("debug.getconstants") then
        constants:SetEnabled(false)
        constants:SetPlaceholder("Constant search unavailable: missing debug.getconstants")
        Workbench.hint(filters, { height = 40, text = "Constant filters unavailable: this executor has no debug.getconstants." })
    end
    local selected
    local actions = {}
    local resultSection = c.tab:NewSection("Functions", "left")
    local sendToHooks = resultSection:NewButton({ text = "Send to Hooks" }, function()
        if selected and context.selectHook then context.selectHook(selected.value, selected.values.name .. " / " .. selected.values.source) end
    end)
    sendToHooks:SetEnabled(false)
    table.insert(actions, { button = sendToHooks, handoff = true })
    local results = resultSection:NewList({ height = 310, columns = {
        { key = "name", text = "Name" }, { key = "line", text = "Line", width = 55 }, { key = "source", text = "Source" },
    } })
    local detail = c.tab:NewSection("Function details", "right")
    local viewer = Workbench.viewer(context, detail, { height = 130, syntax = "lua", text = "-- Select a function." })
    local selection = Workbench.hint(detail, { height = 85, text = "No function selected. Scan, then click a result on the left." })
    c.row:NewButton({ text = "Clear", width = 60 }, function()
        c.jobs:Cancel()
        results:Clear()
        c.status:SetText("Results cleared.")
    end)
    local function inspect(record)
        if c.tab.destroyed then return end
        selected = record
        for _, action in actions do action.button:SetEnabled(record ~= nil and (not action.api or context.compat:Has(action.api))
            and (not action.handoff or context.selectHook ~= nil)) end
        viewer.copyButton:SetEnabled(record ~= nil and context.compat:Has("setclipboard"))
        if not record then
            viewer:SetText("-- Select a function.")
            selection:SetText("No function selected. Scan, then click a result on the left.")
            return
        end
        local metadata = Catalog.metadata(context.compat, record.value)
        metadata.functionId = Catalog.functionId(record.value)
        metadata.alias = record.values.alias
        viewer:SetText(Values.serialize(metadata))
        local unavailable = {}
        for _, field in { "constants", "upvalues", "protos" } do
            if not context.compat:Has("debug.get" .. field) then table.insert(unavailable, if field == "protos" then "nested functions" else field) end
        end
        selection:SetText("Selected: function #" .. metadata.functionId .. " / " .. tostring(record.values.name) .. "\nSend to Hooks above the results transfers this exact function. Start tracing there."
            .. (if #unavailable > 0 then "\nUnavailable in this executor: " .. table.concat(unavailable, ", ") .. "." else "\nInspect buttons open a shared value browser."))
    end
    results:OnSelected(inspect)
    local primary = detail:NewRow()
    local open = primary:NewButton({ text = "Inspect function" }, Workbench.action(context, function()
        if selected then Workbench.inspect(context, selected.value, selected.values.name .. " / function") end
    end))
    open:SetEnabled(false)
    table.insert(actions, { button = open })
    local categories = detail:NewRow()
    for _, field in { { "constants", "Inspect constants", "Constants" }, { "upvalues", "Inspect upvalues", "Upvalues" }, { "protos", "Inspect nested functions", "Nested functions" } } do
        local api = "debug.get" .. field[1]
        local owner = if field[1] == "protos" then detail else categories
        local button = owner:NewButton({ text = field[2] }, Workbench.action(context, function()
            if not selected then return end
            local ok, value = context.compat:Call(api, selected.value)
            if not ok then error(value, 0) end
            Workbench.inspect(context, value, selected.values.name .. " / " .. field[3])
        end))
        button:SetEnabled(false)
        table.insert(actions, { button = button, api = api })
    end
    local refresh = detail:NewButton({ text = "Refresh function details" }, function() inspect(selected) end)
    refresh:SetEnabled(false)
    table.insert(actions, { button = refresh })
    Workbench.hint(detail, { height = 65, text = "In the inspector: expand arrows to browse tables; click a value to preview it. Copy value always copies raw data." })
    c.scan = function(constantsOnly)
        local query = if constantsOnly then "" else c.search:GetValue()
        c.jobs:Run(function(checkpoint)
            local countText = if constantsOnly then "" else arguments:GetValue():match("^%s*(.-)%s*$")
            local count = if countText == "" then nil else tonumber(countText)
            assert(countText == "" or count and count >= 0 and count < math.huge and count % 1 == 0, "Parameter count must be a nonnegative integer")
            local rules = ConstantFilters.parse(constants:GetValue(), Catalog.filterLimit)
            assert(not constantsOnly or #rules > 0, "Enter at least one constant in the comma-separated box before scanning constants only")
            local records, summary = Catalog.functions(context.compat, query, { constants = rules,
                constantMode = constantMode:GetValue(),
                caseSensitive = caseSensitive:GetValue(), source = if constantsOnly then "" else source:GetValue(), arguments = count }, checkpoint)
            if constantsOnly then summary ..= "\nConstants-only scan: name/source/parameter filters ignored." end
            return records, summary .. (if #records == 0 then "\nNo matches. Try fewer constants, Match constants: Any, or a broader name/source/parameter filter." else "\nSelect a result to inspect it or send it to Hooks.")
        end, function(records) results:SetRecords(records) end)
    end
    c.tab.controller = c
    c.results, c.viewer, c.selection = results, viewer, selection
    c.constants, c.constantMode, c.scanConstantsButton = constants, constantMode, scanConstants
    c.source, c.arguments, c.caseSensitive = source, arguments, caseSensitive
    inspect(nil)
    return c.tab
end
return m
