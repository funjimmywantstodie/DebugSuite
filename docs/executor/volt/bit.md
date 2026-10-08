# Bit

Source: <https://docs.voltbz.net/docs/bit>. Checked 2026-09-22.

Enable **Bit Library** in Volt's client settings before calling these functions. Results use 32-bit unsigned integer arithmetic. Variadic operations skip values that cannot be converted to unsigned integers.

```luau
bit.badd(...: number) -> number
bit.bsub(...: number) -> number
bit.bmul(...: number) -> number
bit.bdiv(...: number) -> number
bit.band(...: number) -> number
bit.bor(...: number) -> number
bit.bxor(...: number) -> number
bit.bnot(value: number) -> number
bit.bswap(value: number) -> number
bit.ror(value: number, count: number) -> number
bit.rol(value: number, count: number) -> number
bit.lshift(value: number, count: number) -> number
bit.rshift(value: number, count: number) -> number
bit.arshift(value: number, count: number) -> number
bit.tohex(value: number) -> string
bit.tobit(value: number) -> number
```
