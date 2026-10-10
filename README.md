# SimpleUI

Roblox UI components live in `src/ui`. Build the app from `src/main.lua` with:

```sh
python3 tools/build.py
```

This writes `dist/DebugSuite.lua`. `src/Test.lua` demonstrates windows,
tabs, sections, and controls. Bundle that demo separately with:

```sh
darklua process src/Test.lua dist/Test.lua
```

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
