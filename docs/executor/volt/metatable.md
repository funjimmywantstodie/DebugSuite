# Metatable

Source: <https://docs.voltbz.net/docs/metatable>. Checked 2026-09-22.

Volt API quick reference. Follow a function link for parameter details and examples.

## [getnamecallmethod](https://docs.voltbz.net/docs/metatable/getnamecallmethod)

Gets the method name being called in a __namecall hook.

```luau
getnamecallmethod() -> string?
```

## [getrawmetatable](https://docs.voltbz.net/docs/metatable/getrawmetatable)

Gets the raw metatable of an object, bypassing __metatable.

```luau
getrawmetatable(object: any) -> table?
```

## [isreadonly](https://docs.voltbz.net/docs/metatable/isreadonly)

Checks if a table is read-only.

```luau
isreadonly(table: table) -> boolean
```

## [iswritable](https://docs.voltbz.net/docs/metatable/iswritable)

Checks if a table is writable (not read-only).

```luau
iswritable(table: table) -> boolean
```

## [makereadonly](https://docs.voltbz.net/docs/metatable/makereadonly)

Makes a table read-only.

```luau
makereadonly(table: table) -> ()
```

## [makewritable](https://docs.voltbz.net/docs/metatable/makewritable)

Makes a table writable.

```luau
makewritable(table: table) -> ()
```

## [setnamecallmethod](https://docs.voltbz.net/docs/metatable/setnamecallmethod)

Sets the method name for the current __namecall invocation.

```luau
setnamecallmethod(method: string) -> ()
```

## [setrawmetatable](https://docs.voltbz.net/docs/metatable/setrawmetatable)

Sets the raw metatable of an object.

```luau
setrawmetatable<T>(object: T, metatable: table?) -> T
```

## [setreadonly](https://docs.voltbz.net/docs/metatable/setreadonly)

Sets a table's read-only status.

```luau
setreadonly(table: table, readonly: boolean) -> ()
```
