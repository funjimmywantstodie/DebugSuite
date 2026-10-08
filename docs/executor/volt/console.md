# Console

Source: <https://docs.voltbz.net/docs/console>. Checked 2026-09-22.

Volt API quick reference. Follow a function link for parameter details and examples.

## [rconsoleclear](https://docs.voltbz.net/docs/console/rconsoleclear)

Clears all text from the console window.

```luau
rconsoleclear() -> ()
```

## [rconsoleerr](https://docs.voltbz.net/docs/console/rconsoleerr)

Prints an error message to the console.

```luau
rconsoleerr(data: any, async?: boolean) -> ()
```

## [rconsolehidden](https://docs.voltbz.net/docs/console/rconsolehidden)

Checks if the console window is hidden.

```luau
rconsolehidden() -> boolean
```

## [rconsolehide](https://docs.voltbz.net/docs/console/rconsolehide)

Hides the console window without destroying it.

```luau
rconsolehide() -> ()
```

## [rconsoleinfo](https://docs.voltbz.net/docs/console/rconsoleinfo)

Prints an info message to the console.

```luau
rconsoleinfo(data: any, async?: boolean) -> ()
```

## [rconsoleinput](https://docs.voltbz.net/docs/console/rconsoleinput)

Gets input from the user via the console.

```luau
rconsoleinput() -> string
```

## [rconsolename](https://docs.voltbz.net/docs/console/rconsolename)

Sets the console window title.

```luau
rconsolename(title: string) -> ()
```

## [rconsoleprint](https://docs.voltbz.net/docs/console/rconsoleprint)

Prints text to the console window.

```luau
rconsoleprint(data: any, async?: boolean, escape?: boolean) -> ()
```

## [rconsoleshow](https://docs.voltbz.net/docs/console/rconsoleshow)

Creates and shows the console window.

```luau
rconsoleshow() -> ()
```

## [rconsoletoggle](https://docs.voltbz.net/docs/console/rconsoletoggle)

Toggles the console window visibility.

```luau
rconsoletoggle() -> ()
```

## [rconsoletop](https://docs.voltbz.net/docs/console/rconsoletop)

Sets whether the console window stays above other windows.

```luau
rconsoletop(shouldBeTop: boolean) -> ()
```

## [rconsolewarn](https://docs.voltbz.net/docs/console/rconsolewarn)

Prints a warning message to the console.

```luau
rconsolewarn(data: any, async?: boolean) -> ()
```
