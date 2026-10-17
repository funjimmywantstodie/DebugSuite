local m = {}
m.Name = "Compatibility"

--things for testing
local upvalue
local tbl = {}
local function luaClosure()
    return "fail", upvalue
end
local function proto()
    local function inner() return "yes" end
end
--only assign if exec supports newcclosure
local cClosure: () -> string
upvalue = "fail"

--only check the most used globals that i actually need, no point in remaking sunc lol
local execGlobals = {
    "hookfunction",
    "restorefunction",
    "filtergc",
    "hookmetamethod",
    "islclosure",
    "iscclosure",
    "newcclosure",
}

local debugGlobals = {
    "setconstant",
    "setupvalue",
    "getconstant",
    "getconstants",
    "getupvalue",
    "getupvalues",
    "getprotos",
}

function m.init()
    --REQUIRED GLOBALS
    if not getgenv then return false, "missing getgenv" end
    for namespace, name in {
        [getgenv()] = execGlobals,
        [debug] = debugGlobals,
    } do
        for _, f in name do
            if typeof(rawget(namespace, f)) ~= "function" then
                return false, `Missing global: {f}`
            end
        end
    end
    
    --CONSTANT
    local const1 = debug.getconstant(luaClosure, 1)
    if not const1 then
        return false, "Failed to get constant"
    end

    if const1 ~= debug.getconstants(luaClosure)[1] then
        return false, "getconstants mismatch"
    end

    debug.setconstant(luaClosure, 1, "yes")
    if debug.getconstant(luaClosure, 1) ~= "yes" then
        return false, "Failed to set constant"
    end
    --reset for later tests
    debug.setconstant(luaClosure, 1, "fail")

    --UPVALUE
    local uv = debug.getupvalue(luaClosure,1)
    if not uv then
        return false, "Failed to get upvalue"
    end
    if uv ~= debug.getupvalues(luaClosure)[1] then
        return false, "getupvalues mismatch"
    end

    debug.setupvalue(luaClosure, 1, "yes")
    if debug.getupvalue(luaClosure, 1) ~= "yes" then
        return false, "Failed to set upvalue"
    end
    --reset for later tests
    debug.setupvalue(luaClosure, 1, "fail")

    --GC
    --run gc tests before function tests since the function ones add referances to gc that get in the way
    local found = filtergc("function", {IgnoreExecutor = false, Constants = {"fail"}, UpvalueCount = 1})
    if not next(found) then
        return false, "Failed to find function in filtergc"
    end

    if not table.find(found, luaClosure) then
        return false, "filtergc did not return the correct function"
    end

    --CLOSURES
    cClosure = newcclosure(function ()
        return "fail", upvalue
    end)

    hookfunction(luaClosure, function()
        return "yes"
    end)
    if luaClosure() ~= "yes" then
        return false, "Failed to hook function"
    end

    restorefunction(luaClosure)
    if luaClosure() ~= "fail" then
        return false, "Failed to restore function"
    end

    setmetatable(tbl, {
        __index = function()
            return "fail"
        end
    })
    local mt = getmetatable(tbl)
    mt.__namecall = function()
        return "fail"
    end
    hookmetamethod(tbl, "__index", function()
        return "yes"
    end)
    local result = tbl.nonsense
    
    if result ~= "yes" then
        return false, "Failed to hook metamethod"
    end
    restorefunction(getmetatable(tbl).__index)

    if not islclosure(luaClosure) then
        return false, "Failed to identify lua closure"
    end

    if not iscclosure(cClosure) then
        return false, "Failed to identify c closure"
    end

    --protos
    local protos = debug.getprotos(proto)
    if not protos or #protos ~= 1 then
        return false, "Expected exactly 1 proto"
    end

    if debug.getconstant(protos[1], 1) ~= "yes" then
        return false, "Proto did not contain expected constant"
    end

    local tests = #execGlobals + #debugGlobals
    return true, `{tests}/{tests} compatibility tests passed`
end

return m