# Filesystem

Source: <https://docs.voltbz.net/docs/filesystem>. Checked 2026-09-22.

Volt API quick reference. Follow a function link for parameter details and examples.

## [appendfile](https://docs.voltbz.net/docs/filesystem/appendfile)

Appends data to the end of a file.

```luau
appendfile(path: string, data: string) -> ()
```

## [delfile](https://docs.voltbz.net/docs/filesystem/delfile)

Deletes a file.

```luau
delfile(path: string) -> ()
```

## [delfolder](https://docs.voltbz.net/docs/filesystem/delfolder)

Deletes a folder and its contents.

```luau
delfolder(path: string) -> ()
```

## [dofile](https://docs.voltbz.net/docs/filesystem/dofile)

Loads and executes a Luau file.

```luau
dofile(path: string) -> ()
```

## [getcustomasset](https://docs.voltbz.net/docs/filesystem/getcustomasset)

Returns a content URL for a local file that can be used in the game.

The file must already exist in Volt's workspace. The returned URL uses the `rbxasset://` scheme and retains the file extension.

```luau
getcustomasset(path: string) -> string
```

## [isfile](https://docs.voltbz.net/docs/filesystem/isfile)

Checks if a path points to a file.

```luau
isfile(path: string) -> boolean
```

## [isfolder](https://docs.voltbz.net/docs/filesystem/isfolder)

Checks if a path points to a folder.

```luau
isfolder(path: string) -> boolean
```

## [listfiles](https://docs.voltbz.net/docs/filesystem/listfiles)

Lists all files and folders in a directory.

```luau
listfiles(path: string) -> table
```

## [loadfile](https://docs.voltbz.net/docs/filesystem/loadfile)

Loads a Luau file and returns it as a function.

```luau
loadfile(path: string) -> function?, string?
```

## [makefolder](https://docs.voltbz.net/docs/filesystem/makefolder)

Creates a new folder.

```luau
makefolder(path: string) -> ()
```

## [readfile](https://docs.voltbz.net/docs/filesystem/readfile)

Reads the contents of a file.

```luau
readfile(path: string) -> string
```

## [writefile](https://docs.voltbz.net/docs/filesystem/writefile)

Writes data to a file.

```luau
writefile(path: string, data: string) -> ()
```
