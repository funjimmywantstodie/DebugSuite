local Workbench = require("../Workbench")
local m = {}
function m.init(window, context)
    local tab = window:NewTab("Logs")
    local tools = tab:NewSection("Client output", "top")
    tools:NewTextViewer({ height = 48, text = "Latest 1,000 client messages. Pause discards new messages. Select a row for raw text; the floating console remains available." })
    local search = tools:NewTextbox({ text = "Literal text filter" })
    tab.searchInput = search
    local level = tools:NewDropdown({ text = "Level", options = { "All", "info", "warning", "error" }, value = "All" })
    local paused = tools:NewToggle({ text = "Pause log capture", value = false })
    local list = tab:NewSection("History", "full"):NewList({ height = 260, columns = {
        { key = "time", text = "Time", width = 100 }, { key = "level", text = "Level", width = 80 }, { key = "message", text = "Message" },
    } })
    local detail = Workbench.viewer(context, tab:NewSection("Raw message", "bottom"), { height = 180, text = "Select a message." })
    local records, sequence, elapsed, dirty = {}, 0, 0, false
    local function render()
        local visible = {}
        for _, record in records do
            if level:GetValue() == "All" or record.values.level == level:GetValue() then table.insert(visible, record) end
        end
        list:SetRecords(visible)
        dirty = false
    end
    local function push(message, messageType, stamp)
        if paused:GetValue() then return end
        sequence += 1
        local name = if messageType == Enum.MessageType.MessageError then "error"
            elseif messageType == Enum.MessageType.MessageWarning then "warning" else "info"
        local text = tostring(message)
        text = text:sub(1, 16384) .. (if #text > 16384 then "\n[message truncated at 16 KiB]" else "")
        table.insert(records, { id = sequence, text = text,
            values = { time = stamp or string.format("+%.3fs", os.clock() - context.started), level = name, message = text } })
        if #records > 1000 then table.remove(records, 1) end
        dirty = true
    end
    local logService = window.ctx.services.LogService
    local ok, history = pcall(function() return logService:GetLogHistory() end)
    if ok and type(history) == "table" then
        for i = math.max(1, #history - 999), #history do
            local entry = history[i]
            push(entry.message, entry.messageType, tostring(entry.timestamp or "history"))
        end
    end
    tab.scope:Connect(logService.MessageOut, function(message, messageType) push(message, messageType) end)
    tab.scope:Connect(window.ctx.services.RunService.RenderStepped, function(dt)
        elapsed += dt
        if dirty and elapsed >= .2 then elapsed = 0 render() end
    end)
    search:OnChanged(function(value) list:SetFilter(value) end)
    level:OnChanged(render)
    list:OnSelected(function(record) detail:SetText(if record then record.text else "Select a message.") end)
    local row = tools:NewRow()
    row:NewButton({ text = "Clear history", width = 100 }, function() table.clear(records) render() end)
    row:NewButton({ text = "Copy filtered logs", width = 130 }, Workbench.action(context, function()
        local lines = {}
        for _, record in list.filtered do
            table.insert(lines, record.values.time .. " [" .. record.values.level .. "] " .. record.text)
        end
        Workbench.copy(context, table.concat(lines, "\n"))
    end))
    render()
    return tab
end
return m
