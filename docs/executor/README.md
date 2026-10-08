# Executor API references

Local documentation imported on 2026-10-08 from two neighboring projects:

| Reference | Origin | Use |
|---|---|---|
| [sUNC](sunc/README.md) | Roblox Exploit Sandbox `docs/` | Common executor API conventions and gotchas |
| [Volt](volt/README.md) | Roblox Lab `docs/` | Volt-specific signatures and extensions |

The category files retain their source URLs and original check dates. They
are snapshots, not a fresh upstream verification or a guarantee that an API
exists in the executor running SimpleUI. Keep the two references separate
when their signatures or behavior differ.

Start with the relevant category instead of reading the whole catalog:

- Clipboard, including the demo's `setclipboard` call:
  [Volt miscellaneous](volt/miscellaneous.md#setclipboard).
- Globals and runtime state: [sUNC environment](sunc/environment.md),
  [Volt environment](volt/environment.md).
- Instance references and GUI access: [sUNC instances](sunc/instances.md),
  [Volt instances](volt/instances.md).
- File operations: [sUNC filesystem](sunc/filesystem.md),
  [Volt filesystem](volt/filesystem.md).
- Event connections: [sUNC signals](sunc/signals.md),
  [Volt signals](volt/signals.md).

Only executor reference Markdown was imported. The original projects' agent
instructions, research notes, bridge tooling, and editor definitions remain
in their own repositories. SimpleUI's working guide is [AGENTS.md](../../AGENTS.md).
