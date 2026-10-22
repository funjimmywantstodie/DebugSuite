# SimpleUI

DebugSuite is the debugging workbench built on this UI library. Run the bundled
[dist/DebugSuite.lua](dist/DebugSuite.lua) in your supported Roblox test runtime.
It starts on Overview; inventories run when you click **Scan**, not on startup.
Overview has shortcuts for each task. Search instructions stay visible above a
separate progress/result message; **Scan** is disabled while work is running.

## DebugSuite workbench

| Tab | Workflow |
|---|---|
| Overview | Session details, passive API availability, limits, and navigation help |
| Explorer | Lazy client instance hierarchy; name/class/path search; properties and attributes; readable script source; property snapshot comparison |
| Functions | Name/source/raw table field search, multiple typed constant filters, source/parameter-count filters; function details and inspection of constants, upvalues, or nested functions |
| Hooks | Trace functions transferred from discovery; typed return overrides, arguments, original/modified returns, errors and duration; managed stop/retry; Standard and Volt OTH backends |
| GC | Literal search across raw table keys/values; lazy table inspection; capture and compare frozen baselines |
| Remotes | Remote inventory; incoming RemoteEvent/UnreliableRemoteEvent watches; selected outgoing FireServer/InvokeServer namecalls and results; frozen reports preserving nil slots |
| Logs | Client output history, level/text filters, pause, raw message inspection, and copy filtered logs |
| Runtime | Opt-in frame sampling; average FPS, P95/worst frame time, stall count, and client/Luau memory |

For a table bug: search GC, select a table, **Capture baseline**, reproduce the
problem, then **Compare with baseline**. For instance changes, use Explorer's
property baseline and comparison. Explorer's **Kind: Scripts** filter finds
scripts; **Read script source** works only when `Source` is readable.

Press **Ctrl+F** to focus the current tab's search. Enter submits an inventory
search. Log and captured-event filters update existing results. List headers
sort columns. Tree rows select a value; the separate **Expand / Collapse** button
only opens or closes its children. Explorer leaves have no toggle; refresh the
hierarchy after adding or removing children. Expanding does not change the preview. Table
contents stay in the tree until you request **Show raw value**; scalar selections
appear in the preview. **Copy report** copies the displayed report without color
tags. **Plain text / Syntax colors** changes formatting without changing data.
GC's Preview column uses syntax colors and readable type labels (`table`,
`function`). Tags inside inspected strings are escaped and shown literally;
preview styling never changes filtering or selected values.

The Functions tab shows metadata and explicit **Inspect constants**, **Inspect
upvalues**, and **Inspect nested functions** buttons. These reuse one floating
inspector. Its **Inspect selected** button drills into a function or instance;
**Back** returns to the previous view. **Copy value** serializes the selected
value, even when the preview only shows a table hint. Unavailable actions are
disabled until their required selection, API, or baseline exists. **Cancel** is
enabled while a scan is running.

In Functions, type up to 16 comma-separated values in **Search constants
(comma-separated)** above the results, for example `RemoteEvent, Damage, 100,
true`, then click **Scan** or press Enter. Words are strings; numbers and
`true`/`false` match their raw types and values. Use double quotes to search for
string values such as `"42"` or `"true"`, or a string containing a comma such
as `"a,b"`. Inside quoted strings, double a quote (`"say ""hi"""`); backslashes
stay literal. Extra spaces outside quotes and empty comma-separated entries
are ignored. Leave the box blank or click **Clear constants** to skip the filter.
Click **Scan constants only** to search using just these constants, ignoring
the name, source, and parameter filters without clearing their drafts. You can
also leave those optional filters blank and use regular **Scan** or Enter.
String constants always match substrings without case sensitivity: `integrity`
finds `Integrity-3212zx`, and `INTEGRITY` finds it too.
**Match constants: All** requires every listed value; **Any** requires at least
one. A quoted empty string (`""`) matches any string constant.
Names and sources ignore case unless **Case-sensitive names / sources** is
enabled; that toggle does not affect constants.
The separate source filter and parameter count combine with the main search
and constants. Parameter count means declared fixed parameters, excluding
variadic arguments; functions with unavailable parameter metadata do not match
a specified count. Changing filters requires another scan. Constant filters
need `debug.getconstants`. Known C closures are skipped because they have no
Luau constants. Failed reads mark the scan partial and show the first error;
the status also counts successfully read constant tables separately.

