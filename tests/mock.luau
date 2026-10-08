local connections = 0
local function signal()
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
        for _, conn in table.clone(self.listeners) do
            if conn.Connected then conn.fn(...) end
        end
    end
    return self
end

local Vector2 = {}
local vectorMt = {}
function Vector2.new(x, y) return setmetatable({ X = x, Y = y }, vectorMt) end
vectorMt.__add = function(a, b) return Vector2.new(a.X + b.X, a.Y + b.Y) end
vectorMt.__sub = function(a, b) return Vector2.new(a.X - b.X, a.Y - b.Y) end
Vector2.zero = Vector2.new(0, 0)
local UDim = { new = function(scale, offset) return { Scale = scale or 0, Offset = offset or 0 } end }
local UDim2 = {}
function UDim2.new(xs, xo, ys, yo) return { X = UDim.new(xs, xo), Y = UDim.new(ys, yo) } end
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
        if table.find({ "MouseButton1Click", "Focused", "FocusLost", "InputBegan", "DragStart", "DragContinue", "Destroying" }, key) then
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
    end,
}
function Instance.new(class)
    local self = setmetatable({ props = {
        ClassName = class, Name = class, Visible = true, Enabled = true, ZIndex = 1,
        AbsoluteSize = Vector2.new(500, 300), AbsolutePosition = Vector2.zero,
        CanvasPosition = Vector2.zero, AbsoluteContentSize = Vector2.zero,
        Font = Enum.Font.SourceSans, TextSize = 14, ScrollBarThickness = 6, Size = UDim2.new(), Position = UDim2.new(), Text = "",
    }, children = {}, signals = {} }, instanceMt)
    if class == "BindableEvent" then self.Event = signal() end
    return self
end
local input = { InputBegan = signal(), InputChanged = signal(), InputEnded = signal(), WindowFocusReleased = signal(), keys = {} }
function input:GetFocusedTextBox() return self.focused end
function input:IsKeyDown(key) return self.keys[key] == true end
local run = { RenderStepped = signal() }
local services = { CoreGui = Instance.new("Folder"), UserInputService = input, RunService = run }
local game = {}
function game:GetService(name) return services[name] end
local globals = {}
local function getgenv() return globals end
local function cloneref(value) return value end
local function warn(...) print(...) end
