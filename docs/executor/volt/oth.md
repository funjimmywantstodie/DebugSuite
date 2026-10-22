# Oth

Source: <https://docs.voltbz.net/docs/oth>. Checked 2026-09-22.

Volt API quick reference. Follow a function link for parameter details and examples.

The hook/unhook constraints below were rechecked against their linked upstream
pages on 2026-10-10 for DebugSuite's optional tracing backend.

## [oth.get_original_thread](https://docs.voltbz.net/docs/oth/get_original_thread)

Returns the original thread associated with the hook, or nil if not in a hook thread.

```luau
oth.get_original_thread() -> thread?
```

## [oth.get_root_callback](https://docs.voltbz.net/docs/oth/get_root_callback)

Returns the root callback while executing inside an OTH hook thread.

```luau
oth.get_root_callback() -> function?
```

## [oth.hook](https://docs.voltbz.net/docs/oth/hook)

Hooks a C closure with a Luau callback.

Only C targets are supported. The replacement must be a Luau closure, so do not
wrap it with `newcclosure`. The returned function calls the original behavior;
remove this backend's hooks with `oth.unhook`, not `restorefunction`.

```luau
oth.hook(target: function, hook: function) -> function
```

## [oth.is_hook_thread](https://docs.voltbz.net/docs/oth/is_hook_thread)

Returns true if the current thread is a hook thread.

```luau
oth.is_hook_thread() -> boolean
```

## [oth.unhook](https://docs.voltbz.net/docs/oth/unhook)

Removes a hook created with oth.hook.

Returns true on successful removal, false when no hook exists or removal fails.
This does not remove ordinary `hookfunction` hooks.

```luau
oth.unhook(target: function) -> boolean
```
