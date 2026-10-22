local Compatibility = require("../src/app/Compatibility")
local Hooks = require("../src/app/Hooks")
local Outgoing = require("../src/app/Outgoing")
local Recorder = require("../src/app/Recorder")
local ReturnValues = require("../src/app/ReturnValues")
local App = require("../src/app/App")

local installed, wrapped, cTargets = {}, {}, {}
local installs, restores, contextReads = 0, 0, 0
local failRestore, failInstall = false, false
local function fixture(...)
    return nil, false, select("#", ...), nil
end
local function cFixture(value) return value + 1 end
cTargets[cFixture] = true
globals.hookfunction = function(target, replacement)
    installs += 1
    if failInstall then error("install rejected") end
    assert(wrapped[replacement], "Standard callbacks require newcclosure")
    installed[target] = replacement
    return target
end
globals.newcclosure = function(callback) wrapped[callback] = true return callback end
globals.restorefunction = function(target)
    restores += 1
    if failRestore then error("restore rejected") end
    installed[target] = nil
end
globals.isfunctionhooked = function(target) return installed[target] ~= nil end
globals.iscclosure = function(target) return cTargets[target] == true end
globals.oth = {
    hook = function(target, callback)
        installs += 1
        assert(cTargets[target] and not wrapped[callback], "OTH needs a C target and a Luau callback")
        installed[target] = callback
        return target
    end,
    unhook = function(target)
        restores += 1
        if failRestore then return false end
        installed[target] = nil
        return true
    end,
    is_hook_thread = function() contextReads += 1 return true end,
    get_original_thread = function() contextReads += 1 return coroutine.running() end,
    get_root_callback = function() contextReads += 1 return cFixture end,
}
local function invoke(target, ...) return (installed[target] or target)(...) end
local compat = Compatibility.new()
assert(installs == 0 and restores == 0 and contextReads == 0, "Discovery must never call hook/OTH APIs")
for _, name in { "oth.hook", "oth.unhook", "oth.is_hook_thread", "oth.get_original_thread", "oth.get_root_callback" } do
    assert(compat:Has(name), "Missing OTH capability: " .. name)
