local m = {}
local colors = require("../Colors")

local function visible(self)
    local current = self.popupAnchor
    while current do
        if current:IsA("GuiObject") and not current.Visible then return false end
        if current:IsA("ScreenGui") and not current.Enabled then return false end
        current = current.Parent
    end
    return true
end

local function setOpen(self, value: boolean)
    local popup = self.popupFrame
    self.open = value and self.enabled ~= false and popup.Size.Y.Offset > 0 and visible(self)
    popup.Visible = self.open
    self.stateLabel.Text = if self.open then "Close ^" else "Open v"
    self.frame.Size = UDim2.new(self.frame.Size.X.Scale, self.frame.Size.X.Offset, 0,
        if self.open then 34 + popup.Size.Y.Offset else 28)
    if self.updateText then self:updateText() end
end

function m.attach(self, popup, anchor)
    popup.Parent = self.frame
    popup.Position = UDim2.fromOffset(8, 34)
    popup.BackgroundTransparency = 0
    popup.BackgroundColor3 = colors.console.background
    popup.BorderSizePixel = 1
    popup.BorderColor3 = colors.sectionHeader
    anchor.TextXAlignment = Enum.TextXAlignment.Left
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 8)
    padding.PaddingRight = UDim.new(0, 76)
    padding.Parent = anchor
    local state = Instance.new("TextLabel")
    state.Name = "State"
    state.BackgroundTransparency = 1
    state.Size = UDim2.fromOffset(64, 28)
    state.Position = UDim2.new(1, -72, 0, 0)
    state.TextColor3 = colors.text
    state.Font = anchor.Font
    state.TextSize = anchor.TextSize
    state.ZIndex = anchor.ZIndex + 1
    state.Parent = self.frame
    self.stateLabel = state
    self.popupFrame = popup
    self.popupAnchor = anchor
    local input = game:GetService("UserInputService")
    local run = game:GetService("RunService")

    self.SetOpen = setOpen
    self:SetOpen(false)
    self.scope:Connect(run.RenderStepped, function()
        if self.open and not visible(self) then self:SetOpen(false) end
    end)
    self.scope:Connect(input.InputBegan, function(key)
        if self.open and key.KeyCode == Enum.KeyCode.Escape then self:SetOpen(false) end
    end)
end

return m
