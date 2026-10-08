-- Volt executor API — luau-lsp definition file.
--
-- Based on docs/, the local quick reference to https://docs.voltbz.net/docs (checked 2026-09-22).
-- This file is NEVER executed. It exists only so luau-lsp stops flagging executor globals as
-- unknown, and so completion knows their parameter names and return types.
--
-- Wired up by .vscode/settings.json -> luau-lsp.types.definitionFiles.
-- When docs/ changes, change this to match. Anything not in docs/ does not belong here.
--
-- Only documented Volt names belong here. Check docs/ when an API changes.

-- ============================================================================
-- Shared types
-- ============================================================================

type DebugInfo = {
	source: string,
	short_src: string,
	func: ((...any) -> ...any) | ProtoProxy,
	what: string,
	currentline: number,
	name: string,
	nups: number,
	numparams: number,
	is_vararg: number,
}

type ConnectionObject = {
	Enabled: boolean,
	ForeignState: boolean,
	LuaConnection: boolean,
	LuaWaitConnection: boolean,
	Function: ((...any) -> ...any)?,
	Thread: thread?,
	Fire: (self: ConnectionObject, ...any) -> (),
	Defer: (self: ConnectionObject, ...any) -> (),
	Disconnect: (self: ConnectionObject) -> (),
	Disable: (self: ConnectionObject) -> (),
	Enable: (self: ConnectionObject) -> (),
}

type HttpRequest = {
	Url: string,
	Method: string,
	Body: string?,
	Headers: { [string]: string }?,
	Cookies: { [string]: string }?,
}

-- The upstream docs specify the request shape but not the response shape, so this stays open
-- rather than being guessed at. Index it and check at runtime.
type HttpResponse = { [string]: any }

-- Drawing.new returns a different shape per type string. Flattened into one type here so every
-- property completes; the LSP will not catch you setting .Radius on a Line.
type DrawingObject = {
	-- BaseDrawingObject
	Visible: boolean,
	ZIndex: number,
	Transparency: number,
	Color: Color3,
	__OBJECT_EXISTS: boolean,
	Remove: (self: DrawingObject) -> (),
	Destroy: (self: DrawingObject) -> (),
	-- Line
	From: Vector2,
	To: Vector2,
	Thickness: number,
	-- Text
	Text: string,
	TextBounds: Vector2,
	Font: number,
	Size: Vector2,
	Position: Vector2,
	Center: boolean,
	Outline: boolean,
	OutlineColor: Color3,
	-- Image
	Data: string,
	Rounding: number,
	-- Circle
	NumSides: number,
	Radius: number,
	Filled: boolean,
	-- Quad / Triangle
	PointA: Vector2,
	PointB: Vector2,
	PointC: Vector2,
	PointD: Vector2,
}

type WebSocketConnection = {
	Send: (self: WebSocketConnection, message: string, isBinary: boolean?) -> (),
	Close: (self: WebSocketConnection) -> (),
	OnMessage: VoltSignal,
	OnClose: VoltSignal,
}

type VoltConnection = {
	Connected: boolean,
	Disconnect: (self: VoltConnection) -> (),
}

type VoltSignal = {
	Connect: (self: VoltSignal, callback: (...any) -> ()) -> VoltConnection,
	Once: (self: VoltSignal, callback: (...any) -> ()) -> VoltConnection,
	Fire: (self: VoltSignal, ...any) -> (),
	Wait: (self: VoltSignal) -> ...any,
}

type LuaStateProxy = {
	Id: number?,
	IsActorState: boolean,
	Event: VoltSignal,
	Execute: (self: LuaStateProxy, source: string, ...any) -> (),
	GetActors: (self: LuaStateProxy) -> { Actor },
}

type RakNetPacket = {
	AsBuffer: buffer,
	AsString: string,
	AsArray: { number },
	PacketId: number,
	Priority: number,
	Reliability: number,
	OrderingChannel: number,
	Size: number,
	SetData: (self: RakNetPacket, data: buffer | string | { number }) -> (),
	Block: (self: RakNetPacket) -> (),
}

