# Metatable

Source: https://docs.sunc.su/Metatable/

### getrawmetatable
`getrawmetatable(obj: table | userdata): table | nil`
Raw metatable, bypassing `__metatable` protection. `nil` if none.

### setrawmetatable
`setrawmetatable<T>(obj: T & (table | userdata), mt: table): T`
Force-assign metatable, bypassing `__metatable`. Returns `obj`.

### isreadonly
`isreadonly(t: table): boolean`
True if table is locked against writes.
**Note:** `getrawmetatable(game)` is readonly; empty tables are not.

### setreadonly
`setreadonly(t: table, state: boolean): ()`
Lock (`true`) or unlock (`false`) writes to table.

### getnamecallmethod
`getnamecallmethod(): string?`
Inside a `__namecall` hook, returns the method name (e.g. `"FireServer"`). `nil` elsewhere.
