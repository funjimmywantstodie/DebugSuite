local m = {}

m.__index = m

local function contains(frame, position)
    if not frame.Visible then return false end
    local origin, size = frame.AbsolutePosition, frame.AbsoluteSize
    return position.X >= origin.X and position.Y >= origin.Y
        and position.X <= origin.X + size.X and position.Y <= origin.Y + size.Y
end

function m:HitTest(position)
    if not self.screen.Enabled then return nil end
    for overlay in self.overlays do
        if not overlay.Visible then continue end
        for _, child in overlay:GetChildren() do
            if child:IsA("GuiObject") and contains(child, position) then return nil end
        end
    end
    for index = #self.windows, 1, -1 do
        local window = self.windows[index]
        if contains(window.frame, position) then return window end
    end
    return nil
end

function m:CanStartDrag(window, handle, event)
    if self:BeginPress(event) ~= window or self.focused ~= window then return false end
    --dont drag when clicking the topbar buttons
    for _, child in handle:GetChildren() do
        if (child:IsA("TextButton") or child:IsA("ImageButton") or child:IsA("TextBox"))
            and contains(child, event.Position) then
            return false
        end
    end
    return true
end

function m:BeginPress(event)
    if event.UserInputType ~= Enum.UserInputType.MouseButton1
        and event.UserInputType ~= Enum.UserInputType.Touch then
        return nil
    end
    if not self.screen.Enabled or event.UserInputState == Enum.UserInputState.End
        or event.UserInputState == Enum.UserInputState.Cancel then
        return nil
    end

    local mouse = event.UserInputType == Enum.UserInputType.MouseButton1
    local press = if mouse then self.mousePress else self.presses[event]
    --only focus once per click so opening the console doesnt undo itself
    if press then return press.window end

    local window = self:HitTest(event.Position)
    press = { window = window }
    if mouse then
        self.mousePress = press
    else
        self.presses[event] = press
    end
    if window then self:Focus(window) end
    return window
end

function m:BindPress(scope, object)
    scope:Connect(object.InputBegan, function(event)
        self:BeginPress(event)
    end)
end

function m.new(screen, scope)
    local self = setmetatable({
        screen = screen,
        windows = {},
        overlays = {},
        presses = setmetatable({}, { __mode = "k" })
    }, m)

    local function resetPresses()
        table.clear(self.presses)
        self.mousePress = nil
    end
    scope:Add(function()
        resetPresses()
        self.focused = nil
    end)

    local input = game:GetService("UserInputService")
    scope:Connect(input.InputBegan, function(event)
        if not screen.Enabled then return end
        if event.UserInputType ~= Enum.UserInputType.MouseButton1
            and event.UserInputType ~= Enum.UserInputType.Touch then
            return
        end
        self:BeginPress(event)
    end)
    scope:Connect(input.InputEnded, function(event)
        if event.UserInputType == Enum.UserInputType.MouseButton1 then
            self.mousePress = nil
        else
            self.presses[event] = nil
        end
    end)
    scope:Connect(input.WindowFocusReleased, resetPresses)
    scope:Connect(screen:GetPropertyChangedSignal("Enabled"), function()
        if not screen.Enabled then resetPresses() end
    end)
    return self
end

function m:_restack()
    for index, window in self.windows do window.frame.ZIndex = index + 4 end
    for overlay in self.overlays do overlay.ZIndex = #self.windows + 10 end
end

function m:RegisterOverlay(frame, scope)
    self.overlays[frame] = true
    scope:Add(function() self.overlays[frame] = nil end)
    self:_restack()
end

function m:Register(window)
    table.insert(self.windows, window)
    window.scope:Add(function()
        local index = table.find(self.windows, window)
        if index then table.remove(self.windows, index) end
        if self.focused == window then self.focused = nil end
        self:_restack()
    end)
    self:_restack()
end

function m:Focus(window)
    if window.destroyed or not window.frame.Visible then return end
    local index = table.find(self.windows, window)
    if not index then return end
    table.remove(self.windows, index)
    table.insert(self.windows, window)
    self.focused = window
    self:_restack()
end

return m
