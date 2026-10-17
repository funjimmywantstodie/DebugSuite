--[[
every module passes fails as 
(false, reason: string)
and some do optional msgs at the end for debugging
]]

local Window = require("./ui/Window")
local Config = require("./Config")

local mainWindow = Window.new({})

local modules = {
    --tab modules
    require("./app/tabs/Functions"),
    require("./app/tabs/gc"),

    --window modules
    require("./app/windows/FunctionInspect"),

    --app modules
    require("./app/Compatibility")
} 

local loadedModules = 0
for _, mod in modules do
    local startTime = os.clock()
    local callOk, initOk, initMsg = pcall(function() return mod.init(mainWindow) end)
    if not callOk then
        warn(`[INIT] module {mod.Name} threw an error:\n{initOk}`)
        continue
    elseif not initOk then
        warn(`[INIT] {mod.Name} failed: {initMsg or "no reason provided"}`)
        continue
    end
    local deltaTime = os.clock() - startTime
    if Config.InitTimes then
        print(`[INIT]: {mod.Name} initialized in {deltaTime} seconds.`)
    end
    if Config.InitLogs and initMsg then
        print(`[INIT] {mod.Name} - {initMsg}`)
    end
    loadedModules += 1
end 

print(`[INIT]:{loadedModules}/{#modules} modules loaded successfully.`)
if loadedModules < #modules then
    warn(`[INIT] {#modules - loadedModules} module(s) failed to initialize; see warnings above.`)
end

mainWindow:Show()