Baseline status identifies the captured table or instance, and capturing a
baseline leaves the current report visible. Explorer's live refresh updates the
property tree without replacing open script source or comparison results.
Live refresh also preserves expanded property groups and the selected value.
Changing inventory filters cancels a pending scan and marks the search as needing
**Scan** or Enter, so older results are not mistaken for the new filter.
Close or rerun the tool to release listeners and windows; **Clear**
on inventory tabs releases their retained results. GC and Explorer keep one
baseline each; clear the tab to release it.

Capability discovery checks presence without modifying functions or installing
hooks. The existing UI library requires `getgenv` and `cloneref`.
Missing/unsupported inspection APIs produce feature-specific errors while other
tabs remain usable. GC inventories use documented `getgc`, or `filtergc` as a
fallback. Standard [`debug.info`](https://luau.org/library/#debug-library) supplies
metadata when available; executor debug APIs supply constants/upvalues/prototypes.
Function inspection never calls the inspected function. Inactive prototypes
are treated as inspection data.

Functions handles discovery; Hooks handles tracing. Select a result in Functions
and click **Send to Hooks** above the results. This opens Hooks with that exact
closure selected, without another search. Both detail reports show the same
`functionId`, a session ID that distinguishes closures even when their names
match; it is not a persistent bytecode hash. The value inspector can send
selected closures too. Hooks displays the target's metadata and has a
**Find / change function** button to return to your existing Functions results
and filters. Clearing discovery results leaves the transferred target available.
Choose a backend and **Trace selected function**; transferring a target installs
no hook. Sending an already managed target selects its existing hook and overrides.
Ctrl+F in Hooks focuses the captured-call filter.
The three numbered sections guide target selection, tracing, and reading calls.
Target status shows ready, waiting for a call, paused, or a failed stop with its
error. Starting a hook selects it for immediate stopping. Missing backend APIs
are named beside the disabled action. **Follow latest matching call** previews
new captures automatically; selecting an older row holds that call until you
enable following again. A yielded call shows **running** and its selected report
updates when it returns or fails. Copied reports include target, time and duration.
Standard requires `hookfunction`, `restorefunction`, and `newcclosure`. Volt OTH
requires `oth.hook`, `oth.unhook`, and `iscclosure`; it only accepts C targets and
receives a Luau callback, as documented by [Volt](https://docs.voltbz.net/docs/oth/hook).
All five OTH APIs appear separately in the passive capability report; available
context APIs are sampled inside captured OTH calls, never during discovery.

**Return overrides** edits the selected active function trace. Add numbered slots,
choose `nil`, `string`, `number`, or `boolean`, and click **Apply and enable
override**. This replaces the entire successful return tuple with 0-16 slots;
remove every slot to return no values. A nil slot still counts, including trailing
nils. Strings are literal text without added quotes; numbers must be finite and
booleans use a `true`/`false` selector instead of a textbox. No editor text is evaluated as code. Invalid
input leaves the last applied rule intact, and changing targets loads that target's
applied values. Draft edits take effect only when applied.

The original function still runs and keeps its side effects, yields, and errors.
Captured overridden calls show **overridden** with separate original and modified
return tuples. **Disable override** restores original returns while keeping tracing;
**Stop hook** restores the function. Pausing capture, rate limiting, or a report
failure does not disable an enabled override. Disabling, replacing the rule, or
stopping/closing the hook cancels its override on calls still waiting to return.
Overrides start off and are limited to function traces; outgoing remote hooks
cannot use this editor.

Managed hooks show call counts and capture arguments before execution, then
returns or errors and elapsed call time. Nil slots and original error values
are preserved; reports remain bounded and mark partial data. Hooks keep 500
records at 100 calls/second; rate-limited and paused calls still pass through.
Nested calls made while formatting reports are suppressed, and lists refresh
at most five times per second when data changes. Trace dependencies cannot be
hooked through this tool. Existing hooks are rejected when `isfunctionhooked`
is available; avoid concurrent tools changing the same target. Capture uses
protected calls and adds stack/time overhead, so it is not a transparent or
undetectable instrumentation layer.

Select a managed hook to **Stop selected hook**, or use **Stop all hooks**.
Restoration failures leave capture disabled and retain the entry for retry.
Closing or rerunning attempts to restore all managed targets. If the executor
rejects restoration, a disabled pass-through wrapper can remain installed and
cleanup reports the failure.

Remote observation adds ordinary
[`OnClientEvent`](https://create.roblox.com/docs/reference/engine/classes/RemoteEvent)
listeners only after **Watch selected incoming event**. It does not intercept
incoming RemoteFunction callbacks. **Watch selected outgoing calls** observes
selected `:FireServer` and `:InvokeServer` calls through one shared DataModel
`__namecall` hook, using the chosen backend. This requires `getrawmetatable`,
`getnamecallmethod`, and `setnamecallmethod` as well as the hook backend APIs.
Unrelated instances take a fast path; the saved method is restored after
formatting. Direct calls such as `remote.FireServer(remote, ...)` are outside
this capture. RemoteFunction responses and errors appear in the same history.
Watches remain active while
you change tabs; **Stop all watches** disconnects them. Moving a watched event
out of the DataModel or destroying it also disconnects its watch. Use
**Stop all outgoing watches** before changing its backend; stopping the final
outgoing watch restores the shared hook. Hooks' **Stop all hooks** also stops
outgoing capture. **Pause capture** affects that tab's incoming and outgoing
traffic; **Pause hook capture** pauses all managed hooks. Pause discards
new events rather than queuing them. This is a client inspection tool for
authorized testing; it provides no detection-evasion guarantees.

Functions also matches raw table fields that hold functions, so an
export such as `Detected = fn` is searchable even when `fn` has no debug name.
Alias matches show the field name and select the original closure. Search never
runs the function or resolves proxy/metatable fields. Aliases require table
inventory support and are checked only for nonempty name/source/field filters.

Scans visit at most 30,000 objects and retain at most 1,000 results. Function
alias search has a separate 30,000-value inventory pass and checks up to 30,000
raw fields total, with at most 200 fields per table. GC table
search examines the first 200 entries and first 4,096 bytes of each string;
constant search examines up to 300 constants per closure and matches full
string values. Partial results are
labelled. Cancellation is cooperative between batches; the executor's native
GC call itself cannot be interrupted. Function inventory inclusion depends on
the runtime: `filtergc` uses its documented default executor-function exclusion.

Reports are bounded, lossy Lua-style diagnostics, not runnable reconstruction.
They preserve common Roblox vector/color/CFrame/layout values; unsupported
types, shared references, cycles, and depth/size limits are marked as partial.
Snapshot comparisons cover captured values only. Instance paths use
`FindFirstChild`; duplicate sibling names can make a copied path ambiguous.
Only client-visible instances are inventoried; streaming and replication affect
what appears. Server-only state and protected source are outside this view.

Remote capture keeps 500 records with a 100-events/second limit and a dropped
count. Logs retain 1,000 messages (16 KiB each); frame timing retains 120 frames.
Memory/frame diagnostics include this tool's overhead. Real rendering, text
selection, executor API behavior, and system clipboard access still need Roblox
runtime testing. Mock coverage includes cancellation, partial snapshots, cyclic
tables, raw text, nil arguments/returns, yielded hooks, error forwarding,
OTH target validation, failed restoration, selected outgoing traffic,
method-context preservation, empty branches, detached watches, typed return
overrides, original/modified reports, pending override cancellation, deferred
selection events, and rerun cleanup.

Roblox UI components live in `src/ui`. Build the app from `src/main.lua` with:

```sh
python3 tools/build.py
```

This writes `dist/DebugSuite.lua`. `src/Test.lua` demonstrates windows,
tabs, sections, and controls. Bundle that demo separately with:

```sh
darklua process src/Test.lua dist/Test.lua
```

To build without copying into the configured executor workspace:

```sh
python3 tools/build.py --no-copy
```

Tests run with `python3 tests/run.py`. `DARKLUA` and `LUAU` environment variables
can point at installed tool binaries when launcher shims are unavailable.

## Run locally without pasting the bundle

In `tools/build.py`, optionally set your executor's workspace folder:

```python
WORKSPACE = r"C:\Users\maxim\AppData\Local\Volt\workspace"
```

Run `python tools/build.py` after editing the source. It builds
`dist/DebugSuite.lua` and writes `tools/Bootstrap.lua`. Only `DebugSuite.lua`
is copied into the workspace when configured. Leave `WORKSPACE = r""`
to skip the workspace copy.

Paste the contents of [tools/Bootstrap.lua](tools/Bootstrap.lua) into your executor once and save
it. Run that saved script to load the latest workspace copy through
`loadfile("DebugSuite.lua")`.

## Notifications and console window

Every window has a **</> Console** topbar button that opens a draggable console.
Drag its bottom-right corner to resize it (minimum 360 × 200). Click either
window, including its controls, to bring it to the front. Opening the console
also focuses it; notifications stay above both windows.
Blank window areas also accept focus. Only the frontmost window under the
pointer can begin a drag or resize, and only one drag can run at a time.
Title-bar action buttons do not start a window drag.
Closing the console hides it and preserves its history; **Clear** removes entries.
It keeps the latest 1,000 entries, including messages received while hidden.

```lua
window:Notify({ text = "Saved", messageType = "success" })
window:Notify({ text = "Refresh failed\nFull error details", messageType = "error" })
window:Log("Starting refresh", "info") -- console only
window:OpenConsole()
```

Notification levels are `info`, `success`, `warning`, and `error`. Errors stay
until dismissed; other levels expire after five seconds. Set `duration` in
seconds to override this (`0` keeps it visible). `Notify` returns a component
you can dismiss with `:Destroy()`. Up to three notifications remain visible;
their full, unformatted messages stay in the console. **Details** opens it.

By default, Roblox `LogService.MessageOut` feeds client output into this console;
errors and warnings also create notifications. This includes output from other
client scripts. Use `Window.new({ captureLogs = false })` for manual logging only.
Executor output that bypasses Roblox's LogService requires explicit `Log` or
`Notify` calls. Destroying or rerunning the window cleans up both overlays and
the log subscription.

## Additional windows

The main window and console share `src/ui/WindowFrame.lua` for the frame,
topbar, buttons, dragging, resizing, visibility, and cleanup. A shared focus
registry orders all windows, with notifications above them.

Create another floating window with the same behavior:

```lua
local inspector = window:NewWindow({
    title = "Inspector",
    size = UDim2.fromOffset(500, 300),
    minSize = Vector2.new(300, 200),
    closeBehavior = "hide", -- default is "destroy"
})
local logs = inspector:NewConsole()
logs.frame.Size = UDim2.fromScale(1, 1)
inspector:AddTopbarButton("Clear", "Clear", function() logs:Clear() end)
inspector:Show() -- also brings it to the front
```

Floating windows support the existing container components. Their content area
fills the space below the topbar; use panels or rows to arrange multiple
components. `Hide`, `Toggle`, `Focus`, and `Destroy` are also available.
Destroying the main window cleans up all of its floating windows. Additional
windows do not replace the main window, create another log subscription, or
create consoles of their own.

## Lua syntax highlighting

Text viewers and consoles accept `syntax = "lua"` or `"luau"`. Omit it for
plain text. Both accept `syntaxTheme`, a table of `#RRGGBB` overrides for
`keyword`, `builtin`, `string`, `comment`, `number`, `operator`, `identifier`,
and `whitespace`.

```lua
local code = section:NewTextViewer({
    text = 'local message = "Hello"\nprint(message)',
    syntax = "lua",
    editable = true,
    height = 160,
    syntaxTheme = { keyword = "#FF80AA" },
})
code:SetText("return 42")
print(code:GetText()) -- original source, without formatting tags
code:SetSyntax(false) -- disable; use "lua" or "luau" to enable again

local console = section:NewConsole({ syntax = "lua" })
console:NewEntry("print(42)", "info")
```

The viewer keeps colors visible during selection and editing. Its underlying
TextBox stores raw source, so copying and change callbacks use the original
text without formatting tags. Console highlighting treats each entry as an
independent source fragment.

The demo's Code section includes **Copy all**, which calls
`setclipboard(code:GetText())`, and **View raw / View highlighted**, which
toggles `code:SetSyntax(false)` and `code:SetSyntax("lua")`. Use View raw for
native text selection. The Copy all button requires your runtime to provide
`setclipboard`.

Use the module directly for any Roblox RichText label or button:

```lua
local SyntaxHighlight = require("./ui/SyntaxHighlight") -- relative to src
label.RichText = true
label.Text = SyntaxHighlight.Highlight(source)
local tokens = SyntaxHighlight.Tokenize(source)
-- Each token has kind, text, and inclusive start/finish byte offsets.
```

The lexer recognizes escaped quotes, long-bracket strings and comments,
decimal/hex/binary numbers, and common Lua/Roblox built-ins. Backtick strings
are colored as a whole, including interpolation expressions. It is a lexical
highlighter, so it does not resolve variables or validate syntax. Source text
is escaped before formatting, including text that looks like RichText tags.

Run the lexer and component smoke checks with `python3 tests/run.py` (requires
`darklua` and `luau`).

## Executor references

See [docs/executor/README.md](docs/executor/README.md) for the imported sUNC
and Volt API docs. [AGENTS.md](AGENTS.md) contains the short project working
guide.
