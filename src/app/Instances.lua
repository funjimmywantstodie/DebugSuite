local Values = require("./Values")
local m = {}
local properties = {
    "Name", "ClassName", "Parent", "Archivable", "Value", "Enabled", "Visible", "Text",
    "Position", "Size", "CFrame", "Color", "Material", "Transparency", "Anchored", "CanCollide",
    "AssemblyLinearVelocity", "Health", "MaxHealth", "WalkSpeed", "RunContext", "DisplayOrder",
}
function m.describe(instance)
    local data = { path = Values.path(instance), properties = {}, attributes = {} }
    for _, name in properties do
        local ok, value = pcall(function() return instance[name] end)
        if ok and value ~= nil then data.properties[name] = value end
    end
    local ok, attributes = pcall(function() return instance:GetAttributes() end)
    if ok then data.attributes = attributes else data.attributeError = tostring(attributes) end
    return data
end
-- Property/attribute names are stable IDs, so live refresh preserves the branch.
function m.propertyNodes(instance, data)
    local function fields(values, prefix)
        local keys, nodes, partial = {}, {}, false
        for key in next, values do
            if #keys >= 200 then partial = true break end
            table.insert(keys, key)
        end
        table.sort(keys)
        for index, key in keys do
            local value = rawget(values, key)
            table.insert(nodes, { id = prefix .. ":" .. key, text = key .. " = " .. Values.preview(value), value = value, inspectable = true })
        end
        if partial then table.insert(nodes, { id = prefix .. ":limit", text = "... first 200 fields shown" }) end
        return nodes
    end
    local children = {
        { id = "path", text = "Path = " .. data.path, value = data.path, inspectable = true },
        { id = "properties", text = "Properties", value = data.properties, inspectable = true, children = fields(data.properties, "property") },
        { id = "attributes", text = "Attributes", value = data.attributes, inspectable = true, children = fields(data.attributes, "attribute") },
    }
    if data.attributeError then table.insert(children, { id = "attributeError", text = "Attributes unavailable: " .. data.attributeError, value = data.attributeError, inspectable = true }) end
    return { { id = "instance", text = Values.preview(instance), value = data, inspectable = true, children = children } }
end
function m.nodes(root, excluded)
    local serial, budget = 0, 2000
    local function node(instance, depth)
        serial += 1
        local entry = { id = serial, text = Values.preview(instance), value = instance }
        local hasChildren = false
        if depth < 32 then
            for _, child in instance:GetChildren() do
                if child ~= excluded then hasChildren = true break end
            end
        end
        if hasChildren then
            entry.loadChildren = function()
                local children, nodes, candidates, partial = instance:GetChildren(), {}, {}, false
                for _, child in children do
                    if child ~= excluded then
                        if #candidates >= budget then partial = true break end
                        table.insert(candidates, child)
                    end
                end
                table.sort(candidates, function(a, b) return a.Name < b.Name end)
                for _, child in candidates do budget -= 1 table.insert(nodes, node(child, depth + 1)) end
                if partial then
                    serial += 1
                    table.insert(nodes, { id = serial, text = "... 2,000-node limit; refresh or use search" })
                end
                return nodes
            end
        end
        return entry
    end
    return { node(root, 0) }
end
return m
