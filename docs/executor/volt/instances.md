# Instances

Source: <https://docs.voltbz.net/docs/instances>. Checked 2026-09-22.

Volt API quick reference. Follow a function link for parameter details and examples.

## [cloneref](https://docs.voltbz.net/docs/instances/cloneref)

Creates a new reference to an instance that compares as different.

```luau
cloneref(instance: Instance) -> Instance
```

## [compareinstances](https://docs.voltbz.net/docs/instances/compareinstances)

Compares if two references point to the same instance.

```luau
compareinstances(a: Instance, b: Instance) -> boolean
```

## [fireclickdetector](https://docs.voltbz.net/docs/instances/fireclickdetector)

Triggers a ClickDetector as if it was clicked.

```luau
fireclickdetector(detector: ClickDetector, distance?: number, event?: string) -> ()
```

## [fireproximityprompt](https://docs.voltbz.net/docs/instances/fireproximityprompt)

Triggers a ProximityPrompt as if it was activated.

```luau
fireproximityprompt(prompt: ProximityPrompt) -> ()
```

## [firetouchinterest](https://docs.voltbz.net/docs/instances/firetouchinterest)

Triggers a Touched or TouchEnded event between two parts.

```luau
firetouchinterest(part: BasePart, target: BasePart, toggle: boolean | number) -> ()
```

## [getcallbackmember / getcallbackvalue](https://docs.voltbz.net/docs/instances/getcallbackvalue)

Gets the value assigned to an object callback property.

```luau
getcallbackmember(object: Object, property: string, returnRaw?: boolean) -> any?
getcallbackvalue(object: Object, property: string, returnRaw?: boolean) -> any? -- alias
```

## [gethui](https://docs.voltbz.net/docs/instances/gethui)

Returns the hidden UI container.

```luau
gethui() -> BasePlayerGui
```

## [getinstancecache](https://docs.voltbz.net/docs/instances/getinstancecache)

Gets all cached instance references.

```luau
getinstancecache() -> table
```

## [getinstances](https://docs.voltbz.net/docs/instances/getinstances)

Returns the instances currently stored in the internal instance cache.

```luau
getinstances() -> table
```

## [getnilinstances](https://docs.voltbz.net/docs/instances/getnilinstances)

Returns cached instances with no parent.

```luau
getnilinstances() -> table
```

## [getrendersteppedlist](https://docs.voltbz.net/docs/instances/getrendersteppedlist)

Gets callbacks registered through RunService:BindToRenderStep in the current Luau state.

```luau
getrendersteppedlist() -> table
```
