# Closures

Source: https://docs.sunc.su/Closures/

### checkcaller
`checkcaller(): boolean`
True if current thread originated from the executor (not game code).
**Use:** Inside `hookfunction`/`hookmetamethod` to branch on executor- vs game-initiated calls.

### clonefunction
`clonefunction<A..., R...>(fn: (A...) -> R...): (A...) -> R...`
Clones a function; new copy is unaffected by later modifications to the original.
**Note:** Clone shares the original's environment.

### getfunctionhash
`getfunctionhash(fn: (...any) -> ...any): string`
Hex SHA384 of a Lua function's instructions + constants.
**Note:** C closures unsupported — throws.

### hookfunction
`hookfunction<A1..., R1..., A2..., R2...>(target: (A1...) -> R1..., hook: (A2...) -> R2...): (A1...) -> R1...`
Replaces `target` with `hook`; returns the original (call it to invoke unhooked behaviour).
**Note:** Hook must not have more upvalues than the target. Wrap with `newcclosure` / `newlclosure` to add upvalues.

### hookmetamethod
`hookmetamethod(obj: table | Instance | userdata, name: string, hook: (...any) -> ...any): (...any) -> ...any`
Hooks one metamethod on the object's metatable; returns the original metamethod.
**Note:** Implemented atop `hookfunction`. Common targets: `__index`, `__namecall`.

### iscclosure
`iscclosure(fn: (...any) -> ...any): boolean`
True for C closures (`newcclosure` results, native C fns); false for Lua closures.

### isexecutorclosure
`isexecutorclosure(fn: (...any) -> ...any): boolean`
True for closures the executor created (`getscriptclosure`, `loadstring`, ...). False for built-ins like `print`.

### islclosure
`islclosure(fn: (...any) -> ...any): boolean`
True for Luau closures; false for C closures and built-ins.

### loadstring
`loadstring<A...>(source: string, chunkname: string?): (((A...) -> any) | nil, string?)`
Compiles Luau source. Returns function or `nil, err`.
**Note:** Environment becomes unsafe (uncontrolled `setfenv`/`getfenv` access).

### newcclosure
`newcclosure<A..., R...>(fn: (A...) -> R...): (A...) -> R...`
Wraps a Lua function in a C closure that calls through.
**Note:** Must be yieldable (`task.wait`), no upvalues, errors must appear as C-closure errors. Coroutine-based impls fail sUNC.

### restorefunction
`restorefunction(fn: (...any) -> ...any): ()`
Restores a previously hooked function.
**Note:** Throws if the function was never hooked.
