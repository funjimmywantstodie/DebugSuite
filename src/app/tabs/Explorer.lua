local Workbench = require("../Workbench")
local Catalog = require("../Catalog")
local Values = require("../Values")
local Instances = require("../Instances")
local Scope = require("../../ui/util/Scope")
local m = {}
function m.init(window, context)
    local c = Workbench.scanner(context, "Explorer", "Browse the lazy hierarchy or scan client-visible names/classes/paths. Properties are read-only. Select Scripts to find readable source.")
    local mode = c.tools:NewDropdown({ text = "Kind", options = { "All", "Scripts", "Remotes" }, value = "All" })
    mode:OnChanged(c.invalidate)
    local hierarchy = c.tab:NewSection("Hierarchy", "left")
    local tree = hierarchy:NewTree({ height = 250 })
    local results = c.tab:NewSection("Search results", "left"):NewList({ height = 250, columns = {
        { key = "name", text = "Name" }, { key = "class", text = "Class", width = 100 },
    } })
    local detail = c.tab:NewSection("Properties and attributes", "right")
    local propertyTree = detail:NewTree({ height = 220 })
    local output = Workbench.viewer(context, detail, { height = 200, syntax = "lua", text = "-- Select an instance." })
    local selected, selectedValue, baseline, baselineValue, baselineLabel, dirty, elapsed = nil, nil, nil, nil, nil, false, 0
    local viewMode = "selection"
    local refreshButton, copyPath, readSource, capture, compare, clearBaseline, showRaw
    local baselineStatus = detail:NewTextViewer({ height = 45, text = "No baseline captured." })
    local function updateActions()
        if c.tab.destroyed then return end
        refreshButton:SetEnabled(selected ~= nil)
        copyPath:SetEnabled(selected ~= nil and context.compat:Has("setclipboard"))
        readSource:SetEnabled(selected ~= nil and Catalog.isScript(selected))
        capture:SetEnabled(selected ~= nil)
        compare:SetEnabled(baseline ~= nil and selected == baselineValue)
        clearBaseline:SetEnabled(baseline ~= nil)
        showRaw:SetEnabled(selectedValue ~= nil)
        baselineStatus:SetText(if baseline then "Baseline: " .. baselineLabel .. (if selected == baselineValue then "\nReady to compare." else "\nSelect this instance to compare.") else "No baseline captured.")
    end
    local watch = Scope.new()
    c.tab.scope:Add(function() watch:Destroy() end)
    local function showProperty(node, refreshing)
        if c.tab.destroyed then return end
        if node and not node.inspectable then return end
        selectedValue = if node then node.value else nil
        if node and not (refreshing and (viewMode == "source" or viewMode == "diff")) then
            if refreshing and viewMode == "raw" then
                output:SetText(Values.serialize(node.value))
                output.copyButton:SetEnabled(context.compat:Has("setclipboard"))
            else
                viewMode = "value"
                output:SetText(Workbench.preview(node.value))
                output.copyButton:SetEnabled(type(node.value) ~= "table" and type(node.value) ~= "function" and context.compat:Has("setclipboard"))
            end
        end
        updateActions()
    end
    local function refresh()
        if not selected then return end
        local data = Instances.describe(selected)
        propertyTree:SetNodes(Instances.propertyNodes(selected, data), true, false)
        propertyTree:Expand("instance", true)
        local selectedNode
        for _, entry in propertyTree.visibleNodes do
            if entry.node.id == propertyTree.selectedId then selectedNode = entry.node break end
        end
        showProperty(selectedNode, true)
        if (viewMode == "selection" or viewMode == "value" or viewMode == "raw") and selectedValue == nil then
            viewMode = "selection"
            output:SetText("-- " .. Values.preview(selected) .. "\n-- Select a property or attribute to preview its value.")
            output.copyButton:SetEnabled(false)
        end
        updateActions()
    end
    local function select(instance)
        if c.tab.destroyed then return end
        watch:Destroy()
        watch = Scope.new()
        selected = instance
        selectedValue = nil
        viewMode = "selection"
        propertyTree:SetNodes({}, false, false)
        dirty = false
        if not selected then
            output:SetText("-- Select an instance.")
            output.copyButton:SetEnabled(false)
            updateActions()
            return
        end
        refresh()
        watch:Connect(selected.Changed, function() dirty = true end)
        watch:Connect(selected.AttributeChanged, function() dirty = true end)
        watch:Connect(selected.Destroying, function()
            watch:Destroy()
            selected = nil
            selectedValue = nil
            propertyTree:SetNodes({}, false, false)
            output:SetText("-- Selected instance was destroyed.")
            output.copyButton:SetEnabled(false)
            updateActions()
        end)
    end
    tree:OnSelected(Workbench.action(context, function(node) if node and node.value then select(node.value) end end))
    results:OnSelected(Workbench.action(context, function(record) select(if record then record.value else nil) end))
    propertyTree:OnSelected(function(node)
        showProperty(node, false)
    end)
    local live = detail:NewToggle({ text = "Live property refresh (5 Hz)", value = false })
    c.tab.scope:Connect(window.ctx.services.RunService.RenderStepped, function(dt)
        elapsed += dt
        if elapsed >= .2 then
            elapsed = 0
            if dirty and live:GetValue() and window.currentTab == c.tab then dirty = false refresh() end
        end
    end)
    refreshButton = detail:NewButton({ text = "Refresh properties" }, Workbench.action(context, refresh))
    copyPath = detail:NewButton({ text = "Copy instance path" }, Workbench.action(context, function()
        assert(selected, "Select an instance first")
        Workbench.copy(context, Values.path(selected))
    end))
    readSource = detail:NewButton({ text = "Read script source" }, Workbench.action(context, function()
        assert(selected and Catalog.isScript(selected), "Select a Script, LocalScript or ModuleScript")
        local ok, source = pcall(function() return selected.Source end)
        assert(ok and type(source) == "string", "Source is not readable in this runtime")
        output:SetSyntax("lua")
        viewMode = "source"
        output:SetText(source:sub(1, 131072) .. (if #source > 131072 then "\n-- Source truncated at 128 KiB" else ""))
        output.copyButton:SetEnabled(context.compat:Has("setclipboard"))
    end))
    capture = detail:NewButton({ text = "Capture property baseline" }, Workbench.action(context, function()
        assert(selected, "Select an instance first")
        local data = Instances.describe(selected)
        baseline = Values.snapshot({ properties = data.properties, attributes = data.attributes })
        baselineValue = selected
        baselineLabel = Values.preview(selected) .. (if baseline.truncated then " (partial)" else "")
        updateActions()
    end))
    compare = detail:NewButton({ text = "Compare properties" }, Workbench.action(context, function()
        assert(baseline and selected == baselineValue, "Select the instance used for the baseline")
        local data = Instances.describe(selected)
        output:SetSyntax(false)
        viewMode = "diff"
        output:SetText(Values.diff(baseline, Values.snapshot({ properties = data.properties, attributes = data.attributes })))
        output.copyButton:SetEnabled(context.compat:Has("setclipboard"))
    end))
    clearBaseline = detail:NewButton({ text = "Clear baseline" }, function()
        baseline, baselineValue, baselineLabel = nil, nil, nil
        updateActions()
    end)
    showRaw = detail:NewButton({ text = "Show raw value" }, function()
        viewMode = "raw"
        output:SetText(Values.serialize(selectedValue))
        output.copyButton:SetEnabled(context.compat:Has("setclipboard"))
    end)
    hierarchy:NewButton({ text = "Refresh hierarchy" }, function() tree:SetNodes(Instances.nodes(game, window.guis.ScreenGui)) end)
    c.row:NewButton({ text = "Clear", width = 60 }, function()
        c.jobs:Cancel()
        results:Clear()
        select(nil)
        baseline, baselineValue = nil, nil
        updateActions()
        c.status:SetText("Results and baseline cleared.")
    end)
    c.scan = function()
        local query, kind = c.search:GetValue(), mode:GetValue()
        c.jobs:Run(function(checkpoint) return Catalog.instances(game, query, kind, window.guis.ScreenGui, checkpoint) end,
            function(records) results:SetRecords(records) end)
    end
    tree:SetNodes(Instances.nodes(game, window.guis.ScreenGui))
    tree:Expand(1, true)
    c.tab.controller = c
    updateActions()
    output.copyButton:SetEnabled(false)
    return c.tab
end
return m
