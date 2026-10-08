# Scripts

Source: https://docs.sunc.su/Scripts/

### getcallingscript
`getcallingscript(): BaseScript | ModuleScript | nil`
Script that initiated the current code path. `nil` from executor threads.

### getscripts
`getscripts(): { BaseScript | ModuleScript }`
All Script / LocalScript / ModuleScript instances. CoreScripts excluded.

### getrunningscripts
`getrunningscripts(): { BaseScript | ModuleScript }`
Currently executing scripts in the caller's global state. Robust against `script` reassignment / nilling.

### getloadedmodules
`getloadedmodules(): { ModuleScript }`
ModuleScripts already `require()`'d (excludes errored / never-required).

### getscriptbytecode
`getscriptbytecode(s: BaseScript | ModuleScript): string | nil`
Raw bytecode. `nil` if no bytecode.

### getscriptclosure
`getscriptclosure(s: BaseScript | ModuleScript): ((...any) -> ...any) | nil`
A **freshly compiled** closure from the script's bytecode — not the live running closure. Useful for extracting constants without execution. `nil` if no bytecode.

### getscripthash
`getscripthash(s: BaseScript | ModuleScript): string | nil`
Hex SHA-384 of the script's raw (encrypted/compressed) bytecode.
**Note:** Hash the raw bytes, **not** decrypted/decompressed. `nil` if no bytecode.

### getsenv
`getsenv(s: BaseScript | ModuleScript): { [any]: any } | nil`
Live global env of a running script.
**Note:** Errors if `s` isn't running; returns `nil` if on a different Lua state.
