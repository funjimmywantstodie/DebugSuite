# LuaStateProxy

Source: <https://docs.voltbz.net/docs/luastateproxy>. Checked 2026-09-22.

Volt API quick reference. Follow a function link for parameter details and examples.

## [LuaStateProxy.Event](https://docs.voltbz.net/docs/luastateproxy/event)

Generic event for communication between Lua states.

```luau
state.Event: VoltSignal
```

## [LuaStateProxy:Execute](https://docs.voltbz.net/docs/luastateproxy/execute)

Schedules code execution on this Lua state.

```luau
state:Execute(source: string, ...: any) -> ()
```

## [LuaStateProxy:GetActors](https://docs.voltbz.net/docs/luastateproxy/getactors)

Returns all Actor instances associated with this Lua state.

```luau
state:GetActors() -> {Actor}
```

## [LuaStateProxy.Id](https://docs.voltbz.net/docs/luastateproxy/id)

Unique identifier for this Lua state.

```luau
state.Id: number?
```

## [LuaStateProxy.IsActorState](https://docs.voltbz.net/docs/luastateproxy/isactorstate)

Whether this state was created for use by Actors.

```luau
state.IsActorState: boolean
```

## [LuaStateProxy.new](https://docs.voltbz.net/docs/luastateproxy/new)

Gets a LuaStateProxy for the current Lua state.

```luau
LuaStateProxy.new() -> LuaStateProxy?
```
