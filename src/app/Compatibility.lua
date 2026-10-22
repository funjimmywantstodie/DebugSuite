-- Passive discovery: never hook or mutate a probe function.
local m = {}
m.__index = m
local definitions = {
    { "getgenv", "Required by the UI library" },
    { "cloneref", "Required by the UI service cache" },
    { "getgc", "Function and table inventory" },
    { "filtergc", "Inventory fallback" },
    { "debug.info", "Function metadata" },
    { "debug.getinfo", "Executor metadata fallback" },
    { "debug.getconstants", "Constant inspection" },
    { "debug.getupvalues", "Upvalue inspection" },
    { "debug.getprotos", "Nested prototype inspection" },
    { "setclipboard", "Copy raw reports and paths" },
    { "identifyexecutor", "Runtime identification" },
    { "hookfunction", "Opt-in function tracing" },
    { "restorefunction", "Remove ordinary hooks" },
    { "newcclosure", "Ordinary hook callback wrapper" },
    { "iscclosure", "Skip C-closure constants / validate OTH targets" },
    { "islclosure", "Identify Luau closures for constant search" },
    { "isfunctionhooked", "Avoid replacing existing hooks" },
    { "getrawmetatable", "Outgoing remote namecall target" },
    { "getnamecallmethod", "Outgoing remote method filter" },
    { "setnamecallmethod", "Preserve outgoing remote method during capture" },
    { "oth.hook", "Volt C-closure tracing backend" },
    { "oth.unhook", "Remove Volt OTH hooks" },
    { "oth.is_hook_thread", "Volt hook-context diagnostics" },
    { "oth.get_original_thread", "Volt original-thread diagnostics" },
    { "oth.get_root_callback", "Volt root-callback diagnostics" },
}
function m.new()
    return setmetatable({ functions = {}, records = {} }, m):Refresh()
end
function m:Refresh()
    local env = {}
    if type(getgenv) == "function" then
        local ok, value = pcall(getgenv)
        if ok and type(value) == "table" then env = value end
    end
    local direct = { getgenv = getgenv, cloneref = cloneref, getgc = getgc, filtergc = filtergc,
        setclipboard = setclipboard, identifyexecutor = identifyexecutor,
        hookfunction = hookfunction, restorefunction = restorefunction, newcclosure = newcclosure,
        iscclosure = iscclosure, islclosure = islclosure, isfunctionhooked = isfunctionhooked,
        getrawmetatable = getrawmetatable, getnamecallmethod = getnamecallmethod, setnamecallmethod = setnamecallmethod }
    self.functions, self.records = {}, {}
    for _, definition in definitions do
        local name = definition[1]
        local library, member = name:match("^(%w+)%.(.+)$")
        local value
        if member then
            local namespace = rawget(env, library)
            if type(namespace) == "table" then value = rawget(namespace, member) end
            local fallback = if library == "debug" then debug elseif library == "oth" then oth else nil
            if type(value) ~= "function" and type(fallback) == "table" then value = rawget(fallback, member) end
        else
            value = rawget(env, name)
            if type(value) ~= "function" then value = direct[name] end
        end
        if type(value) == "function" then self.functions[name] = value end
        table.insert(self.records, { id = name, values = { name = name,
            status = if self.functions[name] then "available" else "missing", feature = definition[2] } })
    end
    return self
end
function m:Has(name) return self.functions[name] ~= nil end
function m:Call(name, ...)
    local fn = self.functions[name]
    if not fn then return false, "Unavailable API: " .. name end
    return pcall(fn, ...)
end
function m:IsLuaClosure(fn)
    local ok, value = self:Call("islclosure", fn)
    if ok and type(value) == "boolean" then return value end
    ok, value = self:Call("iscclosure", fn)
    if ok and type(value) == "boolean" then return not value end
    -- An unavailable classifier must not hide otherwise readable functions.
    return nil
end
function m:Inventory(kind)
    local ok, values
    if self:Has("getgc") then ok, values = self:Call("getgc", kind == "table")
    else ok, values = self:Call("filtergc", kind, {}, false) end
    if not ok then error(values, 0) end
    if type(values) ~= "table" then error("GC inventory returned a non-table", 0) end
    return values
end
return m
