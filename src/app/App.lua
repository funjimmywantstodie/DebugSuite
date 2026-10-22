local Window = require("../ui/Window")
local Compatibility = require("./Compatibility")
local Hooks = require("./Hooks")
local m = {}
local modules = {
    { "Overview", require("./tabs/Overview") },
    { "Explorer", require("./tabs/Explorer") },
    { "Functions", require("./tabs/Functions") },
    { "Hooks", require("./tabs/Hooks") },
    { "GC", require("./tabs/gc") },
    { "Remotes", require("./tabs/Remotes") },
    { "Logs", require("./tabs/Logs") },
    { "Runtime", require("./tabs/Runtime") },
}
function m.start()
    local window = Window.new({ size = UDim2.fromOffset(1120, 760), minSize = Vector2.new(760, 480) })
    window.shell.title.Text = "DebugSuite"
    local context = { window = window, compat = Compatibility.new(), started = os.clock(), tabs = {} }
    context.hooks = Hooks.new(context.compat, context.started)
    window.scope:Add(function() context.hooks:Destroy() end)
    window.app = context
    for _, entry in modules do
        local count = #window.tabs
        local ok, tab = pcall(entry[2].init, window, context)
        if ok then context.tabs[entry[1]] = tab
        else
            while #window.tabs > count do window.tabs[#window.tabs]:Destroy() end
            window:Notify({ text = entry[1] .. " failed to initialize: " .. tostring(tab), messageType = "error" })
        end
    end
    if #window.tabs > 0 then window:SelectTab(window.tabs[1]) end
    window:BindShortcut(Enum.KeyCode.F, function()
        local tab = window.currentTab
        if tab and tab.searchInput then tab.searchInput:Focus() end
    end, { ctrl = true })
    window:Log("DebugSuite ready. Select a tab and scan to begin.", "success")
    window:Show()
    return window
end
return m
