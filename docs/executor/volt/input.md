# Input

Source: <https://docs.voltbz.net/docs/input>. Checked 2026-09-22.

Volt API quick reference. Follow a function link for parameter details and examples.

## [iswindowactive](https://docs.voltbz.net/docs/input/iswindowactive)

Checks if the game window is currently focused.

```luau
iswindowactive() -> boolean
```

## [keyclick](https://docs.voltbz.net/docs/input/keyclick)

Simulates a complete key press and release.

```luau
keyclick(keycode: number) -> ()
```

## [keypress](https://docs.voltbz.net/docs/input/keypress)

Simulates pressing a keyboard key.

```luau
keypress(keycode: number) -> ()
```

## [keyrelease](https://docs.voltbz.net/docs/input/keyrelease)

Simulates releasing a keyboard key.

```luau
keyrelease(keycode: number) -> ()
```

## [mouse1click](https://docs.voltbz.net/docs/input/mouse1click)

Simulates a left mouse click.

```luau
mouse1click() -> ()
```

## [mouse1press](https://docs.voltbz.net/docs/input/mouse1press)

Simulates pressing the left mouse button.

```luau
mouse1press() -> ()
```

## [mouse1release](https://docs.voltbz.net/docs/input/mouse1release)

Simulates releasing the left mouse button.

```luau
mouse1release() -> ()
```

## [mouse2click](https://docs.voltbz.net/docs/input/mouse2click)

Simulates a right mouse click.

```luau
mouse2click() -> ()
```

## [mouse2press](https://docs.voltbz.net/docs/input/mouse2press)

Simulates pressing the right mouse button.

```luau
mouse2press() -> ()
```

## [mouse2release](https://docs.voltbz.net/docs/input/mouse2release)

Simulates releasing the right mouse button.

```luau
mouse2release() -> ()
```

## [mousemoveabs](https://docs.voltbz.net/docs/input/mousemoveabs)

Moves the mouse cursor to an absolute screen position.

```luau
mousemoveabs(x: number, y: number) -> ()
```

## [mousemoverel](https://docs.voltbz.net/docs/input/mousemoverel)

Moves the mouse cursor relative to its current position.

```luau
mousemoverel(dx: number, dy: number) -> ()
```

## [mousescroll](https://docs.voltbz.net/docs/input/mousescroll)

Simulates mouse wheel scrolling.

```luau
mousescroll(delta: number) -> ()
```
