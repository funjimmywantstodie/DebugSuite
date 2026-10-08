# Environment

Source: <https://docs.voltbz.net/docs/environment>. Checked 2026-09-22.

Volt API quick reference. Follow a function link for parameter details and examples.

`filtergc` function filters can match `Name`, `Constants`, `Upvalues`, `Hash`, `IgnoreExecutor`, `Environment`, `StartLine`, `Source`, `UpvalueCount`, and `ConstantCount`. Table filters can match `Keys`, `Values`, `KeyValuePairs`, and `Metatable`. All supplied criteria must match. `IgnoreExecutor` defaults to true for function filters; it does not apply to table filters. `Constants`, `Upvalues`, and `Hash` do not apply to C closures.

## [filtergc](https://docs.voltbz.net/docs/environment/filtergc)

Filters objects in the garbage collector based on specified criteria.

```luau
filtergc(type: "function" | "table", options: table, returnOne?: boolean) -> any? | {any}
```

## [getallthreads](https://docs.voltbz.net/docs/environment/getallthreads)

Returns all Luau threads currently reachable by the calling state's garbage collector.

```luau
getallthreads() -> {thread}
```

## [getgc](https://docs.voltbz.net/docs/environment/getgc)

Returns Luau functions tracked by the garbage collector, optionally including tables, userdata, and threads.

```luau
getgc(includeTables?: boolean) -> table
```

## [getgenv](https://docs.voltbz.net/docs/environment/getgenv)

Returns Volt's global environment table.

```luau
getgenv() -> table
```

## [getreg](https://docs.voltbz.net/docs/environment/getreg)

Returns the Luau registry table.

```luau
getreg() -> table
```

## [getrenv](https://docs.voltbz.net/docs/environment/getrenv)

Returns the game's global environment table.

```luau
getrenv() -> table
```

## [gettenv](https://docs.voltbz.net/docs/environment/gettenv)

Gets the environment of a thread.

```luau
gettenv(thread: thread?) -> table?
```
