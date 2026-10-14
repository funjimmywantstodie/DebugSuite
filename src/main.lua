--[[
every module passes fails as 
(false, reason: string)
and some do optional msgs at the end for debugging
]]

local Window = require("./ui/Window")
local Config = require("./Config")

local mainWindow = Window.new({})

local modules = {
    --app modules
    require("./app/tabs/Functions"),
    require("./app/tabs/gc"),

    --tab modules
    require("./app/Compatibility")
} 

local loadedModules = 0
for _, mod in modules do
    local startTime = os.clock()
    local callOk, initOk, initMsg = pcall(function() return mod.init(mainWindow) end)
    if not callOk then
        warn(`Error initializing module {mod.Name}: {initOk}`)
        continue
    elseif not initOk then
        warn(`Module initialization failed: {initMsg}`)
        continue
    end
    local deltaTime = os.clock() - startTime
    if Config.InitTimes then
        print(`[INIT]: {mod.Name} initialized in {deltaTime} seconds.`)
    end
    if Config.InitLogs and initMsg then
        if Config.InitLogs and initMsg then
            print(`[INIT] {mod.Name} - {initMsg}`)
        end
    end
    loadedModules += 1
end 

print(`[INIT]:{loadedModules}/{#modules} modules loaded successfully.`)

mainWindow:Show()
