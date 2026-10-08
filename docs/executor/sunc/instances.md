# Instances

Source: https://docs.sunc.su/Instances/

### cloneref
`cloneref<T>(obj: T & Instance): T`
Duplicate reference behaves identically but fails `==`. Used to defeat weak-table tracking of services (`game.CoreGui`, etc.).

### compareinstances
`compareinstances(a: Instance, b: Instance): boolean`
True if both refs point to the same underlying instance. Works through `cloneref`'d copies that `==` would miss.

### getinstances
`getinstances(): { Instance }`
Every Instance in memory — including those parented to `nil`.

### getnilinstances
`getnilinstances(): { Instance }`
Only unparented (nil-parent) instances.

### gethui
`gethui(): BasePlayerGui | Folder`
Concealed UI container designed to evade detection of injected GUIs.

### getcallbackvalue
`getcallbackvalue(inst: Instance, property: string): any | nil`
Read write-only callback properties (e.g. `RemoteFunction.OnClientInvoke`). `nil` if unset/missing.

### fireclickdetector
`fireclickdetector(d: ClickDetector, distance: number?, event: string?): ()`
Trigger a ClickDetector event (default `"MouseClick"`). Distance arg matches the server's `MaxActivationDistance` check.

```lua
-- Buy every shop item without walking to each detector
for _, det in ipairs(workspace.Shop:GetDescendants()) do
    if det:IsA("ClickDetector") then fireclickdetector(det, 0) end
end
```

### fireproximityprompt
`fireproximityprompt(p: ProximityPrompt): ()`
Instant-trigger, bypasses `HoldDuration` + distance.

```lua
-- Open every chest in the dungeon at once (no need to walk + hold E)
for _, p in ipairs(workspace.Dungeon:GetDescendants()) do
    if p:IsA("ProximityPrompt") then fireproximityprompt(p) end
end
```

### firetouchinterest
`firetouchinterest(p1: BasePart, p2: BasePart, toggle: number): ()`
Simulate `.Touched` between two parts. `0` = begin (fires server-side handlers), `1` = end. Server-side handlers cannot distinguish a real character touch from this. **The canonical tycoon-game bypass** — every Buy/Sell/Collect/Upgrade pad lives on a server `:Touched` handler that just checks "did a HumanoidRootPart touch me." Use HRP as p1.

```lua
-- Drain a Cash-collect pad without walking
local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
local pad = workspace.Plots.Plot1.Pads.CollectCashPad
for i = 1, 20 do
    firetouchinterest(hrp, pad, 0)
    firetouchinterest(hrp, pad, 1)
end
```

Notes for all three: server-side detection of these is rare in casual games but possible — the server can check `Player:GetDistanceFromCharacter` against the part position to gate. Pair with the harness `pad_dump` MCP tool to enumerate every Touched/Click/Prompt in a plot without hand-walking.
