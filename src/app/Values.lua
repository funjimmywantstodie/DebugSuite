-- Bounded raw traversal; never invoke table __pairs, __index or __tostring.
local m = {}
function m.kind(value) return typeof(value) end
local function typedText(value, kind)
    local args
    if kind == "Vector3" then args = { value.X, value.Y, value.Z }
    elseif kind == "Vector2" then args = { value.X, value.Y }
    elseif kind == "Color3" then args = { value.R, value.G, value.B }
    elseif kind == "UDim" then args = { value.Scale, value.Offset }
    elseif kind == "UDim2" then args = { value.X.Scale, value.X.Offset, value.Y.Scale, value.Y.Offset }
    elseif kind == "CFrame" then args = { value:GetComponents() }
    elseif kind == "NumberRange" then args = { value.Min, value.Max }
    elseif kind == "EnumItem" then return tostring(value)
    elseif kind == "BrickColor" then return "BrickColor.new(" .. value.Number .. ")" end
    if not args then return nil end
    local text = {}
    for _, number in args do table.insert(text, tostring(number)) end
    return kind .. ".new(" .. table.concat(text, ", ") .. ")"
end
function m.path(instance)
    if instance == game then return "game" end
    local pieces, current = {}, instance
    for _ = 1, 128 do
        if current == game then
            local expression = "game"
            for i = #pieces, 1, -1 do expression ..= ":FindFirstChild(" .. string.format("%q", pieces[i]) .. ")" end
            return expression
        end
        if not current then return "nil --[[unparented instance]]" end
        local ok, name, parent = pcall(function() return current.Name, current.Parent end)
        if not ok then return "nil --[[unreadable instance]]" end
        table.insert(pieces, name)
        current = parent
    end
    return "nil --[[instance path too deep]]"
