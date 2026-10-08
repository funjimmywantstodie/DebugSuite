# Signals

Source: https://docs.sunc.su/Signals/

### Connection object
Returned by `getconnections`.

```lua
type Connection = {
    Enabled:       boolean,
    ForeignState:  boolean,    -- from a foreign Luau state
    LuaConnection: boolean,    -- Luau vs C-level
    Function:      ((...any) -> ...any)?,  -- nil if foreign/C
    Thread:        thread?,                 -- nil if foreign/C

    Fire:       (self, ...any) -> (),  -- invoke callback immediately
    Defer:      (self, ...any) -> (),  -- schedule via task scheduler
    Disconnect: (self) -> (),          -- permanent
    Disable:    (self) -> (),          -- temporary block
    Enable:     (self) -> (),          -- restore
}
```

### getconnections
`getconnections(signal: RBXScriptSignal): { Connection }`
All active connections on a signal.
**Note:** Must handle C connections (nil `Function`/`Thread`) or game may crash.

### firesignal
`firesignal(signal: RBXScriptSignal, ...any): ()`
Invoke every connection on `signal` immediately. Bypasses `Workspace.SignalBehaviour`.

### replicatesignal
`replicatesignal(signal: RBXScriptSignal, ...any): ()`
Replicate the signal fire to the server. Args must match expected signal shape — errors otherwise.
