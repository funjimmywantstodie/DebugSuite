local m = {}
local scope = require("./Scope")

function m.attach(self, frame, owner)
    self.frame = frame
    self.scope = scope.new()
    self.conns = self.scope.conns
    self.components = self.components or {}
    self.owner = owner
    self.destroyed = false

    function self:SetVisible(value: boolean)
        self.frame.Visible = value
    end

    if not self.Clear then
        function self:Clear()
            while #self.components > 0 do
                self.components[#self.components]:Destroy()
            end
        end
    end

    function self:Destroy(skipFrame)
        if self.destroyed then return end
        self.destroyed = true
        self:Clear()
        self.scope:Destroy()
        if not skipFrame then self.frame:Destroy() end
        if self.owner then
            local index = table.find(self.owner.components, self)
            if index then table.remove(self.owner.components, index) end
            if self.owner.onRemove then self.owner.onRemove(index) end
        end
    end

    self.scope:Connect(frame.Destroying, function() self:Destroy(true) end)
    return self
end

function m.event(self)
    local event = Instance.new("BindableEvent")
    self.scope:Add(function() event:Destroy() end)
    return event
end

return m
