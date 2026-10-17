local m = {}
m.Name = "TableInspect"

local types = require("../../Types")
local ResizeSections = require("../../ui/util/ResizeSections")

local windows = {}

function m.Format(val): string
    local kind = type(val)
    if kind == "string" then
        local text = string.format("%q", string.sub(val, 1, 120))
        if #val > 120 then text ..= "..." end
        return text
    end
    if kind == "table" then return "{...}" end
    if kind == "function" then
        local succ, name = pcall(debug.info, val, "n")
        if not succ or not name or name == "" then name = "<anonymous>" end
        return `function {name}`
    end

    local succ, text = pcall(tostring, val)
    if not succ then return `<{kind}>` end
    return text
end

--shared by the function inspector too, data stays raw even if the text is cut off
function m.MakeNodes(val: {}): {types.TreeNode}
    local nextId = 0
    local function build(tbl, depth, ancestors)
        local entries = {}
        --use next so an inspected table cant run its own iterator
        local key, item = next(tbl)
        while key ~= nil and #entries < 500 do
            table.insert(entries, { key = key, value = item })
            key, item = next(tbl, key)
        end
        local truncated = key ~= nil
        table.sort(entries, function(a, b)
            local aType, bType = type(a.key), type(b.key)
            if aType == bType and (aType == "number" or aType == "string") then
                return a.key < b.key
            end
            return aType .. m.Format(a.key) < bType .. m.Format(b.key)
        end)

        local nodes = {}
        for _, entry in entries do
            local value = entry.value
            nextId += 1
            local node = {
                id = nextId,
                text = `[{m.Format(entry.key)}] = {m.Format(value)}`,
                data = value,
                key = entry.key,
            }
            if type(value) == "table" then
                if ancestors[value] then
                    node.text ..= " [cycle]"
                elseif depth >= 8 then
                    node.text ..= " [depth limit]"
                else
                    --only track this branch, the same table can appear somewhere else
                    local path = table.clone(ancestors)
                    path[value] = true
                    node.loadChildren = function() return build(value, depth + 1, path) end
                end
            end
            table.insert(nodes, node)
        end
        if truncated then
            nextId += 1
            table.insert(nodes, { id = nextId, text = "... more entries omitted (limit 500)" })
        end
        return nodes
    end
    return build(val, 0, { [val] = true })
end

function m.init(mainWindow: types.Window)
    local existing = windows[mainWindow]
    if existing and not existing.window.destroyed then return existing end

    local tblWindow = mainWindow:NewWindow({
        title = "Table Inspect",
        size = UDim2.fromOffset(750, 500),
        position = UDim2.fromScale(0.5, 0.5),
        visible = false,
        closeBehavior = "hide",
    })
    local inspect = { window = tblWindow, history = {} }
    windows[mainWindow] = inspect

    local function populate()
        inspect.selection = nil
        inspect.inspectButton:SetEnabled(false)
        inspect.backButton:SetEnabled(#inspect.history > 0)
        inspect.heading:SetText(inspect.title)
        inspect.details:SetText("")
        inspect.tree:SetNodes(m.MakeNodes(inspect.value))
    end

    function inspect:Open(value: {}, title: string?, onFunction)
        assert(type(value) == "table", "TableInspect.Open expects a table")
        assert(onFunction == nil or type(onFunction) == "function", "onFunction must be a function")
        assert(not tblWindow.destroyed, "inspector destroyed")
        inspect.value = value
        inspect.title = title or "Table"
        --the caller decides where functions open, no require back to FunctionInspect
        inspect.onFunction = onFunction
        table.clear(inspect.history)
        populate()
        tblWindow:Show()
        return inspect
    end

    function inspect:Refresh()
        if not inspect.value then return end
        populate()
    end

    function inspect:Destroy()
        tblWindow:Destroy()
    end

    --window
    local header = tblWindow:NewSection("Table", "top")
    inspect.heading = header:NewLabel({ text = "No table selected", height = 40 })
    local actions = header:NewRow()
    inspect.backButton = actions:NewButton({ text = "Back", width = 60 }, function()
        local previous = table.remove(inspect.history)
        if not previous then return end
        inspect.value = previous.value
        inspect.title = previous.title
        populate()
    end)
    actions:NewButton({ text = "Refresh", width = 70 }, function() inspect:Refresh() end)
    inspect.inspectButton = actions:NewButton({ text = "Inspect selected", width = 130 }, function()
        local node = inspect.selection
        if not node then return end
        if type(node.data) == "table" then
            table.insert(inspect.history, { value = inspect.value, title = inspect.title })
            inspect.value = node.data
            inspect.title = node.text
            populate()
            return
        end
        if type(node.data) == "function" and inspect.onFunction then
            inspect.onFunction(node.data, node.text)
        end
    end)
    inspect.backButton:SetEnabled(false)
    inspect.inspectButton:SetEnabled(false)
    inspect.tree = tblWindow:NewSection("Entries", "left"):NewTree({
        height = 320, maxDepth = 8, emptyText = "Empty table",
    })
    inspect.details = tblWindow:NewSection("Selected value", "right"):NewTextViewer({ height = 320 })
    ResizeSections.init(tblWindow, header, { { inspect.tree }, { inspect.details } })
    inspect.tree:OnSelected(function(node)
        inspect.selection = node
        inspect.inspectButton:SetEnabled(false)
        if not node then
            inspect.details:SetText("")
            return
        end

        local value = node.data
        if type(value) == "string" then
            inspect.details:SetText(value)
        else
            inspect.details:SetText(m.Format(value))
        end
        if type(value) == "table" or (type(value) == "function" and inspect.onFunction) then
            inspect.inspectButton:SetEnabled(true)
        end
    end)

    tblWindow.scope:Add(function()
        if windows[mainWindow] == inspect then windows[mainWindow] = nil end
        inspect.value = nil
        inspect.selection = nil
        inspect.onFunction = nil
        table.clear(inspect.history)
    end)
    return inspect
end

function m.Open(mainWindow: types.Window, value: {}, title: string?, onFunction)
    return m.init(mainWindow):Open(value, title, onFunction)
end

return m