type ProtoProxy = { CodeHash: number }

type TrampolineCallFrame = { currentline: number, func: (...any) -> ...any }
type TrampolineThreadOptions = { script: Instance?, identity: number?, env: { [any]: any }?, thread: thread? }

-- ============================================================================
-- Environment and scripts
-- ============================================================================

declare function getgc(includetables: boolean?): { any }
declare function filtergc(kind: "function" | "table", options: { [string]: any }, returnOne: boolean?): any
declare function getallthreads(): { thread }
declare function getgenv(): { [string]: any }
declare function gettenv(thread: thread?): { [string]: any }?
declare function getreg(): { any }
declare function getrenv(): { [string]: any }
declare function getsenv(script: Instance): { [string]: any }
declare function decompile(source: Instance | string, options: any?): string
declare function getcallingscript(): Instance?
declare function getfunctionbytecode(func: (...any) -> ...any): string
declare function getloadedmodules(): { ModuleScript }
declare function getmodules(): { ModuleScript }
declare function getrunningscripts(): { Instance }
declare function getscripts(): { Instance }
declare function getscriptbytecode(script: Instance): string
declare function getscriptclosure(script: Instance): ((...any) -> ...any) | string
declare function getscriptfromthread(thread: thread): Instance?
declare function getscriptthread(script: Instance): thread?
declare function getscripthash(script: Instance): string?
declare function isexecutorthread(thread: thread?): boolean
declare function loadstring(source: string, chunkname: string?): (((...any) -> ...any)?, string?)
declare function getthreadidentity(): number
declare function setthreadidentity(identity: number): ()

-- ============================================================================
-- Closures  (docs/closures.md)
-- ============================================================================

declare function checkcaller(): boolean
declare function clonefunction<A..., R...>(func: (A...) -> R...): (A...) -> R...
declare function getfunctionhash(func: (...any) -> ...any): string
declare function hookfunction<A..., R...>(func: (A...) -> R..., hook: (A...) -> R...): (A...) -> R...
declare function hookproto(proto: ProtoProxy, hook: (...any) -> ...any): ()
declare function iscclosure(func: (...any) -> ...any): boolean
declare function islclosure(func: (...any) -> ...any): boolean
declare function isexecutorclosure(func: (...any) -> ...any): boolean
declare function isfunctionhooked(func: (...any) -> ...any): boolean
declare function isnewcclosure(func: (...any) -> ...any): boolean
declare function isprotohooked(proto: ProtoProxy): boolean
declare function newcclosure<A..., R...>(func: (A...) -> R..., debugname: string?): (A...) -> R...
declare function newlclosure<A..., R...>(func: (A...) -> R..., debugname: string?): (A...) -> R...
declare function restorefunction(func: (...any) -> ...any): ()
declare function restoreproto(proto: ProtoProxy): ()
declare function setstackhidden(funcOrLevel: ((...any) -> ...any) | number, hidden: boolean): ()
declare function trampoline_call(func: (...any) -> ...any, callstack: { TrampolineCallFrame }, threadOptions: TrampolineThreadOptions, ...: any): (boolean, ...any)

-- ============================================================================
-- Metatable  (docs/metatable.md)
-- ============================================================================

declare function getrawmetatable(object: any): any
declare function setrawmetatable<T>(object: T, metatable: any): T
declare function hookmetamethod(object: any, method: string, hook: (...any) -> ...any): (...any) -> ...any
declare function getnamecallmethod(): string?
declare function setnamecallmethod(method: string): ()
declare function isreadonly(object: any): boolean
declare function iswritable(object: any): boolean
declare function setreadonly(object: any, readonly: boolean): ()
declare function makereadonly(object: any): ()
declare function makewritable(object: any): ()

-- ============================================================================
-- Debug  (docs/debug.md)
--
-- The first seven members are Roblox's own debug library, restated verbatim: a definition file
-- replaces a global's type rather than merging into it, so dropping them here would delete
-- debug.info and debug.traceback from completion.
-- ============================================================================

