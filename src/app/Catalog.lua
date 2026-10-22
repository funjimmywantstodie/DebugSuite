local Values = require("./Values")
local m = { scanLimit = 30000, resultLimit = 1000, aliasEntryLimit = 30000, constantLimit = 300, filterLimit = 16 }
local identities, nextIdentity = setmetatable({}, { __mode = "k" }), 0
local function identity(value)
    if not identities[value] then nextIdentity += 1 identities[value] = nextIdentity end
    return identities[value]
end
function m.functionId(fn)
    assert(type(fn) == "function", "Expected a function")
    return identity(fn)
end
local function contains(text, query) return string.find(string.lower(text), query, 1, true) ~= nil end
local function searchText(value)
    return if type(value) == "string" then value:sub(1, 4096) else Values.preview(value, 4096)
end
function m.metadata(compat, fn)
    local ok, source, line, name, arguments, variadic = compat:Call("debug.info", fn, "slna")
    if ok then return { name = if name == "" then "(anonymous)" else name, source = source, line = line, arguments = arguments, variadic = variadic } end
    local fallback, info = compat:Call("debug.getinfo", fn)
    if fallback and type(info) == "table" then
        return { name = info.name or "(anonymous)", source = info.source or info.short_src or "?",
            line = info.linedefined or -1, arguments = info.numparams or info.nparams or "?", variadic = info.is_vararg }
    end
    return { name = "(metadata unavailable)", source = "?", line = -1, arguments = "?" }
