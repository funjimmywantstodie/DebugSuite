# Drawing

Source: <https://docs.voltbz.net/docs/drawing>. Checked 2026-09-22.

Volt API quick reference. Follow a function link for parameter details and examples.

## [cleardrawcache](https://docs.voltbz.net/docs/drawing/cleardrawcache)

Stops all drawing objects from rendering.

```luau
cleardrawcache() -> ()
```

## [DrawFont](https://docs.voltbz.net/docs/drawing/drawfont)

Registers and measures fonts used by Drawing text APIs.

```luau
DrawFont.Register(data: string, options: DrawFontOptions) -> DrawFont?
font:GetTextBounds(size: number, text: string) -> Vector2
```

## [getrenderproperty](https://docs.voltbz.net/docs/drawing/getrenderproperty)

Gets a property value from a drawing object.

```luau
getrenderproperty(drawing: Drawing, property: string) -> any
```

## [DrawingImmediate](https://docs.voltbz.net/docs/drawing/immediate)

Draws transient primitives from a render-frame callback.

```luau
DrawingImmediate.Line(p1: Vector2, p2: Vector2, color: Color3, opacity: number, thickness: number) -> ()

DrawingImmediate.Circle(center: Vector2, radius: number, color: Color3, opacity: number, numSides: number, thickness: number) -> ()
DrawingImmediate.FilledCircle(center: Vector2, radius: number, color: Color3, opacity: number, numSides: number) -> ()

DrawingImmediate.Triangle(p1: Vector2, p2: Vector2, p3: Vector2, color: Color3, opacity: number, thickness: number) -> ()
DrawingImmediate.FilledTriangle(p1: Vector2, p2: Vector2, p3: Vector2, color: Color3, opacity: number) -> ()

DrawingImmediate.Rectangle(topLeft: Vector2, size: Vector2, color: Color3, opacity: number, rounding: number, thickness: number) -> ()
DrawingImmediate.FilledRectangle(topLeft: Vector2, size: Vector2, color: Color3, opacity: number, rounding: number) -> ()

DrawingImmediate.Quad(p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, color: Color3, opacity: number, thickness: number) -> ()
DrawingImmediate.FilledQuad(p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, color: Color3, opacity: number) -> ()

DrawingImmediate.Text(position: Vector2, font: DrawFont | number, fontSize: number, color: Color3, opacity: number, text: string, center: boolean) -> ()
DrawingImmediate.OutlinedText(position: Vector2, font: DrawFont | number, fontSize: number, color: Color3, opacity: number, outlineColor: Color3, outlineOpacity: number, text: string, center: boolean) -> ()
```

## [isrenderobj](https://docs.voltbz.net/docs/drawing/isrenderobj)

Checks if a value is a drawing object.

```luau
isrenderobj(value: any) -> boolean
```

## [setrenderproperty](https://docs.voltbz.net/docs/drawing/setrenderproperty)

Sets a property value on a drawing object.

```luau
setrenderproperty(drawing: Drawing, property: string, value: any) -> ()
```
