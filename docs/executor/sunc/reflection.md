# Reflection

Source: https://docs.sunc.su/Reflection/

### gethiddenproperty
`gethiddenproperty(inst: Instance, name: string): (any, boolean)`
Read non-scriptable / hidden property. Returns `(value, wasHidden)`.
**Note:** Don't implement via `setscriptable` — detectable + limited.

### sethiddenproperty
`sethiddenproperty(inst: Instance, name: string, value: any): boolean`
Write non-scriptable / hidden property. Returns `true` if it was hidden.
**Note:** Don't implement via `setscriptable`.

### isscriptable
`isscriptable(inst: Instance, name: string): boolean | nil`
`true` = scriptable, `false` = `notscriptable` tag set, `nil` = no such property.

### setscriptable
`setscriptable(inst: Instance, name: string, state: boolean): boolean | nil`
Toggle scriptability of a property.
**Note:** Detection risk — games may watch for newly-scriptable props.

### getthreadidentity
`getthreadidentity(): number`
Current thread's identity level (permission tier for protected APIs).

### setthreadidentity
`setthreadidentity(id: number): ()`
Set thread identity. Identity 8 = CoreGui-level access. Used to unlock `gethiddenproperty`, `getconnections`, etc.
