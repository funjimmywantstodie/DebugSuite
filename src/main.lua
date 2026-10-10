local Window = require("./ui/Window")

local mainWindow = Window.new({})

local modules = {
    --app modules
    require("./app/tabs/Functions"),
    require("./app/tabs/gc"),

    --tab modules
    require("./app/Compatibility")
} 

for _, mod in modules do
    local callOk, initOk, initErr = pcall(function() return mod.init(mainWindow) end)
    if not callOk then
        warn(`Error initializing module: {initOk}`)
    elseif not initOk then
        warn(`Module initialization failed: {initErr}`)
    end
end 

print("init success")

mainWindow:Show()
