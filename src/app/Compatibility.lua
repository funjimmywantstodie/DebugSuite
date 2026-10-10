local m = {}

local upvalue = "fail"
local function testFunction()
    local _val = upvalue
    return "fail"
end
--only check the most used globals that i actually need, no point in remaking sunc lol
local execGlobals = {
    "hookfunction",
    "restorefunction",
    "filtergc"
}

local debugGlobals = {
    "setconstant",
    "setupvalue",
    "getconstant",
    "getconstants",
    "getupvalue",
    "getupvalues",
}

function m.init()
    --===== REQUIRED GLOBALS =====
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
    
    --===== CONSTANT =====
    local const1 = debug.getconstant(testFunction, 1)
    if not const1 then
        return false, "Failed to get constant"
    end

    if const1 ~= debug.getconstants(testFunction)[1] then
        return false, "getconstants mismatch"
    end

    debug.setconstant(testFunction, 1, "yes")
    if debug.getconstant(testFunction, 1) ~= "yes" then
        return false, "Failed to set constant"
    end
    --reset for later tests
    debug.setconstant(testFunction, 1, "fail")

    --===== UPVALUE =====
    local uv = debug.getupvalue(testFunction,1)
    if not uv then
        return false, "Failed to get upvalue"
    end
    if uv ~= debug.getupvalues(testFunction)[1] then
        return false, "getupvalues mismatch"
    end

    debug.setupvalue(testFunction, 1, "yes")
    if debug.getupvalue(testFunction, 1) ~= "yes" then
        return false, "Failed to set upvalue"
    end
    --reset for later tests
    debug.setupvalue(testFunction, 1, "fail")

    --===== GC =====
    --run gc tests before function tests since the function ones add referances to gc that get in the way
    local found = filtergc("function", {IgnoreExecutor = false, Constants = {"fail"}, UpvalueCount = 1})
    if not next(found) then
        return false, "Failed to find function in filtergc"
    end

    if not table.find(found, testFunction) then
        return false, "filtergc did not return the correct function"
    end

    --FUNCTION-----
    hookfunction(testFunction, function()
        return "yes"
    end)
    if testFunction() ~= "yes" then
        return false, "Failed to hook function"
    end

    restorefunction(testFunction)
    if testFunction() ~= "fail" then
        return false, "Failed to restore function"
    end

    return true
end

return m