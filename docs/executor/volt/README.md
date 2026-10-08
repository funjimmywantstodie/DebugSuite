# Volt executor API reference

Local quick reference for the [official Volt documentation](https://docs.voltbz.net/docs), checked 2026-09-22. Each function entry links to Volt's detailed page and records its documented call shape. Read the upstream page for full parameter tables, examples, and caveats. This reference covers the scripting API; Volt's Account Manager, Decompiler guide, and release notes remain at the official site.

| Area | Local reference |
|---|---|
| Scripting | [Closures](closures.md), [Debug](debug.md), [Reflection](reflection.md), [Metatable](metatable.md), [Environment](environment.md), [Bit](bit.md), [Scripts](scripts.md), [LuaStateProxy](luastateproxy.md), [oth](oth.md) |
| Instances and events | [Instances](instances.md), [Cache](cache.md), [Signals](signals.md), [VoltSignal](voltsignal.md), [Actors](actors.md) |
| System | [Filesystem](filesystem.md), [Input](input.md), [Console](console.md), [Crypt](crypt.md), [Encoding](encoding.md), [Miscellaneous](miscellaneous.md) |
| Graphics and network | [Drawing](drawing.md), [WebSocket](websocket.md), [RakNet](raknet.md) |

## Important differences from the old Potassium reference

- `filtergc`, `restorefunction`, and `getfunctionhash` are documented by Volt. The old README incorrectly called them absent.
- Debug functions are available both as `debug.*` methods and same-named globals. `debug.validlevel` also has `debug.isvalidlevel`; both spellings have global aliases.
- `getcallingscript` and `loadstring` belong to Scripts. `getgc` and `getgenv` belong to Environment. Hidden properties and thread identity belong to Reflection.
- Volt documents both bare `base64encode`/`base64decode` and `crypt.base64encode`/`crypt.base64decode` aliases, and both bare and `crypt.*` LZ4 names. See [Encoding](encoding.md).
- The console uses `rconsoleshow`, `rconsolehide`, `rconsoleerr`, and `rconsolename`. Input uses `iswindowactive`, not `isrbxactive`, and includes keyboard functions.
- Volt's Actors API uses `getactorstates`, `getluastate`, `getgamestate`, and `isparallel`. `run_on_thread`, `getactorthreads`, and `is_parallel` are absent from the current Volt index.
- `setsimulationradius` is registered as a compatibility no-op. Do not use it as evidence of a changed simulation radius.
- Bit and RakNet are disabled by default and need their respective client settings enabled.

Imported from Roblox Lab. Its editor definition files were not imported; this directory contains documentation only.
