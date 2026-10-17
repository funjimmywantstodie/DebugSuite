--ai math stuff
local m = {}
m.Name = "ResizeSections"

local drag = require("./Drag")

function m.init(window, header, columns)
    -- Use the starting heights to keep the same proportions when resizing
    local weights = {}
    for i, column in columns do
        weights[i] = {}
        for j, view in column do
            weights[i][j] = view.frame.Size.Y.Offset + 40
        end
    end

    local function resize()
        -- Sections have a 24px header and 8px padding on each edge
        -- Leave room for the host's 5px padding and gaps
        local height = window.container.AbsoluteSize.Y / drag.scale(window.container)
        local available = height - header.frame.Size.Y.Offset - 15
        for i, column in columns do
            local total = 0
            for _, weight in weights[i] do
                total += weight
            end
            local remaining = math.max(0, available - (#column - 1) * 5)
            local used = 0
            for j, view in column do
                local share
                if j == #column then
                    share = remaining - used
                else
                    share = math.floor(remaining * weights[i][j] / total)
                end
                used += share
                local size = view.frame.Size
                view.frame.Size = UDim2.new(size.X.Scale, size.X.Offset, 0, math.max(34, share - 40))
            end
        end
    end

    window.scope:Connect(window.container:GetPropertyChangedSignal("AbsoluteSize"), resize)
    window.scope:Connect(header.frame:GetPropertyChangedSignal("Size"), resize)
    resize()
end

return m
