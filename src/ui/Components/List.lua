local m = {}
m.__index = m

local colors = require("../Colors")
local ui = require("../util/UIConstructor")
local lifecycle = require("../util/Lifecycle")
local scope = require("../util/Scope")
local syntaxHighlight = require("../SyntaxHighlight")

local function render(self, scrolling)
    if self.destroyed then return end
    if not scrolling then
        local fixed, flexible = 0, 0
        for _, column in self.columns do
            if column.width then fixed += column.width else flexible += 1 end
        end
        local available = math.max(0, self.viewport.AbsoluteSize.X - 8)
        local fillWidth = if flexible > 0 then math.max(60, (available - fixed) / flexible) else 0
        self.widths = {}
        self.width = 0
        for i, column in self.columns do
            self.widths[i] = column.width or fillWidth
            self.width += self.widths[i]
        end
        self.viewport.CanvasSize = UDim2.fromOffset(if self.width > available then self.width else 0, #self.filtered * self.rowHeight)
    end
    local offset = 0
    for i, header in self.headers do
        header.Position = UDim2.fromOffset(offset - self.viewport.CanvasPosition.X, 0)
        header.Size = UDim2.fromOffset(self.widths[i], 28)
        offset += self.widths[i]
    end
    local height = self.rowHeight
    local first = math.max(1, math.floor(self.viewport.CanvasPosition.Y / height) + 1)
    local count = math.ceil(self.viewport.AbsoluteSize.Y / height) + 2
    local active = {}
    table.clear(self.rows)
    for index = first, math.min(#self.filtered, first + count) do
        local record = self.filtered[index]
        local view = self.rowViews[record.id]
        local created = view == nil
        if created then
            local row = Instance.new("Frame")
            row.BorderSizePixel = 0
            row.ClipsDescendants = true
            row.ZIndex = self.viewport.ZIndex + 1
            view = { frame = row, cells = {}, scope = scope.new(), record = record }
            self.rowViews[record.id] = view
            for _, column in self.columns do
                local cell = ui.createButton(row, { text = "" })
                cell.TextXAlignment = Enum.TextXAlignment.Left
                cell.RichText = syntaxHighlight.ValidateSyntax(column.syntax)
                if cell.RichText then cell.Font = Enum.Font.Code end
                cell.TextTruncate = Enum.TextTruncate.AtEnd
                cell.BackgroundTransparency = 1
                cell.BorderSizePixel = 0
                view.scope:Connect(cell.MouseButton1Click, function() self:Select(view.record.id) end)
                local padding = Instance.new("UIPadding")
                padding.PaddingLeft = UDim.new(0, 8)
                padding.PaddingRight = UDim.new(0, 8)
                padding.Parent = cell
                table.insert(view.cells, cell)
            end
        end
        active[record.id] = true
        table.insert(self.rows, view.frame)
        if created or not scrolling then
            view.record = record
            local row = view.frame
            row.Size = UDim2.fromOffset(math.max(self.width, self.viewport.AbsoluteSize.X - 8), height)
            row.Position = UDim2.fromOffset(0, (index - 1) * height)
            row.BackgroundColor3 = if record.id == self.selectedId then colors.sectionHeader else colors.section
            local offset = 0
            for i, column in self.columns do
                local value = record.values[column.key]
                local cell = view.cells[i]
                local raw = if value == nil then "" else tostring(value)
                -- Styling is display-only: filtering, selection and sorting use raw values.
                cell.Text = if cell.RichText then syntaxHighlight.Highlight(raw) else raw
                cell.Name = raw
                cell.Position = UDim2.fromOffset(offset, 0)
                cell.Size = UDim2.new(0, self.widths[i], 1, 0)
                offset += self.widths[i]
            end
            if created then row.Parent = self.viewport end
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
    local frame = Instance.new("Frame")
    frame.Name = opts.text or "List"
    frame.BackgroundColor3 = colors.console.background
    frame.BorderSizePixel = 0
    frame.Size = opts.size or UDim2.new(1, 0, 0, opts.height or 240)
    frame.ZIndex = owner.contentFrame.ZIndex + 1
    frame.Parent = owner.contentFrame
    local self = lifecycle.attach(setmetatable({}, m), frame, owner)
    self.records = {}
    self.filtered = {}
    self.rows = {}
    self.rowViews = {}
    self.headers = {}
    self.columns = opts.columns or { { key = "text", text = "Text" } }
    self.rowHeight = math.max(16, opts.rowHeight or 26)
    self.maxRecords = math.max(1, opts.maxRecords or 5000)
    self.filter = ""
    self.selected = lifecycle.event(self)
    self.scope:Add(function()
        for _, view in self.rowViews do view.scope:Destroy() end
        table.clear(self.rowViews)
    end)
    local viewport = Instance.new("ScrollingFrame")
    viewport.BackgroundTransparency = 1
    viewport.BorderSizePixel = 0
    viewport.Position = UDim2.fromOffset(8, 42)
    viewport.Size = UDim2.new(1, -16, 1, -50)
    viewport.CanvasSize = UDim2.new()
    viewport.ScrollBarThickness = 6
    viewport.ZIndex = frame.ZIndex + 1
    viewport.Parent = frame
    self.viewport = viewport
    local headerFrame = Instance.new("Frame")
    headerFrame.BackgroundTransparency = 1
    headerFrame.ClipsDescendants = true
    headerFrame.Position = UDim2.fromOffset(8, 8)
    headerFrame.Size = UDim2.new(1, -24, 0, 28)
    headerFrame.ZIndex = frame.ZIndex + 1
    headerFrame.Parent = frame
    local offset = 0
    for _, column in self.columns do
        local header = ui.createButton(headerFrame, { text = column.text or column.key })
        table.insert(self.headers, header)
        header.Position = UDim2.fromOffset(offset, 0)
        header.Size = UDim2.fromOffset(column.width or 120, 28)
        header.TextXAlignment = Enum.TextXAlignment.Left
        local padding = Instance.new("UIPadding")
        padding.PaddingLeft = UDim.new(0, 8)
        padding.PaddingRight = UDim.new(0, 8)
        padding.Parent = header
        self.scope:Connect(header.MouseButton1Click, function()
            self:SetSort(column.key, self.sortKey ~= column.key or not self.ascending)
        end)
        offset += column.width or 120
    end
    self.width = offset
    render(self)
    self.scope:Connect(viewport:GetPropertyChangedSignal("CanvasPosition"), function() render(self, true) end)
    self.scope:Connect(viewport:GetPropertyChangedSignal("AbsoluteSize"), function() render(self) end)
    return self
end

-- notify=false updates selection state without dispatching a selection event.
function m:Refresh(notify: boolean?)
    table.clear(self.filtered)
    for _, record in self.records do
        local matches = self.filter == ""
        for _, value in record.values do
            if string.find(string.lower(tostring(value)), self.filter, 1, true) then matches = true end
        end
        if matches then table.insert(self.filtered, record) end
    end
    if self.sortKey then
        table.sort(self.filtered, function(a, b)
            local av, bv = a.values[self.sortKey], b.values[self.sortKey]
            if type(av) ~= "number" or type(bv) ~= "number" then
                av, bv = tostring(av or ""), tostring(bv or "")
            end
            return if self.ascending then av < bv else av > bv
        end)
    end
    local selected
    for _, record in self.filtered do if record.id == self.selectedId then selected = record end end
    local previous, hadSelection = self.selectedRecord, self.selectedId ~= nil
    self.selectedId = if selected then selected.id else nil
    self.selectedRecord = selected
    if notify ~= false and (selected ~= previous or (hadSelection and not selected)) then
        self.selected:Fire(selected)
    end
    self.viewport.CanvasPosition = Vector2.new(self.viewport.CanvasPosition.X, math.min(self.viewport.CanvasPosition.Y,
        math.max(0, #self.filtered * self.rowHeight - self.viewport.AbsoluteSize.Y)))
    render(self)
end

function m:SetRecords(records, notify: boolean?)
    local seen = {}
    local nextRecords = {}
    local start = math.max(1, #records - self.maxRecords + 1)
    for i, record in records do
        assert(type(record.id) == "string" or type(record.id) == "number", "list records need ids")
        assert(not seen[record.id], "list records need unique ids")
        assert(type(record.values) == "table", "list records need values")
        seen[record.id] = true
        if i >= start then table.insert(nextRecords, record) end
    end
    self.records = nextRecords
    self:Refresh(notify)
end

function m:Append(records)
    local nextRecords = table.clone(self.records)
    local positions = {}
    for i, record in nextRecords do positions[record.id] = i end
    for _, record in records do
        assert(record.id ~= nil, "list records need ids")
        local index = positions[record.id]
        if index then
            nextRecords[index] = record
        else
            table.insert(nextRecords, record)
            positions[record.id] = #nextRecords
        end
    end
    self:SetRecords(nextRecords)
end

function m:SetFilter(value: string, notify: boolean?)
    self.filter = string.lower(value)
    self:Refresh(notify)
end

function m:SetSort(key: string, ascending: boolean?)
    self.sortKey = key
    self.ascending = ascending ~= false
    self:Refresh()
end

function m:Select(id, notify: boolean?)
    for _, record in self.filtered do
        if record.id == id then
            self.selectedId = id
            self.selectedRecord = record
            render(self)
            if notify ~= false then self.selected:Fire(record) end
            return
        end
    end
end

function m:OnSelected(callback)
    return self.scope:Connect(self.selected.Event, callback)
end

function m:Clear()
    self:SetRecords({})
end

return m