declare debug: {
	info: (<R...>(thread, number, string) -> R...) & (<R...>(number, string) -> R...) & (<A..., R1..., R2...>((A...) -> R1..., string) -> R2...),
	traceback: ((string?, number?) -> string) & ((thread, string?, number?) -> string),
	profilebegin: (label: string) -> (),
	profileend: () -> (),
	getmemorycategory: () -> string,
	setmemorycategory: (tag: string) -> (),
	resetmemorycategory: () -> (),

	validlevel: (level: number, thread: thread?) -> boolean,
	isvalidlevel: (level: number, thread: thread?) -> boolean,
	getcallstack: (thread: thread?) -> { { func: (...any) -> ...any, currentline: number? } },
	getconstant: (func: any, index: number) -> any,
	getconstants: (func: any) -> { any },
	getinfo: (func: any) -> DebugInfo,
	getproto: (func: any, index: number, active: boolean?) -> ProtoProxy | { (...any) -> ...any },
	getprotos: (func: any) -> { ProtoProxy },
	getstack: (level: number, index: number?) -> any,
	getupvalue: (func: any, index: number) -> any,
	getupvalues: (func: any) -> { any },
	setconstant: (func: any, index: number, value: any) -> (...any) -> ...any,
	setinfo: (func: any, info: { [string]: any }) -> (),
	setstack: (level: number, index: number, value: any) -> (),
	setupvalue: (func: any, index: number, value: any) -> (),
}

declare function validlevel(level: number, thread: thread?): boolean
declare function isvalidlevel(level: number, thread: thread?): boolean
declare function getcallstack(thread: thread?): { any }
declare function getconstant(func: any, index: number): any
declare function getconstants(func: any): { any }
declare function getinfo(func: any): DebugInfo
declare function getproto(func: any, index: number, active: boolean?): any
declare function getprotos(func: any): { any }
declare function getstack(level: number, index: number?): any
declare function getupvalue(func: any, index: number): any
declare function getupvalues(func: any): { any }
declare function setconstant(func: any, index: number, value: any): (...any) -> ...any
declare function setinfo(func: any, info: { [string]: any }): ()
declare function setstack(level: number, index: number, value: any): ()
declare function setupvalue(func: any, index: number, value: any): ()

-- ============================================================================
-- Instances, signals, and reflection
-- ============================================================================

declare function getconnections(signal: RBXScriptSignal): { ConnectionObject }
declare function get_signal_cons(signal: RBXScriptSignal): { ConnectionObject }
declare function cansignalreplicate(signal: RBXScriptSignal): boolean
declare function getsignalarguments(signal: RBXScriptSignal): { any }
declare function getsignalargumentsinfo(signal: RBXScriptSignal): { any }
declare function getsignalwhitelist(): { any }
declare function firesignal(signal: RBXScriptSignal, ...: any): ()
declare function replicatesignal(signal: RBXScriptSignal, ...: any): ()
declare function fireclickdetector(object: ClickDetector, distance: number?, event: string?): ()
declare function fireproximityprompt(prompt: ProximityPrompt): ()
declare function firetouchinterest(instance: BasePart, touchingPart: BasePart, isTouching: boolean | number): ()
declare function gethiddenproperties(object: Instance): { [string]: any }
declare function getproperties(object: Instance): { [string]: any }
declare function gethiddenproperty(object: Instance, property: string): (any, boolean)
declare function sethiddenproperty(object: Instance, property: string, value: any): boolean
declare function isscriptable(object: Instance, property: string): boolean
declare function setscriptable(object: Instance, property: string, value: boolean): boolean
declare function getcallbackvalue(object: Instance, property: string, returnRaw: boolean?): any
declare function getcallbackmember(object: Instance, property: string, returnRaw: boolean?): any
declare function getcustomasset(path: string): string
declare function gethui(): Instance
declare function getinstancecache(): { Instance }
declare function getinstances(): { Instance }
declare function getnilinstances(): { Instance }
declare function getrendersteppedlist(): { any }
declare function isnetworkowner(part: Instance): boolean
declare function setsimulationradius(...: any): ()

