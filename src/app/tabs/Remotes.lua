local Workbench = require("../Workbench")
local Catalog = require("../Catalog")
local Values = require("../Values")
local Recorder = require("../Recorder")
local Outgoing = require("../Outgoing")
local Scope = require("../../ui/util/Scope")
local m = {}
function m.init(window, context)
    local c = Workbench.scanner(context, "Remotes", "Inventory + opt-in incoming events and selected outgoing FireServer/InvokeServer namecalls. Arguments and return values are frozen; calls pass through.")
    local list = c.tab:NewSection("Remote inventory", "left"):NewList({ height = 280, columns = {
        { key = "name", text = "Name" }, { key = "class", text = "Class", width = 115 },
    } })
    local actions = c.tab:NewSection("Observation", "right")
    local status = actions:NewTextViewer({ height = 90, text = "No watches. Select an event, then Watch selected.\nWatches add ordinary OnClientEvent listeners." })
    local historySection = c.tab:NewSection("Captured traffic", "bottom")
    local events = historySection:NewList({ height = 200, columns = {
        { key = "time", text = "Seconds", width = 85 }, { key = "args", text = "Args", width = 45 },
        { key = "kind", text = "Direction / method", width = 150 },
        { key = "outcome", text = "Outcome", width = 75 },
        { key = "duration", text = "ms", width = 65 },
        { key = "partial", text = "Data", width = 65 }, { key = "path", text = "Remote path" },
    } })
    local output = Workbench.viewer(context, historySection, { height = 180, text = "-- Select a captured event.", syntax = "lua" })
    local recorder = Recorder.new()
    local selected, watches, watchCount, dirty, elapsed = nil, {}, 0, false, 0
    local watchButton, stopButton, stopAllButton, copyPath, outgoingStart, outgoingStop, outgoingStopAll
    local paused = actions:NewToggle({ text = "Pause capture", value = false })
    local backend = actions:NewDropdown({ text = "Outgoing backend", options = { "Standard", "Volt OTH" }, value = "Standard" })
    local outgoing = Outgoing.new(context.hooks, recorder, function() return paused:GetValue() end)
    local renderedVersion, watchVersion, wasTracing = -1, -1, false
    c.tab.scope:Add(function() outgoing:Destroy() end)
    local function updateStatus()
        if c.tab.destroyed then return end
        outgoing:Sync()
        local paths = {}
        for instance in watches do table.insert(paths, Values.path(instance)) end
        table.sort(paths)
        local canWatch = selected ~= nil and selected.ClassName ~= "RemoteFunction" and selected:IsDescendantOf(game)
        local hint = if selected and selected.ClassName == "RemoteFunction" then "RemoteFunction callbacks are not observed."
            elseif selected and not canWatch then "Event left the DataModel. Scan again."
            elseif watchCount == 0 then "Select an event, then Watch selected incoming event." else table.concat(paths, "\n")
        local entry = outgoing.entry
        local tracing = entry and context.hooks.entries[entry.target] == entry and entry.active
        status:SetText(string.format("%d/32 watches incoming | %d/32 outgoing (%s) | %d retained | %d rate-limited\n%s%s", watchCount, outgoing.count,
            if tracing then "tracing" else "stopped", #recorder.records, recorder.dropped, hint,
            if entry and entry.error then "\n" .. entry.error else ""))
        watchButton:SetEnabled(canWatch and not watches[selected] and watchCount < 32)
        stopButton:SetEnabled(selected ~= nil and watches[selected] ~= nil)
        stopAllButton:SetEnabled(watchCount > 0)
        copyPath:SetEnabled(selected ~= nil and context.compat:Has("setclipboard"))
        outgoingStart:SetEnabled(selected ~= nil and selected:IsDescendantOf(game) and outgoing:Available(backend:GetValue())
            and not outgoing.watches[selected] and outgoing.count < 32
            and (outgoing.entry == nil or (tracing and outgoing.entry.backend == backend:GetValue())))
        outgoingStop:SetEnabled(selected ~= nil and outgoing.watches[selected] ~= nil)
        outgoingStopAll:SetEnabled(outgoing.count > 0 or outgoing.entry ~= nil)
    end
    local function stop(instance)
        local scope = watches[instance]
        if scope then
            watches[instance] = nil
            watchCount -= 1
            scope:Destroy()
            updateStatus()
        end
    end
    local function stopAll()
        local instances = {}
        for instance in watches do table.insert(instances, instance) end
        for _, instance in instances do stop(instance) end
    end
    c.tab.scope:Add(stopAll)
    list:OnSelected(function(record)
        selected = if record then record.value else nil
        updateStatus()
    end)
    watchButton = actions:NewButton({ text = "Watch selected incoming event" }, Workbench.action(context, function()
        assert(selected and Catalog.isRemote(selected) and selected.ClassName ~= "RemoteFunction", "Select a RemoteEvent or UnreliableRemoteEvent")
        assert(selected:IsDescendantOf(game), "Selected event is no longer in the DataModel; scan again")
        if watches[selected] then updateStatus() return end
        assert(watchCount < 32, "32-watch limit reached; stop a watch first")
        local instance, scope = selected, Scope.new()
        local ok, err = pcall(function()
            scope:Connect(instance.OnClientEvent, function(...)
                if paused:GetValue() then return end
                recorder:Push(function() return Values.path(instance) end, table.pack(...), os.clock() - context.started)
                dirty = true
            end)
            scope:Connect(instance.AncestryChanged, function()
                if not instance:IsDescendantOf(game) then stop(instance) dirty = true end
            end)
            scope:Connect(instance.Destroying, function() stop(instance) dirty = true end)
        end)
        if not ok then scope:Destroy() error(err, 0) end
        watches[instance] = scope
        watchCount += 1
        updateStatus()
    end))
    stopButton = actions:NewButton({ text = "Stop selected watch" }, function() if selected then stop(selected) end updateStatus() end)
    stopAllButton = actions:NewButton({ text = "Stop all watches" }, function() stopAll() updateStatus() end)
    copyPath = actions:NewButton({ text = "Copy selected remote path" }, Workbench.action(context, function()
        assert(selected, "Select a remote first")
        Workbench.copy(context, Values.path(selected))
    end))
    outgoingStart = actions:NewButton({ text = "Watch selected outgoing calls" }, Workbench.action(context, function()
        outgoing:Watch(selected, backend:GetValue())
        updateStatus()
    end))
    outgoingStop = actions:NewButton({ text = "Stop selected outgoing watch" }, Workbench.action(context, function()
        local ok, err = outgoing:Stop(selected)
        updateStatus()
        assert(ok, err)
    end))
    outgoingStopAll = actions:NewButton({ text = "Stop all outgoing watches" }, Workbench.action(context, function()
        local ok, err = outgoing:StopAll()
        updateStatus()
        assert(ok, err)
    end))
    backend:OnChanged(updateStatus)
    actions:NewTextViewer({ height = 75, text = "Outgoing watches observe selected :FireServer / :InvokeServer calls through one shared __namecall hook. Direct method calls and incoming RemoteFunction callbacks are outside this capture. Stop all outgoing watches to change backend." })
    local filter = historySection:NewTextbox({ text = "Filter captured paths" })
    filter:OnChanged(function(value) events:SetFilter(value) end)
    local function showEvent(record)
        output:SetText(if record then record.text else "-- Select a captured event.")
    end
    events:OnSelected(showEvent)
    historySection:NewButton({ text = "Clear captured events" }, function()
        recorder:Clear()
        events:SetRecords({}, false)
        showEvent(nil)
        updateStatus()
    end)
    c.tab.scope:Connect(window.ctx.services.RunService.RenderStepped, function(dt)
        elapsed += dt
        local entry = outgoing.entry
        local tracing = entry ~= nil and context.hooks.entries[entry.target] == entry and entry.active
        if elapsed >= .2 and (dirty or recorder.version ~= renderedVersion or outgoing.version ~= watchVersion or tracing ~= wasTracing) then
            elapsed, dirty = 0, false
            events:SetRecords(recorder.records, false)
            -- Finished outgoing calls update the same record object.
            showEvent(events.selectedRecord)
            updateStatus()
            renderedVersion, watchVersion, wasTracing = recorder.version, outgoing.version, tracing
        end
    end)
    c.scan = function()
        local query = c.search:GetValue()
        c.jobs:Run(function(checkpoint) return Catalog.instances(game, query, "Remotes", window.guis.ScreenGui, checkpoint) end,
            function(records) list:SetRecords(records) end)
    end
    c.tab.controller = c
    c.outgoing = outgoing
    updateStatus()
    return c.tab
end
return m
