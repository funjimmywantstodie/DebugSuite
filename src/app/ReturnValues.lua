-- Literal scalar values only; never evaluate editor text as code.
local m = { limit = 16 }
function m.parse(kind, text)
    if kind == "nil" then return nil end
    if kind == "string" then return text end
    if kind == "boolean" then
        assert(text == "true" or text == "false", "Boolean must be true or false")
        return text == "true"
    end
    assert(kind == "number", "Unknown return type")
    local value = tonumber(text)
    assert(value and value == value and math.abs(value) < math.huge, "Number must be finite")
    return value
end
function m.copy(values)
    assert(type(values) == "table" and type(values.n) == "number" and values.n % 1 == 0
        and values.n >= 0 and values.n <= m.limit, "Return count must be 0 to 16")
    local result = { n = values.n }
    for i = 1, values.n do
        local value = values[i]
        local kind = type(value)
        assert(kind == "nil" or kind == "string" or kind == "boolean" or kind == "number", "Return #" .. i .. " must be a scalar")
        if kind == "number" then assert(value == value and math.abs(value) < math.huge, "Return #" .. i .. " must be finite") end
        result[i] = value
    end
    return result
end
return m