-- ============================================================================
-- Cache  (docs/cache.md)
-- ============================================================================

declare cache: {
	invalidate: (object: Instance) -> (),
	iscached: (object: Instance) -> boolean,
	replace: (object: Instance, newobject: Instance) -> (),
}

declare function cloneref<T>(object: T & Instance): T
declare function compareinstances(a: Instance, b: Instance): boolean

-- ============================================================================
-- File system  (docs/file-system.md)
-- ============================================================================

declare function readfile(path: string): string
declare function writefile(path: string, data: string): ()
declare function appendfile(path: string, data: string): ()
declare function delfile(path: string): ()
declare function isfile(path: string): boolean
declare function listfiles(path: string): { string }
declare function makefolder(path: string): ()
declare function delfolder(path: string): ()
declare function isfolder(path: string): boolean
declare function loadfile(path: string): (((...any) -> ...any)?, string?)
declare function dofile(path: string): ()

-- ============================================================================
-- Crypt  (docs/crypt.md)
-- ============================================================================

declare crypt: {
	base64encode: (data: string) -> string,
	base64decode: (data: string) -> string,
	encrypt: (data: string, key: string, iv: string?, mode: string?) -> (string, string),
	decrypt: (data: string, key: string, iv: string, mode: string) -> string,
	generatebytes: (size: number) -> string,
	generatekey: () -> string,
	hash: (data: string, algo: string, key: string?) -> string,
	hmac: (key: string, data: string, algorithm: string) -> string,
	random: (length: number) -> string,
	lz4compress: (data: string) -> string,
	lz4decompress: (data: string, size: number) -> string,
}

declare function base64encode(data: string): string
declare function base64decode(data: string): string

-- ============================================================================
-- Console  (docs/console.md)
-- Volt console
-- ============================================================================

declare function rconsoleprint(data: any, async: boolean?, escape: boolean?): ()
declare function rconsolewarn(data: any, async: boolean?): ()
declare function rconsoleerr(data: any, async: boolean?): ()
declare function rconsoleinfo(data: any, async: boolean?): ()
declare function rconsoleclear(): ()
declare function rconsoleshow(): ()
declare function rconsolehide(): ()
declare function rconsoletoggle(): ()
declare function rconsolehidden(): boolean
declare function rconsoletop(shouldBeTop: boolean): ()
declare function rconsoleinput(): string
declare function rconsolename(title: string): ()

-- ============================================================================
-- Input  (docs/input.md)
-- ============================================================================

declare function iswindowactive(): boolean
declare function keyclick(keycode: number): ()
declare function keypress(keycode: number): ()
declare function keyrelease(keycode: number): ()
declare function mouse1click(): ()
declare function mouse1press(): ()
declare function mouse1release(): ()
declare function mouse2click(): ()
declare function mouse2press(): ()
declare function mouse2release(): ()
declare function mousemoveabs(x: number, y: number): ()
declare function mousemoverel(x: number, y: number): ()
declare function mousescroll(pixels: number): ()

-- ============================================================================
-- Drawing  (docs/drawing.md)
-- ============================================================================

declare Drawing: {
	new: (type: string) -> DrawingObject,
	Fonts: {
		UI: number,
		System: number,
		Plex: number,
		Monospace: number,
	},
}

declare DrawFont: {
	Register: (data: string, options: { [string]: any }) -> any,
}