end
local manager = Hooks.new(compat, os.clock())
assert(manager:Available("Standard") and manager:Available("Volt OTH"))
local unhookAPI = globals.oth.unhook
globals.oth.unhook = nil
compat:Refresh()
assert(compat:Has("oth.hook") and not manager:Available("Volt OTH"), "Missing OTH removal API must disable the backend")
globals.oth.unhook = unhookAPI
compat:Refresh()
assert(not manager:CanTrace(fixture, "Volt OTH"), "OTH must reject Luau targets")
assert(not manager:CanTrace(coroutine.running, "Standard"), "Guard primitive must not be hooked")
local entry = manager:Add(fixture, "fixture", "Standard")
assert(not manager:CanTrace(fixture, "Standard"), "Duplicate hooks must be rejected")
local result = table.pack(invoke(fixture, nil, false, "value", nil))
assert(result.n == 4 and result[1] == nil and result[2] == false and result[3] == 4 and result[4] == nil)
local record = manager.recorder.records[1]
assert(record.values.args == 4 and record.values.outcome == "returned" and record.text:find("returns", 1, true))
assert(record.text:find("fixture", 1, true) and record.text:find("ms", 1, true), "Copied call report needs its target and duration")
manager.paused = true
assert(select(3, invoke(fixture, 1, 2)) == 2 and #manager.recorder.records == 1)
manager.paused = false
local errorObject = { code = "failure" }
local function throws() error(errorObject, 0) end
manager:Add(throws, "throws", "Standard")
local ok, err = pcall(invoke, throws)
assert(not ok and err == errorObject, "Original error value changed")
assert(manager.recorder.records[2].values.outcome == "error")
local function mutate(value) value.message = "after" return value end
manager:Add(mutate, "mutate", "Standard")
local arguments = { message = "before" }
assert(invoke(mutate, arguments) == arguments)
local mutation = manager.recorder.records[3]
assert(mutation.text:find('"before"', 1, true) and mutation.text:find('"after"', 1, true), "Arguments must freeze before execution")
local function yielding()
    coroutine.yield("waiting")
    return nil, "resumed", nil
end
manager:Add(yielding, "yielding", "Standard")
local co = coroutine.create(function()
    local values = table.pack(invoke(yielding))
    assert(values.n == 3 and values[2] == "resumed")
end)
assert(select(2, coroutine.resume(co)) == "waiting")
assert(manager.recorder.records[#manager.recorder.records].values.outcome == "running", "Yielded call must report that it is running")
assert(coroutine.resume(co) and coroutine.status(co) == "dead", "Tracing prevented yielding")
local originalPush = manager.recorder.Push
manager.recorder.Push = function() error("capture failure") end
assert(select(3, invoke(fixture, 1)) == 1 and manager.failures == 1, "Observer error changed original execution")
manager.recorder.Push = originalPush
manager.recorder.rate = 0
assert(select(3, invoke(fixture, 1, nil)) == 2 and manager.recorder.dropped > 0)
manager.recorder.rate = 100
failRestore = true
assert(not manager:Stop(fixture) and not entry.active and manager.entries[fixture] == entry)
local count = #manager.recorder.records
invoke(fixture, "stopped")
assert(#manager.recorder.records == count, "Failed restoration must still disable capture")
failRestore = false
assert(manager:Stop(fixture) and installed[fixture] == nil)
failInstall = true
assert(not pcall(function() manager:Add(fixture, "failed", "Standard") end) and manager.entries[fixture] == nil)
failInstall = false
local othEntry = manager:Add(cFixture, "C target", "Volt OTH")
assert(invoke(cFixture, 3) == 4 and contextReads == 3)
assert(manager.recorder.records[#manager.recorder.records].text:find("oth.is_hook_thread", 1, true))
local pushBeforeNested = manager.recorder.Push
manager.recorder.Push = function(self, ...)
    -- Model OTH dispatching report-internal calls on a different thread.
    local nested = coroutine.create(function() assert(invoke(cFixture, 8) == 9) end)
    assert(coroutine.resume(nested))
    return pushBeforeNested(self, ...)
end
local beforeNested = #manager.recorder.records
invoke(fixture, 1) -- currently unhooked
manager:Add(fixture, "nested reporting", "Standard")
invoke(fixture, 1)
assert(#manager.recorder.records == beforeNested + 1, "Report-internal OTH dispatch recursively captured itself")
manager.recorder.Push = pushBeforeNested
assert(manager:Stop(fixture))
failRestore = true
assert(not manager:Stop(cFixture) and not othEntry.active, "OTH false must count as restoration failure")
failRestore = false
assert(manager:Stop(cFixture))
installed[cFixture] = cFixture
assert(not manager:CanTrace(cFixture, "Standard"), "Pre-existing hooks must be preserved")
installed[cFixture] = nil
assert(manager:StopAll())

-- Overrides run the original and preserve the exact scalar return tuple.
assert(ReturnValues.parse("boolean", "false") == false)
assert(ReturnValues.parse("string", '"literal"') == '"literal"')
assert(ReturnValues.parse("number", "-1.25") == -1.25)
assert(not pcall(ReturnValues.parse, "boolean", "yes"))
assert(not pcall(ReturnValues.parse, "number", "0/0"), "Editor text must not be evaluated")
local sideEffects = 0
local function editable()
    sideEffects += 1
    return nil, false, "original", nil
end
local editableEntry = manager:Add(editable, "editable", "Standard")
assert(editableEntry.override == nil, "New hooks must start with overrides off")
local replacement = table.pack(nil, false, "modified", nil)
manager:SetReturnOverride(editable, replacement)
replacement[3] = "caller mutation"
local modified = table.pack(invoke(editable))
assert(sideEffects == 1 and modified.n == 4 and modified[2] == false and modified[3] == "modified" and modified[4] == nil)
local report = manager.recorder.records[#manager.recorder.records]
assert(report.values.outcome == "overridden" and report.text:find("original returns", 1, true)
    and report.text:find('"original"', 1, true) and report.text:find("modified returns", 1, true)
    and report.text:find('"modified"', 1, true), "Reports must include both return tuples")
local overrideBeforeInvalid = editableEntry.override
for _, invalid in { { n = -1 }, { n = 17 }, { n = 1.5 }, { n = 1, {} }, { n = 1, math.huge } } do
    assert(not pcall(function() manager:SetReturnOverride(editable, invalid) end))
    assert(editableEntry.override == overrideBeforeInvalid, "Invalid input replaced a working override")
end
local beforePause = #manager.recorder.records
manager.paused = true
assert(select(3, invoke(editable)) == "modified" and #manager.recorder.records == beforePause, "Pause capture must leave overrides active")
manager.paused = false
manager.recorder.rate = 0
assert(select(3, invoke(editable)) == "modified", "Rate limiting disabled an override")
manager.recorder.rate = 100
local savedPush = manager.recorder.Push
manager.recorder.Push = function() error("observer failure") end
assert(select(3, invoke(editable)) == "modified", "Capture failure disabled an override")
manager.recorder.Push = savedPush
local savedFinish = manager.recorder.Finish
manager.recorder.Finish = function() error("finish failure") end
assert(select(3, invoke(editable)) == "modified", "Report failure changed modified returns")
manager.recorder.Finish = savedFinish
manager:SetReturnOverride(editable, { n = 0 })
assert(select("#", invoke(editable)) == 0, "Zero returns became one nil")
manager:SetReturnOverride(editable, { n = 1 })
assert(select("#", invoke(editable)) == 1 and invoke(editable) == nil, "One nil return was lost")
manager:DisableReturnOverride(editable)
assert(select(3, invoke(editable)) == "original" and manager.entries[editable] == editableEntry, "Disabling must keep tracing")
manager:Add(throws, "error override", "Standard")
manager:SetReturnOverride(throws, table.pack("must not hide errors"))
local errorOK, originalError = pcall(invoke, throws)
assert(not errorOK and originalError == errorObject and manager.recorder.records[#manager.recorder.records].values.outcome == "error")
manager:Add(yielding, "pending override", "Standard")
manager:SetReturnOverride(yielding, table.pack(false, nil))
local pendingValues
local function pendingCall()
    local thread = coroutine.create(function() pendingValues = table.pack(invoke(yielding)) end)
    assert(select(2, coroutine.resume(thread)) == "waiting")
    return thread
end
local pendingThread = pendingCall()
manager:DisableReturnOverride(yielding)
assert(coroutine.resume(pendingThread) and pendingValues.n == 3 and pendingValues[2] == "resumed", "Disable failed to cancel a pending override")
manager:SetReturnOverride(yielding, table.pack(false, nil))
pendingThread = pendingCall()
manager:SetReturnOverride(yielding, table.pack("new config"))
assert(coroutine.resume(pendingThread) and pendingValues[2] == "resumed", "Pending call used a new rule retroactively")
pendingThread = pendingCall()
assert(coroutine.resume(pendingThread) and pendingValues.n == 1 and pendingValues[1] == "new config")
pendingThread = pendingCall()
assert(manager:Stop(yielding))
assert(coroutine.resume(pendingThread) and pendingValues[2] == "resumed", "Stopped hook modified a pending call")
manager:Add(cFixture, "OTH override", "Volt OTH")
manager:SetReturnOverride(cFixture, table.pack(42))
assert(invoke(cFixture, 3) == 42, "OTH did not apply the override")
failRestore = true
manager:SetReturnOverride(editable, table.pack("disabled on stop"))
assert(not manager:Stop(editable) and editableEntry.override == nil and select(3, invoke(editable)) == "original")
failRestore = false
assert(manager:StopAll())

-- Selected outgoing calls share one hook; unrelated calls take the fast path.
local method, originalCalls = "FireServer", 0
local yieldNamecall = false
local function namecall(remote, ...)
    originalCalls += 1
    assert(method == "FireServer" or method == "InvokeServer", "Capture corrupted namecall context")
    if yieldNamecall then
        coroutine.yield("remote waiting")
        return nil, "remote response", nil
    end
    return nil, select("#", ...), nil
end
cTargets[namecall] = true
globals.getrawmetatable = function(object) assert(object == game) return { __namecall = namecall } end
globals.getnamecallmethod = function() return method end
globals.setnamecallmethod = function(value) method = value end
compat:Refresh()
local traffic = Recorder.new()
local paused = false
local outgoing = Outgoing.new(manager, traffic, function() return paused end)
local event = Instance.new("RemoteEvent")
event.Name, event.Parent = "Event", services.ReplicatedStorage
local query = Instance.new("RemoteFunction")
query.Name, query.Parent = "Query", services.ReplicatedStorage
local other = Instance.new("RemoteEvent")
other.Parent = services.ReplicatedStorage
local baseConnections, baseInstalls = connections, installs
outgoing:Watch(event, "Standard")
outgoing:Watch(query, "Standard")
outgoing:Watch(event, "Standard")
assert(not pcall(function() manager:SetReturnOverride(namecall, table.pack("blocked")) end), "Outgoing hooks must not be editable")
assert(outgoing.count == 2 and installs == baseInstalls + 1 and connections == baseConnections + 4)
assert(select(2, invoke(namecall, event, nil, false, nil)) == 3)
assert(traffic.records[1].values.args == 3 and traffic.records[1].values.kind == "outgoing FireServer")
assert(traffic.records[1].values.outcome == "returned")
invoke(namecall, other, 1)
assert(#traffic.records == 1)
method = "InvokeServer"
assert(select(2, invoke(namecall, query, "request", nil)) == 2)
assert(traffic.records[2].values.kind == "outgoing InvokeServer")
paused = true
invoke(namecall, query)
assert(#traffic.records == 2)
paused = false
-- A serializer can make a namecall of its own. Restore the saved method.
local push = traffic.Push
traffic.Push = function(self, ...)
    local result = push(self, ...)
    method = "GetComponents"
    return result
end
invoke(namecall, query, 1)
assert(method == "InvokeServer")
traffic.Push = push
event.Parent = nil
assert(outgoing.count == 1 and installed[namecall] ~= nil)
query:Destroy()
assert(outgoing.count == 0 and installed[namecall] == nil and connections == baseConnections)
method = "FireServer"
event.Parent = services.ReplicatedStorage
outgoing:Watch(event, "Volt OTH")
assert(invoke(namecall, event, 2) == nil)
assert(manager:StopAll())
outgoing:Sync()
assert(outgoing.count == 0 and connections == baseConnections, "Stopping all hooks left outgoing watch listeners")
outgoing:Watch(event, "Standard")
outgoing:Destroy()
assert(installed[namecall] == nil and connections == baseConnections)
event:Destroy()
other:Destroy()
manager:Destroy()

-- Live UI: start/stop from Hooks and clean active hooks when rerunning the app.
local discoveryScans = 0
globals.getgc = function() discoveryScans += 1 return { fixture, cFixture } end
local function section(tab, name)
    for _, item in tab.sections do if item.frame.Name == name then return item end end
    error(name)
end
local function button(root, text)
    for _, child in root:GetChildren() do
        if child:IsA("TextButton") and child.Text == text then return child end
        local found = button(child, text)
        if found then return found end
    end
end
local window = App.start()
assert(#window.tabs == 8)
local tab = window.app.tabs.Hooks
local discovery = window.app.tabs.Functions.controller
assert(not button(tab.container, "Trace selected function").Active, "Hooks must wait for a transferred target")
discovery.scan()
runTasks()
local discovered
for _, record in discovery.results.records do if record.value == fixture then discovered = record end end
assert(discovered)
discovery.results:Select(discovered.id)
local scansBeforeTransfer, installsBeforeTransfer = discoveryScans, installs
button(discovery.tab.container, "Send to Hooks").MouseButton1Click:Fire()
assert(window.currentTab == tab and tab.controller.target == fixture, "Discovery did not transfer the chosen closure")
assert(tab.controller.targetReport:GetText():find('["functionId"] = ' .. discovered.id, 1, true))
assert(discoveryScans == scansBeforeTransfer and installs == installsBeforeTransfer, "Transferring rescanned or hooked the target")
assert(tab.controller.targetStatus:GetText():find("READY", 1, true))
failInstall = true
button(tab.container, "Trace selected function").MouseButton1Click:Fire()
assert(tab.controller.targetStatus:GetText():find("install rejected", 1, true), "Install failure disappeared from target status")
failInstall = false
button(tab.container, "Trace selected function").MouseButton1Click:Fire()
assert(installed[fixture] ~= nil)
assert(tab.controller.targetStatus:GetText():find("waiting for a call", 1, true))
assert(button(tab.container, "Stop selected hook").Active, "Starting a hook should select it for immediate stopping")
local installedCount = installs
button(discovery.tab.container, "Send to Hooks").MouseButton1Click:Fire()
assert(installs == installedCount and not button(tab.container, "Trace selected function").Active
    and button(tab.container, "Stop selected hook").Active, "Resending a managed function replaced its hook")
tab.controller.pause:SetValue(true)
assert(tab.controller.targetStatus:GetText():find("PAUSED", 1, true))
invoke(fixture, "paused")
assert(#window.app.hooks.recorder.records == 0)
tab.controller.pause:SetValue(false)
invoke(fixture, "from UI")
services.RunService.RenderStepped:Fire(.25)
local captures = section(tab, "Captured calls").components[3]
assert(#captures.records == 1)
assert(tab.controller.output:GetText():find("from UI", 1, true), "Latest call was not shown automatically")
assert(tab.controller.follow:GetValue())
invoke(fixture, "newest UI")
services.RunService.RenderStepped:Fire(.25)
assert(tab.controller.output:GetText():find("newest UI", 1, true))
captures:Select(captures.records[1].id)
assert(not tab.controller.follow:GetValue(), "Selecting history must stop following new calls")
invoke(fixture, "keep selection")
services.RunService.RenderStepped:Fire(.25)
assert(tab.controller.output:GetText():find("from UI", 1, true), "New calls overwrote selected history")
section(tab, "Captured calls").components[2]:SetValue("no matching function")
assert(#captures.filtered == 0 and not tab.controller.output:GetText():find("from UI", 1, true))
section(tab, "Captured calls").components[2]:SetValue("")
tab.controller.follow:SetValue(true)
assert(tab.controller.output:GetText():find("keep selection", 1, true))
local active = section(tab, "Managed hooks").components[1]
active:Select(active.records[1].id)
assert(tab.controller.target == fixture and tab.controller.targetReport:GetText():find('["functionId"] = ' .. discovered.id, 1, true),
    "Managed-hook selection did not synchronize the function details")
failRestore = true
button(tab.container, "Stop selected hook").MouseButton1Click:Fire()
assert(tab.controller.targetStatus:GetText():find("STOP FAILED", 1, true))
assert(active.records[1].values.state == "retry stop" and button(tab.container, "Stop selected hook").Active)
failRestore = false
button(tab.container, "Stop selected hook").MouseButton1Click:Fire()
assert(installed[fixture] == nil)

-- A selected pending record must refresh even though it keeps the same identity.
tab.controller.select(yielding, "UI yielding")
button(tab.container, "Trace selected function").MouseButton1Click:Fire()
local uiThread = coroutine.create(function() invoke(yielding) end)
assert(select(2, coroutine.resume(uiThread)) == "waiting")
services.RunService.RenderStepped:Fire(.25)
local pending = captures.records[#captures.records]
captures:Select(pending.id)
assert(tab.controller.output:GetText():find("Still running", 1, true))
assert(coroutine.resume(uiThread))
services.RunService.RenderStepped:Fire(.25)
assert(tab.controller.output:GetText():find("resumed", 1, true) and not tab.controller.output:GetText():find("Still running", 1, true))
button(tab.container, "Stop selected hook").MouseButton1Click:Fire()
tab.controller.select(fixture, "UI fixture")
button(tab.container, "Trace selected function").MouseButton1Click:Fire()
assert(installed[fixture] ~= nil)
local editor = tab.controller.overrideEditor
assert(editor.apply.button.Active and not editor.disable.button.Active)
editor.slots[1].kind:SetValue("string")
editor.slots[1].value:SetValue('raw <b>"text"</b>')
button(tab.container, "Add return slot").MouseButton1Click:Fire()
editor.slots[2].kind:SetValue("boolean")
assert(not editor.slots[2].value.frame.Visible and editor.slots[2].boolean.frame.Visible, "Boolean editor still requires typing")
editor.slots[2].boolean:SetValue("true")
button(tab.container, "Add return slot").MouseButton1Click:Fire()
button(tab.container, "Apply and enable override").MouseButton1Click:Fire()
local uiModified = table.pack(invoke(fixture, "UI override"))
assert(uiModified.n == 3 and uiModified[1] == 'raw <b>"text"</b>' and uiModified[2] == true and uiModified[3] == nil)
editor.slots[2].boolean:SetValue("false")
button(tab.container, "Apply and enable override").MouseButton1Click:Fire()
assert(select(2, invoke(fixture)) == false, "False selector did not apply a raw boolean")
tab.controller.follow:SetValue(true)
services.RunService.RenderStepped:Fire(.25)
assert(tab.controller.output:GetText():find("modified returns", 1, true))
editor.slots[2].kind:SetValue("number")
editor.slots[2].value:SetValue("invalid")
button(tab.container, "Apply and enable override").MouseButton1Click:Fire()
assert(tab.controller.targetStatus:GetText():find("Return #2", 1, true) and select(2, invoke(fixture)) == false)
tab.controller.select(cFixture, "Other UI target")
assert(not editor.apply.button.Active, "An untraced target must not enable editing")
tab.controller.select(fixture, "UI fixture")
assert(#editor.slots == 3 and editor.slots[1].value:GetValue() == 'raw <b>"text"</b>'
    and editor.slots[2].kind:GetValue() == "boolean" and editor.slots[2].boolean:GetValue() == "false"
    and editor.slots[2].boolean.frame.Visible, "Target selection failed to reload the applied values")
button(tab.container, "Disable override").MouseButton1Click:Fire()
assert(table.pack(invoke(fixture)).n == 4 and window.app.hooks.entries[fixture] ~= nil)
button(tab.container, "Apply and enable override").MouseButton1Click:Fire()
local replacementWindow = App.start()
assert(window.destroyed and installed[fixture] == nil, "Rerun did not restore hooks")
replacementWindow:Destroy()
assert(connections == 0 and next(installed) == nil, "Hook or connection leak")

-- Roblox can dispatch BindableEvent listeners after the refresh guard resets.
deferBindableEvents = true
local deferredWindow = App.start()
local deferredTab = deferredWindow.app.tabs.Hooks
local function drain()
    assert(flushEvents(100) == 0, "Deferred selection events keep refreshing managed hooks")
end
deferredTab.controller.select(fixture, "Deferred fixture")
button(deferredTab.container, "Trace selected function").MouseButton1Click:Fire()
drain()
assert(deferredTab.controller.targetStatus:GetText():find("Hook installed", 1, true), "Refresh erased the last action")
local deferredEditor = deferredTab.controller.overrideEditor
deferredEditor.slots[1].kind:SetValue("boolean")
deferredEditor.slots[1].boolean:SetValue("true")
drain()
assert(deferredEditor.slots[1].boolean.frame.Visible and not deferredEditor.slots[1].value.frame.Visible)
button(deferredTab.container, "Apply and enable override").MouseButton1Click:Fire()
drain()
assert(invoke(fixture) == true, "Deferred boolean selector failed")
deferredEditor.slots[1].kind:SetValue("number")
deferredEditor.slots[1].value:SetValue("12.5")
button(deferredTab.container, "Add return slot").MouseButton1Click:Fire()
drain()
button(deferredTab.container, "Apply and enable override").MouseButton1Click:Fire()
drain()
local deferredReturns = table.pack(invoke(fixture, "deferred override"))
assert(deferredReturns.n == 2 and deferredReturns[1] == 12.5 and deferredReturns[2] == nil)
button(deferredTab.container, "Disable override").MouseButton1Click:Fire()
drain()
assert(table.pack(invoke(fixture)).n == 4)
button(deferredTab.container, "Clear captured calls").MouseButton1Click:Fire()
drain()
invoke(fixture, "deferred first")
services.RunService.RenderStepped:Fire(.25)
drain()
assert(deferredTab.controller.follow:GetValue(), "Automatic selection disabled following after deferred dispatch")
invoke(fixture, "deferred latest")
services.RunService.RenderStepped:Fire(.25)
drain()
assert(deferredTab.controller.output:GetText():find("deferred latest", 1, true))
deferredWindow.app.hooks:Add(cFixture, "Other function", "Standard")
invoke(cFixture, 5)
services.RunService.RenderStepped:Fire(.25)
drain()
local deferredFilter = section(deferredTab, "Captured calls").components[2]
deferredFilter:SetValue("Deferred fixture")
drain()
assert(deferredTab.controller.follow:GetValue() and deferredTab.controller.output:GetText():find("deferred latest", 1, true),
    "A deferred filter deselection cleared the latest matching report")
deferredFilter:SetValue("")
drain()
assert(deferredWindow.app.hooks:Stop(cFixture))
local deferredCalls = deferredTab.controller.calls
deferredCalls:Select(deferredCalls.records[1].id)
drain()
assert(not deferredTab.controller.follow:GetValue(), "A deferred user selection must stop following")
invoke(fixture, "leave older selection")
services.RunService.RenderStepped:Fire(.25)
drain()
assert(deferredTab.controller.output:GetText():find("deferred first", 1, true))
local originalDeferredEntry = deferredWindow.app.hooks.entries[fixture]
deferredTab.controller.select(cFixture, "Other target")
drain()
assert(not deferredEditor.apply.button.Active and originalDeferredEntry.override == nil)
deferredTab.controller.select(fixture, "Deferred fixture")
drain()
assert(#deferredEditor.slots == 2 and deferredEditor.slots[1].value:GetValue() == "12.5")
local deferredActive = section(deferredTab, "Managed hooks").components[1]
deferredActive:Select(deferredActive.records[1].id)
drain()
button(deferredTab.container, "Stop selected hook").MouseButton1Click:Fire()
drain()
assert(deferredTab.controller.targetStatus:GetText():find("Original function restored", 1, true))

-- Live property refresh must preserve source/diff/raw modes under deferred events.
local deferredScript = Instance.new("ModuleScript")
deferredScript.Name, deferredScript.Source = "DeferredScript", 'return "preserved source"'
deferredScript.Parent = services.ReplicatedStorage
deferredScript:SetAttribute("Counter", 1)
local explorer = deferredWindow.app.tabs.Explorer
explorer.controller.search:SetValue("DeferredScript")
drain()
explorer.controller.scan()
runTasks()
drain()
local instanceList = section(explorer, "Search results").components[1]
instanceList:Select(instanceList.records[1].id)
drain()
deferredWindow:SelectTab(explorer)
local properties = section(explorer, "Properties and attributes")
local propertyTree, propertyOutput = properties.components[1], properties.components[2]
properties.components[5]:SetValue(true)
drain()
propertyTree:Expand("attributes", true)
propertyTree:Select("attribute:Counter")
drain()
button(explorer.container, "Read script source").MouseButton1Click:Fire()
deferredScript:SetAttribute("Counter", 2)
services.RunService.RenderStepped:Fire(.25)
drain()
assert(propertyOutput:GetText() == deferredScript.Source, "Deferred property refresh overwrote source")
button(explorer.container, "Capture property baseline").MouseButton1Click:Fire()
deferredScript:SetAttribute("Counter", 3)
button(explorer.container, "Compare properties").MouseButton1Click:Fire()
local comparison = propertyOutput:GetText()
services.RunService.RenderStepped:Fire(.25)
drain()
assert(propertyOutput:GetText() == comparison, "Deferred property refresh overwrote a comparison")
propertyTree:Select("attributes")
drain()
button(explorer.container, "Show raw value").MouseButton1Click:Fire()
deferredScript:SetAttribute("NewRawField", "raw stays current")
services.RunService.RenderStepped:Fire(.25)
drain()
assert(propertyOutput:GetText():find("raw stays current", 1, true), "Deferred property refresh lost the raw view")
propertyTree:Select("attribute:Counter")
drain()
assert(propertyOutput:GetText() == "3", "User selection must still show its property")
deferredScript:Destroy()

-- A selected outgoing report must update when a yielded call finishes in place.
local deferredQuery = Instance.new("RemoteFunction")
deferredQuery.Name, deferredQuery.Parent = "DeferredQuery", services.ReplicatedStorage
local remotes = deferredWindow.app.tabs.Remotes
remotes.controller.outgoing:Watch(deferredQuery, "Standard")
method, yieldNamecall = "InvokeServer", true
local remoteThread = coroutine.create(function()
    local values = table.pack(invoke(namecall, deferredQuery, "request"))
    assert(values.n == 3 and values[2] == "remote response")
end)
assert(select(2, coroutine.resume(remoteThread)) == "remote waiting")
services.RunService.RenderStepped:Fire(.25)
drain()
local trafficSection = section(remotes, "Captured traffic")
local trafficList, trafficOutput = trafficSection.components[1], trafficSection.components[2]
assert(trafficList.records[1].values.outcome == "running")
trafficList:Select(trafficList.records[1].id)
drain()
assert(not trafficOutput:GetText():find("remote response", 1, true))
assert(coroutine.resume(remoteThread))
services.RunService.RenderStepped:Fire(.25)
drain()
assert(trafficOutput:GetText():find("remote response", 1, true), "Selected remote report stayed stale after returning")
button(remotes.container, "Clear captured events").MouseButton1Click:Fire()
drain()
assert(not trafficOutput:GetText():find("remote response", 1, true), "Cleared remote report stayed visible")
yieldNamecall = false
deferredQuery:Destroy()
deferredWindow:Destroy()
drain()
deferBindableEvents = false
assert(connections == 0 and next(installed) == nil, "Deferred UI leaked hooks or connections")
print("hooks smoke passed")
