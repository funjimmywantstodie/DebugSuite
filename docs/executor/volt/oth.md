# Oth

Source: <https://docs.voltbz.net/docs/oth>. Checked 2026-09-22.

Volt API quick reference. Follow a function link for parameter details and examples.

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

```luau
oth.unhook(target: function) -> boolean
```
