# RakNet

Source: <https://docs.voltbz.net/docs/raknet>. Checked 2026-09-22.

Enable **RakNet Library** under Settings → Client first. `add_send_hook` receives outgoing packets before they are sent. A packet object is valid only during its hook callback.

```luau
raknet.add_send_hook(hook: (packet: RakNetPacket) -> ()) -> ()
raknet.remove_send_hook(hook: (packet: RakNetPacket) -> ()) -> ()
raknet.is_enabled() -> boolean
raknet.send(data: buffer | string | {number}, priority?: number, reliability?: number, ordering_channel?: number) -> ()

RakNetPacket:SetData(data: buffer | string | {number}) -> ()
RakNetPacket:Block() -> ()
```

`RakNetPacket` exposes `AsBuffer`, `AsString`, `AsArray`, `PacketId`, `Priority`, `Reliability`, `OrderingChannel`, and `Size`. Priority ranges from 0 to 3 (default 2); reliability ranges from 0 to 7 (default 3); ordering channel ranges from 0 to 31. `send` requires a nonempty payload, and some packet IDs are rejected. See the source for protocol and usage details.
