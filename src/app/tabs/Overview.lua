local Workbench = require("../Workbench")
local m = {}
function m.init(window, context)
    local tab = window:NewTab("Overview")
    local welcome = tab:NewSection("DebugSuite", "top")
    Workbench.hint(welcome, { height = 110, text = "Choose what you want to investigate below.\nFor a function: discover in Functions -> select a result -> Send to Hooks -> start tracing -> trigger it in-game -> inspect calls.\nFor state changes: select a table or instance -> capture a baseline -> reproduce -> compare.\nCtrl+F focuses search (captured-call filtering in Hooks). Scans and tracing start when you request them." })
    local function open(name)
        local target = context.tabs[name]
        if not target then window:Notify({ text = name .. " is unavailable. Open the console for initialization details.", messageType = "error" }) return end
        window:SelectTab(target)
        if name ~= "Hooks" and target.searchInput then target.searchInput:Focus() end
    end
    local function taskRow(entries)
        local row = welcome:NewRow()
        for _, entry in entries do
            row:NewButton({ text = entry[1] }, function() open(entry[2]) end)
        end
    end
    taskRow({ { "Find functions", "Functions" }, { "Trace / manage hooks", "Hooks" }, { "Watch remotes", "Remotes" } })
    taskRow({ { "Browse instances", "Explorer" }, { "Search tables", "GC" }, { "Read logs", "Logs" }, { "Check performance", "Runtime" } })
    local tools = tab:NewSection("What each tool shows", "left")
    Workbench.hint(tools, { height = 225, text = "Explorer: hierarchy, properties, attributes, source.\nFunctions: names, constants, upvalues, nested functions.\nHooks: arguments, returns, errors; Standard / Volt OTH.\nGC: table search, field inspection, snapshot diffs.\nRemotes: incoming events, selected outgoing calls.\nLogs: client output; level and text filters.\nRuntime: frame timing and memory.\n\nDisabled actions need a selection or an executor API. Check Capabilities below." })
    local reportSection = tab:NewSection("Session", "right")
    local report = Workbench.viewer(context, reportSection, { height = 190 })
    local function update()
        local ok, name, version = context.compat:Call("identifyexecutor")
        local managed, active = 0, 0
        for _, entry in context.hooks.entries do
            managed += 1
            if entry.active then active += 1 end
        end
        report:SetText(string.format("Place: %s\nGame: %s\nJob: %s\nRuntime: %s\nHooks at last refresh: %d/32; capture %s\nCalls retained at refresh: %d/500\n\nAPI checks are passive; calls can still fail.\nClient tools show client-visible state only.",
            tostring(game.PlaceId), tostring(game.GameId), tostring(game.JobId), if ok then tostring(name) .. " " .. tostring(version or "") else "unidentified",
            managed, if context.hooks.paused then "paused" elseif active > 0 then "enabled" else "stopped", #context.hooks.recorder.records))
    end
    reportSection:NewButton({ text = "Refresh session" }, update)
    local limits = tab:NewSection("Working limits", "right")
    Workbench.hint(limits, { height = 170, text = "Inventories: 30,000 visited values / 1,000 results.\nGC search: first 200 raw entries per table.\nInspectors: bounded depth, strings and entries; truncation is reported.\nHooks: 32 targets; capture: 100 calls/sec; history: 500.\nRemote watches: 32 incoming + 32 outgoing; shared capture: 100 events/sec; history: 500.\nLogs: 1,000 entries. Frame samples: latest 120.\n\nCancel takes effect between batches. The executor's native GC call itself cannot be interrupted.\nReports are diagnostic, lossy Lua-style text, not executable reconstruction." })
    local capabilities = tab:NewSection("Capabilities", "bottom")
    local list = capabilities:NewList({ height = 280, columns = {
        { key = "name", text = "API", width = 170 }, { key = "status", text = "Status", width = 90 }, { key = "feature", text = "Used for" },
    } })
    list:SetRecords(context.compat.records)
    update()
    return tab
end
return m
