local m = {}
local lifecycle = require("../util/Lifecycle")
local colors = require("../Colors")
local dragUtil = require("../util/Drag")

function m.new(owner, opts)
    opts = opts or {}
    local frame = Instance.new("Frame")
    frame.Name = "SplitPane"
    frame.BackgroundTransparency = 1
    frame.Size = opts.size or UDim2.new(1, 0, 0, opts.height or 320)
    frame.ZIndex = owner.contentFrame.ZIndex + 1
    frame.Parent = owner.contentFrame
    local self = lifecycle.attach({}, frame, owner)
    self.ratio = opts.ratio or 0.5
    local vertical = opts.vertical or false
    local first = Instance.new("Frame")
    first.Name = "First"
    first.BackgroundTransparency = 1
    first.ZIndex = frame.ZIndex + 1
    first.Parent = frame
    local second = first:Clone()
    second.Name = "Second"
    second.Parent = frame
    self.first = lifecycle.attach({ contentFrame = first }, first, self)
    self.second = lifecycle.attach({ contentFrame = second }, second, self)
    self.components = { self.first, self.second }
    local divider = Instance.new("Frame")
    divider.BackgroundColor3 = colors.sectionHeader
    divider.BorderSizePixel = 0
    divider.ZIndex = frame.ZIndex + 2
    divider.Parent = frame

    function self:SetRatio(value: number)
        local scale = dragUtil.scale(frame)
        local length = (if vertical then frame.AbsoluteSize.Y else frame.AbsoluteSize.X) / scale
        local minimum = math.min(opts.minSize or 80, math.max(0, (length - 6) / 2))
        local available = math.max(0, length - 6)
        local position = math.clamp(available * value, minimum, math.max(minimum, available - minimum))
        self.ratio = if available > 0 then position / available else value
        if vertical then
            first.Size = UDim2.new(1, 0, 0, position)
            divider.Position = UDim2.fromOffset(0, position)
            divider.Size = UDim2.new(1, 0, 0, 6)
            second.Position = UDim2.fromOffset(0, position + 6)
            second.Size = UDim2.new(1, 0, 1, -position - 6)
        else
            first.Size = UDim2.new(0, position, 1, 0)
            divider.Position = UDim2.fromOffset(position, 0)
            divider.Size = UDim2.new(0, 6, 1, 0)
            second.Position = UDim2.fromOffset(position + 6, 0)
            second.Size = UDim2.new(1, -position - 6, 1, 0)
        end
    end

    local start, scale, available
    dragUtil.attach(self.scope, divider, function()
        scale = dragUtil.scale(frame)
        local length = (if vertical then frame.AbsoluteSize.Y else frame.AbsoluteSize.X) / scale
        available = math.max(1, length - 6)
        start = self.ratio * available
    end, function(delta)
        local offset = (if vertical then delta.Y else delta.X) / scale
        self:SetRatio((start + offset) / available)
    end)
    self.scope:Connect(frame:GetPropertyChangedSignal("AbsoluteSize"), function() self:SetRatio(self.ratio) end)
    self:SetRatio(self.ratio)
    return self
end

return m