end
function m.preview(value, limit)
    limit = limit or 140
    local kind = m.kind(value)
    if kind == "table" then return if next(value) == nil then "table (empty)" else "table" end
    if kind == "function" then return "function" end
    if kind == "thread" then return "thread" end
    if kind == "Instance" then
        local ok, text = pcall(function() return value.Name .. " [" .. value.ClassName .. "]" end)
        return if ok then text:sub(1, limit) else "Instance (unreadable)"
    end
    if kind == "string" then return string.format("%q", value:sub(1, limit)) .. (if #value > limit then "..." else "") end
    if kind == "nil" or kind == "number" or kind == "boolean" then return tostring(value) end
    if type(value) == "userdata" and kind == "userdata" then return "userdata" end
    local ok, text = pcall(tostring, value)
    return if ok then text:sub(1, limit) else kind .. " (unreadable)"
end
function m.serialize(value, opts)
    opts = opts or {}
    local seen, count, truncated = {}, 0, false
    local depthLimit, entryLimit, stringLimit = opts.depth or 5, opts.entries or 300, opts.string or 4096
    local function visit(item, depth)
        local kind = m.kind(item)
        if kind == "Instance" then return m.path(item) end
        if kind == "string" then
            if #item > stringLimit then truncated = true end
            return string.format("%q", item:sub(1, stringLimit)) .. (if #item > stringLimit then " --[[string truncated]]" else "")
        end
        if kind == "number" then
            if item ~= item then return "(0/0)" end
            if item == math.huge then return "math.huge" end
            if item == -math.huge then return "-math.huge" end
            return tostring(item)
        end
        if kind == "nil" or kind == "boolean" then return tostring(item) end
        if kind ~= "table" then
            local typed = typedText(item, kind)
            if typed then return typed end
            truncated = true
            return "nil --[[" .. kind .. "; not serialized]]"
        end
        if seen[item] then truncated = true return "nil --[[cycle/shared reference]]" end
        if depth >= depthLimit or count >= entryLimit then truncated = true return "{} --[[truncated]]" end
        seen[item] = true
        local entries, lines = {}, { "{" }
        local key, val = next(item)
        while key ~= nil do
            if #entries >= entryLimit - count then truncated = true break end
            table.insert(entries, { key = key, value = val, order = #entries + 1 })
            key, val = next(item, key)
        end
        table.sort(entries, function(a, b)
            local ak, bk = m.kind(a.key), m.kind(b.key)
            if ak ~= bk then return ak < bk end
            if ak == "string" or ak == "number" then return a.key < b.key end
            if ak == "boolean" then return a.key == false and b.key == true end
            return a.order < b.order
        end)
        for _, entry in entries do
            if count >= entryLimit then truncated = true table.insert(lines, "  -- entry limit reached") break end
            count += 1
            table.insert(lines, string.rep("  ", depth + 1) .. "[" .. visit(entry.key, depth + 1) .. "] = " .. visit(entry.value, depth + 1) .. ",")
        end
        if key ~= nil then table.insert(lines, "  -- entry limit reached") end
        table.insert(lines, string.rep("  ", depth) .. "}")
        return table.concat(lines, "\n")
    end
    local text = visit(value, 0)
    local bytes = opts.bytes or 65536
    if #text > bytes then text = text:sub(1, bytes) .. "\n-- output truncated" truncated = true end
    return text, truncated
end
function m.nodes(value, label, opts)
    opts = opts or {}
    local serial, budget = 0, opts.entries or 500
    local function node(item, text, ancestors, depth)
        serial += 1
        local entry = { id = serial, text = text .. " = " .. m.preview(item), value = item, inspectable = true }
        if m.kind(item) == "table" and next(item) ~= nil and not ancestors[item] and depth < (opts.depth or 8) then
            local path = table.clone(ancestors)
            path[item] = true
            entry.loadChildren = function()
                local children = {}
                local key, val = next(item)
                while key ~= nil and budget > 0 do
                    budget -= 1
                    table.insert(children, node(val, "[" .. m.preview(key, 60) .. "]", path, depth + 1))
                    key, val = next(item, key)
                end
                if key ~= nil then
                    serial += 1
                    table.insert(children, { id = serial, text = "... inspection limit reached" })
                end
                return children
            end
        end
        return entry
    end
    return { node(value, label or "value", {}, 0) }
end
function m.snapshot(value, limit)
    assert(type(value) == "table", "Select a table first")
    local result = { entries = {}, truncated = false }
    local key, val = next(value)
    while key ~= nil do
        if #result.entries >= (limit or 200) then result.truncated = true break end
        local text, truncated = m.serialize(val, { depth = 3, entries = 60, string = 512, bytes = 4096 })
        result.truncated = result.truncated or truncated
        local kind = m.kind(val)
        local identity = if kind == "function" or kind == "thread" or kind == "Instance" or kind == "userdata" then val else nil
        table.insert(result.entries, { key = key, label = m.preview(key), text = text, identity = identity })
        key, val = next(value, key)
    end
    return result
end
function m.diff(before, after)
    local old, new, lines = {}, {}, {}
    for _, entry in before.entries do old[entry.key] = entry end
    for _, entry in after.entries do new[entry.key] = entry end
    for _, entry in before.entries do
        local current = new[entry.key]
        if not current then table.insert(lines, "REMOVED " .. entry.label .. " = " .. entry.text)
        elseif entry.text ~= current.text or not rawequal(entry.identity, current.identity) then
            table.insert(lines, "CHANGED " .. entry.label .. "\n  before: " .. entry.text .. "\n  after: " .. current.text)
        end
    end
    for _, entry in after.entries do
        if not old[entry.key] then table.insert(lines, "ADDED " .. entry.label .. " = " .. entry.text) end
    end
    if #lines == 0 then table.insert(lines, "No changes in captured values.") end
    if before.truncated or after.truncated then table.insert(lines, "PARTIAL SNAPSHOT: limits or unsupported values; changes outside captured values may be omitted.") end
    return table.concat(lines, "\n")
end
return m
