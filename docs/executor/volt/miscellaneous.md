# Miscellaneous

Source: <https://docs.voltbz.net/docs/miscellaneous>. Checked 2026-09-22.

Volt API quick reference. Follow a function link for parameter details and examples.

## [clearqueueonteleport](https://docs.voltbz.net/docs/miscellaneous/clearqueueonteleport)

Clears the teleport script queue.

```luau
clearqueueonteleport() -> ()
```

## [get_process_identifier](https://docs.voltbz.net/docs/miscellaneous/get_process_identifier)

Returns the operating-system process identifier for the current game process.

```luau
get_process_identifier() -> number
```

## [getfflag](https://docs.voltbz.net/docs/miscellaneous/getfflag)

Gets a Fast Flag value.

```luau
getfflag(name: string) -> string
```

## [getfpscap](https://docs.voltbz.net/docs/miscellaneous/getfpscap)

Gets the current FPS cap.

```luau
getfpscap() -> number
```

## [gethwid](https://docs.voltbz.net/docs/miscellaneous/gethwid)

Gets Volt's external user identifier.

```luau
gethwid() -> string
```

## [identifyexecutor](https://docs.voltbz.net/docs/miscellaneous/identifyexecutor)

Returns information about Volt.

```luau
identifyexecutor() -> string, string
```

## [messagebox](https://docs.voltbz.net/docs/miscellaneous/messagebox)

Displays a message box dialog.

```luau
messagebox(text: string, caption: string, flags: number) -> number
```

## [queueonteleport](https://docs.voltbz.net/docs/miscellaneous/queueonteleport)

Queues a script to run after teleporting.

```luau
queueonteleport(script: string) -> ()
```

## [request](https://docs.voltbz.net/docs/miscellaneous/request)

Sends an HTTP request and yields until the response is available.

```luau
request(options: table) -> table
```

## [saveinstance](https://docs.voltbz.net/docs/miscellaneous/saveinstance)

Serializes one or more instances to the game's binary model or place format.

```luau
saveinstance(root: Instance | {Instance}, options: SaveInstanceOptions?) -> ()
SaveInstanceOptions.new() -> SaveInstanceOptions
```

## [saveplace](https://docs.voltbz.net/docs/miscellaneous/saveplace)

Serializes the current DataModel to the game's binary place format.

```luau
saveplace(options: SaveInstanceOptions?) -> ()
```

## [setclipboard](https://docs.voltbz.net/docs/miscellaneous/setclipboard)

Copies a value's string representation to the system clipboard.

```luau
setclipboard(data: any) -> ()
```

## [setfflag](https://docs.voltbz.net/docs/miscellaneous/setfflag)

Sets a Fast Flag value.

```luau
setfflag(name: string, value: string) -> ()
```

## [setfpscap](https://docs.voltbz.net/docs/miscellaneous/setfpscap)

Sets the FPS cap for the game.

```luau
setfpscap(fps: number) -> ()
```

## [setrbxclipboard](https://docs.voltbz.net/docs/miscellaneous/setrbxclipboard)

Copies a value to the internal Studio clipboard.

```luau
setrbxclipboard(value: any) -> ()
```
