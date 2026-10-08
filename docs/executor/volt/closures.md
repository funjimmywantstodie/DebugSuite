# Closures

Source: <https://docs.voltbz.net/docs/closures>. Checked 2026-09-22.

Volt API quick reference. Follow a function link for parameter details and examples.

## [checkcaller](https://docs.voltbz.net/docs/closures/checkcaller)

Returns whether the current function was called by Volt.

```luau
checkcaller() -> boolean
```

## [clonefunction](https://docs.voltbz.net/docs/closures/clonefunction)

Creates a copy of the given function.

```luau
clonefunction(func: function) -> function
```

## [getfunctionhash](https://docs.voltbz.net/docs/closures/getfunctionhash)

Returns a hash of the function's bytecode.

The digest is 96 hexadecimal characters (SHA-384) over a Luau closure's instructions and constants. C closures have no Luau bytecode and cause an error.

```luau
getfunctionhash(func: function) -> string
```

## [hookfunction](https://docs.voltbz.net/docs/closures/hookfunction)

Replaces a function with a custom implementation.

```luau
hookfunction(target: function, hook: function) -> function
```

## [hookmetamethod](https://docs.voltbz.net/docs/closures/hookmetamethod)

Hooks a metamethod on an object's metatable.

```luau
hookmetamethod(object: any, metamethod: string, hook: function) -> function
```

## [hookproto](https://docs.voltbz.net/docs/closures/hookproto)

Hook a nested Luau proto.

```luau
hookproto(proto: ProtoProxy, hook: (...any) -> ...any) -> ()
```

## [iscclosure](https://docs.voltbz.net/docs/closures/iscclosure)

Checks if a function is a C closure.

```luau
iscclosure(func: function) -> boolean
```

## [isexecutorclosure](https://docs.voltbz.net/docs/closures/isexecutorclosure)

Checks if a function originates from Volt.

```luau
isexecutorclosure(func: function) -> boolean
```

## [isfunctionhooked](https://docs.voltbz.net/docs/closures/isfunctionhooked)

Checks if a function has been hooked.

```luau
isfunctionhooked(func: function) -> boolean
```

## [islclosure](https://docs.voltbz.net/docs/closures/islclosure)

Checks if a function is a Luau closure.

```luau
islclosure(func: function) -> boolean
```

## [isnewcclosure](https://docs.voltbz.net/docs/closures/isnewcclosure)

Checks if a function is a newcclosure wrapper.

```luau
isnewcclosure(func: function) -> boolean
```

## [isprotohooked](https://docs.voltbz.net/docs/closures/isprotohooked)

Check whether a proto is hooked.

```luau
isprotohooked(proto: ProtoProxy) -> boolean
```

## [newcclosure](https://docs.voltbz.net/docs/closures/newcclosure)

Wraps a Luau function to appear as a C closure.

```luau
newcclosure(func: function, debugname?: string) -> function
```

## [newlclosure](https://docs.voltbz.net/docs/closures/newlclosure)

Wraps a C closure to appear as a Luau closure.

```luau
newlclosure(func: function, debugname?: string) -> function
```

## [restorefunction](https://docs.voltbz.net/docs/closures/restorefunction)

Restores a hooked function to its original implementation.

```luau
restorefunction(func: function) -> ()
```

## [restoreproto](https://docs.voltbz.net/docs/closures/restoreproto)

Restore a proto hooked with hookproto.

```luau
restoreproto(proto: ProtoProxy) -> ()
```

## [setstackhidden](https://docs.voltbz.net/docs/closures/setstackhidden)

Sets whether a function is hidden from stack traces.

```luau
setstackhidden(funcOrLevel: function | number, hidden: boolean) -> ()
```

## [trampoline_call](https://docs.voltbz.net/docs/closures/trampoline_call)

Call a function with a custom stack and thread context.

```luau
type TrampolineCallFrame = {
    currentline: number,
    func: (...any) -> ...any,
}

type TrampolineThreadOptions = {
    script: Instance?,
    identity: number?,
    env: {[any]: any}?,
    thread: thread?,
}

trampoline_call(
    func: (...any) -> ...any,
    callstack: {TrampolineCallFrame},
    thread_options: TrampolineThreadOptions,
    ...: any
) -> (boolean, ...any)
```
