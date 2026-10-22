local Jobs = require("./Jobs")
local Values = require("./Values")
local Catalog = require("./Catalog")
local Instances = require("./Instances")
local m = {}
function m.action(context, callback)
    return function(...)
        local ok, err = pcall(callback, ...)
        if not ok then context.window:Notify({ text = tostring(err), messageType = "error" }) end
    end
end
function m.copy(context, text)
    local ok, err = context.compat:Call("setclipboard", text)
    if not ok then error(err, 0) end
    context.window:Log("Copied raw text to clipboard.", "success")
end
function m.viewer(context, section, opts)
    local viewer = section:NewTextViewer(opts or { height = 200, text = "Select an item." })
    local row = section:NewRow()
    local copy = row:NewButton({ text = "Copy report", width = 100 }, m.action(context, function() m.copy(context, viewer:GetText()) end))
    copy:SetEnabled(context.compat:Has("setclipboard"))
    viewer.copyButton = copy
    if opts and opts.syntax then
        local toggle = row:NewButton({ text = "Plain text", width = 100 }, function()
            viewer:SetSyntax(if viewer.highlighted then false else opts.syntax)
        end)
        m.bindSyntax(viewer, toggle)
    end
    return viewer
end
function m.bindSyntax(viewer, button)
    local function update() button:SetText(if viewer.highlighted then "Plain text" else "Syntax colors") end
    viewer:OnSyntaxChanged(update)
    update()
end
function m.hint(section, opts)
    local viewer = section:NewTextViewer(opts)
    -- Instruction text follows the panel width; raw reports retain their layout.
    viewer.textbox.TextWrapped = true
    viewer.textbox.AutomaticSize = Enum.AutomaticSize.Y
    viewer.textbox.Size = UDim2.new(1, -24, 0, 20)
    viewer.frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    viewer.frame.ScrollingDirection = Enum.ScrollingDirection.Y
    return viewer
end
function m.preview(value)
    local kind = Values.kind(value)
    if kind == "table" then
        if next(value) == nil then return "-- Empty table (no raw fields)." end
        return "-- Table selected. Expand it to browse its fields.\n-- Show raw value to see or copy the serialized table."
    end
    if kind == "function" then return "-- Function selected. Inspect selected to browse its closure." end
    return Values.serialize(value)
end
function m.scanner(context, name, description)
    local tab = context.window:NewTab(name)
    local tools = tab:NewSection("Search and controls", "top")
    local help = m.hint(tools, { height = 58, text = description })
    local status = m.hint(tools, { height = 48, text = "Ready. Enter a filter or leave it empty, then click Scan." })
    local row = tools:NewRow()
    local search = row:NewTextbox({ text = "Literal filter (Enter to scan)", fill = true })
    local cancel, scan
    local jobs = Jobs.new(tab, function(text)
        status:SetText(if text == "Scanning..." then "Scanning... Previous results stay visible until the scan finishes.\nCancel stops between batches." else text)
    end, function(busy)
        cancel:SetEnabled(busy)
        scan:SetEnabled(not busy)
    end)
    local controller = { tab = tab, tools = tools, row = row, search = search, jobs = jobs, status = status, help = help }
    controller.invalidate = function()
        jobs:Cancel()
        status:SetText("Search changed. Click Scan or press Enter to apply it.")
    end
    search:OnChanged(controller.invalidate)
    controller.scan = function() end
    scan = row:NewButton({ text = "Scan", width = 65 }, function() controller.scan() end)
    cancel = row:NewButton({ text = "Cancel", width = 65 }, function() jobs:Cancel() end)
    controller.scanButton, controller.cancelButton = scan, cancel
    cancel:SetEnabled(false)
    search:OnSubmitted(function() controller.scan() end)
    tab.searchInput = search
    return controller
end
function m.inspect(context, value, label)
    local inspector = context.inspector
    if not inspector or inspector.shell.destroyed then
        local shell = context.window:NewWindow({ title = "Value inspector", size = UDim2.fromOffset(700, 500) })
        local navigation = shell:NewRow()
        navigation.frame.Position = UDim2.fromOffset(8, 8)
        navigation.frame.Size = UDim2.new(1, -16, 0, 28)
        local valueActions = shell:NewRow()
        valueActions.frame.Position = UDim2.fromOffset(8, 42)
        valueActions.frame.Size = UDim2.new(1, -16, 0, 28)
        local split = shell:NewSplitPane({ size = UDim2.new(1, -16, 1, -86), vertical = true, ratio = .6 })
        split.frame.Position = UDim2.fromOffset(8, 78)
        inspector = { shell = shell, history = {}, tree = split.first:NewTree({ size = UDim2.fromScale(1, 1) }),
            viewer = split.second:NewTextViewer({ size = UDim2.fromScale(1, 1), syntax = "lua" }) }
        context.inspector = inspector
        local tree, viewer = inspector.tree, inspector.viewer
        local copy, drill, back, hooks
        local function preview(item)
            inspector.selected = item
            viewer:SetText(m.preview(item))
            local kind = Values.kind(item)
            drill:SetEnabled(kind == "function" or kind == "Instance")
            hooks:SetEnabled(kind == "function" and context.selectHook ~= nil)
        end
        local function load(item, title)
            inspector.source, inspector.label = item, title
            if Values.kind(item) == "Instance" then item = Instances.describe(item)
            elseif type(item) == "function" then
                local data = { metadata = Catalog.metadata(context.compat, item) }
                for _, field in { "constants", "upvalues", "protos" } do
                    local ok, result = context.compat:Call("debug.get" .. field, item)
                    data[field] = if ok then result else tostring(result)
                end
                item = data
            end
            shell.title.Text = title
            tree:SetNodes(Values.nodes(item, title))
            tree:Expand(1, true)
            preview(item)
            back:SetEnabled(#inspector.history > 0)
        end
        inspector.load = load
        tree:OnSelected(function(node) if node and node.inspectable then preview(node.value) end end)
        back = navigation:NewButton({ text = "Back" }, function()
            local previous = table.remove(inspector.history)
            if previous then load(previous.value, previous.label) end
        end)
        drill = navigation:NewButton({ text = "Inspect selected" }, m.action(context, function()
            local kind = Values.kind(inspector.selected)
            if kind ~= "function" and kind ~= "Instance" then return end
            if #inspector.history >= 16 then table.remove(inspector.history, 1) end
            table.insert(inspector.history, { value = inspector.source, label = inspector.label })
            load(inspector.selected, kind .. " inspector")
        end))
        hooks = navigation:NewButton({ text = "Send to Hooks" }, function()
            if type(inspector.selected) == "function" and context.selectHook then
                context.selectHook(inspector.selected, inspector.label .. " / selected function")
            end
        end)
        valueActions:NewButton({ text = "Show raw value" }, function()
            viewer:SetText(Values.serialize(inspector.selected))
        end)
        local raw = valueActions:NewButton({ text = "Plain text" }, function() viewer:SetSyntax(not viewer.highlighted and "lua" or false) end)
        m.bindSyntax(viewer, raw)
        copy = valueActions:NewButton({ text = "Copy value" }, m.action(context, function()
            if not context.compat:Has("setclipboard") then return end
            m.copy(context, Values.serialize(inspector.selected))
        end))
        copy:SetEnabled(context.compat:Has("setclipboard"))
        shell.scope:Add(function() if context.inspector == inspector then context.inspector = nil end end)
    end
    table.clear(inspector.history)
    inspector.load(value, label or "Value inspector")
    inspector.shell:Show()
    return inspector.shell
end
return m
