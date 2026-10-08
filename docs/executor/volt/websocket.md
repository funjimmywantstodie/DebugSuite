# WebSocket

Source: <https://docs.voltbz.net/docs/websocket>. Checked 2026-09-22.

Volt API quick reference. Follow a function link for parameter details and examples.

## [WebSocket:Close](https://docs.voltbz.net/docs/websocket/close)

Closes the WebSocket connection.

```luau
WebSocket:Close() -> ()
```

## [WebSocket.connect](https://docs.voltbz.net/docs/websocket/connect)

Creates a new WebSocket connection to the specified URL.

```luau
WebSocket.connect(url: string) -> WebSocket
```

## [WebSocket.OnClose](https://docs.voltbz.net/docs/websocket/onclose)

Signal that fires when the WebSocket connection is closed.

```luau
WebSocket.OnClose:Connect(callback: () -> ()) -> VoltConnection
```

## [WebSocket.OnMessage](https://docs.voltbz.net/docs/websocket/onmessage)

Signal that fires when a message is received from the server.

```luau
WebSocket.OnMessage:Connect(callback: (message: string, isBinary: boolean) -> ()) -> VoltConnection
```

## [WebSocket:Send](https://docs.voltbz.net/docs/websocket/send)

Sends a message through the WebSocket connection.

```luau
WebSocket:Send(message: string, isBinary?: boolean) -> ()
```