end
function m.functions(compat, query, constantQuery, checkpoint)
    -- Keep the single text filter accepted by older callers.
    local filters = if type(constantQuery) == "table" then constantQuery else {}
    local rules = filters.constants or {}
    if type(constantQuery) == "string" and constantQuery ~= "" then
        rules = { { kind = "text", value = constantQuery } }
    end
    assert(#rules <= m.filterLimit, "At most 16 constant filters")
    for _, rule in rules do
        assert((rule.kind == "text" or rule.kind == "string") and type(rule.value) == "string"
            or rule.kind == "number" and type(rule.value) == "number" and rule.value == rule.value and math.abs(rule.value) < math.huge
            or rule.kind == "boolean" and type(rule.value) == "boolean", "Invalid constant filter")
    end
    if #rules > 0 then assert(compat:Has("debug.getconstants"), "Constant search requires debug.getconstants") end
    local function textMatches(text, needle, exact, ignoreCase)
        if ignoreCase or not filters.caseSensitive then text, needle = string.lower(text), string.lower(needle) end
        return if exact then text == needle else string.find(text, needle, 1, true) ~= nil
    end
    local function metadataMatches(info)
        return textMatches(tostring(info.source), filters.source or "")
            and (filters.arguments == nil or info.arguments == filters.arguments)
    end
    local records, seen, visited, errors, partial, cancelled = {}, {}, 0, 0, false, false
    local skipped, reads, firstError = 0, 0, nil
    local inventory = compat:Inventory("function")
    local exhausted = true
    local function constantsMatch(value)
        if #rules == 0 then return true end
        if compat:IsLuaClosure(value) == false then skipped += 1 return false end
        local ok, constants = compat:Call("debug.getconstants", value)
        if not ok or type(constants) ~= "table" then
            errors += 1
            firstError = firstError or (if ok then "debug.getconstants returned " .. type(constants) .. ", expected a table" else tostring(constants))
            return false
        end
        reads += 1
        local matched, found, count = {}, 0, 0
        local key, constant = next(constants)
        while key ~= nil do
            if not checkpoint() then cancelled = true return false end
            count += 1
            for i, rule in rules do
                if not matched[i] then
                    local matches = false
                    if rule.kind == "text" then
                        matches = textMatches(if type(constant) == "string" then constant else searchText(constant), rule.value, false, true)
                    elseif type(constant) == rule.kind then
                        if rule.kind == "string" then
                            matches = textMatches(constant, rule.value, filters.exactConstants, true)
                        else matches = constant == rule.value end
                    end
                    if matches then
                        matched[i], found = true, found + 1
                        if filters.constantMode == "Any" or found == #rules then return true end
                    end
                end
            end
            key, constant = next(constants, key)
            if count >= m.constantLimit then
                if key ~= nil then partial = true end
                break
            end
        end
        return false
    end
    local function add(value, info, alias)
        if seen[value] then return end
        seen[value] = true
        if metadataMatches(info) and constantsMatch(value) then
            if alias then info.debugName, info.name, info.alias = info.name, alias, alias end
            table.insert(records, { id = identity(value), value = value, values = info })
        end
    end
    for _, value in next, inventory do
        visited += 1
        if not checkpoint() then return {} end
        if type(value) == "function" then
            local info = m.metadata(compat, value)
            if textMatches(tostring(info.name) .. " " .. tostring(info.source), query) then
                add(value, info)
            end
        end
        if cancelled then return {} end
        if visited >= m.scanLimit or #records >= m.resultLimit then exhausted = false break end
    end
    -- Exported table keys are separate from closure debug names (which can be stripped).
    -- Only inspect raw fields: resolving a proxy's __index could execute game code.
    local aliasEntries, aliasStatus = 0, ""
    if query ~= "" and #records < m.resultLimit then
        local ok, tables = pcall(compat.Inventory, compat, "table")
        if ok then
            local tableValues = 0
            for _, value in next, tables do
                tableValues += 1
                if not checkpoint() then return {} end
                if type(value) == "table" then
                    local count, key, fn = 0, next(value)
                    while key ~= nil do
                        if not checkpoint() then return {} end
                        count += 1
                        aliasEntries += 1
                        if type(key) == "string" and type(fn) == "function" then
                            if #key > 4096 then partial = true end
                            if not seen[fn] and textMatches(key:sub(1, 4096), query) then add(fn, m.metadata(compat, fn), key) end
                            if cancelled then return {} end
                        end
                        key, fn = next(value, key)
                        if count >= 200 or aliasEntries >= m.aliasEntryLimit or #records >= m.resultLimit then
                            if key ~= nil then partial = true end
                            break
                        end
                    end
                end
                if tableValues >= m.scanLimit or aliasEntries >= m.aliasEntryLimit or #records >= m.resultLimit then partial = true break end
            end
            aliasStatus = string.format(" %d raw table fields checked for aliases.", aliasEntries)
        else
            partial = true
            aliasStatus = " Table alias inventory unavailable; name/source search only."
        end
    end
    local summary = string.format("%d functions / %d values checked. %s", #records, visited,
        if exhausted and not partial and errors == 0 then "Scan complete." else "PARTIAL.") .. aliasStatus
    if not exhausted or partial then summary ..= " Scan/result/constant/alias limits reached or alias inventory unavailable." end
    if #rules > 0 then
        summary ..= string.format("\n%d constant tables read; %d C closures skipped; %d constant reads failed.", reads, skipped, errors)
        if firstError then summary ..= "\nFirst constant read error: " .. firstError end
    end
    return records, summary
end
function m.tables(compat, query, checkpoint)
    query = string.lower(query)
    local records, visited, partial = {}, 0, false
    for _, value in next, compat:Inventory("table") do
        visited += 1
        if not checkpoint() then return {} end
        if type(value) == "table" then
            local count, matches, samples = 0, query == "", {}
            local key, val = next(value)
            while key ~= nil and count < 200 do
                count += 1
                local text = Values.preview(key, 120) .. " = " .. Values.preview(val, 120)
                if #samples < 3 then table.insert(samples, text) end
                if contains(searchText(key) .. " " .. searchText(val), query) then matches = true end
                if (type(key) == "string" and #key > 4096) or (type(val) == "string" and #val > 4096) then partial = true end
                key, val = next(value, key)
            end
            if key ~= nil then partial = true end
            if matches then
                local id = identity(value)
                table.insert(records, { id = id, value = value,
                    values = { name = "Table " .. id, entries = tostring(count) .. (if key ~= nil then "+" else ""), preview = table.concat(samples, "; ") } })
            end
        end
        if visited >= m.scanLimit or #records >= m.resultLimit then partial = true break end
    end
    return records, string.format("%d tables / %d values checked. %s", #records, visited,
        if partial then "PARTIAL: limits reached (200 entries per table)." else "Scan complete.")
end
function m.isRemote(value)
    return value.ClassName == "RemoteEvent" or value.ClassName == "UnreliableRemoteEvent" or value.ClassName == "RemoteFunction"
end
function m.isScript(value)
    return value.ClassName == "LocalScript" or value.ClassName == "ModuleScript" or value.ClassName == "Script"
end
function m.instances(root, query, mode, excluded, checkpoint)
    query = string.lower(query)
    local queue, head, records, partial, errors = { root }, 1, {}, false, 0
    while head <= #queue do
        if not checkpoint() then return {} end
        local value = queue[head]
        local ok, name, class = pcall(function() return value.Name, value.ClassName end)
        if ok then
            local path = Values.path(value)
            local kindMatches = mode == "All" or (mode == "Scripts" and m.isScript(value)) or (mode == "Remotes" and m.isRemote(value))
            if kindMatches and contains(name .. " " .. class .. " " .. path, query) then
                table.insert(records, { id = identity(value), value = value, values = { name = name, class = class, path = path } })
            end
            local childrenOk, children = pcall(function() return value:GetChildren() end)
            if childrenOk then
                for _, child in children do
                    if child ~= excluded then
                        if #queue >= m.scanLimit then partial = true break end
                        table.insert(queue, child)
                    end
                end
            else errors += 1 end
        else errors += 1 end
        if #records >= m.resultLimit then partial = true break end
        head += 1
    end
    return records, string.format("%d matches / %d instances checked. %d reads failed. %s", #records, math.min(head, #queue), errors,
        if partial then "PARTIAL: limits reached. Narrow the filter." else "Scan complete (client-visible instances).")
end
return m
