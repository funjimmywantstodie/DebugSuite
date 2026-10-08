# Scripts

Source: <https://docs.voltbz.net/docs/scripts>. Checked 2026-09-22.

Volt API quick reference. Follow a function link for parameter details and examples.

## [decompile](https://docs.voltbz.net/docs/scripts/decompile)

Decompiles Luau bytecode into source text.

```luau
decompile(source: LuaSourceContainer | string, options: DecompilerOptions?) -> string
DecompilerOptions.new() -> DecompilerOptions
DecompilerFormatter.new() -> DecompilerFormatter
```

## [getcallingscript](https://docs.voltbz.net/docs/scripts/getcallingscript)

Returns the script that called the current function.

```luau
getcallingscript() -> BaseScript | ModuleScript | nil
```

## [getfunctionbytecode](https://docs.voltbz.net/docs/scripts/getfunctionbytecode)

Returns the bytecode for a Luau closure.

```luau
getfunctionbytecode(func: function) -> string
```

## [getloadedmodules](https://docs.voltbz.net/docs/scripts/getloadedmodules)

Returns all currently loaded ModuleScripts.

```luau
getloadedmodules() -> {ModuleScript}
```

## [getmodules](https://docs.voltbz.net/docs/scripts/getmodules)

Gets cached ModuleScripts.

```luau
getmodules() -> {ModuleScript}
```

## [getrunningscripts](https://docs.voltbz.net/docs/scripts/getrunningscripts)

Returns scripts that are currently running.

```luau
getrunningscripts() -> {LuaSourceContainer}
```

## [getscriptbytecode](https://docs.voltbz.net/docs/scripts/getscriptbytecode)

Gets processed Luau bytecode for a script.

```luau
getscriptbytecode(script: CoreScript | LocalScript | ModuleScript | Script) -> string
```

## [getscriptclosure](https://docs.voltbz.net/docs/scripts/getscriptclosure)

Gets the main function of a script.

```luau
getscriptclosure(script: LocalScript | ModuleScript | Script) -> function | string
```

## [getscriptfromthread](https://docs.voltbz.net/docs/scripts/getscriptfromthread)

Gets the script associated with a thread.

```luau
getscriptfromthread(thread: thread) -> BaseScript | ModuleScript | nil
```

## [getscripthash](https://docs.voltbz.net/docs/scripts/getscripthash)

Gets a hash of a script's bytecode.

```luau
getscripthash(script: CoreScript | LocalScript | ModuleScript | Script) -> string?
```

## [getscripts](https://docs.voltbz.net/docs/scripts/getscripts)

Returns cached client-visible scripts.

```luau
getscripts() -> {BaseScript | ModuleScript}
```

## [getscriptthread](https://docs.voltbz.net/docs/scripts/getscriptthread)

Returns a thread associated with a client script or ModuleScript.

```luau
getscriptthread(script: LocalScript | ModuleScript | Script) -> thread?
```

## [getsenv](https://docs.voltbz.net/docs/scripts/getsenv)

Gets a script's environment table.

```luau
getsenv(script: LocalScript | ModuleScript | Script) -> table?
```

## [isexecutorthread](https://docs.voltbz.net/docs/scripts/isexecutorthread)

Checks whether a thread was created by Volt.

```luau
isexecutorthread(thread?: thread) -> boolean
```

## [loadstring](https://docs.voltbz.net/docs/scripts/loadstring)

Compiles a string of Luau code and returns it as a function.

```luau
loadstring(code: string, chunkname?: string) -> function?, string?
```
