# Filesystem

Source: https://docs.sunc.su/Filesystem/

All paths are relative to the executor's workspace folder.

### readfile
`readfile(path: string): string`
Returns file contents. Errors if missing/unreadable.

### writefile
`writefile(path: string, data: string): ()`
Write (overwrite) file with `data`.

### appendfile
`appendfile(path: string, data: string): ()`
Append `data`; creates file if missing.

### delfile
`delfile(path: string): ()`
Delete file at `path`.

### isfile
`isfile(path: string): boolean`
True if path exists and is a file.

### loadfile
`loadfile<A...>(path: string): (((A...) -> any) | nil, string?)`
Compile Luau from file. Runs in global env.
**Note:** Throws on syntax errors (unlike `loadstring` which returns `nil, err`).
**Observed (Volt):** also throws on a *missing* file — `invalid argument #1 to 'loadfile' (File
not found)` — rather than returning `nil, err`. So `loadfile(a) or loadfile(b)` never reaches
`b`. Probe with `isfile` first, or wrap in `pcall`.

### listfiles
`listfiles(path: string): { string }`
Children of folder. Paths relative to executor workspace.

### makefolder
`makefolder(path: string): ()`
Create folder. Silent no-op if exists.

### delfolder
`delfolder(path: string): ()`
Recursively delete folder.

### isfolder
`isfolder(path: string): boolean`
True if path exists and is a folder.

### getcustomasset
`getcustomasset(path: string): string`
Copies file into game asset dir, returns `rbxasset://...` content ID usable for audio/mesh/image/UI etc.
