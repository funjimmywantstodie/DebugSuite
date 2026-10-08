
--[[AI]]

-- Standalone Lua/Luau lexer and Roblox RichText renderer. No UI instances required.
local m = {}

m.theme = {
    keyword = "#C586C0", builtin = "#4EC9B0", string = "#CE9178",
    comment = "#6A9955", number = "#B5CEA8", operator = "#D4D4D4",
}

local function words(value)
    local result = {}
    for word in value:gmatch("%S+") do result[word] = true end
    return result
end

local keywords = words("and break do else elseif end false for function if in local nil not or repeat return then true until while continue")
local builtins = words("assert error ipairs next pairs pcall print rawequal rawget rawset select setmetatable getmetatable tonumber tostring type unpack xpcall collectgarbage require warn typeof game workspace script Enum Instance Color3 Vector2 Vector3 UDim UDim2 CFrame math string table coroutine utf8 os bit32 task buffer")
local operators = words("... .. ..= // //= == ~= <= >= += -= *= /= %= ^= :: ->")

function m.Escape(value: string): string
    local escaped = value:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")
        :gsub('"', "&quot;"):gsub("'", "&apos;")
    return escaped
end

-- Returns the byte after a long-bracket literal, including unfinished literals.
local function longBracket(source, position)
    local equals = source:sub(position):match("^%[(=*)%[")
    if not equals then return nil end
    local _, finish = source:find("]" .. equals .. "]", position + #equals + 2, true)
    return finish and finish + 1 or #source + 1
end

function m.Tokenize(source: string)
    local tokens = {}
    local position, length = 1, #source
    while position <= length do
        local start = position
        local char = source:sub(position, position)
        local kind
        if char:match("%s") then
            kind = "whitespace"
            repeat position += 1 until position > length or not source:sub(position, position):match("%s")
        elseif source:sub(position, position + 1) == "--" then
            kind = "comment"
            position = longBracket(source, position + 2) or source:find("[\r\n]", position + 2) or length + 1
        elseif char == '"' or char == "'" or char == "`" then
            kind = "string"
            position += 1
            while position <= length do
                local current = source:sub(position, position)
                if current == "\\" then
                    position = math.min(position + 2, length + 1)
                elseif current == char then
                    position += 1
                    break
                elseif char ~= "`" and (current == "\n" or current == "\r") then
                    break
                else
                    position += 1
                end
            end
        elseif char == "[" and longBracket(source, position) then
            kind = "string"
            position = longBracket(source, position)
        elseif char:match("[%a_]") then
            position += 1
            while position <= length and source:sub(position, position):match("[%w_]") do position += 1 end
            local word = source:sub(start, position - 1)
            kind = keywords[word] and "keyword" or builtins[word] and "builtin" or "identifier"
        elseif char:match("%d") or (char == "." and source:sub(position + 1, position + 1):match("%d")) then
            kind = "number"
            local rest = source:sub(position)
            local number = rest:match("^0[xX][%da-fA-F_]+") or rest:match("^0[bB][01_]+")
            if number then
                position += #number
                if number:match("^0[xX]") then
                    if source:sub(position, position) == "." and source:sub(position + 1, position + 1) ~= "." then
                        position += 1
                        position += #(source:sub(position):match("^[%da-fA-F_]+") or "")
                    end
                    position += #(source:sub(position):match("^[pP][+-]?%d[%d_]*") or "")
                end
            else
                local whole = rest:match("^%d[%d_]*") or ""
                position += #whole
                if source:sub(position, position) == "." and source:sub(position + 1, position + 1) ~= "." then
                    position += 1
                    local fraction = source:sub(position):match("^[%d_]+") or ""
                    position += #fraction
                end
                local exponent = source:sub(position):match("^[eE][+-]?%d[%d_]*")
                if exponent then position += #exponent end
            end
        else
            kind = "operator"
            local three = source:sub(position, position + 2)
            local two = source:sub(position, position + 1)
            position += operators[three] and 3 or operators[two] and 2 or 1
        end
        table.insert(tokens, { kind = kind, text = source:sub(start, position - 1), start = start, finish = position - 1 })
    end
    return tokens
end

-- Theme overrides use hex RGB strings, e.g. { keyword = "#FF80AA" }.
function m.Highlight(source: string, theme): string
    local output = {}
    for _, token in m.Tokenize(source) do
        local value = m.Escape(token.text)
        local color = (theme and theme[token.kind]) or m.theme[token.kind]
        if color then
            assert(type(color) == "string" and color:match("^#%x%x%x%x%x%x$"), "syntax colors must be #RRGGBB strings")
            value = '<font color="' .. color .. '">' .. value .. '</font>'
        end
        table.insert(output, value)
    end
    return table.concat(output)
end

function m.ValidateSyntax(syntax)
    assert(syntax == nil or syntax == false or syntax == "lua" or syntax == "luau", "syntax must be lua, luau, false, or nil")
    return syntax == "lua" or syntax == "luau"
end

return m
