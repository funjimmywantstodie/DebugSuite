# Signals

Source: <https://docs.voltbz.net/docs/signals>. Checked 2026-09-22.

Volt API quick reference. Follow a function link for parameter details and examples.

## [cansignalreplicate](https://docs.voltbz.net/docs/signals/cansignalreplicate)

Checks if a signal can be replicated to the server.

```luau
cansignalreplicate(signal: RBXScriptSignal) -> boolean
```

## [firesignal](https://docs.voltbz.net/docs/signals/firesignal)

Fires a signal with the given arguments.

```luau
firesignal(signal: RBXScriptSignal, ...: any) -> ()
```

## [getconnections](https://docs.voltbz.net/docs/signals/getconnections)

Alias: `get_signal_cons`. Each returned connection exposes `Enabled`, `ForeignState`, `LuaConnection`, `LuaWaitConnection`, `Function`, `Thread`, and `Fire`/`Defer`/`Disconnect`/`Disable`/`Enable` methods.

Gets all connections to a signal.

```luau
getconnections(signal: RBXScriptSignal) -> {Connection}
```

## [getsignalarguments](https://docs.voltbz.net/docs/signals/getsignalarguments)

Gets the argument types for a signal.

```luau
getsignalarguments(signal: RBXScriptSignal) -> table
```

## [getsignalargumentsinfo](https://docs.voltbz.net/docs/signals/getsignalargumentsinfo)

Gets detailed information about a signal's expected arguments.

```luau
getsignalargumentsinfo(signal: RBXScriptSignal) -> table
```

## [getsignalwhitelist](https://docs.voltbz.net/docs/signals/getsignalwhitelist)

Gets information about signals that support replication.

```luau
getsignalwhitelist() -> table
```

## [replicatesignal](https://docs.voltbz.net/docs/signals/replicatesignal)

Fires a signal with server replication.

```luau
replicatesignal(signal: RBXScriptSignal, ...: any) -> ()
```
