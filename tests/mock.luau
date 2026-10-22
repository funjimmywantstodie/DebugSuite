local connections = 0
local deferBindableEvents = false
local pendingEvents = {}
local function flushEvents(limit)
    local count = 0
    while #pendingEvents > 0 and count < (limit or 1000) do
        count += 1
        table.remove(pendingEvents, 1)()
    end
    return #pendingEvents
end
local function signal(bindable)
    local self = { listeners = {} }
    function self:Connect(fn)
        local conn = { Connected = true, fn = fn }
        connections += 1
        function conn:Disconnect()
            if not self.Connected then return end
            self.Connected = false
            connections -= 1
        end
        table.insert(self.listeners, conn)
        return conn
    end
    function self:Fire(...)
        local args = table.pack(...)
        for _, conn in table.clone(self.listeners) do
            if conn.Connected then
                if bindable and deferBindableEvents then
                    table.insert(pendingEvents, function()
                        if conn.Connected then conn.fn(table.unpack(args, 1, args.n)) end
                    end)
                else conn.fn(...) end
            end
        end
    end
    return self
end

local Vector2 = {}
local vectorMt = { __type = "Vector2" }
function Vector2.new(x, y) return setmetatable({ X = x, Y = y }, vectorMt) end
vectorMt.__add = function(a, b) return Vector2.new(a.X + b.X, a.Y + b.Y) end
vectorMt.__sub = function(a, b) return Vector2.new(a.X - b.X, a.Y - b.Y) end
Vector2.zero = Vector2.new(0, 0)
local udimMt = { __type = "UDim" }
local udim2Mt = { __type = "UDim2" }
local UDim = { new = function(scale, offset) return setmetatable({ Scale = scale or 0, Offset = offset or 0 }, udimMt) end }
local UDim2 = {}
function UDim2.new(xs, xo, ys, yo) return setmetatable({ X = UDim.new(xs, xo), Y = UDim.new(ys, yo) }, udim2Mt) end
function UDim2.fromOffset(x, y) return UDim2.new(0, x, 0, y) end
function UDim2.fromScale(x, y) return UDim2.new(x, 0, y, 0) end
local Color3 = { fromRGB = function(...) return {...} end }
local Enum = setmetatable({}, { __index = function(self, category)
    local values = setmetatable({}, { __index = function(items, key)
        local value = category .. "." .. key
        rawset(items, key, value)
        return value
    end })
    rawset(self, category, values)
    return values
end })

local Instance = {}
local methods = {}
function methods:GetChildren() return table.clone(self.children) end
function methods:GetAttributes() return table.clone(self.attributes) end
function methods:SetAttribute(key, value)
    self.attributes[key] = value
    if self.signals.AttributeChanged then self.signals.AttributeChanged:Fire(key) end
end
function methods:FindFirstChild(name)
    for _, child in self.children do if child.Name == name then return child end end
end
function methods:IsDescendantOf(ancestor)
    local current = self.Parent
    while current do
        if current == ancestor then return true end
        current = current.Parent
    end
    return false
end
function methods:GetPropertyChangedSignal(key)
    if not self.signals[key] then self.signals[key] = signal() end
    return self.signals[key]
end
function methods:IsA(class)
    return self.props.ClassName == class or (class == "GuiObject" and table.find({ "Frame", "ScrollingFrame", "TextButton", "TextBox", "TextLabel" }, self.props.ClassName) ~= nil)
end
function methods:FindFirstAncestorWhichIsA(class)
    local current = self.Parent
    while current do
        if current:IsA(class) then return current end
        current = current.Parent
    end
end
function methods:Destroy()
    if self.props.destroyed then return end
    if self.signals.Destroying then self.signals.Destroying:Fire() end
    for _, child in self:GetChildren() do child:Destroy() end
    for _, event in self.signals do
        for _, conn in event.listeners do conn:Disconnect() end
    end
    if self.props.Event then
        for _, conn in self.props.Event.listeners do conn:Disconnect() end
    end
    self.Parent = nil
    self.props.destroyed = true
