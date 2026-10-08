# Encoding

Source: <https://docs.voltbz.net/docs/encoding>. Checked 2026-09-22.

Volt API quick reference. Follow a function link for parameter details and examples.

The Base64 functions also have `crypt.base64encode` and `crypt.base64decode` aliases. LZ4 also has `crypt.lz4compress` and `crypt.lz4decompress` aliases. The individual pages list other aliases.

## [base64decode](https://docs.voltbz.net/docs/encoding/base64decode)

Decodes a Base64 encoded string.

```luau
base64decode(data: string) -> string
```

## [base64encode](https://docs.voltbz.net/docs/encoding/base64encode)

Encodes data to Base64 format.

```luau
base64encode(data: string) -> string
```

## [lz4compress](https://docs.voltbz.net/docs/encoding/lz4compress)

Compresses data using the LZ4 algorithm.

```luau
lz4compress(data: string) -> string
```

## [lz4decompress](https://docs.voltbz.net/docs/encoding/lz4decompress)

Decompresses LZ4 compressed data.

```luau
lz4decompress(data: string, size: number) -> string
```
