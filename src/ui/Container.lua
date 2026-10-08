local m = {}
local button = require("./Components/Button")
local textbox = require("./Components/Textbox")
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

function m.attach(self)
    local function add(component)
        self.nextOrder = (self.nextOrder or 0) + 1
        component.frame.LayoutOrder = self.nextOrder
        table.insert(self.components, component)
        return component
    end

    function self:NewButton(opts, callback)
        return add(button.new(self, opts, callback))
    end

    function self:NewTextbox(opts, callback)
        return add(textbox.new(self, opts, callback))
    end

    function self:NewRow(opts)
        return add(row.new(self, opts))
    end

    function self:NewConsole(opts)
        return add(console.new(self, opts))
    end

    function self:NewPanel(opts)
        return add(m.attach(panel.new(self, opts)))
    end

    function self:NewSplitPane(opts)
        local component = split.new(self, opts)
        m.attach(component.first)
        m.attach(component.second)
        return add(component)
    end

    function self:NewList(opts)
        return add(list.new(self, opts))
    end

    function self:NewTree(opts)
        return add(tree.new(self, opts))
    end

    function self:NewTextViewer(opts)
        return add(viewer.new(self, opts))
    end

    function self:NewToggle(opts, callback)
        return add(toggle.new(self, opts, callback))
    end

    function self:NewDropdown(opts, callback)
        return add(dropdown.new(self, opts, callback))
    end

    function self:NewMenu(opts)
        return add(menu.new(self, opts))
    end

    return self
end

return m