end
function methods:Clone()
    local copy = Instance.new(self.ClassName)
    for key, value in self.props do if key ~= "Parent" then copy.props[key] = value end end
    return copy
end
function methods:CaptureFocus() self.props.focused = true end
function methods:Fire(...) self.Event:Fire(...) end
local instanceMt = {
    __index = function(self, key)
        if methods[key] then return methods[key] end
        if self.props[key] ~= nil then return self.props[key] end
        if table.find({ "MouseButton1Click", "Focused", "FocusLost", "InputBegan", "DragStart", "DragContinue", "Destroying", "Changed", "AttributeChanged", "AncestryChanged", "OnClientEvent" }, key) then
            return self:GetPropertyChangedSignal(key)
        end
    end,
    __newindex = function(self, key, value)
        if key == "Parent" then
            local old = self.props.Parent
            if old then
                local index = table.find(old.children, self)
                if index then table.remove(old.children, index) end
            end
            if value then table.insert(value.children, self) end
        end
        local changed = self.props[key] ~= value
        self.props[key] = value
        if changed and self.signals[key] then self.signals[key]:Fire() end
        if changed and self.signals.Changed then self.signals.Changed:Fire(key) end
        if changed and key == "Parent" and self.signals.AncestryChanged then self.signals.AncestryChanged:Fire(self, value) end
    end,
}
function Instance.new(class)
    local self = setmetatable({ props = {
        ClassName = class, Name = class, Visible = true, Enabled = true, ZIndex = 1,
        AbsoluteSize = Vector2.new(500, 300), AbsolutePosition = Vector2.zero,
        CanvasPosition = Vector2.zero, AbsoluteContentSize = Vector2.zero,
        Font = Enum.Font.SourceSans, TextSize = 14, ScrollBarThickness = 6, Size = UDim2.new(), Position = UDim2.new(), Text = "",
    }, children = {}, signals = {}, attributes = {} }, instanceMt)
    if class == "BindableEvent" then self.Event = signal(true) end
    return self
end
local input = { InputBegan = signal(), InputChanged = signal(), InputEnded = signal(), WindowFocusReleased = signal(), keys = {} }
function input:GetFocusedTextBox() return self.focused end
function input:IsKeyDown(key) return self.keys[key] == true end
local run = { RenderStepped = signal() }
local services = { CoreGui = Instance.new("Folder"), UserInputService = input, RunService = run,
    LogService = { MessageOut = signal() } }
local game = Instance.new("DataModel")
game.Name = "Game"
game.PlaceId, game.GameId, game.JobId = 123, 456, "mock-job"
services.CoreGui.Name = "CoreGui"
services.CoreGui.Parent = game
services.ReplicatedStorage = Instance.new("Folder")
services.ReplicatedStorage.Name = "ReplicatedStorage"
services.ReplicatedStorage.Parent = game
services.Workspace = Instance.new("Folder")
services.Workspace.Name = "Workspace"
services.Workspace.Parent = game
services.Stats = { GetTotalMemoryUsageMb = function() return 123 end }
function game:GetService(name) return services[name] end
local globals = {}
local function getgenv() return globals end
local function cloneref(value) return value end
local function warn(...) print(...) end
local function typeof(value)
    if type(value) == "table" and getmetatable(value) == instanceMt then return "Instance" end
    if type(value) == "table" then
        local mt = getmetatable(value)
        if type(mt) == "table" and rawget(mt, "__type") then return rawget(mt, "__type") end
    end
    return type(value)
end
local taskQueue = {}
local task = {}
function task.spawn(fn) table.insert(taskQueue, coroutine.create(fn)) end
function task.wait() coroutine.yield() end
local function runTasks(steps)
    local count = 0
    while #taskQueue > 0 and count < (steps or 10000) do
        count += 1
        local thread = table.remove(taskQueue, 1)
        local ok, err = coroutine.resume(thread)
        assert(ok, err)
        if coroutine.status(thread) ~= "dead" then table.insert(taskQueue, thread) end
    end
    return #taskQueue
end
