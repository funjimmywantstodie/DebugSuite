# Crypt

Source: <https://docs.voltbz.net/docs/crypt>. Checked 2026-09-22.

Volt API quick reference. Follow a function link for parameter details and examples.

## [crypt.decrypt](https://docs.voltbz.net/docs/crypt/decrypt)

Decrypts data using a specified algorithm and key.

```luau
crypt.decrypt(data: string, key: string, iv: string, mode?: string) -> string
```

## [crypt.encrypt](https://docs.voltbz.net/docs/crypt/encrypt)

Encrypts data using a specified algorithm and key.

```luau
crypt.encrypt(data: string, key: string, iv?: string, mode?: string) -> string, string
```

## [crypt.generatebytes](https://docs.voltbz.net/docs/crypt/generatebytes)

Generates cryptographically secure random bytes.

```luau
crypt.generatebytes(length: number) -> string
```

## [crypt.generatekey](https://docs.voltbz.net/docs/crypt/generatekey)

Generates a random encryption key.

```luau
crypt.generatekey() -> string
```

## [crypt.hash](https://docs.voltbz.net/docs/crypt/hash)

Generates a hash of the provided data.

```luau
crypt.hash(data: string, algorithm: string, key?: string) -> string
```

## [crypt.hmac](https://docs.voltbz.net/docs/crypt/hmac)

Generates an HMAC (Hash-based Message Authentication Code).

```luau
crypt.hmac(key: string, data: string, algorithm: string) -> string
```

## [crypt.random](https://docs.voltbz.net/docs/crypt/random)

Generates cryptographically secure random bytes.

```luau
crypt.random(length: number) -> string
```
