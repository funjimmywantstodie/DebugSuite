local m = {}
local button = require("./Components/Button")
local textbox = require("./Components/Textbox")
local label = require("./Components/Label")
local row = require("./Components/Row")
local console = require("./Components/Console")
local panel = require("./Components/Panel")
local split = require("./Components/SplitPane")
local list = require("./Components/List")
local tree = require("./Components/Tree")
local viewer = require("./Components/TextViewer")
local toggle = require("./Components/Toggle")
local dropdown = require("./Components/Dropdown")
local menu = require("./Components/Menu")
m.__index = m

local function add(self, component)
    self.nextOrder = (self.nextOrder or 0) + 1
    component.frame.LayoutOrder = self.nextOrder
    table.insert(self.components, component)
    return component
end

function m:NewButton(opts, callback)
    return add(self, button.new(self, opts, callback))
end

function m:NewTextbox(opts, callback)
    return add(self, textbox.new(self, opts, callback))
end

function m:NewLabel(opts)
    return add(self, label.new(self, opts))
end

function m:NewRow(opts)
    return add(self, row.new(self, opts))
end

function m:NewConsole(opts)
    return add(self, console.new(self, opts))
end

function m:NewPanel(opts)
    return add(self, m.attach(panel.new(self, opts)))
end

function m:NewSplitPane(opts)
    local component = split.new(self, opts)
    m.attach(component.first)
    m.attach(component.second)
    return add(self, component)
end

function m:NewList(opts)
    return add(self, list.new(self, opts))
end

function m:NewTree(opts)
    return add(self, tree.new(self, opts))
end

function m:NewTextViewer(opts)
    return add(self, viewer.new(self, opts))
end

function m:NewToggle(opts, callback)
    return add(self, toggle.new(self, opts, callback))
end

function m:NewDropdown(opts, callback)
    return add(self, dropdown.new(self, opts, callback))
end

function m:NewMenu(opts)
    return add(self, menu.new(self, opts))
end

function m.attach(self)
    --dont overwrite methods the component already has
    for name, method in m do
        if name ~= "attach" and self[name] == nil then self[name] = method end
    end
    return self
end

return m
