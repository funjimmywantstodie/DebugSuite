local m = {}

local activeOwner

local function visible(handle)
    while handle do
        if handle:IsA("GuiObject") and not handle.Visible then return false end
        if handle:IsA("ScreenGui") and not handle.Enabled then return false end
        handle = handle.Parent
    end
    return true
end

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

function m.attach(scope, handle, started, moved, canStart)
    local input = game:GetService("UserInputService")
    local active, origin
    local token = {}

    local function release()
        active = nil
        if activeOwner == token then activeOwner = nil end
    end
    scope:Add(release)

    --stop dragging when the window gets hidden
    local ancestor = handle
    while ancestor do
        if ancestor:IsA("GuiObject") then
            local object = ancestor
            scope:Connect(object:GetPropertyChangedSignal("Visible"), function()
                if not object.Visible then release() end
            end)
        elseif ancestor:IsA("ScreenGui") then
            local screen = ancestor
            scope:Connect(screen:GetPropertyChangedSignal("Enabled"), function()
                if not screen.Enabled then release() end
            end)
        end
        ancestor = ancestor.Parent
    end

    handle.Active = true
    scope:Connect(handle.InputBegan, function(event)
        if activeOwner or not visible(handle) then return end
        if event.UserInputType ~= Enum.UserInputType.MouseButton1 and event.UserInputType ~= Enum.UserInputType.Touch then return end
        if event.UserInputState == Enum.UserInputState.End or event.UserInputState == Enum.UserInputState.Cancel then return end
        if canStart and not canStart(event) then return end
        activeOwner = token
        active = event
        origin = Vector2.new(event.Position.X, event.Position.Y)
        started()
    end)

    scope:Connect(input.InputChanged, function(event)
        if not active then return end
        if not visible(handle) then
            release()
            return
        end
        if event == active and (event.UserInputState == Enum.UserInputState.End
            or event.UserInputState == Enum.UserInputState.Cancel) then
            release()
            return
        end
        local mouse = active.UserInputType == Enum.UserInputType.MouseButton1
        if (mouse and event.UserInputType == Enum.UserInputType.MouseMovement) or event == active then
            moved(Vector2.new(event.Position.X, event.Position.Y) - origin)
        end
    end)

    scope:Connect(input.InputEnded, function(event)
        --mouse events can use different objects, touch needs the same finger
        if event == active or (active and active.UserInputType == Enum.UserInputType.MouseButton1
            and event.UserInputType == Enum.UserInputType.MouseButton1) then
            release()
        end
    end)
    scope:Connect(input.WindowFocusReleased, release)
end

function m.attachResize(scope, handle, root, minimum, canStart)
    local resizeScale, parentScale, sizeStart, positionStart
    m.attach(scope, handle, function()
        resizeScale = m.scale(root)
        parentScale = m.scale(root.Parent)
        sizeStart = Vector2.new(root.AbsoluteSize.X / resizeScale, root.AbsoluteSize.Y / resizeScale)
        positionStart = root.Position
    end, function(delta)
        local width = math.max(minimum.X, sizeStart.X + delta.X / resizeScale)
        local height = math.max(minimum.Y, sizeStart.Y + delta.Y / resizeScale)
        root.Size = UDim2.fromOffset(width, height)
        root.Position = UDim2.new(
            positionStart.X.Scale,
            positionStart.X.Offset + (width - sizeStart.X) * resizeScale / parentScale * root.AnchorPoint.X,
            positionStart.Y.Scale,
            positionStart.Y.Offset + (height - sizeStart.Y) * resizeScale / parentScale * root.AnchorPoint.Y
        )
    end, canStart)
end

return m
