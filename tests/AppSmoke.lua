local App = require("../src/app/App")
local Compatibility = require("../src/app/Compatibility")
local Catalog = require("../src/app/Catalog")
local ConstantFilters = require("../src/app/ConstantFilters")
local Values = require("../src/app/Values")
local Recorder = require("../src/app/Recorder")
local Timing = require("../src/app/Timing")
local Jobs = require("../src/app/Jobs")
local Scope = require("../src/ui/util/Scope")
local Instances = require("../src/app/Instances")

local literals = ConstantFilters.parse(' RemoteEvent, Damage, 100, true, false, "42", "true", "a,b", "say ""hi""", "", "  raw  ", "C:\\temp" ')
assert(#literals == 12 and literals[1].value == "RemoteEvent" and literals[2].kind == "string")
assert(literals[3].kind == "number" and literals[3].value == 100)
assert(literals[4].kind == "boolean" and literals[4].value == true and literals[5].value == false)
assert(literals[6].kind == "string" and literals[6].value == "42" and literals[7].value == "true")
assert(literals[8].value == "a,b" and literals[9].value == 'say "hi"')
assert(literals[10].value == "" and literals[11].value == "  raw  " and literals[12].value == "C:\\temp", "Quoted values lost raw data")
assert(#ConstantFilters.parse("  , ,  ") == 0 and #ConstantFilters.parse("hello, , false,") == 2, "Empty separators became filters")
assert(not pcall(ConstantFilters.parse, '"unterminated'))
assert(not pcall(ConstantFilters.parse, '"hello" extra'))
assert(not pcall(ConstantFilters.parse, 'hello"quote'))
assert(not pcall(ConstantFilters.parse, "1e999"), "Infinite number accepted")
assert(#ConstantFilters.parse(string.rep("hello,", 16)) == 16)
assert(not pcall(ConstantFilters.parse, string.rep("hello,", 17)), "Filter limit lost")

local mutationCalls, gcCalls, metadataCalls, constantReads = 0, 0, 0, 0
local state = { needleKey = "initial", nested = { count = 1 }, enabled = false }
local cycle = {}
cycle.self = cycle
local hostile = setmetatable({ key = "raw" }, {
    __tostring = function() error("__tostring must not run") end,
    __index = function() error("__index must not run") end,
    __iter = function() error("__iter must not run") end,
})
local function fixtureA() error("Inspected functions must never execute") end
local function fixtureB() error("Inspected functions must never execute") end
local function fixtureDetected() error("Search must never run the detected function") end
local exports = setmetatable({ Detected = fixtureDetected }, {
    __index = function() error("Search must not resolve proxy fields") end,
    __iter = function() error("Search must only iterate raw fields") end,
    __tostring = function() error("Search must not format the owner table") end,
})
local duplicateExports = { Detected = fixtureDetected }
globals.getgc = function(includeTables)
    gcCalls += 1
    return if includeTables then { fixtureA, state, cycle, hostile, exports, duplicateExports } else { fixtureA, fixtureB, print }
end
globals.debug = {
    info = function(fn, options)
        metadataCalls += 1
        assert(options == "slna")
        if fn == fixtureDetected then return "Opaque.lua", 74, "", 3, false end
        return "Fixture.lua", 42, if fn == fixtureA then "fixtureA" else "fixtureB", 2, false
    end,
    getconstants = function(fn)
        constantReads += 1
        if fn == print then error("C closure") end
        return { [1] = "hello<font>", [3] = false }
    end,
    getupvalues = function() return { state } end,
    getprotos = function() return { fixtureB } end,
}
globals.setclipboard = function(text) globals.copied = text end
globals.identifyexecutor = function() return "Mock", "1" end
globals.hookfunction = function() mutationCalls += 1 end
globals.restorefunction = function() mutationCalls += 1 end
local compat = Compatibility.new()
assert(gcCalls == 0 and metadataCalls == 0 and mutationCalls == 0, "Capability discovery must be passive")
assert(compat:Has("getgc") and not compat:Has("debug.setupvalue"))
assert(not compat:Call("missing"))
local functions, summary = Catalog.functions(compat, "fixturea", "hello", function() return true end)
assert(#functions == 1 and functions[1].value == fixtureA and summary:find("complete", 1, true))
local reordered = Catalog.functions(compat, "", "", function() return true end)
assert(functions[1].id == reordered[1].id, "Function identity changed across scans")
local detected, detectedSummary = Catalog.functions(compat, "dEtEcTeD", "", function() return true end)
assert(#detected == 1 and detected[1].value == fixtureDetected, "Missing anonymous closure exported as Detected")
assert(detected[1].values.name == "Detected" and detected[1].values.debugName == "(anonymous)")
assert(detected[1].values.alias == "Detected" and detectedSummary:find("raw table fields", 1, true))
local withConstant = Catalog.functions(compat, "detected", "hello", function() return true end)
assert(#withConstant == 1 and withConstant[1].id == detected[1].id, "Alias identity changed across scans")
assert(#Catalog.functions(compat, "detected", "absent", function() return true end) == 0, "Aliases bypassed the constant filter")
local originalConstants = compat.functions["debug.getconstants"]
compat.functions["debug.getconstants"] = function(fn)
    if fn == fixtureA then return { [1] = "hello<font>", [3] = false, [4] = 42, [5] = "Integrity-3212zx" } end
    if fn == fixtureB then return { "HELLO<font>", true, "42" } end
    return originalConstants(fn)
end
local function filtered(query, filters) return Catalog.functions(compat, query, filters, function() return true end) end
local allConstants = filtered("", { constants = { { kind = "string", value = "hello" }, { kind = "boolean", value = false } } })
assert(#allConstants == 1 and allConstants[1].value == fixtureA, "All constants failed on sparse/false values")
local anyConstants, failedReads = filtered("", { constantMode = "Any", constants = { { kind = "number", value = 42 }, { kind = "boolean", value = true } } })
assert(#anyConstants == 2 and failedReads:find("PARTIAL", 1, true), "Any constants or failed-read reporting failed")
assert(failedReads:find("First constant read error:", 1, true) and failedReads:find("C closure", 1, true), "Constant read errors must explain a partial scan")
compat.functions.islclosure = function(fn) return fn ~= print end
local readsBeforeClassification = constantReads
local classified, classifiedSummary = filtered("", { constants = ConstantFilters.parse("integrity") })
assert(#classified == 1 and classified[1].value == fixtureA)
assert(constantReads == readsBeforeClassification and classifiedSummary:find("1 C closures skipped; 0 constant reads failed", 1, true)
    and classifiedSummary:find("Scan complete", 1, true), "C closures must be skipped without a failed constant read")
compat.functions.islclosure = function() error("Classifier unavailable") end
compat.functions.iscclosure = function(fn) return fn == print end
local _, cFallbackSummary = filtered("", { constants = ConstantFilters.parse("integrity") })
assert(cFallbackSummary:find("1 C closures skipped; 0 constant reads failed", 1, true), "C classifier fallback failed")
compat.functions.iscclosure = nil
local unknownClosure, unknownSummary = filtered("", { constants = ConstantFilters.parse("integrity") })
assert(#unknownClosure == 1 and unknownSummary:find("1 constant reads failed", 1, true), "A failed classifier must not hide Luau functions")
compat.functions.islclosure = nil
local stringNumber = filtered("", { exactConstants = true, constants = { { kind = "string", value = "42" } } })
assert(#stringNumber == 1 and stringNumber[1].value == fixtureB, "String constant matched a number")
assert(#filtered("fixtureA", { exactConstants = true, constants = { { kind = "string", value = "hello" } } }) == 0, "Exact matched a substring")
assert(#filtered("fixtureA", { exactConstants = true, constants = { { kind = "string", value = "HELLO<font>" } } }) == 1)
assert(#filtered("fixtureA", { caseSensitive = true, constants = { { kind = "string", value = "HELLO" } } }) == 1,
    "Name/source case sensitivity must not affect constants")
local partialConstant = filtered("", { caseSensitive = true, constants = ConstantFilters.parse("iNtEgRiTy") })
assert(#partialConstant == 1 and partialConstant[1].value == fixtureA, "Constants-only scan must match a substring regardless of case")
local savedInfo = compat.functions["debug.info"]
compat.functions["debug.info"] = nil
local noMetadata = filtered("", { constants = ConstantFilters.parse("integrity") })
assert(#noMetadata == 1 and noMetadata[1].value == fixtureA, "Constants-only search must not require function metadata")
compat.functions["debug.info"] = savedInfo
assert(#filtered("fixturea", { caseSensitive = true }) == 0 and #filtered("fixtureA", { caseSensitive = true }) == 1)
local aliasFiltered = filtered("detected", { source = "opaque", arguments = 3, constants = { { kind = "boolean", value = false } } })
assert(#aliasFiltered == 1 and aliasFiltered[1].value == fixtureDetected, "Metadata/typed filters lost table aliases")
assert(#filtered("detected", { source = "fixture" }) == 0 and #filtered("detected", { arguments = 2 }) == 0, "Aliases bypassed metadata filters")
local oldConstantLimit = Catalog.constantLimit
Catalog.constantLimit = 1
local boundedConstants, constantLimitSummary = filtered("fixtureA", { constants = { { kind = "boolean", value = false } } })
assert(#boundedConstants == 0 and constantLimitSummary:find("PARTIAL", 1, true), "Constant read limit must report partial results")
Catalog.constantLimit = oldConstantLimit
local constantSteps = 0
assert(#Catalog.functions(compat, "fixtureA", { constants = { { kind = "number", value = 42 } } }, function()
    constantSteps += 1
    return constantSteps < 3
end) == 0, "Cancellation inside constants returned results")
local longConstant = string.rep("x", 4097) .. "end"
compat.functions["debug.getconstants"] = function() return { longConstant } end
assert(#filtered("fixtureA", { exactConstants = true, constants = { { kind = "string", value = longConstant } } }) == 1, "Exact constants must use raw string values")
local longMatch, longSummary = filtered("fixtureA", { constants = ConstantFilters.parse("END") })
assert(#longMatch == 1 and longSummary:find("Scan complete", 1, true), "Constant substring search must include text past 4096 characters")
assert(#Catalog.functions(compat, "fixtureA", "end", function() return true end) == 1, "Legacy text filter truncated a constant")
compat.functions["debug.getconstants"] = function() return false end
local malformedConstants, malformedSummary = filtered("fixtureA", { constants = ConstantFilters.parse("hello") })
assert(#malformedConstants == 0 and malformedSummary:find("returned boolean, expected a table", 1, true), "Malformed API results need a specific diagnostic")
compat.functions["debug.getconstants"] = nil
assert(not pcall(filtered, "", { constants = { { kind = "boolean", value = false } } }), "Missing constant API silently removed the filter")
compat.functions["debug.getconstants"] = originalConstants
local checkpoints = 0
local cancelledAlias = Catalog.functions(compat, "detected", "", function()
    checkpoints += 1
    return checkpoints < 6
end)
assert(#cancelledAlias == 0, "Cancelled alias scan returned results")
local oldAliasLimit = Catalog.aliasEntryLimit
Catalog.aliasEntryLimit = 1
local _, aliasLimitedSummary = Catalog.functions(compat, "detected", "", function() return true end)
assert(aliasLimitedSummary:find("PARTIAL", 1, true), "Alias field budget must report partial results")
Catalog.aliasEntryLimit = oldAliasLimit
local tables = Catalog.tables(compat, "needlekey", function() return true end)
assert(#tables == 1 and tables[1].value == state)
local oldResultLimit = Catalog.resultLimit
Catalog.resultLimit = 1
local limited, limitedSummary = Catalog.functions(compat, "", "", function() return true end)
assert(#limited == 1 and limitedSummary:find("PARTIAL", 1, true))
Catalog.resultLimit = oldResultLimit
globals.getgc = nil
globals.filtergc = function(kind, options, one)
    assert(next(options) == nil and one == false)
    return if kind == "table" then { state, exports, duplicateExports } else { fixtureA }
end
local fallback = Compatibility.new()
assert(fallback:Inventory("table")[1] == state and fallback:Inventory("function")[1] == fixtureA)
assert(Catalog.functions(fallback, "detected", "", function() return true end)[1].value == fixtureDetected, "filtergc alias fallback failed")
fallback.functions.filtergc = function(kind)
    if kind == "table" then error("Table inventory unavailable") end
    return { fixtureA }
end
local metadataOnly, metadataOnlySummary = Catalog.functions(fallback, "fixturea", "", function() return true end)
assert(#metadataOnly == 1 and metadataOnlySummary:find("Table alias inventory unavailable", 1, true), "Table failure broke metadata search")
globals.getgc = function(includeTables)
    gcCalls += 1
    return if includeTables then { fixtureA, state, cycle, hostile, exports, duplicateExports } else { fixtureA, fixtureB, print }
end

assert(Values.serialize(false) == "false")
assert(Values.serialize("<font>") == '"<font>"')
assert(Values.serialize(Vector2.new(1, 2)) == "Vector2.new(1, 2)")
assert(Values.serialize(UDim2.new(.5, 10, 1, 20)) == "UDim2.new(0.5, 10, 1, 20)")
local positionBefore = Values.snapshot({ position = Vector2.new(1, 2) })
assert(Values.diff(positionBefore, Values.snapshot({ position = Vector2.new(3, 4) })):find("CHANGED", 1, true))
assert(Values.serialize({ a = 1, b = 2 }) == Values.serialize({ b = 2, a = 1 }))
local closureBefore = Values.snapshot({ callback = fixtureA })
assert(Values.diff(closureBefore, Values.snapshot({ callback = fixtureB })):find("CHANGED", 1, true))
local cycleText, cyclePartial = Values.serialize(cycle)
assert(cyclePartial and cycleText:find("cycle", 1, true))
assert(Values.serialize(hostile):find("raw", 1, true))
assert(Values.preview(hostile) == "table" and Values.preview({}) == "table (empty)")
assert(Values.preview(fixtureA) == "function", "Function preview should not resemble a markup tag")
local longText, partial = Values.serialize(string.rep("x", 500), { string = 8 })
assert(partial and #longText < 100)
local nodes = Values.nodes(hostile, "hostile")
assert(#nodes[1].loadChildren() == 1)
local before = Values.snapshot(state)
state.needleKey, state.nested.count, state.added, state.enabled = false, 2, "new", nil
local difference = Values.diff(before, Values.snapshot(state))
assert(difference:find("CHANGED", 1, true) and difference:find("false", 1, true))
assert(difference:find("REMOVED", 1, true) and difference:find("ADDED", 1, true))
assert(Values.diff(Values.snapshot(state), Values.snapshot(state)) == "No changes in captured values.")
local bounded = Values.snapshot({ a = 1, b = 2 }, 1)
assert(bounded.truncated and Values.diff(bounded, bounded):find("PARTIAL", 1, true))

local recorder = Recorder.new(2, 3)
local args = { content = "frozen" }
recorder:Push("remote", table.pack(nil, false, args, nil), 0)
args.content = "changed"
assert(recorder.records[1].values.args == 4)
assert(recorder.records[1].text:find("frozen", 1, true) and not recorder.records[1].text:find("changed", 1, true))
recorder:Push("remote", table.pack(2), .1)
recorder:Push("remote", table.pack(3), .2)
assert(#recorder.records == 2 and recorder.records[1].id == 2)
assert(recorder:Push("remote", table.pack(4), .3) == nil and recorder.dropped == 1)
assert(recorder:Push("remote", table.pack(5), 1) ~= nil)
recorder:Clear()
assert(#recorder.records == 0 and recorder.dropped == 0)
local timing = Timing.new()
timing:Push(0)
timing:Push(0/0)
timing:Push(math.huge)
assert(#timing.samples == 0)
for _ = 1, 125 do timing:Push(.02) end
assert(#timing.samples == 120 and timing:Report():find("50.0 FPS", 1, true))
timing:Push(.1)
assert(timing:Report():find("100.00 ms", 1, true))

local owner = { scope = Scope.new(), destroyed = false }
local committed = 0
local jobs = Jobs.new(owner, function() end)
local function slow(checkpoint)
    for _ = 1, 300 do if not checkpoint() then return "cancelled" end end
    return "old"
end
jobs:Run(slow, function() committed += 1 end)
runTasks(1)
jobs:Cancel()
runTasks()
assert(committed == 0)
jobs:Run(slow, function() error("Superseded scan committed") end)
runTasks(1)
jobs:Run(function() return "new" end, function(value) assert(value == "new") committed += 1 end)
runTasks()
assert(committed == 1)
jobs:Run(function() error("Cancelled scan did work") end, function() error("Cancelled scan committed") end)
jobs:Cancel()
runTasks()
jobs:Run(slow, function() error("Destroyed owner committed") end)
runTasks(1)
owner.destroyed = true
owner.scope:Destroy()
runTasks()

local function section(tab, name)
    for _, item in tab.sections do if item.frame.Name == name then return item end end
    error("Missing section: " .. name)
end
local function guiButton(root, text)
    for _, child in root:GetChildren() do
        if child:IsA("TextButton") and child.Text == text then return child end
        local found = guiButton(child, text)
        if found then return found end
    end
end
local function press(tab, text)
    local button = guiButton(tab.container, text)
    assert(button, "Missing button: " .. text)
    button.MouseButton1Click:Fire()
end
local part = Instance.new("Part")
part.Name = "TestPart"
part.Parent = services.Workspace
part:SetAttribute("Counter", 1)
local scriptInstance = Instance.new("ModuleScript")
scriptInstance.Name, scriptInstance.Source = "TestScript", 'return "<font>raw source</font>"'
scriptInstance.Parent = services.ReplicatedStorage
local remote = Instance.new("RemoteEvent")
remote.Name, remote.Parent = "IncomingEvent", services.ReplicatedStorage
local queryRemote = Instance.new("RemoteFunction")
queryRemote.Name, queryRemote.Parent = "Query", services.ReplicatedStorage
local inventory = Catalog.instances(game, "testpart", "All", nil, function() return true end)
assert(#inventory == 1 and inventory[1].value == part)
assert(Values.path(part) == 'game:FindFirstChild("Workspace"):FindFirstChild("TestPart")')
local unrelated = Instance.new("Folder")
assert(Values.path(unrelated):find("unparented", 1, true))
unrelated:Destroy()
local leafNodes = Instances.nodes(part)
assert(leafNodes[1].loadChildren == nil, "Leaf instances must not advertise children")
local onlyUI = Instance.new("Folder")
local excludedUI = Instance.new("ScreenGui")
excludedUI.Parent = onlyUI
assert(Instances.nodes(onlyUI, excludedUI)[1].loadChildren == nil, "Excluded UI created a phantom branch")
onlyUI:Destroy()

local priorGC = gcCalls
local window = App.start()
assert(#window.tabs == 8, "App initialization failed: " .. #window.tabs .. " tabs")
assert(gcCalls == priorGC, "Startup must not automatically scan GC")
assert(window.currentTab == window.app.tabs.Overview and window.shell.title.Text == "DebugSuite")
press(window.app.tabs.Overview, "Find functions")
assert(window.currentTab == window.app.tabs.Functions)
press(window.app.tabs.Overview, "Trace / manage hooks")
assert(window.currentTab == window.app.tabs.Hooks)
local functionsTab = window.app.tabs.Functions
assert(not guiButton(functionsTab.container, "Inspect constants").Active)
assert(not guiButton(functionsTab.container, "Cancel").Active)
local scanHelp = functionsTab.controller.help:GetText()
functionsTab.controller.search:SetValue("fixturea")
functionsTab.controller.scan()
assert(guiButton(functionsTab.container, "Cancel").Active)
assert(not guiButton(functionsTab.container, "Scan").Active)
assert(functionsTab.controller.help:GetText() == scanHelp, "Scan progress replaced workflow instructions")
runTasks()
assert(not guiButton(functionsTab.container, "Cancel").Active)
assert(guiButton(functionsTab.container, "Scan").Active)
local functionList = functionsTab.controller.results
assert(#functionList.records == 1)
local functionSearch = functionsTab.controller
functionSearch.constants:SetValue("hello, false")
functionSearch.source:SetValue("Fixture")
functionSearch.arguments:SetValue("2")
functionSearch.scan()
runTasks()
assert(#functionList.records == 1 and functionList.records[1].value == fixtureA, "UI did not combine constant and metadata filters")
functionSearch.constants:SetValue("hello, true")
functionSearch.constants.button.FocusLost:Fire(true)
runTasks()
assert(#functionList.records == 0, "Comma-separated booleans or Enter submission did not filter")
functionSearch.constantMode:SetValue("Any")
functionSearch.scan()
runTasks()
assert(#functionList.records == 1, "UI match-any mode failed")
functionSearch.constants:SetValue('"missing quote')
functionSearch.scan()
runTasks()
assert(functionSearch.status:GetText():find("closing double quote", 1, true) and #functionList.records == 1, "Malformed constants discarded previous results")
functionSearch.constants:SetValue("hello, false")
functionSearch.arguments:SetValue("2.5")
functionSearch.scan()
runTasks()
assert(functionSearch.status:GetText():find("Parameter count", 1, true) and #functionList.records == 1, "Invalid metadata filter discarded previous results")
local uiConstants = window.app.compat.functions["debug.getconstants"]
window.app.compat.functions["debug.getconstants"] = function(fn)
    return if fn == fixtureA then { "Integrity-3212zx" } else uiConstants(fn)
end
functionSearch.search:SetValue("unrelated name")
functionSearch.source:SetValue("unrelated source")
functionSearch.caseSensitive:SetValue(true)
functionSearch.constants:SetValue("iNtEgRiTy")
press(functionsTab, "Scan constants only")
assert(not functionSearch.scanConstantsButton.button.Active, "Constants-only scan must disable its button while running")
runTasks()
assert(#functionList.records == 1 and functionList.records[1].value == fixtureA, "Constants-only UI used name/source/parameter filters or exact/case-sensitive matching")
assert(functionSearch.status:GetText():find("filters ignored", 1, true) and functionSearch.scanConstantsButton.button.Active)
assert(functionSearch.search:GetValue() == "unrelated name" and functionSearch.arguments:GetValue() == "2.5", "Constants-only scan erased other filter drafts")
press(functionsTab, "Clear constants")
assert(functionSearch.constants:GetValue() == "")
press(functionsTab, "Scan constants only")
runTasks()
assert(functionSearch.status:GetText():find("Enter at least one constant", 1, true) and #functionList.records == 1, "Empty constants-only scan returned an unfiltered inventory")
window.app.compat.functions["debug.getconstants"] = uiConstants
functionSearch.search:SetValue("fixturea")
functionSearch.caseSensitive:SetValue(false)
functionSearch.arguments:SetValue("")
functionSearch.source:SetValue("")
functionSearch.scan()
runTasks()
local readsBeforeSelect = constantReads
functionList:Select(functionList.records[1].id)
assert(constantReads == readsBeforeSelect, "Selecting a function must not fetch every category")
assert(guiButton(functionsTab.container, "Inspect constants").Active)
press(functionsTab, "Send to Hooks")
assert(window.currentTab == window.app.tabs.Hooks, "Selected function was not sent to Hooks")
assert(not guiButton(window.app.tabs.Hooks.container, "Trace selected function").Active, "Missing backend APIs must disable tracing")
assert(window.app.tabs.Hooks.controller.targetStatus:GetText():find("newcclosure", 1, true), "Disabled tracing must name the missing API")
local hooksTab = window.app.tabs.Hooks
assert(hooksTab.controller.target == fixtureA, "Handoff lost the exact function reference")
assert(hooksTab.controller.targetReport:GetText():find('["functionId"] = ' .. functionList.records[1].id, 1, true), "Function ID changed during handoff")
assert(hooksTab.controller.scan == nil and not guiButton(hooksTab.container, "Scan"), "Hooks still performs discovery")
local gcBeforeBack = gcCalls
press(hooksTab, "Find / change function")
assert(window.currentTab == functionsTab and functionSearch.search:GetValue() == "fixturea" and functionList.selectedRecord.value == fixtureA,
    "Returning to discovery lost its filters or selection")
assert(gcCalls == gcBeforeBack, "Navigation rescanned discovery")
functionSearch.search:SetValue("detected")
functionSearch.scan()
runTasks()
assert(#functionList.records == 1 and functionList.records[1].value == fixtureDetected, "Discovery lost exported anonymous closure")
functionList:Select(functionList.records[1].id)
local gcBeforeHandoff = gcCalls
press(functionsTab, "Send to Hooks")
assert(hooksTab.controller.targetStatus:GetText():find("Detected / Opaque.lua", 1, true), "Hooks did not select the alias target")
assert(hooksTab.controller.target == fixtureDetected and gcCalls == gcBeforeHandoff, "Handoff searched again or substituted a function")
assert(mutationCalls == 0, "Searching or selecting an alias installed a hook")
press(functionsTab, "Clear")
assert(hooksTab.controller.target == fixtureDetected, "Clearing discovery released the transferred target")
functionSearch.search:SetValue("fixturea")
functionSearch.scan()
runTasks()
functionList:Select(functionList.records[1].id)
local initialWindows = #window.childWindowOwner.components
press(functionsTab, "Inspect constants")
assert(#window.childWindowOwner.components == initialWindows + 1)
local inspector = window.app.inspector
local constantsTree = inspector.tree
local stringNode
for _, entry in constantsTree.loaded[1] do if type(entry.value) == "string" then stringNode = entry end end
constantsTree:Select(stringNode.id)
assert(inspector.viewer:GetText() == '"hello<font>"')
assert(not guiButton(inspector.shell.frame, "Send to Hooks").Active, "Non-functions cannot be sent to Hooks")
local previewText = inspector.viewer:GetText()
constantsTree.rowViews[1].state.MouseButton1Click:Fire()
assert(inspector.viewer:GetText() == previewText, "Expansion duplicated the selected value into the preview")
guiButton(inspector.shell.frame, "Copy value").MouseButton1Click:Fire()
assert(globals.copied == previewText, "Copied markup instead of raw data")
press(functionsTab, "Inspect upvalues")
assert(window.app.inspector == inspector and #window.childWindowOwner.components == initialWindows + 1, "Inspection opened a duplicate window")
press(functionsTab, "Inspect nested functions")
local nestedNode = inspector.tree.loaded[1][1]
inspector.tree:Select(nestedNode.id)
assert(guiButton(inspector.shell.frame, "Inspect selected").Active)
assert(guiButton(inspector.shell.frame, "Send to Hooks").Active)
guiButton(inspector.shell.frame, "Send to Hooks").MouseButton1Click:Fire()
assert(window.currentTab == hooksTab and hooksTab.controller.target == fixtureB, "Inspector handoff lost the selected nested function")
guiButton(inspector.shell.frame, "Inspect selected").MouseButton1Click:Fire()
assert(inspector.source == fixtureB and #inspector.history == 1)
guiButton(inspector.shell.frame, "Back").MouseButton1Click:Fire()
assert(inspector.label:find("Nested functions", 1, true) and #inspector.history == 0)
local functionViewer = section(functionsTab, "Function details").components[1]
assert(functionViewer:GetText():find("fixtureA", 1, true), "Category inspection overwrote function details")
press(functionsTab, "Copy report")
assert(globals.copied == functionViewer:GetText(), "Copied markup instead of raw data")

local gcTab = window.app.tabs.GC
gcTab.controller.search:SetValue("needlekey")
gcTab.controller.scan()
runTasks()
local gcList = section(gcTab, "Tables").components[1]
assert(#gcList.records == 1)
assert(gcList.rowViews[gcList.records[1].id].cells[3].RichText, "GC previews must enable their syntax formatting")
gcList:Select(gcList.records[1].id)
local gcOutput = section(gcTab, "Raw value / snapshot diff").components[1]
assert(not gcOutput:GetText():find("needleKey", 1, true), "Selecting a table automatically dumped it twice")
assert(not guiButton(gcTab.container, "Compare with baseline").Active)
press(gcTab, "Show raw value")
assert(gcOutput:GetText():find("needleKey", 1, true))
local valueBeforeBaseline = gcOutput:GetText()
press(gcTab, "Capture baseline")
assert(guiButton(gcTab.container, "Compare with baseline").Active)
assert(gcOutput:GetText() == valueBeforeBaseline, "Capturing a baseline overwrote the value report")
state.needleKey = "updated"
press(gcTab, "Compare with baseline")
assert(section(gcTab, "Raw value / snapshot diff").components[1]:GetText():find("CHANGED", 1, true))
assert(guiButton(gcTab.container, "Syntax colors"))
press(gcTab, "Syntax colors")
assert(gcOutput.highlighted and guiButton(gcTab.container, "Plain text"))
press(gcTab, "Clear")
assert(#gcList.records == 0)

local explorerTab = window.app.tabs.Explorer
explorerTab.controller.search:SetValue("testpart")
explorerTab.controller.scan()
runTasks()
local instanceList = section(explorerTab, "Search results").components[1]
assert(#instanceList.records == 1)
instanceList:Select(instanceList.records[1].id)
window:SelectTab(explorerTab)
local liveProperties = section(explorerTab, "Properties and attributes").components[5]
liveProperties:SetValue(true)
part:SetAttribute("LiveCheck", "refreshed")
run.RenderStepped:Fire(.25)
local properties = section(explorerTab, "Properties and attributes").components[1]
assert(properties.nodes[1].value.attributes.LiveCheck == "refreshed")
properties:Expand("attributes", true)
properties:Select("attribute:Counter")
part:SetAttribute("Counter", 4)
run.RenderStepped:Fire(.25)
assert(properties.expanded.attributes and properties.selectedId == "attribute:Counter", "Live refresh collapsed or deselected the current branch")
assert(section(explorerTab, "Properties and attributes").components[2]:GetText() == "4")
properties:Select("attributes")
press(explorerTab, "Show raw value")
part:SetAttribute("RawRefresh", "still raw")
run.RenderStepped:Fire(.25)
assert(section(explorerTab, "Properties and attributes").components[2]:GetText():find("still raw", 1, true), "Live refresh replaced the requested raw view with a hint")
liveProperties:SetValue(false)
press(explorerTab, "Capture property baseline")
part:SetAttribute("Counter", 2)
press(explorerTab, "Compare properties")
assert(section(explorerTab, "Properties and attributes").components[2]:GetText():find("CHANGED", 1, true))
local propertyOutput = section(explorerTab, "Properties and attributes").components[2]
local comparisonText = propertyOutput:GetText()
liveProperties:SetValue(true)
part:SetAttribute("Counter", 3)
run.RenderStepped:Fire(.25)
assert(propertyOutput:GetText() == comparisonText, "Live refresh overwrote the comparison")
explorerTab.controller.search:SetValue("testscript")
explorerTab.controller.scan()
runTasks()
instanceList:Select(instanceList.records[1].id)
press(explorerTab, "Read script source")
assert(section(explorerTab, "Properties and attributes").components[2]:GetText() == scriptInstance.Source)
scriptInstance:SetAttribute("SourceCheck", true)
run.RenderStepped:Fire(.25)
assert(propertyOutput:GetText() == scriptInstance.Source, "Live refresh overwrote script source")
liveProperties:SetValue(false)

local remotesTab = window.app.tabs.Remotes
remotesTab.controller.scan()
runTasks()
local remoteList = section(remotesTab, "Remote inventory").components[1]
assert(#remoteList.records == 2)
for _, record in remoteList.records do if record.value == remote then remoteList:Select(record.id) end end
local beforeWatch = connections
press(remotesTab, "Watch selected incoming event")
assert(connections == beforeWatch + 3)
press(remotesTab, "Watch selected incoming event")
assert(connections == beforeWatch + 3, "Duplicate watch leaked connections")
remote.OnClientEvent:Fire(nil, false, { message = "event" }, nil)
run.RenderStepped:Fire(.25)
local eventList = section(remotesTab, "Captured traffic").components[1]
assert(#eventList.records == 1 and eventList.records[1].values.args == 4)
for _, record in remoteList.records do if record.value == queryRemote then remoteList:Select(record.id) end end
assert(not guiButton(remotesTab.container, "Watch selected incoming event").Active)
press(remotesTab, "Watch selected incoming event")
assert(queryRemote.OnClientInvoke == nil and #queryRemote.OnClientEvent.listeners == 0, "RemoteFunction callback was intercepted")
local beforeRemoteDestroy = connections
remote:Destroy()
assert(connections == beforeRemoteDestroy - 3, "Destroyed remote watch leaked")
local detachedRemote = Instance.new("RemoteEvent")
detachedRemote.Name, detachedRemote.Parent = "DetachedEvent", services.ReplicatedStorage
remotesTab.controller.scan()
runTasks()
for _, record in remoteList.records do if record.value == detachedRemote then remoteList:Select(record.id) end end
press(remotesTab, "Watch selected incoming event")
local beforeDetach = connections
local detachedFolder = Instance.new("Folder")
detachedRemote.Parent = detachedFolder
assert(connections == beforeDetach - 3, "Detached remote watch leaked")
press(remotesTab, "Watch selected incoming event")
assert(not guiButton(remotesTab.container, "Watch selected incoming event").Active)
run.RenderStepped:Fire(.25)
assert(section(remotesTab, "Observation").components[1]:GetText():find("0/32", 1, true))
detachedFolder:Destroy()
local logsTab = window.app.tabs.Logs
services.LogService.MessageOut:Fire("<font>raw log</font>", Enum.MessageType.MessageWarning)
run.RenderStepped:Fire(.25)
local logList = section(logsTab, "History").components[1]
assert(logList.records[#logList.records].text == "<font>raw log</font>")
logsTab.searchInput:SetValue("raw log")
assert(#logList.filtered == 1)
logList:Select(logList.filtered[1].id)
press(logsTab, "Copy filtered logs")
assert(globals.copied:find("<font>raw log</font>", 1, true))
local logPause = section(logsTab, "Client output").components[4]
logPause:SetValue(true)
local logCount = #logList.records
services.LogService.MessageOut:Fire("discard while paused", Enum.MessageType.MessageOutput)
run.RenderStepped:Fire(.25)
assert(#logList.records == logCount)
logPause:SetValue(false)
local runtimeTab = window.app.tabs.Runtime
local frameList = section(runtimeTab, "Recent frames").components[1]
assert(#frameList.records == 0, "Timing sampled while disabled")
local sampling = section(runtimeTab, "Frame diagnostics").components[2]
sampling:SetValue(true)
for _ = 1, 125 do run.RenderStepped:Fire(.02) end
sampling:SetValue(false)
assert(#frameList.records == 120)
assert(section(runtimeTab, "Summary").components[1]:GetText():find("123.0 MiB", 1, true))
press(runtimeTab, "Reset samples")
assert(#frameList.records == 0)

-- A queued scan and owned floating inspector must both be cleaned on rerun.
functionsTab.controller.scan()
local nextWindow = App.start()
assert(window.destroyed and #window.childWindowOwner.components == 0)
runTasks()
assert(#nextWindow.tabs == 8)
globals.getgc, globals.filtergc, globals.setclipboard, globals.debug = nil, nil, nil, nil
local missingWindow = App.start()
assert(nextWindow.destroyed and #missingWindow.tabs == 8)
missingWindow.app.tabs.GC.controller.scan()
runTasks()
assert(missingWindow.app.tabs.GC.controller.status:GetText():find("Unavailable API", 1, true))
missingWindow:Destroy()
nextWindow:Destroy()
assert(connections == 0, "Leaked connections: " .. connections)
assert(#services.CoreGui:GetChildren() == 0)
assert(mutationCalls == 0)
part:Destroy()
scriptInstance:Destroy()
queryRemote:Destroy()
print("app smoke passed")
