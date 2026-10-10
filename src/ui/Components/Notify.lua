local m = {}
local colors = require("../Colors")
local lifecycle = require("../util/Lifecycle")
local ui = require("../util/UIConstructor")

function m.new(owner, opts)
    opts = opts or {}
    local level = opts.messageType or "info"
    assert(colors.console[level] and level ~= "background", "invalid notification level")
    local frame = Instance.new("Frame")
    frame.Name = "Notification"
    frame.Size = UDim2.new(1, 0, 0, 106)
    frame.BackgroundColor3 = colors.console.background
    frame.BorderSizePixel = 0
    frame.ZIndex = 310
    frame.Parent = owner.contentFrame
    local self = lifecycle.attach({ text = opts.text, messageType = level }, frame, owner)
    local accent = Instance.new("Frame")
    accent.Size = UDim2.new(0, 3, 1, 0)
    accent.BackgroundColor3 = colors.console[level]
    accent.BorderSizePixel = 0
    accent.ZIndex = 311
    accent.Parent = frame
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Position = UDim2.fromOffset(12, 8)
    label.Size = UDim2.new(1, -24, 0, 60)
    label.Font = Enum.Font.SourceSans
    label.TextSize = 16
    label.TextColor3 = colors.console[level]
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Top
    label.TextWrapped = true
    label.TextTruncate = Enum.TextTruncate.AtEnd
    label.RichText = false
    label.Text = string.upper(level) .. ": " .. (opts.text:match("[^\r\n]*") or "")
    label.ZIndex = 311
    label.Parent = frame
    local dismiss = ui.createButton(frame, { text = "Dismiss" }, 312)
    dismiss.Size = UDim2.fromOffset(76, 24)
    dismiss.Position = UDim2.new(1, -88, 1, -32)
    self.scope:Connect(dismiss.MouseButton1Click, function() self:Destroy() end)
    if opts.onDetails then
        local details = ui.createButton(frame, { text = "Details" }, 312)
        details.Size = UDim2.fromOffset(76, 24)
        details.Position = UDim2.fromOffset(12, 74)
        self.scope:Connect(details.MouseButton1Click, opts.onDetails)
    end
    local duration = opts.duration
    if duration == nil then duration = if level == "error" then 0 else 5 end
    if duration > 0 then
        local elapsed = 0
        self.scope:Connect(game:GetService("RunService").RenderStepped, function(dt)
            elapsed += dt
            if elapsed >= duration then self:Destroy() end
        end)
    end
    return self
end

return m
