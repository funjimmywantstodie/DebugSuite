# Miscellaneous

Source: https://docs.sunc.su/Miscellaneous/

### identifyexecutor
`identifyexecutor(): (string, string)`
Returns `(name, version)` of the running executor.

### request
```lua
request(opts: {
    Url:     string,
    Method:  "GET" | "HEAD" | "POST" | "PUT" | "DELETE" | "OPTIONS" | "PATCH",
    Body:    string?,
    Headers: { [string]: string }?,
    Cookies: { [string]: string }?,
}): {
    Success:       boolean,
    StatusCode:    number,
    StatusMessage: string,
    Body:          string,
    Headers:       { [string]: string },
}
```
Yields until HTTP response.
**Note:** Executor auto-injects 3 headers: unique user id, HWID fingerprint, executor User-Agent.
