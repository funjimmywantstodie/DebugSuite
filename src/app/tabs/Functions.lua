local m = {}
m.Name = "Functions"

local types = require("../../Types")
local InspectWindow = require("../windows/FunctionInspect")

local function getName(func): string?
    local succ, name = pcall(debug.info, func, "n")
    if not succ or name == "" then return nil end
    return name
end

local function parse(str: string): {string}
    local result = {}

    for value in string.gmatch(str, "[^,]+") do
        local trimmed = string.match(value, "^%s*(.-)%s*$")
        if trimmed and trimmed ~= "" then
            table.insert(result, trimmed)
        end
    end

    return result
end

local function matchesConstants(func, wanted): boolean
    if not wanted or #wanted == 0 then return true end

    local succ, constants = pcall(debug.getconstants, func)
    if not succ then return false end

    for _, expected in wanted do
        local matched = false
        for _, actual in constants do
            if actual == expected then
                matched = true
                break
            end
        end
        if not matched then return false end
    end

    return true
end

local function search(funcName, consts, exactMatch, resultsList)
    local opts = {}
    if funcName and funcName ~= "" then
        opts.Name = funcName
    end
    if consts and #consts > 0 then
        opts.Constants = consts
    end

    local found = {}

    if exactMatch then
        found = filtergc("function", opts)
    else
        local query = string.lower(funcName or "")

        for _, func in getgc(false) do
            if type(func) ~= "function" then continue end
            if isexecutorclosure(func) then continue end

            local name = getName(func) or ""
            if query ~= "" and not string.find(string.lower(name), query, 1, true) then
                continue
            end
            if not matchesConstants(func, consts) then continue end
            table.insert(found, func)
        end
    end

    print("Search filters:", funcName, consts)
    print("Functions found:", #found)
    local rows = {}

    for i, func in found do
        table.insert(rows, {
            id = i,
            values = { name = getName(func) or "<anonymous>" },
            data = func,
        })
    end

    resultsList:SetRecords(rows)
end

function m.init(window: types.Window)
    local tab = window:NewTab("Functions")
    local consts
    local funcName
    local exactMatch = false

    --search
    local searchSection = tab:NewSection("Search Functions", "full")
    searchSection:NewLabel({
        text = "function name(partial, case insensitive)",
    })
    local nameInput = searchSection:NewTextbox({ text = "function name" }, function(val)
        funcName = val
    end)
    searchSection:NewLabel({
        text = "Constants (comma separated)",
    })
    local constantsInput = searchSection:NewTextbox({ text = "enter constants(ex: x,y,z)" }, function(val)
        consts = parse(val)
    end)

    --results
    local resultSection = tab:NewSection("Results", "full")
    local resultsList = resultSection:NewList({
        showHeader = false,
        columns = {
            { key = "name", text = "Function name" },
        },
    })
    resultsList:OnSelected(function(record)
        if not record then return end
        InspectWindow.Open(window, record.data, record.values.name)
    end)

    searchSection:NewToggle({ text = "Exact name match", value = false }, function(val)
        exactMatch = val
    end)

    searchSection:NewButton({ text = "Search" }, function()
        search(funcName, consts, exactMatch, resultsList)
    end)
    nameInput:OnSubmitted(function()
        search(funcName, consts, exactMatch, resultsList)
    end)
    constantsInput:OnSubmitted(function()
        search(funcName, consts, exactMatch, resultsList)
    end)

    window:SelectTab(tab)
    return tab
end

return m
