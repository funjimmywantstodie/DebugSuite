local Workbench = require("../Workbench")
local Catalog = require("../Catalog")
local Values = require("../Values")
local OverrideEditor = require("../OverrideEditor")
local m = {}
function m.init(window, context)
    local c = { tab = window:NewTab("Hooks") }
    local workflow = c.tab:NewSection("Hooks workflow", "top")
    c.help = Workbench.hint(workflow, { height = 65, text = "1. Find a function in Functions and click Send to Hooks. Its exact function reference arrives here.\n2. Choose a backend and Trace selected function.  3. Trigger it in-game, then read captured calls below." })
    workflow:NewButton({ text = "Find / change function" }, Workbench.action(context, function()
        local functions = context.tabs.Functions
        assert(functions and not functions.destroyed, "Functions is unavailable; check the console for initialization errors")
        window:SelectTab(functions)
        window.shell:Focus()
    end))
    local manager = context.hooks
    local targetSection = c.tab:NewSection("Selected function", "left")
    targetSection.frame:FindFirstChild("Header").Text = "1. Function from discovery"
    local targetReport = Workbench.viewer(context, targetSection, { height = 155, syntax = "lua",
        text = "-- No function selected.\n-- Open Functions, select a result, then click Send to Hooks." })
    targetReport.copyButton:SetEnabled(false)
    local controls = c.tab:NewSection("Tracing", "right")
    controls.frame:FindFirstChild("Header").Text = "2. Start or stop tracing"
    local targetStatus = Workbench.hint(controls, { height = 115, text = "Select a function." })
    local backend = controls:NewDropdown({ text = "Backend", options = { "Standard", "Volt OTH" },
        value = if manager:Available("Standard") or not manager:Available("Volt OTH") then "Standard" else "Volt OTH" })
    local pause = controls:NewToggle({ text = "Pause hook capture", value = false })
    local activeSection = c.tab:NewSection("Managed hooks", "left")
    local active = activeSection:NewList({ height = 150, columns = {
        { key = "name", text = "Target" }, { key = "backend", text = "Backend", width = 85 },
        { key = "hits", text = "Calls", width = 55 }, { key = "state", text = "State", width = 100 },
    } })
    local history = c.tab:NewSection("Captured calls", "bottom")
    history.frame:FindFirstChild("Header").Text = "3. Read captured calls"
    local summary = Workbench.hint(history, { height = 60 })
    local filter = history:NewTextbox({ text = "Filter captured calls" })
    c.tab.searchInput = filter
    local calls = history:NewList({ height = 180, columns = {
        { key = "time", text = "Seconds", width = 80 }, { key = "path", text = "Function" },
        { key = "args", text = "Args", width = 40 }, { key = "outcome", text = "Outcome", width = 75 },
        { key = "duration", text = "ms", width = 65 }, { key = "partial", text = "Data", width = 60 },
    } })
    local follow = history:NewToggle({ text = "Follow latest matching call", value = true })
    local output = Workbench.viewer(context, history, { height = 190, syntax = "lua", text = "-- No calls yet. Start tracing, then reproduce the action." })
    local target, label, selectedEntry, start, stop, stopAll, lastAction, editor
    local function showCall(record)
        output:SetText(if record then record.text .. (if record.values.outcome == "running" then "\n-- Still running; waiting for returns or an error." else "")
            else "-- No call selected. Start tracing and reproduce the action, or select a captured row.")
    end
    local function refreshCalls()
        calls:SetRecords(manager.recorder.records, false)
        if follow:GetValue() and #calls.filtered > 0 then
            local latest = calls.filtered[1]
            for _, record in calls.filtered do if record.id > latest.id then latest = record end end
            calls:Select(latest.id, false)
        end
        -- The recorder finishes yielded calls in place; list identity does not change.
        showCall(calls.selectedRecord)
    end
    filter:OnChanged(function(value) calls:SetFilter(value, false) refreshCalls() end)
    follow:OnChanged(refreshCalls)
    calls:OnSelected(function(record)
        if record then follow:SetValue(false) end
        showCall(record)
    end)
    local function update()
        if c.tab.destroyed then return end
        local canTrace, reason = manager:CanTrace(target, backend:GetValue())
        local state
        if selectedEntry and manager.entries[selectedEntry.target] == selectedEntry then
            state = if selectedEntry.error then "STOP FAILED: capture off. Retry Stop selected hook.\n" .. selectedEntry.error
                elseif manager.paused then "PAUSED: hook installed; new calls are not recorded."
                elseif selectedEntry.hits == 0 then "TRACING: waiting for a call. Reproduce the action now."
                else "TRACING: " .. selectedEntry.hits .. " calls observed."
            state ..= "\nInstalled backend: " .. selectedEntry.backend
            if selectedEntry.override then state ..= " | Return override ON (" .. selectedEntry.override.values.n .. " slots)." end
            if selectedEntry.hits > 0 then
                state ..= if selectedEntry.recorder == manager.recorder then " | Calls below." else " | Traffic in Remotes."
            end
        else
            state = if not target then "Choose a function in Functions, then click Send to Hooks."
                elseif canTrace then "READY: click Trace selected function (" .. backend:GetValue() .. ")." else "BLOCKED: " .. reason
            if canTrace and manager.paused then state ..= "\nCapture is paused; turn off Pause hook capture to record." end
        end
        targetStatus:SetText("Target: " .. (label or "none") .. "\n" .. state .. (if lastAction then "\nLast action: " .. lastAction else ""))
        start:SetEnabled(canTrace)
        local records = {}
        local tracing, retry = 0, 0
        for _, entry in manager.entries do
            if entry.active then tracing += 1 else retry += 1 end
            table.insert(records, { id = entry.id, value = entry, values = { name = entry.label, backend = entry.backend, hits = entry.hits,
                state = if entry.error then "retry stop" elseif not entry.active then "stopped" elseif manager.paused then "paused"
                    elseif entry.override then "overriding" elseif entry.hits == 0 then "waiting" else "tracing" } })
        end
        table.sort(records, function(a, b) return a.id < b.id end)
        active.selectedId = if selectedEntry then selectedEntry.id else nil
        -- Programmatic refreshes must not feed back into the selection handler,
        -- including when Roblox dispatches BindableEvent callbacks later.
        active:SetRecords(records, false)
        stop:SetEnabled(selectedEntry ~= nil and manager.entries[selectedEntry.target] == selectedEntry)
        stopAll:SetEnabled(#records > 0)
        if editor then editor:SetEntry(if selectedEntry and manager.entries[selectedEntry.target] == selectedEntry then selectedEntry else nil) end
        summary:SetText(string.format("%s | %d tracing | %d need stop retry | %d/32 managed\n%d/500 retained calls | %d rate-limited | %d capture failures",
            if manager.paused then "Capture paused" elseif tracing > 0 then "Capture live" else "Capture stopped",
            tracing, retry, #records, #manager.recorder.records, manager.recorder.dropped, manager.failures))
    end
    local function setTarget(value, name)
        target, label = value, name
        c.target, c.label = value, name
        if value then
            local metadata = Catalog.metadata(context.compat, value)
            metadata.functionId, metadata.label = Catalog.functionId(value), name
            targetReport:SetText(Values.serialize(metadata))
        else
            targetReport:SetText("-- No function selected.\n-- Open Functions, select a result, then click Send to Hooks.")
        end
        targetReport.copyButton:SetEnabled(value ~= nil and context.compat:Has("setclipboard"))
    end
    c.select = function(value, name)
        assert(value == nil or type(value) == "function", "Select a function")
        setTarget(value, name or (if value then "Inspected function" else nil))
        lastAction = nil
        selectedEntry = if value then manager.entries[value] else nil
        update()
    end
    context.selectHook = function(value, name)
        c.select(value, name or "Inspected function")
        window:SelectTab(c.tab)
        c.tab.container.CanvasPosition = Vector2.new(0, 0)
        window.shell:Focus()
    end
    active:OnSelected(function(record)
        selectedEntry = if record then record.value else nil
        if selectedEntry then setTarget(selectedEntry.target, selectedEntry.label) end
        lastAction = nil
        update()
    end)
    local function action(callback)
        return function()
            local ok, message = pcall(callback)
            lastAction = if ok then message else "Failed: " .. tostring(message)
            update()
            if ok then window:Log(message, "success")
            else window:Notify({ text = tostring(message), messageType = "error" }) end
        end
    end
    start = controls:NewButton({ text = "Trace selected function" }, action(function()
        selectedEntry = manager:Add(target, label, backend:GetValue())
        return "Hook installed. " .. (if manager.paused then "Capture is paused." else "Reproduce the action to capture calls.")
    end))
    stop = controls:NewButton({ text = "Stop selected hook" }, action(function()
        assert(selectedEntry, "Select a managed hook first")
        local ok, err = manager:Stop(selectedEntry.target)
        assert(ok, err)
        selectedEntry = nil
        return "Original function restored; captured history kept."
    end))
    stopAll = controls:NewButton({ text = "Stop all hooks" }, action(function()
        local ok, err = manager:StopAll()
        assert(ok, err)
        selectedEntry = nil
        return "All managed hooks restored (including outgoing remote hooks)."
    end))
    pause:OnChanged(function(value)
        manager.paused = value
        lastAction = if value then "Capture paused; calls still run." else "Capture resumed."
        update()
    end)
    controls:NewButton({ text = "Refresh hook status" }, update)
    Workbench.hint(controls, { height = 65, text = "Tracing records arguments, returns, errors and time while the original function runs. Pause skips new captures; Stop restores the function. Volt OTH accepts C functions only." })
    editor = OverrideEditor.new(c.tab:NewSection("Return overrides", "right"), manager, action)
    history:NewButton({ text = "Clear captured calls" }, function()
        manager.recorder:Clear()
        calls:Clear()
        showCall(nil)
        update()
    end)
    backend:OnChanged(update)
    local elapsed = 0
    c.tab.scope:Connect(window.ctx.services.RunService.RenderStepped, function(dt)
        elapsed += dt
        if elapsed >= .2 and manager.dirty then
            elapsed, manager.dirty = 0, false
            refreshCalls()
            update()
        end
    end)
    c.tab.scope:Add(function()
        context.selectHook = nil
        local targets = {}
        for targetValue, entry in manager.entries do
            if entry.recorder == manager.recorder then table.insert(targets, targetValue) end
        end
        for _, targetValue in targets do
            local ok, err = manager:Stop(targetValue)
            if not ok then warn("DebugSuite hook cleanup: " .. err) end
        end
    end)
    c.tab.controller = c
    c.targetStatus, c.targetReport, c.calls, c.output, c.follow, c.pause, c.backend = targetStatus, targetReport, calls, output, follow, pause, backend
    c.overrideEditor = editor
    update()
    return c.tab
end
return m
