-- Freeze arguments at receipt; retain no live argument tables in the history.
local Values = require("./Values")
local m = {}
m.__index = m
function m.new(limit, rate)
    return setmetatable({ records = {}, limit = limit or 500, rate = rate or 100, sequence = 0, dropped = 0, bucket = -1, received = 0, version = 0 }, m)
end
function m:Push(path, arguments, now, kind)
    local bucket = math.floor(now)
    if bucket ~= self.bucket then self.bucket, self.received = bucket, 0 end
    self.received += 1
    self.version += 1
    if self.received > self.rate then self.dropped += 1 return nil end
    if type(path) == "function" then path = path() end
    self.sequence += 1
    local text, truncated = Values.serialize(arguments, { depth = 4, entries = 100, string = 512, bytes = 8192 })
    kind = kind or "incoming event"
    local record = { id = self.sequence, text = string.format("-- Call #%d | %.3fs | %s\n-- %s, %d arguments (n preserves nil slots)\n%s",
            self.sequence, now, path, kind, arguments.n, text),
        values = { time = string.format("%.3f", now), path = path, args = arguments.n, kind = kind, partial = if truncated then "partial" else "" } }
    table.insert(self.records, record)
    if #self.records > self.limit then table.remove(self.records, 1) end
    return record
end
function m:Finish(record, ok, results, duration, modified)
    local text, truncated = Values.serialize(results, { depth = 4, entries = 100, string = 512, bytes = 8192 })
    record.text ..= string.format("\n-- %s | %.3f ms\n%s", if modified then "original returns (n preserves nil slots)"
        elseif ok then "returns (n preserves nil slots)" else "error", duration * 1000, text)
    if modified then
        local replacement, partial = Values.serialize(modified, { depth = 4, entries = 100, string = 512, bytes = 8192 })
        record.text ..= "\n-- modified returns (n preserves nil slots)\n" .. replacement
        truncated = truncated or partial
    end
    record.values.outcome = if modified then "overridden" elseif ok then "returned" else "error"
    record.values.duration = string.format("%.3f", duration * 1000)
    if truncated then record.values.partial = "partial" end
    self.version += 1
end
function m:Clear()
    table.clear(self.records)
    self.dropped, self.received, self.bucket = 0, 0, -1
    self.version += 1
end
return m
