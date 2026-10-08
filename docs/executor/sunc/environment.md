# Environment

Source: https://docs.sunc.su/Environment/

### getgc
```lua
getgc(includeTables: true): { table | function | userdata }
getgc(includeTables: false?): { function | userdata }
```
All live GC values. Tables excluded by default.

### getgenv
`getgenv(): { [any]: any }`
Executor's shared global env. Writable, persistent across the session. Independent of any thread's fenv.

### getrenv
`getrenv(): { [any]: any }`
Roblox game-side global env. Mutations are visible to game scripts.
**Note:** Detection vector if poorly implemented — `_G` / `shared` must integrate cleanly.

### getreg
`getreg(): { [any]: any }`
Luau registry — threads, C↔Luau shared refs, internal pinned objects.

### filtergc
```lua
function filtergc(filterType: string, filterOptions: table, filterOne: boolean): {any} | any?
```
Returns a table of objects filtered from the garbage collection list. If `filterOne`
is `true`, a single matching object is returned instead (or `nil` if none match).
`filterType` is `"function"` or `"table"` — these are the only accepted values,
each with its own filter-option shape.

**Function filter options:**
| Field | Type | Meaning |
|---|---|---|
| `IgnoreExecutor` | `boolean?` | exclude executor-created fns (default `true`) |
| `Name` | `string?` | function `__name` matches |
| `Hash` | `string?` | `getfunctionhash` match |
| `Environment` | `table?` | function's environment table matches |
| `StartLine` | `number?` | line number the function is defined on |
| `Constants` | `{ any }?` | bytecode contains all listed constants |
| `Upvalues` | `{ any }?` | function has all listed upvalues |

**Table filter options:**
| Field | Type | Meaning |
|---|---|---|
| `Keys` | `{ any }?` | table contains **all** listed keys |
| `Values` | `{ any }?` | table contains **all** listed values |
| `KeyValuePairs` | `{ [any]: any }?` | table contains **all** k/v pairs |
| `Metatable` | `table?` | metatable identity match |

```lua
-- function filter example
local filterOptions = { IgnoreExecutor = false, Name = "exampleFunction" }
local found = filtergc("function", filterOptions, true)

-- table filter example
local filterOptions = { Keys = { "myKey" } }
local found = filtergc("table", filterOptions, true)
```

Each call does its own GC walk scoped to the requested `filterType` — filtering
for both functions and tables costs two calls, same as calling `getgc(true)`
once and splitting the result by `type()` yourself costs one. Prefer `filtergc`
when you want native `IgnoreExecutor`/`Name`/`Hash`/etc. filtering to avoid
per-item Luau-side checks; prefer a single `getgc(true)` walk when you need
both types and don't need the extra filter criteria.
