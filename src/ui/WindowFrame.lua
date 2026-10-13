local m = {}

m.__index = m

local colors = require("./Colors")
local lifecycle = require("./util/Lifecycle")
local drag = require("./util/Drag")
local ui = require("./util/UIConstructor")
local container = require("./Container")

function m:Focus()
    self.focusManager:Focus(self)
end

function m:SetVisible(value)
    if self.destroyed then return end
    self.frame.Visible = value
    if value then self:Focus() end
end

function m:Show()
    self:SetVisible(true)
end

function m:Hide()
    self:SetVisible(false)
end

function m:Toggle()
    self:SetVisible(not self.frame.Visible)
end

function m:AddTopbarButton(name, text, callback, width)
    local button = ui.createButton(self.guis.Topbar, { text = text }, 15)
    button.Name = name
    button.Size = UDim2.fromOffset(width or 60, 22)
    self.actionWidth += (width or 60) + 5
    button.Position = UDim2.new(1, -self.actionWidth, 0, 5)
    self.title.Size = UDim2.new(1, -self.actionWidth - 15, 1, 0)
    self.scope:Connect(button.MouseButton1Click, callback)
    self.focusManager:BindPress(self.scope, button)
    return button
end

function m.new(screen, opts, focusManager, owner)
    opts = opts or {}
    local root = Instance.new("Frame")
    root.Name = opts.name or "Root"
    root.Size = opts.size or UDim2.fromScale(.5, .5)
    root.AnchorPoint = Vector2.new(.5, .5)
    root.Position = opts.position or UDim2.fromScale(.5, .5)
    root.BackgroundColor3 = opts.backgroundColor or colors.component
    root.BorderSizePixel = 0
    root.Active = true
    root.Visible = opts.visible ~= false
    root.Parent = screen

    local self = lifecycle.attach(setmetatable({}, m), root, owner)
    self.SetVisible = m.SetVisible
    self.focusManager = focusManager
    focusManager:BindPress(self.scope, root)
    self.minimum = opts.minSize or Vector2.new(400, 260)
    self.guis = { ScreenGui = screen, Root = root }
    local constraint = Instance.new("UISizeConstraint")
    constraint.MinSize = self.minimum
    constraint.Parent = root

    local topbar = Instance.new("Frame")
    topbar.Name = "Topbar"
    topbar.Size = UDim2.new(1, 0, 0, 32)
    topbar.BackgroundColor3 = colors.topbar
    topbar.BorderSizePixel = 0
    topbar.ZIndex = 10
    topbar.Parent = root
    self.guis.Topbar = topbar

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Text = opts.title or ""
    title.TextColor3 = colors.text
    title.BackgroundTransparency = 1
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Position = UDim2.fromOffset(10, 0)
    title.Size = UDim2.new(1, -42, 1, 0)
    title.ZIndex = 11
    title.Parent = topbar
    self.title = title
    self.actionWidth = 27

    local close = ui.createButton(topbar, { text = "X" }, 15)
    close.Name = "CloseButton"
    close.Size = UDim2.fromOffset(22, 22)
    close.Position = UDim2.new(1, -27, 0, 5)
    close.BackgroundColor3 = colors.closeButton
    focusManager:BindPress(self.scope, close)
    self.scope:Connect(close.MouseButton1Click, function()
        if opts.onClose then
            opts.onClose(self)
        elseif opts.closeBehavior == "hide" then
            self:Hide()
        else
            self:Destroy()
        end
    end)

    local start, scale
    drag.attach(self.scope, topbar, function()
        start = root.Position
        scale = drag.scale(root.Parent)
    end, function(delta)
        root.Position = UDim2.new(start.X.Scale, start.X.Offset + delta.X / scale,
            start.Y.Scale, start.Y.Offset + delta.Y / scale)
    end, function(event)
        return focusManager:CanStartDrag(self, topbar, event)
    end)

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.BackgroundTransparency = 1
    content.Position = UDim2.fromOffset(0, 32)
    content.Size = UDim2.new(1, 0, 1, -32)
    content.ZIndex = 9
    content.Parent = root
    self.contentFrame = content
    container.attach(self)

    local resize = Instance.new("Frame")
    resize.Name = "Resize"
    resize.Size = UDim2.fromOffset(16, 16)
    resize.Position = UDim2.new(1, -16, 1, -16)
    resize.BackgroundColor3 = colors.sectionHeader
    resize.BorderSizePixel = 0
    resize.ZIndex = 200
    resize.Parent = root
    drag.attachResize(self.scope, resize, root, self.minimum, function(event)
        return focusManager:CanStartDrag(self, resize, event)
    end)
    focusManager:Register(self)
    return self
end

return m
