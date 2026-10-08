# Encoding

Source: https://docs.sunc.su/Encoding/

### base64encode
`base64encode(data: string): string`
Encode binary-safe string (null bytes OK) as Base64.

### base64decode
`base64decode(data: string): string`
Decode Base64 string to original bytes.

### lz4compress
`lz4compress(data: string): string`
LZ4-compress string. Returns binary string.

### lz4decompress
`lz4decompress(data: string): string`
LZ4-decompress (input must come from `lz4compress`).
