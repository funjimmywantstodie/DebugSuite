# Debug

Source: https://docs.sunc.su/Debug/

All functions in this section reject C closures — only Luau closures supported.
`func` arg accepts a function OR a stack level (number).

### debug.getconstant
`debug.getconstant(func: fn | number, index: number): number | string | boolean | nil`
Constant at `index` in the function's bytecode constant table.

### debug.getconstants
`debug.getconstants(func: fn | number): { number | string | boolean | nil }`
All bytecode constants embedded in the function.

### debug.getproto
`debug.getproto(func: fn | number, index: number, activated: boolean?): fn | { fn }`
Nested function prototype at `index`. With `activated=true`, returns currently-live closures of that proto.
**Note:** Inactive protos (default) are non-callable, info only.

### debug.getprotos
`debug.getprotos(func: fn | number): { fn }`
All nested function prototypes (inactive — info only).

### debug.getstack
`debug.getstack(level: number, index: number?): any | { any }`
Value at `index` of stack frame `level`, or all values if `index` omitted.
**Note:** `level=0` fails (C closure).

### debug.getupvalue
`debug.getupvalue(func: fn | number, index: number): any`
Upvalue at `index` of the function's closure.

### debug.getupvalues
`debug.getupvalues(func: fn | number): { any }`
All upvalues of the function.

### debug.setconstant
`debug.setconstant(func: fn | number, index: number, value: number | string | boolean | nil): ()`
Overwrite constant at `index` — alter behaviour without touching source.

### debug.setstack
`debug.setstack(level: number, index: number, value: any): ()`
Overwrite stack value at frame `level`, position `index`.

### debug.setupvalue
`debug.setupvalue(func: fn | number, index: number, value: any): ()`
Overwrite upvalue at `index`.
