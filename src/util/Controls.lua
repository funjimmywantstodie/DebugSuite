local m = {}
local ui = require("./UIConstructor")
local lifecycle = require("./Lifecycle")

function m.button(owner, opts, callback, parent)
    local gui = ui.createButton(parent or owner.contentFrame, opts)
    local self = lifecycle.attach({ button = gui, callback = callback, enabled = true }, gui, owner)
    self.scope:Connect(gui.MouseButton1Click, function()
        if self.enabled and self.callback then self.callback() end
    end)

    function self:SetText(value: string)
        gui.Text = value
    end

    function self:SetEnabled(value: boolean)
        self.enabled = value
        gui.Active = value
        gui.AutoButtonColor = value
        gui.TextTransparency = if value then 0 else 0.5
    end

    return self
end

function m.textbox(owner, opts, callback, parent)
    local gui = ui.createTextbox(parent or owner.contentFrame, opts)
    gui.ClearTextOnFocus = false
    local self = lifecycle.attach({ button = gui, callback = callback }, gui, owner)
    local changed = lifecycle.event(self)
    local submitted = lifecycle.event(self)
    self.scope:Connect(gui:GetPropertyChangedSignal("Text"), function()
        changed:Fire(gui.Text)
    end)
    self.scope:Connect(gui.FocusLost, function(enterPressed)
        if enterPressed then
            if self.callback then self.callback(gui.Text) end
            submitted:Fire(gui.Text)
        end
    end)

    function self:GetValue(): string
        return gui.Text
    end

    function self:SetValue(value: string)
        gui.Text = value
    end

    function self:SetPlaceholder(value: string)
        gui.PlaceholderText = value
    end

    function self:SetEnabled(value: boolean)
        gui.TextEditable = value
    end

    function self:Focus()
        gui:CaptureFocus()
    end

    function self:OnChanged(callback)
        return self.scope:Connect(changed.Event, callback)
    end

    function self:OnSubmitted(callback)
        return self.scope:Connect(submitted.Event, callback)
    end

    return self
end

return m
