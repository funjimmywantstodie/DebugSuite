local m = {}
m.__index = m

local colors = require("../Colors")
local ui = require("../util/UIConstructor")
local lifecycle = require("../util/Lifecycle")
local scope = require("../util/Scope")

local function validateVisit(children, ancestors, loaded, seen)
    for _, node in children do
        if not ancestors[node] then
            assert(type(node.id) == "string" or type(node.id) == "number", "tree nodes need ids")
            assert(not seen[node.id], "tree nodes need unique ids")
            seen[node.id] = true
            local path = table.clone(ancestors)
            path[node] = true
            validateVisit(loaded[node.id] or node.children or {}, path, loaded, seen)
        end
    end
end

local function validate(nodes, loaded)
    validateVisit(nodes, {}, loaded, {})
end

local function flattenVisit(self, nodes, depth, ancestors)
    if depth > self.maxDepth then return end
    for _, node in nodes do
        if not ancestors[node] then
            table.insert(self.visibleNodes, { node = node, depth = depth })
            if self.expanded[node.id] then
                local path = table.clone(ancestors)
                path[node] = true
                flattenVisit(self, self.loaded[node.id] or node.children or {}, depth + 1, path)
            end
        end
    end
end

local function flatten(self)
    self.visibleNodes = {}
    flattenVisit(self, self.nodes, 0, {})
end

