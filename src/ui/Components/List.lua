local m = {}
m.__index = m

local colors = require("../Colors")
local ui = require("../util/UIConstructor")
local lifecycle = require("../util/Lifecycle")
local scope = require("../util/Scope")

local function render(self)
    if self.destroyed then return end
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
    local offset = 0
    for i, header in self.headers do
        header.Position = UDim2.fromOffset(offset - self.viewport.CanvasPosition.X, 0)
        header.Size = UDim2.fromOffset(self.widths[i], 28)
        offset += self.widths[i]
    end
    local height = self.rowHeight
    local first = math.max(1, math.floor(self.viewport.CanvasPosition.Y / height) + 1)
    local count = math.ceil(self.viewport.AbsoluteSize.Y / height) + 2
    self.viewport.CanvasSize = UDim2.fromOffset(if self.width > available then self.width else 0, #self.filtered * height)
    local last = math.min(#self.filtered, first + count)
    for index, entry in self.rowEntries do
        if index < first or index > last then
            entry.scope:Destroy()
            entry.frame:Destroy()
            self.rowEntries[index] = nil
        end
    end
    table.clear(self.rows)
    for index = first, last do
        local record = self.filtered[index]
        local entry = self.rowEntries[index]
        if not entry then
            local row = Instance.new("Frame")
            row.BorderSizePixel = 0
            row.ClipsDescendants = true
            row.ZIndex = self.viewport.ZIndex + 1
            entry = { frame = row, cells = {}, scope = scope.new() }
            self.rowEntries[index] = entry
            for _, column in self.columns do
                local cell = ui.createButton(row, { text = "" })
                cell.TextXAlignment = Enum.TextXAlignment.Left
                cell.TextTruncate = Enum.TextTruncate.AtEnd
                cell.BackgroundTransparency = 1
                cell.BorderSizePixel = 0
                entry.scope:Connect(cell.MouseButton1Click, function() self:Select(entry.record.id) end)
                local padding = Instance.new("UIPadding")
                padding.PaddingLeft = UDim.new(0, 8)
                padding.PaddingRight = UDim.new(0, 8)
                padding.Parent = cell
                table.insert(entry.cells, cell)
            end
        end
        entry.record = record
        local row = entry.frame
        row.Size = UDim2.fromOffset(math.max(self.width, self.viewport.AbsoluteSize.X - 8), height)
        row.Position = UDim2.fromOffset(0, (index - 1) * height)
        row.BackgroundColor3 = if record.id == self.selectedId then colors.sectionHeader else colors.section
        table.insert(self.rows, row)
        local offset = 0
        for i, column in self.columns do
            local value = record.values[column.key]
            local cell = entry.cells[i]
            cell.Text = if value == nil then "" else tostring(value)
            cell.Position = UDim2.fromOffset(offset, 0)
            cell.Size = UDim2.new(0, self.widths[i], 1, 0)
            offset += self.widths[i]
        end
        if row.Parent ~= self.viewport then row.Parent = self.viewport end
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
    self.rowEntries = {}
    self.headers = {}
    self.columns = opts.columns or { { key = "text", text = "Text" } }
    self.rowHeight = math.max(16, opts.rowHeight or 26)
    self.maxRecords = math.max(1, opts.maxRecords or 5000)
    self.filter = ""
    self.selected = lifecycle.event(self)
    self.scope:Add(function()
        for _, entry in self.rowEntries do entry.scope:Destroy() end
        table.clear(self.rowEntries)
        table.clear(self.rows)
    end)
    local viewport = Instance.new("ScrollingFrame")
    local showHeader = opts.showHeader ~= false
    local viewportTop = if showHeader then 42 else 8
    viewport.BackgroundTransparency = 1
    viewport.BorderSizePixel = 0
    viewport.Position = UDim2.fromOffset(8, viewportTop)
    viewport.Size = UDim2.new(1, -16, 1, -(viewportTop + 8))
    viewport.CanvasSize = UDim2.new()
    viewport.ScrollBarThickness = 6
    viewport.ZIndex = frame.ZIndex + 1
    viewport.Parent = frame
    self.viewport = viewport
    local headerFrame = Instance.new("Frame")
    headerFrame.Visible = showHeader
    headerFrame.BackgroundTransparency = 1
    headerFrame.ClipsDescendants = true
    headerFrame.Position = UDim2.fromOffset(8, 8)
    headerFrame.Size = UDim2.new(1, -24, 0, 28)
    headerFrame.ZIndex = frame.ZIndex + 1
    headerFrame.Parent = frame
    local offset = 0
    for _, column in (if showHeader then self.columns else {}) do
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
    self.scope:Connect(viewport:GetPropertyChangedSignal("CanvasPosition"), function() render(self) end)
    self.scope:Connect(viewport:GetPropertyChangedSignal("AbsoluteSize"), function() render(self) end)
    return self
end

function m:Refresh()
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
    if self.selectedId and not selected then
        self.selectedId = nil
        self.selectedRecord = nil
        self.selected:Fire(nil)
    end
    if selected and selected ~= self.selectedRecord then
        self.selectedRecord = selected
        self.selected:Fire(selected)
    end
    self.viewport.CanvasPosition = Vector2.new(self.viewport.CanvasPosition.X, math.min(self.viewport.CanvasPosition.Y,
        math.max(0, #self.filtered * self.rowHeight - self.viewport.AbsoluteSize.Y)))
    render(self)
end

function m:SetRecords(records)
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
    self:Refresh()
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

function m:SetFilter(value: string)
    self.filter = string.lower(value)
    self:Refresh()
end

function m:SetSort(key: string, ascending: boolean?)
    self.sortKey = key
    self.ascending = ascending ~= false
    self:Refresh()
end

function m:Select(id)
    for _, record in self.filtered do
        if record.id == id then
            self.selectedId = id
            self.selectedRecord = record
            render(self)
            self.selected:Fire(record)
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
