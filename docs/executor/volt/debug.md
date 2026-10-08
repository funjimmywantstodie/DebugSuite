# Debug

Source: <https://docs.voltbz.net/docs/debug>. Checked 2026-09-22.

Volt API quick reference. Follow a function link for parameter details and examples.

## [debug.getcallstack](https://docs.voltbz.net/docs/debug/getcallstack)

Gets visible call frames from the current thread or another thread.

```luau
debug.getcallstack(thread?: thread) -> {{func: function, currentline: number?}}
```

## [debug.getconstant](https://docs.voltbz.net/docs/debug/getconstant)

Gets a constant from a function at the specified index.

```luau
debug.getconstant(func: function | number | ProtoProxy, index: number) -> any
```

## [debug.getconstants](https://docs.voltbz.net/docs/debug/getconstants)

Gets all constants from a function.

```luau
debug.getconstants(func: function | number | ProtoProxy) -> table
```

## [debug.getinfo](https://docs.voltbz.net/docs/debug/getinfo)

Gets information about a function or stack level.

```luau
debug.getinfo(func_or_level: function | number | ProtoProxy) -> table
```

## [debug.getproto](https://docs.voltbz.net/docs/debug/getproto)

Gets a proto (nested function) from a function.

```luau
debug.getproto(func: function | number | ProtoProxy, index: number, activated?: boolean) -> ProtoProxy | {function}
```

## [debug.getprotos](https://docs.voltbz.net/docs/debug/getprotos)

Gets all protos (nested functions) from a function.

```luau
debug.getprotos(func: function | number | ProtoProxy) -> {ProtoProxy}
```

## [debug.getstack](https://docs.voltbz.net/docs/debug/getstack)

Gets one value or all values from a Luau stack frame.

```luau
debug.getstack(level: number, index?: number) -> any | {any}
debug.getstack(thread: thread, level: number, index?: number) -> any | {any}
```

## [debug.getupvalue](https://docs.voltbz.net/docs/debug/getupvalue)

Gets an upvalue from a function by index.

```luau
debug.getupvalue(func: function | number, index: number) -> any
```

## [debug.getupvalues](https://docs.voltbz.net/docs/debug/getupvalues)

Gets all upvalues from a function.

```luau
debug.getupvalues(func: function | number) -> table
```

## [ProtoProxy](https://docs.voltbz.net/docs/debug/protoproxy)

`debug.getproto` returns this proxy by default. Its `CodeHash` is a signed 32-bit comparison value, not a cryptographic hash. Calling the proxy does not execute the nested function.

Represents a nested Luau proto. It does not create an active closure.

## [debug.setconstant](https://docs.voltbz.net/docs/debug/setconstant)

Sets a constant in a function at the specified index.

```luau
debug.setconstant(func: function | number | ProtoProxy, index: number, value: any) -> function
```

## [debug.setinfo](https://docs.voltbz.net/docs/debug/setinfo)

Changes selected debug metadata on a Luau function or proto.

```luau
debug.setinfo(func_or_level: function | number | ProtoProxy, info: table) -> ()
```

## [debug.setstack](https://docs.voltbz.net/docs/debug/setstack)

Sets a value on the stack at a specific level and index.

```luau
debug.setstack(level: number, index: number, value: any) -> ()
debug.setstack(thread: thread, level: number, index: number, value: any) -> ()
```

## [debug.setupvalue](https://docs.voltbz.net/docs/debug/setupvalue)

Sets an upvalue in a function by index.

```luau
debug.setupvalue(func: function | number, index: number, value: any) -> ()
```

## [debug.validlevel](https://docs.voltbz.net/docs/debug/validlevel)

Checks if a stack level is valid.

```luau
debug.validlevel(level: number, thread?: thread) -> boolean
```
