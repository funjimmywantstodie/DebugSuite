# VoltSignal

Source: <https://docs.voltbz.net/docs/voltsignal>. Checked 2026-09-22.

Volt API quick reference. Follow a function link for parameter details and examples.

## [VoltSignal:Connect](https://docs.voltbz.net/docs/voltsignal/connect)

Connects a handler function to the signal.

```luau
VoltSignal:Connect(f: function) -> VoltConnection
```

## [VoltConnection.Connected](https://docs.voltbz.net/docs/voltsignal/connected)

Reports whether a VoltConnection is still active.

```luau
connection.Connected: boolean
```

## [VoltConnection:Disconnect](https://docs.voltbz.net/docs/voltsignal/disconnect)

Disconnects the connection from the signal.

```luau
VoltConnection:Disconnect() -> ()
```

## [VoltSignal:Fire](https://docs.voltbz.net/docs/voltsignal/fire)

Fires the signal with the given arguments.

```luau
VoltSignal:Fire(...: any) -> ()
```

## [VoltSignal.new](https://docs.voltbz.net/docs/voltsignal/new)

Creates a new VoltSignal instance.

```luau
VoltSignal.new() -> VoltSignal
```

## [VoltSignal:Once](https://docs.voltbz.net/docs/voltsignal/once)

Connects a handler that disconnects itself after the signal fires once.

```luau
VoltSignal:Once(f: function) -> VoltConnection
```

## [VoltSignal:Wait](https://docs.voltbz.net/docs/voltsignal/wait)

Yields the current thread until the signal fires.

```luau
VoltSignal:Wait() -> any
```
