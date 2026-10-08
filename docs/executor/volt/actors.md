# Actors

Source: <https://docs.voltbz.net/docs/actors>. Checked 2026-09-22.

Volt API quick reference. Follow a function link for parameter details and examples.

## [create_comm_channel](https://docs.voltbz.net/docs/actors/create_comm_channel)

Creates a communication channel for sending messages between actors.

```luau
create_comm_channel() -> (number, ChannelReceiver)
```

## [get_comm_channel](https://docs.voltbz.net/docs/actors/get_comm_channel)

Retrieves an existing communication channel by its identifier.

```luau
get_comm_channel(id: number) -> BindableEvent
```

## [get_current_actor](https://docs.voltbz.net/docs/actors/get_current_actor)

Returns the Actor associated with the calling Luau state.

```luau
get_current_actor() -> Actor?
```

## [getactors](https://docs.voltbz.net/docs/actors/getactors)

Gets all active Actors.

```luau
getactors() -> {Actor}
```

## [getactorstates](https://docs.voltbz.net/docs/actors/getactorstates)

Returns LuaStateProxy objects for active Actors.

```luau
getactorstates() -> {LuaStateProxy}
```

## [getgamestate](https://docs.voltbz.net/docs/actors/getgamestate)

Returns the game Lua state.

```luau
getgamestate() -> LuaStateProxy?
```

## [getluastate](https://docs.voltbz.net/docs/actors/getluastate)

Returns the LuaStateProxy for an Actor, script, or the current state.

```luau
getluastate(actor_or_script: (Actor | LocalScript | ModuleScript | Script)?) -> LuaStateProxy?
```

## [isparallel](https://docs.voltbz.net/docs/actors/isparallel)

Checks if the current thread is running in parallel.

```luau
isparallel() -> boolean
```

## [on_actor_state_created](https://docs.voltbz.net/docs/actors/on_actor_state_created)

Event fired when an Actor Lua state becomes available.

```luau
on_actor_state_created: VoltSignal
```

## [run_on_actor](https://docs.voltbz.net/docs/actors/run_on_actor)

Runs a script on an actor's state.

```luau
run_on_actor(actor: Actor, script: string, ...: any) -> ()
```
