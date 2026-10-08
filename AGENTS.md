# SimpleUI

This is a Roblox/Luau UI library intended for executor runtimes. Help build,
debug, and explain the UI. Implement requested changes directly and keep them
small enough to fit the existing design.

## Project layout

- `src/ui/`: library modules, components, and shared utilities.
- `src/Test.lua`: runnable example.
- `dist/Test.lua`: generated standalone bundle; change source and rebuild.
- `tests/`: mocked Roblox smoke checks and demo runner.
- `docs/executor/`: imported sUNC and Volt API references.

## Working conventions

- Reuse existing components and lifecycle helpers. Clean up connections and
  instances when a component is destroyed; keep rerunning the demo safe.
- Keep callbacks and getters working with raw values. UI formatting should
  not leak into copied text or application data.
- Preserve the user's edits. Avoid unrelated rewrites and new dependencies.
- Explain the cause of a bug and the resulting behavior briefly. State what
  was checked and what still needs an actual Roblox runtime check.

## Executor APIs

Read the relevant category in [docs/executor/README.md](docs/executor/README.md)
before introducing or changing an executor API call. Use the target executor's
documented signature; do not assume every sUNC or Volt function exists in
every runtime. Read upstream docs when the local reference is unclear or stale.

Executor globals such as `getgenv`, `cloneref`, and `setclipboard` are expected
here. Do not replace them with fake locals just to silence editor warnings.
Keep executor dependencies confined to the code that needs them.

## Validation and build

Run `python3 tests/run.py` for behavior changes. These mocks check logic and
cleanup, not Roblox rendering, text selection, or the real clipboard.
Rebuild the demo with `darklua process src/Test.lua dist/Test.lua` after source
changes. For documentation-only changes, check paths and links.
