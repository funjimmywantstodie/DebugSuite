local m = {}
local lifecycle = require("../util/Lifecycle")

function m.new(owner, opts)
    opts = opts or {}
    local frame = Instance.new(if opts.scroll then "ScrollingFrame" else "Frame")
    frame.Name = opts.text or "Panel"
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = opts.clip ~= false
    frame.ZIndex = owner.contentFrame.ZIndex + 1
    frame.Position = opts.position or UDim2.new()
    frame.Size = opts.size or UDim2.new(1, 0, 0, opts.height or 200)
    if opts.auto then
        frame.Size = UDim2.new(1, 0, 0, 0)
        frame.AutomaticSize = Enum.AutomaticSize.Y
    end
    if opts.scroll then
        frame.CanvasSize = UDim2.new()
        frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
        frame.ScrollingDirection = Enum.ScrollingDirection.Y
        frame.ScrollBarThickness = 6
    end
    if opts.minSize or opts.maxSize then
        local constraint = Instance.new("UISizeConstraint")
        if opts.minSize then constraint.MinSize = opts.minSize end
        if opts.maxSize then constraint.MaxSize = opts.maxSize end
        constraint.Parent = frame
    end
    frame.Parent = owner.contentFrame
    local self = lifecycle.attach({}, frame, owner)
    self.contentFrame = frame
    local padding = Instance.new("UIPadding")
    local inset = opts.padding or 8
    padding.PaddingLeft = UDim.new(0, inset)
    padding.PaddingRight = UDim.new(0, inset + (if opts.scroll then 8 else 0))
    padding.PaddingTop = UDim.new(0, inset)
    padding.PaddingBottom = UDim.new(0, inset)
    padding.Parent = frame
    if opts.layout ~= "none" then
        local layout = Instance.new("UIListLayout")
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, opts.gap or 6)
        layout.FillDirection = if opts.layout == "horizontal" then Enum.FillDirection.Horizontal else Enum.FillDirection.Vertical
        layout.Parent = frame
    end
    return self
end

return m
