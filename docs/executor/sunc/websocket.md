# WebSocket

Source: https://docs.sunc.su/WebSocket/

### WebSocket.connect
`WebSocket.connect(url: string): WebSocket`
Open a connection. URL must be `ws://` or `wss://` (most validators require `wss://`).

### WebSocket object

| Member | Signature | Purpose |
|---|---|---|
| `:Send(msg)` | `(msg: string) -> ()` | Send a text frame |
| `:Close()` | `() -> ()` | Close the connection |
| `.OnMessage` | `RBXScriptSignal(msg: string)` | Fires per inbound message |
| `.OnClose` | `RBXScriptSignal()` | Fires when connection closes |

Client-only. No server-side WebSocket support.
