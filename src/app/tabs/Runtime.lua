local Workbench = require("../Workbench")
local Timing = require("../Timing")
local m = {}
function m.init(window, context)
    local tab = window:NewTab("Runtime")
    local controls = tab:NewSection("Frame diagnostics", "top")
    controls:NewTextViewer({ height = 64, text = "Opt-in client frame sampling. Latest 120 frames; P95 and >=50 ms stalls help identify hitches. Memory is sampled once per second. Values include the debugger's overhead." })
    local timing = Timing.new()
    local enabled = controls:NewToggle({ text = "Sample frame timing", value = false })
    local report = Workbench.viewer(context, tab:NewSection("Summary", "left"), { height = 210, text = timing:Report() })
    local list = tab:NewSection("Recent frames", "right"):NewList({ height = 310, columns = {
        { key = "frame", text = "Frame", width = 60 }, { key = "ms", text = "ms" }, { key = "fps", text = "FPS" }, { key = "stall", text = "Stall", width = 50 },
    } })
    local elapsed = 0
    local function update()
        local ok, memory = pcall(function() return game:GetService("Stats"):GetTotalMemoryUsageMb() end)
        local luaOk, luaMemory = pcall(gcinfo)
        report:SetText(timing:Report() .. "\nTotal client memory: " .. (if ok then string.format("%.1f MiB", memory) else "unavailable")
            .. "\nLuau heap: " .. (if luaOk then string.format("%.1f KiB", luaMemory) else "unavailable"))
        list:SetRecords(timing.samples)
    end
    tab.scope:Connect(window.ctx.services.RunService.RenderStepped, function(dt)
        if not enabled:GetValue() then return end
        timing:Push(dt)
        elapsed += dt
        if elapsed >= 1 then elapsed = 0 update() end
    end)
    enabled:OnChanged(function(value) if not value then update() end end)
    controls:NewButton({ text = "Reset samples" }, function() timing:Clear() update() end)
    controls:NewButton({ text = "Refresh summary" }, Workbench.action(context, update))
    return tab
end
return m
