local m = {}
local ui = require("./UIConstructor")
local lifecycle = require("./Lifecycle")
local buttonMethods = {}
local textboxMethods = {}

function buttonMethods:SetText(value: string)
    self.button.Text = value
end

function buttonMethods:SetEnabled(value: boolean)
    self.enabled = value
    self.button.Active = value
    self.button.AutoButtonColor = value
    self.button.TextTransparency = if value then 0 else 0.5
end

function textboxMethods:GetValue(): string
    return self.button.Text
end

function textboxMethods:SetValue(value: string)
    self.button.Text = value
end

function textboxMethods:SetPlaceholder(value: string)
    self.button.PlaceholderText = value
end

function textboxMethods:SetEnabled(value: boolean)
    self.button.TextEditable = value
end

function textboxMethods:Focus()
    self.button:CaptureFocus()
end

function textboxMethods:OnChanged(callback)
    return self.scope:Connect(self.changed.Event, callback)
end

function textboxMethods:OnSubmitted(callback)
    return self.scope:Connect(self.submitted.Event, callback)
end

function m.button(owner, opts, callback, parent)
    local gui = ui.createButton(parent or owner.contentFrame, opts)
    local self = lifecycle.attach({ button = gui, callback = callback, enabled = true }, gui, owner)
    self.scope:Connect(gui.MouseButton1Click, function()
        if self.enabled and self.callback then self.callback() end
    end)
    for name, method in buttonMethods do self[name] = method end

    return self
end

function m.textbox(owner, opts, callback, parent)
    local gui = ui.createTextbox(parent or owner.contentFrame, opts)
    gui.ClearTextOnFocus = false
    local self = lifecycle.attach({ button = gui, callback = callback }, gui, owner)
    self.changed = lifecycle.event(self)
    self.submitted = lifecycle.event(self)
    self.scope:Connect(gui:GetPropertyChangedSignal("Text"), function()
        self.changed:Fire(gui.Text)
    end)
    self.scope:Connect(gui.FocusLost, function(enterPressed)
        if enterPressed then
            if self.callback then self.callback(gui.Text) end
            self.submitted:Fire(gui.Text)
        end
    end)
    for name, method in textboxMethods do self[name] = method end

    return self
end

return m
