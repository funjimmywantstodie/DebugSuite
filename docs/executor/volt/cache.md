# Cache

Source: <https://docs.voltbz.net/docs/cache>. Checked 2026-09-22.

Volt API quick reference. Follow a function link for parameter details and examples.

## [cache.invalidate](https://docs.voltbz.net/docs/cache/invalidate)

Removes an instance from the reference cache.

```luau
cache.invalidate(instance: Instance) -> ()
```

## [cache.iscached](https://docs.voltbz.net/docs/cache/iscached)

Checks if an instance is in the reference cache.

```luau
cache.iscached(instance: Instance) -> boolean
```

## [cache.replace](https://docs.voltbz.net/docs/cache/replace)

Replaces a cached instance reference with another.

```luau
cache.replace(instance: Instance, replacement: Instance) -> ()
```
