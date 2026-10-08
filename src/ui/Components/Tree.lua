local m = {}
m.__index = m

local colors = require("../Colors")
local ui = require("../util/UIConstructor")
local lifecycle = require("../util/Lifecycle")
local scope = require("../util/Scope")

local function validate(nodes, loaded)
    local seen = {}
    local function visit(children, ancestors)
        for _, node in children do
            if not ancestors[node] then
                assert(type(node.id) == "string" or type(node.id) == "number", "tree nodes need ids")
                assert(not seen[node.id], "tree nodes need unique ids")
                seen[node.id] = true
                local path = table.clone(ancestors)
                path[node] = true
                visit(loaded[node.id] or node.children or {}, path)
            end
        end
    end
    visit(nodes, {})
end

local function flatten(self)
    self.visibleNodes = {}
    local function visit(nodes, depth, ancestors)
        if depth > self.maxDepth then return end
        for _, node in nodes do
            if not ancestors[node] then
                table.insert(self.visibleNodes, { node = node, depth = depth })
                if self.expanded[node.id] then
                    local path = table.clone(ancestors)
                    path[node] = true
                    visit(self.loaded[node.id] or node.children or {}, depth + 1, path)
                end
            end
        end
    end
    visit(self.nodes, 0, {})
end

local function render(self)
    if self.destroyed then return end
    self.renderScope:Destroy()
    self.renderScope = scope.new()
    for _, row in self.rows do row:Destroy() end
    table.clear(self.rows)
    flatten(self)
    self.emptyLabel.Visible = #self.visibleNodes == 0
    self.frame.CanvasSize = UDim2.fromOffset(0, #self.visibleNodes * 34 + 16)
    local first = math.max(1, math.floor(self.frame.CanvasPosition.Y / 34) + 1)
    local count = math.ceil(self.frame.AbsoluteSize.Y / 34) + 2
    for i = first, math.min(#self.visibleNodes, first + count) do
        local entry = self.visibleNodes[i]
        local node = entry.node
        local canExpand = node.loadChildren ~= nil or (node.children ~= nil and #node.children > 0)
        local indent = entry.depth * 16
        local row = Instance.new("Frame")
        row.Name = "Node"
        row.BackgroundTransparency = 1
        row.BorderSizePixel = 0
        row.Position = UDim2.fromOffset(8 + indent, 8 + (i - 1) * 34)
        row.Size = UDim2.new(1, -24 - indent, 0, 28)
        row.ZIndex = self.frame.ZIndex + 1
        row.Parent = self.frame
        local button = ui.createButton(row, { text = node.text })
        button.TextXAlignment = Enum.TextXAlignment.Left
        button.TextTruncate = Enum.TextTruncate.AtEnd
        button.BackgroundTransparency = if canExpand or node.id == self.selectedId then 0 else 1
        button.BorderSizePixel = if canExpand then 1 else 0
        local padding = Instance.new("UIPadding")
        padding.PaddingLeft = UDim.new(0, 8)
        padding.PaddingRight = UDim.new(0, if canExpand then 88 else 8)
        padding.Parent = button
        if canExpand then
            local state = Instance.new("TextLabel")
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
        end
        table.insert(self.rows, row)
        self.renderScope:Connect(button.MouseButton1Click, function()
            if canExpand then self:Expand(node.id, not self.expanded[node.id]) end
            self:Select(node.id)
        end)
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
    self.renderScope = scope.new()
    self.selected = lifecycle.event(self)
    self.scope:Add(function() self.renderScope:Destroy() end)
    self.scope:Connect(frame:GetPropertyChangedSignal("CanvasPosition"), function() render(self) end)
    self.scope:Connect(frame:GetPropertyChangedSignal("AbsoluteSize"), function() render(self) end)
    return self
end

function m:SetNodes(nodes)
    validate(nodes, {})
    self.nodes = nodes
    self.expanded = {}
    self.loaded = {}
    local hadSelection = self.selectedId ~= nil
    self.selectedId = nil
    self.frame.CanvasPosition = Vector2.zero
    render(self)
    if hadSelection then self.selected:Fire(nil) end
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
            self.expanded[id] = value
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
