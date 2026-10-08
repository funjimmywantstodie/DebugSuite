local m = {}
local ui = require("../util/UIConstructor")
local lifecycle = require("../util/Lifecycle")
local popupUtil = require("../util/Popup")

function m.new(owner, opts)
    local frame = Instance.new("Frame")
    frame.Name = opts.text
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 0, 28)
    frame.ZIndex = owner.contentFrame.ZIndex + 1
    frame.Parent = owner.contentFrame
    local self = lifecycle.attach({ enabled = true }, frame, owner)
    local button = ui.createButton(frame, opts)
    self.button = button
    local text = opts.text
    self.updateText = function()
        button.Text = text
    end
    local popup = Instance.new("Frame")
    popup.BackgroundTransparency = 1
    popup.BorderSizePixel = 0
    popup.Size = UDim2.new(1, -16, 0, if #opts.items > 0 then #opts.items * 34 + 10 else 0)
    popup.ZIndex = frame.ZIndex + 1
    popup.Visible = false
    popupUtil.attach(self, popup, button)
    for i, item in opts.items do
        local action = ui.createButton(popup, { text = item.text })
        action.Position = UDim2.fromOffset(8, 8 + (i - 1) * 34)
        action.Size = UDim2.new(1, -16, 0, 28)
        action.TextXAlignment = Enum.TextXAlignment.Left
        local padding = Instance.new("UIPadding")
        padding.PaddingLeft = UDim.new(0, 8)
        padding.PaddingRight = UDim.new(0, 8)
        padding.Parent = action
        action.Active = item.enabled ~= false
        action.TextTransparency = if item.enabled == false then 0.5 else 0
        self.scope:Connect(action.MouseButton1Click, function()
            if not self.enabled or item.enabled == false then return end
            self:SetOpen(false)
            item.callback()
        end)
    end

    function self:SetText(value: string)
        text = value
        self.updateText()
    end

    function self:SetEnabled(value: boolean)
        self.enabled = value
        button.Active = value
        button.AutoButtonColor = value
        button.TextTransparency = if value then 0 else 0.5
        if not value then self:SetOpen(false) end
    end

    self.callback = function() self:SetOpen(not self.open) end
    self.scope:Connect(button.MouseButton1Click, function()
        if self.enabled then self.callback() end
    end)
    return self
end

return m