declare DrawingImmediate: {
	Line: (p1: Vector2, p2: Vector2, color: Color3, opacity: number, thickness: number) -> (),
	Circle: (center: Vector2, radius: number, color: Color3, opacity: number, numSides: number, thickness: number) -> (),
	FilledCircle: (center: Vector2, radius: number, color: Color3, opacity: number, numSides: number) -> (),
	Triangle: (p1: Vector2, p2: Vector2, p3: Vector2, color: Color3, opacity: number, thickness: number) -> (),
	FilledTriangle: (p1: Vector2, p2: Vector2, p3: Vector2, color: Color3, opacity: number) -> (),
	Rectangle: (topLeft: Vector2, size: Vector2, color: Color3, opacity: number, rounding: number, thickness: number) -> (),
	FilledRectangle: (topLeft: Vector2, size: Vector2, color: Color3, opacity: number, rounding: number) -> (),
	Quad: (p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, color: Color3, opacity: number, thickness: number) -> (),
	FilledQuad: (p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, color: Color3, opacity: number) -> (),
	Text: (position: Vector2, font: any, fontSize: number, color: Color3, opacity: number, text: string, center: boolean) -> (),
	OutlinedText: (position: Vector2, font: any, fontSize: number, color: Color3, opacity: number, outlineColor: Color3, outlineOpacity: number, text: string, center: boolean) -> (),
}

declare function cleardrawcache(): ()
declare function getrenderproperty(drawing: DrawingObject, property: string): any
declare function setrenderproperty(drawing: DrawingObject, property: string, value: any): ()
declare function isrenderobj(object: any): boolean

declare bit: {
	badd: (...number) -> number, bsub: (...number) -> number,
	bmul: (...number) -> number, bdiv: (...number) -> number,
	band: (...number) -> number, bor: (...number) -> number,
	bxor: (...number) -> number,
	bnot: (number) -> number, bswap: (number) -> number,
	ror: (number, number) -> number, rol: (number, number) -> number,
	lshift: (number, number) -> number, rshift: (number, number) -> number,
	arshift: (number, number) -> number,
	tohex: (number) -> string, tobit: (number) -> number,
}

declare VoltSignal: { new: () -> VoltSignal }
declare Signal: { new: () -> VoltSignal }
declare LuaStateProxy: { new: () -> LuaStateProxy? }

declare oth: {
	hook: (target: (...any) -> ...any, hook: (...any) -> ...any) -> (...any) -> ...any,
	unhook: (target: (...any) -> ...any) -> boolean,
	get_root_callback: () -> ((...any) -> ...any)?,
	get_original_thread: () -> thread?,
	is_hook_thread: () -> boolean,
}

-- ============================================================================
-- Actor / parallel Luau  (docs/actor.md)
-- ============================================================================

declare function create_comm_channel(): (number, any)
declare function get_comm_channel(id: number): BindableEvent
declare function run_on_actor(actor: Actor, script: string, ...: any): ()
declare function getactors(): { Actor }
declare function get_current_actor(): Actor?
declare function getactorstates(): { LuaStateProxy }
declare function getgamestate(): LuaStateProxy?
declare function getluastate(actorOrScript: Instance?): LuaStateProxy?
declare function isparallel(): boolean
declare on_actor_state_created: VoltSignal

-- ============================================================================
-- Web sockets  (docs/web-sockets.md)
-- ============================================================================

declare WebSocket: {
	connect: (url: string) -> WebSocketConnection,
}

declare raknet: {
	add_send_hook: (hook: (RakNetPacket) -> ()) -> (),
	remove_send_hook: (hook: (RakNetPacket) -> ()) -> (),
	is_enabled: () -> boolean,
	send: (data: buffer | string | { number }, priority: number?, reliability: number?, ordering_channel: number?) -> (),
}

-- ============================================================================
-- Miscellaneous  (docs/miscellaneous.md)
-- ============================================================================

declare function identifyexecutor(): (string, string)
declare function request(options: HttpRequest): HttpResponse
declare function lz4compress(data: string): string
declare function lz4decompress(data: string, size: number): string
declare function getfflag(fflag: string): string
declare function setfflag(fflag: string, value: string): ()
declare function getfpscap(): number
declare function gethwid(): string
declare function get_process_identifier(): number
declare function setclipboard(text: any): ()
declare function setrbxclipboard(text: any): ()
declare function setfpscap(fps: number): ()
declare function messagebox(text: string, caption: string, flags: number): number
declare function queueonteleport(code: string): ()
declare function clearqueueonteleport(): ()
declare function saveinstance(root: Instance | { Instance }, options: any?): ()
declare function saveplace(options: any?): ()
