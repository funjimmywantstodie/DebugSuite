-- Comma-separated literals, with CSV-style double quotes; never evaluate input.
local m = {}
function m.parse(text, limit)
    local rules, position, length = {}, 1, #text
    local function skipSpace()
        while position <= length and text:sub(position, position):match("%s") do position += 1 end
    end
    while position <= length do
        skipSpace()
        if position > length then break end
        if text:sub(position, position) == "," then position += 1 continue end
        local kind, value
        local label = "Constant #" .. (#rules + 1) .. ": "
        if text:sub(position, position) == '"' then
            local pieces = {}
            position += 1
            while true do
                local closing = text:find('"', position, true)
                assert(closing, label .. "missing closing double quote")
                table.insert(pieces, text:sub(position, closing - 1))
                position = closing + 1
                if text:sub(position, position) ~= '"' then break end
                table.insert(pieces, '"')
                position += 1
            end
            kind, value = "string", table.concat(pieces)
            skipSpace()
            assert(position > length or text:sub(position, position) == ",", label .. "expected a comma after the quoted string")
        else
            local comma = text:find(",", position, true) or length + 1
            local token = text:sub(position, comma - 1):match("^%s*(.-)%s*$")
            assert(not token:find('"', 1, true), label .. 'wrap text containing double quotes in quotes and double each inner quote')
            position = comma
            if token == "true" or token == "false" then
                kind, value = "boolean", token == "true"
            else
                local number = tonumber(token)
                if number then
                    assert(number == number and math.abs(number) < math.huge, label .. "number must be finite")
                    kind, value = "number", number
                else kind, value = "string", token end
            end
        end
        assert(#rules < (limit or 16), "At most " .. (limit or 16) .. " constant filters; remove some comma-separated values")
        table.insert(rules, { kind = kind, value = value })
        position += 1
    end
    return rules
end
return m