local function render(self, scrolling)
    if self.destroyed then return end
    if not scrolling then
        flatten(self)
        self.emptyLabel.Visible = #self.visibleNodes == 0
        self.frame.CanvasSize = UDim2.fromOffset(0, #self.visibleNodes * 34 + 16)
    end
    local first = math.max(1, math.floor(self.frame.CanvasPosition.Y / 34) + 1)
    local count = math.ceil(self.frame.AbsoluteSize.Y / 34) + 2
    local active = {}
    table.clear(self.rows)
    for i = first, math.min(#self.visibleNodes, first + count) do
        local entry = self.visibleNodes[i]
        local node = entry.node
        local children = self.loaded[node.id] or node.children
        local canExpand = (node.loadChildren ~= nil and self.loaded[node.id] == nil) or (children ~= nil and #children > 0)
        local indent = entry.depth * 16
        local view = self.rowViews[node.id]
        local created = view == nil
        if created then
            local row = Instance.new("Frame")
            row.Name = "Node"
            row.BackgroundTransparency = 1
            row.BorderSizePixel = 0
            row.ZIndex = self.frame.ZIndex + 1
            local button = ui.createButton(row, { text = "" })
            button.TextXAlignment = Enum.TextXAlignment.Left
            button.TextTruncate = Enum.TextTruncate.AtEnd
            local padding = Instance.new("UIPadding")
            padding.PaddingLeft = UDim.new(0, 8)
            padding.Parent = button
            view = { frame = row, button = button, padding = padding, scope = scope.new(), node = node, canExpand = canExpand }
            view.scope:Add(function() if view.stateConnection then view.stateConnection:Disconnect() end end)
            self.rowViews[node.id] = view
            view.scope:Connect(button.MouseButton1Click, function()
                self:Select(view.node.id)
            end)
        end
        active[node.id] = true
        table.insert(self.rows, view.frame)
        if created or not scrolling then
            view.node = node
            view.canExpand = canExpand
            local row, button = view.frame, view.button
            row.Position = UDim2.fromOffset(8 + indent, 8 + (i - 1) * 34)
            row.Size = UDim2.new(1, -24 - indent, 0, 28)
            button.Text = node.text
            button.Name = node.text
            button.Size = UDim2.new(1, if canExpand then -88 else 0, 1, 0)
            button.BackgroundTransparency = if node.id == self.selectedId then 0 else 1
            button.BorderSizePixel = 0
            view.padding.PaddingRight = UDim.new(0, 8)
            if canExpand then
                local state = view.state
                if not state then
                    state = ui.createButton(row, { text = "Expand v" })
                    view.stateConnection = state.MouseButton1Click:Connect(function()
                        local id = view.node.id
                        self:Expand(id, not self.expanded[id])
                    end)
                end
                state.Name = "State"
                state.BackgroundTransparency = 1
                state.Size = UDim2.fromOffset(80, 28)
                state.Position = UDim2.new(1, -84, 0, 0)
                state.Text = if self.expanded[node.id] then "Collapse ^" else "Expand v"
                state.TextColor3 = colors.text
                state.Font = button.Font
                state.TextSize = button.TextSize
                state.ZIndex = button.ZIndex + 1
                state.Parent = row
                view.state = state
            elseif view.state then
                view.stateConnection:Disconnect()
                view.state:Destroy()
                view.state = nil
                view.stateConnection = nil
            end
            if created then row.Parent = self.frame end
        end
    end
    for id, view in self.rowViews do
        if not active[id] then
            view.scope:Destroy()
            view.frame:Destroy()
            self.rowViews[id] = nil
        end
    end
end

function m.new(owner, opts)
    opts = opts or {}
    local frame = Instance.new("ScrollingFrame")
    frame.Name = opts.text or "Tree"
    frame.BackgroundColor3 = colors.console.background
    frame.BorderSizePixel = 0
    frame.Size = opts.size or UDim2.new(1, 0, 0, opts.height or 240)
    frame.CanvasSize = UDim2.new()
    frame.ScrollBarThickness = 6
    frame.ZIndex = owner.contentFrame.ZIndex + 1
    frame.Parent = owner.contentFrame
    local self = lifecycle.attach(setmetatable({}, m), frame, owner)
    self.nodes = {}
    self.expanded = {}
    self.loaded = {}
    self.rows = {}
    self.rowViews = {}
    self.visibleNodes = {}
    self.maxDepth = opts.maxDepth or 32
    local empty = Instance.new("TextLabel")
    empty.Name = "Empty"
    empty.BackgroundTransparency = 1
    empty.Size = UDim2.new(1, -16, 0, 28)
    empty.Position = UDim2.fromOffset(8, 8)
    empty.Text = opts.emptyText or "No items"
    empty.TextXAlignment = Enum.TextXAlignment.Left
    empty.TextColor3 = colors.text
    empty.TextTransparency = 0.35
    empty.TextSize = 14
    empty.ZIndex = frame.ZIndex + 1
    empty.Parent = frame
    self.emptyLabel = empty
    self.selected = lifecycle.event(self)
    self.scope:Add(function()
        for _, view in self.rowViews do view.scope:Destroy() end
        table.clear(self.rowViews)
    end)
    self.scope:Connect(frame:GetPropertyChangedSignal("CanvasPosition"), function() render(self, true) end)
    self.scope:Connect(frame:GetPropertyChangedSignal("AbsoluteSize"), function() render(self) end)
    return self
end

-- preserveState is intended for eager children with stable IDs (live properties).
function m:SetNodes(nodes, preserveState, notify: boolean?)
    validate(nodes, {})
    local selectedId = if preserveState then self.selectedId else nil
    self.nodes = nodes
    if not preserveState then self.expanded = {} end
    self.loaded = {}
    local hadSelection = self.selectedId ~= nil
    self.selectedId = nil
    flatten(self)
    local selected
    for _, entry in self.visibleNodes do
        if entry.node.id == selectedId then selected = entry.node self.selectedId = selectedId break end
    end
    self.frame.CanvasPosition = if preserveState then Vector2.new(self.frame.CanvasPosition.X,
        math.min(self.frame.CanvasPosition.Y, math.max(0, #self.visibleNodes * 34 + 16 - self.frame.AbsoluteSize.Y))) else Vector2.zero
    render(self)
    if notify ~= false then
        if selected then self.selected:Fire(selected)
        elseif hadSelection then self.selected:Fire(nil) end
    end
end

function m:Expand(id, value: boolean)
    flatten(self)
    for _, entry in self.visibleNodes do
        local node = entry.node
        if node.id == id then
            if value and node.loadChildren and not self.loaded[id] then
                local ok, children = pcall(node.loadChildren)
                if not ok then warn(children) return end
                local nextLoaded = table.clone(self.loaded)
                nextLoaded[id] = children or {}
                local valid, err = pcall(validate, self.nodes, nextLoaded)
                if not valid then warn(err) return end
                self.loaded = nextLoaded
            end
            local children = self.loaded[id] or node.children
            self.expanded[id] = value and children ~= nil and #children > 0 or nil
            render(self)
            return
        end
    end
end

function m:Select(id)
    flatten(self)
    for _, entry in self.visibleNodes do
        if entry.node.id == id then
            self.selectedId = id
            render(self)
            self.selected:Fire(entry.node)
            return
        end
    end
end

function m:OnSelected(callback)
    return self.scope:Connect(self.selected.Event, callback)
end

function m:Clear()
    self:SetNodes({})
end

return m
