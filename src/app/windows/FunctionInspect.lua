local m = {}
m.Name = "FunctionInspect"

local types = require("../../Types")
local TableInspect = require("./TableInspect")
local ResizeSections = require("../../ui/util/ResizeSections")

--one inspector per main window, removed when its window gets destroyed
local windows = {}

local function getValues(func, name)
    local api = debug[name]
    if type(api) ~= "function" then
        return false, `debug.{name} is unavailable`
    end

    local succ, values = pcall(api, func)
    if not succ then
        if type(values) ~= "string" then values = TableInspect.Format(values) end
        return false, values
    end
    if type(values) ~= "table" then
        return false, `debug.{name} did not return a table`
    end

    return true, values
end

function m.init(mainWindow: types.Window)
    local existing = windows[mainWindow]
    if existing and not existing.window.destroyed then return existing end

    local funcWindow = mainWindow:NewWindow({
        title = "Function Inspect",
        size = UDim2.fromOffset(520, 420),
        position = UDim2.new(1, -16, 0.5, 0),
        visible = false,
        closeBehavior = "hide",
    })
    funcWindow.frame.AnchorPoint = Vector2.new(1, 0.5)
    local inspect = { window = funcWindow, history = {} }
    windows[mainWindow] = inspect

    local function populate(info)
        inspect.current = info
        inspect.selection = nil
        inspect.inspectButton:SetEnabled(false)
        inspect.backButton:SetEnabled(#inspect.history > 0)

        --metadata
        local succ, name, source = pcall(debug.info, info.target, "ns")
        if not succ or not name or name == "" then name = info.name or "<anonymous>" end
        if not succ or not source or source == "" then source = "<unknown>" end
        local kind = "Function"
        if info.isProto then kind = "Prototype" end
        inspect.heading:SetText(`{kind}: {name}\nSource: {source}`)

        --constants and upvalues use the same table view
        for api, tree in {
            getconstants = inspect.constants,
            getupvalues = inspect.upvalues,
        } do
            --inactive protos have constants but no live upvalues
            if info.isProto and api == "getupvalues" then
                tree:SetNodes({ { id = "inactive", text = "Inactive prototypes have no live upvalues" } })
                continue
            end

            local succ, values = getValues(info.target, api)
            if not succ then
                tree:SetNodes({ { id = "error", text = `Unavailable: {values}` } })
                continue
            end
            tree:SetNodes(TableInspect.MakeNodes(values))
        end

        --protos are opaque, dont treat a proxy like a normal table
        local succ, protos = getValues(info.target, "getprotos")
        if not succ then
            inspect.protos:SetNodes({ { id = "error", text = `Unavailable: {protos}` } })
            return
        end

        local nodes = {}
        for index, proto in next, protos do
            local succ, name = pcall(debug.info, proto, "n")
            if not succ or not name or name == "" then name = "<anonymous>" end
            table.insert(nodes, {
                id = index,
                text = `[{index}] {name}`,
                data = proto,
                isProto = true,
            })
        end
        inspect.protos:SetNodes(nodes)
    end

    function inspect:Open(func, name: string?)
        assert(type(func) == "function", "FunctionInspect.Open expects a function")
        assert(not funcWindow.destroyed, "inspector destroyed")
        table.clear(inspect.history)
        populate({ target = func, name = name, isProto = false })
        funcWindow:Show()
        return inspect
    end

    function inspect:Refresh()
        if not inspect.current then return end
        populate(inspect.current)
    end

    function inspect:Destroy()
        funcWindow:Destroy()
    end

    --window
    local header = funcWindow:NewSection("Selected function", "top")
    inspect.heading = header:NewLabel({ text = "No function selected", height = 40 })
    local actions = header:NewRow()
    inspect.backButton = actions:NewButton({ text = "Back", width = 60 }, function()
        local previous = table.remove(inspect.history)
        if not previous then return end
        populate(previous)
    end)
    actions:NewButton({ text = "Refresh", width = 70 }, function() inspect:Refresh() end)
    inspect.inspectButton = actions:NewButton({ text = "Inspect selected", width = 130 }, function()
        local node = inspect.selection
        if not node then return end
        local value = node.data
        if node.isProto or type(value) == "function" then
            table.insert(inspect.history, inspect.current)
            populate({ target = value, name = node.text, isProto = node.isProto == true })
            return
        end
        if type(value) == "table" then
            --pass the callback down so TableInspect never needs to require us
            TableInspect.Open(mainWindow, value, node.text, function(func, name)
                m.Open(mainWindow, func, name)
            end)
        end
    end)
    inspect.backButton:SetEnabled(false)
    inspect.inspectButton:SetEnabled(false)

    inspect.upvalues = funcWindow:NewSection("Upvalues", "left"):NewTree({
        height = 220, maxDepth = 8, emptyText = "No upvalues",
    })
    inspect.constants = funcWindow:NewSection("Constants", "right"):NewTree({
        height = 110, maxDepth = 8, emptyText = "No constants",
    })
    inspect.protos = funcWindow:NewSection("Protos", "right"):NewTree({
        height = 60, emptyText = "No protos",
    })
    ResizeSections.init(funcWindow, header, {
        { inspect.upvalues }, { inspect.constants, inspect.protos },
    })
    for _, tree in { inspect.protos, inspect.constants, inspect.upvalues } do
        tree:OnSelected(function(node)
            inspect.selection = node
            inspect.inspectButton:SetEnabled(false)
            if not node then return end
            local kind = type(node.data)
            if node.isProto or kind == "function" or kind == "table" then
                inspect.inspectButton:SetEnabled(true)
            end
        end)
    end

    funcWindow.scope:Add(function()
        if windows[mainWindow] == inspect then windows[mainWindow] = nil end
        inspect.current = nil
        inspect.selection = nil
        table.clear(inspect.history)
    end)
    return inspect
end

function m.Open(mainWindow: types.Window, func, name: string?)
    return m.init(mainWindow):Open(func, name)
end

return m
