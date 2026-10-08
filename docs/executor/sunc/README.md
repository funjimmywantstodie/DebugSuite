# Executor API Reference

Mirror of [sUNC docs](https://docs.sunc.su/) (sUNC = Unified Naming Convention — the spec most executors implement). Compact: signatures + 1-line semantics + key gotchas. For prose/examples, follow the source link at the top of each file.

| File | Section | Functions |
|---|---|---|
| [closures.md](closures.md) | Closures | `checkcaller`, `clonefunction`, `getfunctionhash`, `hookfunction`, `hookmetamethod`, `iscclosure`, `isexecutorclosure`, `islclosure`, `loadstring`, `newcclosure`, `restorefunction` |
| [debug.md](debug.md) | Debug | `debug.get/setconstant(s)`, `debug.get/setupvalue(s)`, `debug.get/setstack`, `debug.getproto(s)` |
| [drawing.md](drawing.md) | Drawing | `cleardrawcache`, `get/setrenderproperty`, `isrenderobj`, `Drawing.new` |
| [encoding.md](encoding.md) | Encoding | `base64encode/decode`, `lz4compress/decompress` |
| [environment.md](environment.md) | Environment | `getgc`, `getgenv`, `getrenv`, `getreg`, `filtergc` |
| [filesystem.md](filesystem.md) | Filesystem | `read/write/append/delfile`, `isfile/isfolder`, `listfiles`, `make/delfolder`, `loadfile`, `getcustomasset` |
| [instances.md](instances.md) | Instances | `cloneref`, `compareinstances`, `fire*detector/prompt/interest`, `getcallbackvalue`, `gethui`, `get(nil)instances` |
| [metatable.md](metatable.md) | Metatable | `get/setrawmetatable`, `is/setreadonly`, `getnamecallmethod` |
| [miscellaneous.md](miscellaneous.md) | Misc | `identifyexecutor`, `request` |
| [reflection.md](reflection.md) | Reflection | `get/sethiddenproperty`, `is/setscriptable`, `get/setthreadidentity` |
| [scripts.md](scripts.md) | Scripts | `getcallingscript`, `getscripts`, `getrunningscripts`, `getloadedmodules`, `getscriptbytecode/closure/hash`, `getsenv` |
| [signals.md](signals.md) | Signals | `getconnections`, `firesignal`, `replicatesignal`, Connection object |
| [websocket.md](websocket.md) | WebSocket | `WebSocket.connect` + Send/Close/OnMessage/OnClose |

## When to read

Before writing exploit code that touches an executor API. One file per section so Read tool stays narrow.

If a doc seems stale or you need full prose (gotchas, examples), WebFetch the URL at the top of the file.
