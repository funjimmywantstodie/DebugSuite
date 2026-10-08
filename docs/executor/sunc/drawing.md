# Drawing

Source: https://docs.sunc.su/Drawing/

`Drawing.new(class: string): Drawing` — top-level constructor (Line, Square, Circle, Triangle, Text, Image, Quad).

### cleardrawcache
`cleardrawcache(): ()`
Destroys all drawing objects created via `Drawing.new`.

### getrenderproperty
`getrenderproperty(d: Drawing, property: string): any`
Read a Drawing property by name (reflection-style).

### isrenderobj
`isrenderobj(v: any): boolean`
True iff `v` is a real Drawing object.

### setrenderproperty
`setrenderproperty(d: Drawing, property: string, value: any): ()`
Write a Drawing property by name.
