# Reflection

Source: <https://docs.voltbz.net/docs/reflection>. Checked 2026-09-22.

Volt API quick reference. Follow a function link for parameter details and examples.

## [gethiddenproperties](https://docs.voltbz.net/docs/reflection/gethiddenproperties)

Gets all hidden properties of an object.

```luau
gethiddenproperties(object: Object) -> table
```

## [gethiddenproperty](https://docs.voltbz.net/docs/reflection/gethiddenproperty)

Gets the value of a hidden property.

```luau
gethiddenproperty(object: Object, property: string) -> any?, boolean?
```

## [getproperties](https://docs.voltbz.net/docs/reflection/getproperties)

Gets the readable properties of an object.

```luau
getproperties(object: Object) -> table
```

## [getthreadidentity](https://docs.voltbz.net/docs/reflection/getthreadidentity)

Gets the current thread's identity level.

```luau
getthreadidentity() -> number
```

## [isnetworkowner](https://docs.voltbz.net/docs/reflection/isnetworkowner)

Checks if the local player owns a part's physics simulation.

```luau
isnetworkowner(part: BasePart) -> boolean
```

## [isscriptable](https://docs.voltbz.net/docs/reflection/isscriptable)

Checks if a property is scriptable.

```luau
isscriptable(object: Object, property: string) -> boolean
```

## [sethiddenproperty](https://docs.voltbz.net/docs/reflection/sethiddenproperty)

Sets the value of a hidden property.

```luau
sethiddenproperty(object: Object, property: string, value: any) -> boolean?
```

## [setscriptable](https://docs.voltbz.net/docs/reflection/setscriptable)

Sets whether a property is scriptable.

```luau
setscriptable(object: Object, property: string, scriptable: boolean) -> boolean
```

## [setsimulationradius](https://docs.voltbz.net/docs/reflection/setsimulationradius)

Compatibility function that currently has no effect.

```luau
setsimulationradius(...: any) -> ()
```

## [setthreadidentity](https://docs.voltbz.net/docs/reflection/setthreadidentity)

Sets the current thread's identity level.

```luau
setthreadidentity(identity: number) -> ()
```
