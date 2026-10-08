local m = {}

function m.scale(gui)
    local scale = 1
    while gui do
        for _, child in gui:GetChildren() do
            if child:IsA("UIScale") then scale *= child.Scale end
        end
        gui = gui.Parent
    end
    return math.max(0.001, scale)
end

function m.attach(scope, handle, started, moved)
    local input = game:GetService("UserInputService")
    local active, origin
    handle.Active = true
    scope:Connect(handle.InputBegan, function(event)
        if active then return end
        if event.UserInputType ~= Enum.UserInputType.MouseButton1 and event.UserInputType ~= Enum.UserInputType.Touch then return end
        active = event
        origin = Vector2.new(event.Position.X, event.Position.Y)
        started()
    end)
    scope:Connect(input.InputChanged, function(event)
        if not active then return end
        local mouse = active.UserInputType == Enum.UserInputType.MouseButton1
        if (mouse and event.UserInputType == Enum.UserInputType.MouseMovement) or event == active then
            moved(Vector2.new(event.Position.X, event.Position.Y) - origin)
        end
    end)
    scope:Connect(input.InputEnded, function(event)
        if event == active then active = nil end
    end)
    scope:Connect(input.WindowFocusReleased, function() active = nil end)
end

return m
