# SimpleUI

Roblox UI components live in `src/ui`. `src/Test.lua` demonstrates windows,
tabs, sections, and controls. Bundle the demo with:

```sh
darklua process src/Test.lua dist/Test.lua
```

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
