import os 'os'
import m 'math'

var libUrl: match os.system:
    'linux': 'https://raw.githubusercontent.com/fubark/ray-cyber/master/libraylib.so.4.5.0'
    'windows': 'https://raw.githubusercontent.com/fubark/ray-cyber/master/raylib.4.5.0.dll'
    'macos': 'https://raw.githubusercontent.com/fubark/ray-cyber/master/libraylib.4.5.0.dylib'
    else: throw error.Unsupported

var libPath: cacheUrl(libUrl)

-- Overrided bindings. See bottom for auto-generated API from cbindgen.cy.

func DrawText(text any, x number, y number, size number, color Color) none:
    cstr = os.cstr(text)
    (lib.DrawText)(cstr, x, y, size, color)
    os.free(cstr)
func InitWindow(width number, height number, title any) none:
    cstr = os.cstr(title)
    (lib.InitWindow)(width, height, cstr)
    os.free(cstr)
func LoadTexture(fileName any) Texture2D:
    cstr = os.cstr(fileName)
    res = (lib.LoadTexture)(cstr)
    os.free(cstr)
    return res
func MeasureText(text any, size number) number:
    cstr = os.cstr(text)
    res = (lib.MeasureText)(cstr, size)
    os.free(cstr)
    return res

type Vector2 object:
    x number
    y number

    func sub(v1, v2) Vector2:
        return Vector2{
            x: v1.x - v2.x,
            y: v1.y - v2.y,
        }

    func add(v1, v2) Vector2:
        return Vector2{
            x: v1.x + v2.x,
            y: v1.y + v2.y,
        }

    func scale(v, scale) Vector2:
        return Vector2{
            x: v.x * scale,
            y: v.y * scale,
        }

    func normalize(v) Vector2:
        res = Vector2{ x: 0, y: 0 }
        len = v.len()
        if len > 0:
            ilen = 1/len
            res.x = v.x*ilen
            res.y = v.y*ilen
        return res

    func len(self):
        return m.sqrt(self.x*self.x + self.y*self.y)

func toColor(r, g, b, a) Color:
    return Color{ r: r, g: g, b: b, a: a }

var LIGHTGRAY Color: toColor(200, 200, 200, 255)
var GRAY Color: toColor(130, 130, 130, 255)
var DARKGRAY Color: toColor(80, 80, 80, 255)
var YELLOW Color: toColor(253, 249, 0, 255)
var GOLD Color: toColor(255, 203, 0, 255)
var ORANGE Color: toColor(255, 161, 0, 255)
var PINK Color: toColor(255, 109, 194, 255)
var RED Color: toColor(230, 41, 55, 255)
var MAROON Color: toColor(190, 33, 55, 255)
var GREEN Color: toColor(0, 228, 48, 255)
var LIME Color: toColor(0, 158, 47, 255)
var DARKGREEN Color: toColor(0, 117, 44, 255)
var SKYBLUE Color: toColor(102, 191, 255, 255)
var BLUE Color: toColor(0, 121, 241, 255)
var DARKBLUE Color: toColor(0, 82, 172, 255)
var PURPLE Color: toColor(200, 122, 255, 255)
var VIOLET Color: toColor(135, 60, 190, 255)
var DARKPURPLE Color: toColor(112, 31, 126, 255)
var BEIGE Color: toColor(211, 176, 131, 255)
var BROWN Color: toColor(127, 106, 79, 255)
var DARKBROWN Color: toColor(76, 63, 47, 255)

var WHITE Color: toColor(255, 255, 255, 255)
var BLACK Color: toColor(0, 0, 0, 255)
var BLANK Color: toColor(0, 0, 0, 0)
var MAGENTA Color: toColor(255, 0, 255, 255)
var RAYWHITE Color: toColor(245, 245, 245, 255)

-- CBINDGEN MARKER
-- Skip type Vector2 object:
--   x number
--   y number

type Vector3 object:
  x number
  y number
  z number

type Vector4 object:
  x number
  y number
  z number
  w number

type Quaternion Vector4
type Matrix object:
  m0 number
  m4 number
  m8 number
  m12 number
  m1 number
  m5 number
  m9 number
  m13 number
  m2 number
  m6 number
  m10 number
  m14 number
  m3 number
  m7 number
  m11 number
  m15 number

type Color object:
  r number
  g number
  b number
  a number

type Rectangle object:
  x number
  y number
  width number
  height number

type Image object:
  data pointer -- ?*anyopaque
  width number
  height number
  mipmaps number
  format number

type Texture object:
  id number
  width number
  height number
  mipmaps number
  format number

type Texture2D Texture
type TextureCubemap Texture
type RenderTexture object:
  id number
  texture Texture
  depth Texture

type RenderTexture2D RenderTexture
type NPatchInfo object:
  source Rectangle
  left number
  top number
  right number
  bottom number
  layout number

type GlyphInfo object:
  value number
  offsetX number
  offsetY number
  advanceX number
  image Image

type Font object:
  baseSize number
  glyphCount number
  glyphPadding number
  texture Texture
  recs pointer -- [*c]Rectangle
  glyphs pointer -- [*c]GlyphInfo

type Camera3D object:
  position Vector3
  target Vector3
  up Vector3
  fovy number
  projection number

type Camera Camera3D
type Camera2D object:
  offset Vector2
  target Vector2
  rotation number
  zoom number

type Mesh object:
  vertexCount number
  triangleCount number
  vertices pointer -- [*c]f32
  texcoords pointer -- [*c]f32
  texcoords2 pointer -- [*c]f32
  normals pointer -- [*c]f32
  tangents pointer -- [*c]f32
  colors pointer -- [*c]u8
  indices pointer -- [*c]c_ushort
  animVertices pointer -- [*c]f32
  animNormals pointer -- [*c]f32
  boneIds pointer -- [*c]u8
  boneWeights pointer -- [*c]f32
  vaoId number
  vboId pointer -- [*c]c_uint

type Shader object:
  id number
  locs pointer -- [*c]c_int

type MaterialMap object:
  texture Texture
  color Color
  value number

type Material object:
  shader Shader
  maps pointer -- [*c]MaterialMap
  params List -- [4]f32

type Transform object:
  translation Vector3
  rotation Vector4
  scale Vector3

type BoneInfo object:
  name List -- [32]u8
  parent number

type Model object:
  transform Matrix
  meshCount number
  materialCount number
  meshes pointer -- [*c]Mesh
  materials pointer -- [*c]Material
  meshMaterial pointer -- [*c]c_int
  boneCount number
  bones pointer -- [*c]BoneInfo
  bindPose pointer -- [*c]Transform

type ModelAnimation object:
  boneCount number
  frameCount number
  bones pointer -- [*c]BoneInfo
  framePoses pointer -- [*c][*c]Transform

type Ray object:
  position Vector3
  direction Vector3

type RayCollision object:
  hit boolean
  distance number
  point Vector3
  normal Vector3

type BoundingBox object:
  min Vector3
  max Vector3

type Wave object:
  frameCount number
  sampleRate number
  sampleSize number
  channels number
  data pointer -- ?*anyopaque

type rAudioBuffer pointer
type rAudioProcessor pointer
type AudioStream object:
  buffer pointer -- ?*rAudioBuffer
  processor pointer -- ?*rAudioProcessor
  sampleRate number
  sampleSize number
  channels number

type Sound object:
  stream AudioStream
  frameCount number

type Music object:
  stream AudioStream
  frameCount number
  looping boolean
  ctxType number
  ctxData pointer -- ?*anyopaque

type VrDeviceInfo object:
  hResolution number
  vResolution number
  hScreenSize number
  vScreenSize number
  vScreenCenter number
  eyeToScreenDistance number
  lensSeparationDistance number
  interpupillaryDistance number
  lensDistortionValues List -- [4]f32
  chromaAbCorrection List -- [4]f32

type VrStereoConfig object:
  projection List -- [2]Matrix
  viewOffset List -- [2]Matrix
  leftLensCenter List -- [2]f32
  rightLensCenter List -- [2]f32
  leftScreenCenter List -- [2]f32
  rightScreenCenter List -- [2]f32
  scale List -- [2]f32
  scaleIn List -- [2]f32

type FilePathList object:
  capacity number
  count number
  paths pointer -- [*c][*c]u8

var FLAG_VSYNC_HINT number: 64
var FLAG_FULLSCREEN_MODE number: 2
var FLAG_WINDOW_RESIZABLE number: 4
var FLAG_WINDOW_UNDECORATED number: 8
var FLAG_WINDOW_HIDDEN number: 128
var FLAG_WINDOW_MINIMIZED number: 512
var FLAG_WINDOW_MAXIMIZED number: 1024
var FLAG_WINDOW_UNFOCUSED number: 2048
var FLAG_WINDOW_TOPMOST number: 4096
var FLAG_WINDOW_ALWAYS_RUN number: 256
var FLAG_WINDOW_TRANSPARENT number: 16
var FLAG_WINDOW_HIGHDPI number: 8192
var FLAG_WINDOW_MOUSE_PASSTHROUGH number: 16384
var FLAG_MSAA_4X_HINT number: 32
var FLAG_INTERLACED_HINT number: 65536
type ConfigFlags number
var LOG_ALL number: 0
var LOG_TRACE number: 1
var LOG_DEBUG number: 2
var LOG_INFO number: 3
var LOG_WARNING number: 4
var LOG_ERROR number: 5
var LOG_FATAL number: 6
var LOG_NONE number: 7
type TraceLogLevel number
var KEY_NULL number: 0
var KEY_APOSTROPHE number: 39
var KEY_COMMA number: 44
var KEY_MINUS number: 45
var KEY_PERIOD number: 46
var KEY_SLASH number: 47
var KEY_ZERO number: 48
var KEY_ONE number: 49
var KEY_TWO number: 50
var KEY_THREE number: 51
var KEY_FOUR number: 52
var KEY_FIVE number: 53
var KEY_SIX number: 54
var KEY_SEVEN number: 55
var KEY_EIGHT number: 56
var KEY_NINE number: 57
var KEY_SEMICOLON number: 59
var KEY_EQUAL number: 61
var KEY_A number: 65
var KEY_B number: 66
var KEY_C number: 67
var KEY_D number: 68
var KEY_E number: 69
var KEY_F number: 70
var KEY_G number: 71
var KEY_H number: 72
var KEY_I number: 73
var KEY_J number: 74
var KEY_K number: 75
var KEY_L number: 76
var KEY_M number: 77
var KEY_N number: 78
var KEY_O number: 79
var KEY_P number: 80
var KEY_Q number: 81
var KEY_R number: 82
var KEY_S number: 83
var KEY_T number: 84
var KEY_U number: 85
var KEY_V number: 86
var KEY_W number: 87
var KEY_X number: 88
var KEY_Y number: 89
var KEY_Z number: 90
var KEY_LEFT_BRACKET number: 91
var KEY_BACKSLASH number: 92
var KEY_RIGHT_BRACKET number: 93
var KEY_GRAVE number: 96
var KEY_SPACE number: 32
var KEY_ESCAPE number: 256
var KEY_ENTER number: 257
var KEY_TAB number: 258
var KEY_BACKSPACE number: 259
var KEY_INSERT number: 260
var KEY_DELETE number: 261
var KEY_RIGHT number: 262
var KEY_LEFT number: 263
var KEY_DOWN number: 264
var KEY_UP number: 265
var KEY_PAGE_UP number: 266
var KEY_PAGE_DOWN number: 267
var KEY_HOME number: 268
var KEY_END number: 269
var KEY_CAPS_LOCK number: 280
var KEY_SCROLL_LOCK number: 281
var KEY_NUM_LOCK number: 282
var KEY_PRINT_SCREEN number: 283
var KEY_PAUSE number: 284
var KEY_F1 number: 290
var KEY_F2 number: 291
var KEY_F3 number: 292
var KEY_F4 number: 293
var KEY_F5 number: 294
var KEY_F6 number: 295
var KEY_F7 number: 296
var KEY_F8 number: 297
var KEY_F9 number: 298
var KEY_F10 number: 299
var KEY_F11 number: 300
var KEY_F12 number: 301
var KEY_LEFT_SHIFT number: 340
var KEY_LEFT_CONTROL number: 341
var KEY_LEFT_ALT number: 342
var KEY_LEFT_SUPER number: 343
var KEY_RIGHT_SHIFT number: 344
var KEY_RIGHT_CONTROL number: 345
var KEY_RIGHT_ALT number: 346
var KEY_RIGHT_SUPER number: 347
var KEY_KB_MENU number: 348
var KEY_KP_0 number: 320
var KEY_KP_1 number: 321
var KEY_KP_2 number: 322
var KEY_KP_3 number: 323
var KEY_KP_4 number: 324
var KEY_KP_5 number: 325
var KEY_KP_6 number: 326
var KEY_KP_7 number: 327
var KEY_KP_8 number: 328
var KEY_KP_9 number: 329
var KEY_KP_DECIMAL number: 330
var KEY_KP_DIVIDE number: 331
var KEY_KP_MULTIPLY number: 332
var KEY_KP_SUBTRACT number: 333
var KEY_KP_ADD number: 334
var KEY_KP_ENTER number: 335
var KEY_KP_EQUAL number: 336
var KEY_BACK number: 4
var KEY_MENU number: 82
var KEY_VOLUME_UP number: 24
var KEY_VOLUME_DOWN number: 25
type KeyboardKey number
var MOUSE_BUTTON_LEFT number: 0
var MOUSE_BUTTON_RIGHT number: 1
var MOUSE_BUTTON_MIDDLE number: 2
var MOUSE_BUTTON_SIDE number: 3
var MOUSE_BUTTON_EXTRA number: 4
var MOUSE_BUTTON_FORWARD number: 5
var MOUSE_BUTTON_BACK number: 6
type MouseButton number
var MOUSE_CURSOR_DEFAULT number: 0
var MOUSE_CURSOR_ARROW number: 1
var MOUSE_CURSOR_IBEAM number: 2
var MOUSE_CURSOR_CROSSHAIR number: 3
var MOUSE_CURSOR_POINTING_HAND number: 4
var MOUSE_CURSOR_RESIZE_EW number: 5
var MOUSE_CURSOR_RESIZE_NS number: 6
var MOUSE_CURSOR_RESIZE_NWSE number: 7
var MOUSE_CURSOR_RESIZE_NESW number: 8
var MOUSE_CURSOR_RESIZE_ALL number: 9
var MOUSE_CURSOR_NOT_ALLOWED number: 10
type MouseCursor number
var GAMEPAD_BUTTON_UNKNOWN number: 0
var GAMEPAD_BUTTON_LEFT_FACE_UP number: 1
var GAMEPAD_BUTTON_LEFT_FACE_RIGHT number: 2
var GAMEPAD_BUTTON_LEFT_FACE_DOWN number: 3
var GAMEPAD_BUTTON_LEFT_FACE_LEFT number: 4
var GAMEPAD_BUTTON_RIGHT_FACE_UP number: 5
var GAMEPAD_BUTTON_RIGHT_FACE_RIGHT number: 6
var GAMEPAD_BUTTON_RIGHT_FACE_DOWN number: 7
var GAMEPAD_BUTTON_RIGHT_FACE_LEFT number: 8
var GAMEPAD_BUTTON_LEFT_TRIGGER_1 number: 9
var GAMEPAD_BUTTON_LEFT_TRIGGER_2 number: 10
var GAMEPAD_BUTTON_RIGHT_TRIGGER_1 number: 11
var GAMEPAD_BUTTON_RIGHT_TRIGGER_2 number: 12
var GAMEPAD_BUTTON_MIDDLE_LEFT number: 13
var GAMEPAD_BUTTON_MIDDLE number: 14
var GAMEPAD_BUTTON_MIDDLE_RIGHT number: 15
var GAMEPAD_BUTTON_LEFT_THUMB number: 16
var GAMEPAD_BUTTON_RIGHT_THUMB number: 17
type GamepadButton number
var GAMEPAD_AXIS_LEFT_X number: 0
var GAMEPAD_AXIS_LEFT_Y number: 1
var GAMEPAD_AXIS_RIGHT_X number: 2
var GAMEPAD_AXIS_RIGHT_Y number: 3
var GAMEPAD_AXIS_LEFT_TRIGGER number: 4
var GAMEPAD_AXIS_RIGHT_TRIGGER number: 5
type GamepadAxis number
var MATERIAL_MAP_ALBEDO number: 0
var MATERIAL_MAP_METALNESS number: 1
var MATERIAL_MAP_NORMAL number: 2
var MATERIAL_MAP_ROUGHNESS number: 3
var MATERIAL_MAP_OCCLUSION number: 4
var MATERIAL_MAP_EMISSION number: 5
var MATERIAL_MAP_HEIGHT number: 6
var MATERIAL_MAP_CUBEMAP number: 7
var MATERIAL_MAP_IRRADIANCE number: 8
var MATERIAL_MAP_PREFILTER number: 9
var MATERIAL_MAP_BRDF number: 10
type MaterialMapIndex number
var SHADER_LOC_VERTEX_POSITION number: 0
var SHADER_LOC_VERTEX_TEXCOORD01 number: 1
var SHADER_LOC_VERTEX_TEXCOORD02 number: 2
var SHADER_LOC_VERTEX_NORMAL number: 3
var SHADER_LOC_VERTEX_TANGENT number: 4
var SHADER_LOC_VERTEX_COLOR number: 5
var SHADER_LOC_MATRIX_MVP number: 6
var SHADER_LOC_MATRIX_VIEW number: 7
var SHADER_LOC_MATRIX_PROJECTION number: 8
var SHADER_LOC_MATRIX_MODEL number: 9
var SHADER_LOC_MATRIX_NORMAL number: 10
var SHADER_LOC_VECTOR_VIEW number: 11
var SHADER_LOC_COLOR_DIFFUSE number: 12
var SHADER_LOC_COLOR_SPECULAR number: 13
var SHADER_LOC_COLOR_AMBIENT number: 14
var SHADER_LOC_MAP_ALBEDO number: 15
var SHADER_LOC_MAP_METALNESS number: 16
var SHADER_LOC_MAP_NORMAL number: 17
var SHADER_LOC_MAP_ROUGHNESS number: 18
var SHADER_LOC_MAP_OCCLUSION number: 19
var SHADER_LOC_MAP_EMISSION number: 20
var SHADER_LOC_MAP_HEIGHT number: 21
var SHADER_LOC_MAP_CUBEMAP number: 22
var SHADER_LOC_MAP_IRRADIANCE number: 23
var SHADER_LOC_MAP_PREFILTER number: 24
var SHADER_LOC_MAP_BRDF number: 25
type ShaderLocationIndex number
var SHADER_UNIFORM_FLOAT number: 0
var SHADER_UNIFORM_VEC2 number: 1
var SHADER_UNIFORM_VEC3 number: 2
var SHADER_UNIFORM_VEC4 number: 3
var SHADER_UNIFORM_INT number: 4
var SHADER_UNIFORM_IVEC2 number: 5
var SHADER_UNIFORM_IVEC3 number: 6
var SHADER_UNIFORM_IVEC4 number: 7
var SHADER_UNIFORM_SAMPLER2D number: 8
type ShaderUniformDataType number
var SHADER_ATTRIB_FLOAT number: 0
var SHADER_ATTRIB_VEC2 number: 1
var SHADER_ATTRIB_VEC3 number: 2
var SHADER_ATTRIB_VEC4 number: 3
type ShaderAttributeDataType number
var PIXELFORMAT_UNCOMPRESSED_GRAYSCALE number: 1
var PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA number: 2
var PIXELFORMAT_UNCOMPRESSED_R5G6B5 number: 3
var PIXELFORMAT_UNCOMPRESSED_R8G8B8 number: 4
var PIXELFORMAT_UNCOMPRESSED_R5G5B5A1 number: 5
var PIXELFORMAT_UNCOMPRESSED_R4G4B4A4 number: 6
var PIXELFORMAT_UNCOMPRESSED_R8G8B8A8 number: 7
var PIXELFORMAT_UNCOMPRESSED_R32 number: 8
var PIXELFORMAT_UNCOMPRESSED_R32G32B32 number: 9
var PIXELFORMAT_UNCOMPRESSED_R32G32B32A32 number: 10
var PIXELFORMAT_COMPRESSED_DXT1_RGB number: 11
var PIXELFORMAT_COMPRESSED_DXT1_RGBA number: 12
var PIXELFORMAT_COMPRESSED_DXT3_RGBA number: 13
var PIXELFORMAT_COMPRESSED_DXT5_RGBA number: 14
var PIXELFORMAT_COMPRESSED_ETC1_RGB number: 15
var PIXELFORMAT_COMPRESSED_ETC2_RGB number: 16
var PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA number: 17
var PIXELFORMAT_COMPRESSED_PVRT_RGB number: 18
var PIXELFORMAT_COMPRESSED_PVRT_RGBA number: 19
var PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA number: 20
var PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA number: 21
type PixelFormat number
var TEXTURE_FILTER_POINT number: 0
var TEXTURE_FILTER_BILINEAR number: 1
var TEXTURE_FILTER_TRILINEAR number: 2
var TEXTURE_FILTER_ANISOTROPIC_4X number: 3
var TEXTURE_FILTER_ANISOTROPIC_8X number: 4
var TEXTURE_FILTER_ANISOTROPIC_16X number: 5
type TextureFilter number
var TEXTURE_WRAP_REPEAT number: 0
var TEXTURE_WRAP_CLAMP number: 1
var TEXTURE_WRAP_MIRROR_REPEAT number: 2
var TEXTURE_WRAP_MIRROR_CLAMP number: 3
type TextureWrap number
var CUBEMAP_LAYOUT_AUTO_DETECT number: 0
var CUBEMAP_LAYOUT_LINE_VERTICAL number: 1
var CUBEMAP_LAYOUT_LINE_HORIZONTAL number: 2
var CUBEMAP_LAYOUT_CROSS_THREE_BY_FOUR number: 3
var CUBEMAP_LAYOUT_CROSS_FOUR_BY_THREE number: 4
var CUBEMAP_LAYOUT_PANORAMA number: 5
type CubemapLayout number
var FONT_DEFAULT number: 0
var FONT_BITMAP number: 1
var FONT_SDF number: 2
type FontType number
var BLEND_ALPHA number: 0
var BLEND_ADDITIVE number: 1
var BLEND_MULTIPLIED number: 2
var BLEND_ADD_COLORS number: 3
var BLEND_SUBTRACT_COLORS number: 4
var BLEND_ALPHA_PREMULTIPLY number: 5
var BLEND_CUSTOM number: 6
var BLEND_CUSTOM_SEPARATE number: 7
type BlendMode number
var GESTURE_NONE number: 0
var GESTURE_TAP number: 1
var GESTURE_DOUBLETAP number: 2
var GESTURE_HOLD number: 4
var GESTURE_DRAG number: 8
var GESTURE_SWIPE_RIGHT number: 16
var GESTURE_SWIPE_LEFT number: 32
var GESTURE_SWIPE_UP number: 64
var GESTURE_SWIPE_DOWN number: 128
var GESTURE_PINCH_IN number: 256
var GESTURE_PINCH_OUT number: 512
type Gesture number
var CAMERA_CUSTOM number: 0
var CAMERA_FREE number: 1
var CAMERA_ORBITAL number: 2
var CAMERA_FIRST_PERSON number: 3
var CAMERA_THIRD_PERSON number: 4
type CameraMode number
var CAMERA_PERSPECTIVE number: 0
var CAMERA_ORTHOGRAPHIC number: 1
type CameraProjection number
var NPATCH_NINE_PATCH number: 0
var NPATCH_THREE_PATCH_VERTICAL number: 1
var NPATCH_THREE_PATCH_HORIZONTAL number: 2
type NPatchLayout number
type TraceLogCallback pointer
type LoadFileDataCallback pointer
type SaveFileDataCallback pointer
type LoadFileTextCallback pointer
type SaveFileTextCallback pointer
-- Skip func InitWindow(width number, height number, title pointer) none = lib.InitWindow
func WindowShouldClose() boolean = lib.WindowShouldClose
func CloseWindow() none = lib.CloseWindow
func IsWindowReady() boolean = lib.IsWindowReady
func IsWindowFullscreen() boolean = lib.IsWindowFullscreen
func IsWindowHidden() boolean = lib.IsWindowHidden
func IsWindowMinimized() boolean = lib.IsWindowMinimized
func IsWindowMaximized() boolean = lib.IsWindowMaximized
func IsWindowFocused() boolean = lib.IsWindowFocused
func IsWindowResized() boolean = lib.IsWindowResized
func IsWindowState(flag number) boolean = lib.IsWindowState
func SetWindowState(flags number) none = lib.SetWindowState
func ClearWindowState(flags number) none = lib.ClearWindowState
func ToggleFullscreen() none = lib.ToggleFullscreen
func MaximizeWindow() none = lib.MaximizeWindow
func MinimizeWindow() none = lib.MinimizeWindow
func RestoreWindow() none = lib.RestoreWindow
func SetWindowIcon(image Image) none = lib.SetWindowIcon
func SetWindowIcons(images pointer, count number) none = lib.SetWindowIcons
func SetWindowTitle(title pointer) none = lib.SetWindowTitle
func SetWindowPosition(x number, y number) none = lib.SetWindowPosition
func SetWindowMonitor(monitor number) none = lib.SetWindowMonitor
func SetWindowMinSize(width number, height number) none = lib.SetWindowMinSize
func SetWindowSize(width number, height number) none = lib.SetWindowSize
func SetWindowOpacity(opacity number) none = lib.SetWindowOpacity
func GetWindowHandle() pointer = lib.GetWindowHandle
func GetScreenWidth() number = lib.GetScreenWidth
func GetScreenHeight() number = lib.GetScreenHeight
func GetRenderWidth() number = lib.GetRenderWidth
func GetRenderHeight() number = lib.GetRenderHeight
func GetMonitorCount() number = lib.GetMonitorCount
func GetCurrentMonitor() number = lib.GetCurrentMonitor
func GetMonitorPosition(monitor number) Vector2 = lib.GetMonitorPosition
func GetMonitorWidth(monitor number) number = lib.GetMonitorWidth
func GetMonitorHeight(monitor number) number = lib.GetMonitorHeight
func GetMonitorPhysicalWidth(monitor number) number = lib.GetMonitorPhysicalWidth
func GetMonitorPhysicalHeight(monitor number) number = lib.GetMonitorPhysicalHeight
func GetMonitorRefreshRate(monitor number) number = lib.GetMonitorRefreshRate
func GetWindowPosition() Vector2 = lib.GetWindowPosition
func GetWindowScaleDPI() Vector2 = lib.GetWindowScaleDPI
func GetMonitorName(monitor number) pointer = lib.GetMonitorName
func SetClipboardText(text pointer) none = lib.SetClipboardText
func GetClipboardText() pointer = lib.GetClipboardText
func EnableEventWaiting() none = lib.EnableEventWaiting
func DisableEventWaiting() none = lib.DisableEventWaiting
func SwapScreenBuffer() none = lib.SwapScreenBuffer
func PollInputEvents() none = lib.PollInputEvents
func WaitTime(seconds number) none = lib.WaitTime
func ShowCursor() none = lib.ShowCursor
func HideCursor() none = lib.HideCursor
func IsCursorHidden() boolean = lib.IsCursorHidden
func EnableCursor() none = lib.EnableCursor
func DisableCursor() none = lib.DisableCursor
func IsCursorOnScreen() boolean = lib.IsCursorOnScreen
func ClearBackground(color Color) none = lib.ClearBackground
func BeginDrawing() none = lib.BeginDrawing
func EndDrawing() none = lib.EndDrawing
func BeginMode2D(camera Camera2D) none = lib.BeginMode2D
func EndMode2D() none = lib.EndMode2D
func BeginMode3D(camera Camera3D) none = lib.BeginMode3D
func EndMode3D() none = lib.EndMode3D
func BeginTextureMode(target RenderTexture) none = lib.BeginTextureMode
func EndTextureMode() none = lib.EndTextureMode
func BeginShaderMode(shader Shader) none = lib.BeginShaderMode
func EndShaderMode() none = lib.EndShaderMode
func BeginBlendMode(mode number) none = lib.BeginBlendMode
func EndBlendMode() none = lib.EndBlendMode
func BeginScissorMode(x number, y number, width number, height number) none = lib.BeginScissorMode
func EndScissorMode() none = lib.EndScissorMode
func BeginVrStereoMode(config VrStereoConfig) none = lib.BeginVrStereoMode
func EndVrStereoMode() none = lib.EndVrStereoMode
func LoadVrStereoConfig(device VrDeviceInfo) VrStereoConfig = lib.LoadVrStereoConfig
func UnloadVrStereoConfig(config VrStereoConfig) none = lib.UnloadVrStereoConfig
func LoadShader(vsFileName pointer, fsFileName pointer) Shader = lib.LoadShader
func LoadShaderFromMemory(vsCode pointer, fsCode pointer) Shader = lib.LoadShaderFromMemory
func IsShaderReady(shader Shader) boolean = lib.IsShaderReady
func GetShaderLocation(shader Shader, uniformName pointer) number = lib.GetShaderLocation
func GetShaderLocationAttrib(shader Shader, attribName pointer) number = lib.GetShaderLocationAttrib
func SetShaderValue(shader Shader, locIndex number, value pointer, uniformType number) none = lib.SetShaderValue
func SetShaderValueV(shader Shader, locIndex number, value pointer, uniformType number, count number) none = lib.SetShaderValueV
func SetShaderValueMatrix(shader Shader, locIndex number, mat Matrix) none = lib.SetShaderValueMatrix
func SetShaderValueTexture(shader Shader, locIndex number, texture Texture) none = lib.SetShaderValueTexture
func UnloadShader(shader Shader) none = lib.UnloadShader
func GetMouseRay(mousePosition Vector2, camera Camera3D) Ray = lib.GetMouseRay
func GetCameraMatrix(camera Camera3D) Matrix = lib.GetCameraMatrix
func GetCameraMatrix2D(camera Camera2D) Matrix = lib.GetCameraMatrix2D
func GetWorldToScreen(position Vector3, camera Camera3D) Vector2 = lib.GetWorldToScreen
func GetScreenToWorld2D(position Vector2, camera Camera2D) Vector2 = lib.GetScreenToWorld2D
func GetWorldToScreenEx(position Vector3, camera Camera3D, width number, height number) Vector2 = lib.GetWorldToScreenEx
func GetWorldToScreen2D(position Vector2, camera Camera2D) Vector2 = lib.GetWorldToScreen2D
func SetTargetFPS(fps number) none = lib.SetTargetFPS
func GetFPS() number = lib.GetFPS
func GetFrameTime() number = lib.GetFrameTime
func GetTime() number = lib.GetTime
func GetRandomValue(min number, max number) number = lib.GetRandomValue
func SetRandomSeed(seed number) none = lib.SetRandomSeed
func TakeScreenshot(fileName pointer) none = lib.TakeScreenshot
func SetConfigFlags(flags number) none = lib.SetConfigFlags
func SetTraceLogLevel(logLevel number) none = lib.SetTraceLogLevel
func MemAlloc(size number) pointer = lib.MemAlloc
func MemRealloc(ptr pointer, size number) pointer = lib.MemRealloc
func MemFree(ptr pointer) none = lib.MemFree
func OpenURL(url pointer) none = lib.OpenURL
func SetTraceLogCallback(callback pointer) none = lib.SetTraceLogCallback
func SetLoadFileDataCallback(callback pointer) none = lib.SetLoadFileDataCallback
func SetSaveFileDataCallback(callback pointer) none = lib.SetSaveFileDataCallback
func SetLoadFileTextCallback(callback pointer) none = lib.SetLoadFileTextCallback
func SetSaveFileTextCallback(callback pointer) none = lib.SetSaveFileTextCallback
func LoadFileData(fileName pointer, bytesRead pointer) pointer = lib.LoadFileData
func UnloadFileData(data pointer) none = lib.UnloadFileData
func SaveFileData(fileName pointer, data pointer, bytesToWrite number) boolean = lib.SaveFileData
func ExportDataAsCode(data pointer, size number, fileName pointer) boolean = lib.ExportDataAsCode
func LoadFileText(fileName pointer) pointer = lib.LoadFileText
func UnloadFileText(text pointer) none = lib.UnloadFileText
func SaveFileText(fileName pointer, text pointer) boolean = lib.SaveFileText
func FileExists(fileName pointer) boolean = lib.FileExists
func DirectoryExists(dirPath pointer) boolean = lib.DirectoryExists
func IsFileExtension(fileName pointer, ext pointer) boolean = lib.IsFileExtension
func GetFileLength(fileName pointer) number = lib.GetFileLength
func GetFileExtension(fileName pointer) pointer = lib.GetFileExtension
func GetFileName(filePath pointer) pointer = lib.GetFileName
func GetFileNameWithoutExt(filePath pointer) pointer = lib.GetFileNameWithoutExt
func GetDirectoryPath(filePath pointer) pointer = lib.GetDirectoryPath
func GetPrevDirectoryPath(dirPath pointer) pointer = lib.GetPrevDirectoryPath
func GetWorkingDirectory() pointer = lib.GetWorkingDirectory
func GetApplicationDirectory() pointer = lib.GetApplicationDirectory
func ChangeDirectory(dir pointer) boolean = lib.ChangeDirectory
func IsPathFile(path pointer) boolean = lib.IsPathFile
func LoadDirectoryFiles(dirPath pointer) FilePathList = lib.LoadDirectoryFiles
func LoadDirectoryFilesEx(basePath pointer, filter pointer, scanSubdirs boolean) FilePathList = lib.LoadDirectoryFilesEx
func UnloadDirectoryFiles(files FilePathList) none = lib.UnloadDirectoryFiles
func IsFileDropped() boolean = lib.IsFileDropped
func LoadDroppedFiles() FilePathList = lib.LoadDroppedFiles
func UnloadDroppedFiles(files FilePathList) none = lib.UnloadDroppedFiles
func GetFileModTime(fileName pointer) number = lib.GetFileModTime
func CompressData(data pointer, dataSize number, compDataSize pointer) pointer = lib.CompressData
func DecompressData(compData pointer, compDataSize number, dataSize pointer) pointer = lib.DecompressData
func EncodeDataBase64(data pointer, dataSize number, outputSize pointer) pointer = lib.EncodeDataBase64
func DecodeDataBase64(data pointer, outputSize pointer) pointer = lib.DecodeDataBase64
func IsKeyPressed(key number) boolean = lib.IsKeyPressed
func IsKeyDown(key number) boolean = lib.IsKeyDown
func IsKeyReleased(key number) boolean = lib.IsKeyReleased
func IsKeyUp(key number) boolean = lib.IsKeyUp
func SetExitKey(key number) none = lib.SetExitKey
func GetKeyPressed() number = lib.GetKeyPressed
func GetCharPressed() number = lib.GetCharPressed
func IsGamepadAvailable(gamepad number) boolean = lib.IsGamepadAvailable
func GetGamepadName(gamepad number) pointer = lib.GetGamepadName
func IsGamepadButtonPressed(gamepad number, button number) boolean = lib.IsGamepadButtonPressed
func IsGamepadButtonDown(gamepad number, button number) boolean = lib.IsGamepadButtonDown
func IsGamepadButtonReleased(gamepad number, button number) boolean = lib.IsGamepadButtonReleased
func IsGamepadButtonUp(gamepad number, button number) boolean = lib.IsGamepadButtonUp
func GetGamepadButtonPressed() number = lib.GetGamepadButtonPressed
func GetGamepadAxisCount(gamepad number) number = lib.GetGamepadAxisCount
func GetGamepadAxisMovement(gamepad number, axis number) number = lib.GetGamepadAxisMovement
func SetGamepadMappings(mappings pointer) number = lib.SetGamepadMappings
func IsMouseButtonPressed(button number) boolean = lib.IsMouseButtonPressed
func IsMouseButtonDown(button number) boolean = lib.IsMouseButtonDown
func IsMouseButtonReleased(button number) boolean = lib.IsMouseButtonReleased
func IsMouseButtonUp(button number) boolean = lib.IsMouseButtonUp
func GetMouseX() number = lib.GetMouseX
func GetMouseY() number = lib.GetMouseY
func GetMousePosition() Vector2 = lib.GetMousePosition
func GetMouseDelta() Vector2 = lib.GetMouseDelta
func SetMousePosition(x number, y number) none = lib.SetMousePosition
func SetMouseOffset(offsetX number, offsetY number) none = lib.SetMouseOffset
func SetMouseScale(scaleX number, scaleY number) none = lib.SetMouseScale
func GetMouseWheelMove() number = lib.GetMouseWheelMove
func GetMouseWheelMoveV() Vector2 = lib.GetMouseWheelMoveV
func SetMouseCursor(cursor number) none = lib.SetMouseCursor
func GetTouchX() number = lib.GetTouchX
func GetTouchY() number = lib.GetTouchY
func GetTouchPosition(index number) Vector2 = lib.GetTouchPosition
func GetTouchPointId(index number) number = lib.GetTouchPointId
func GetTouchPointCount() number = lib.GetTouchPointCount
func SetGesturesEnabled(flags number) none = lib.SetGesturesEnabled
func IsGestureDetected(gesture number) boolean = lib.IsGestureDetected
func GetGestureDetected() number = lib.GetGestureDetected
func GetGestureHoldDuration() number = lib.GetGestureHoldDuration
func GetGestureDragVector() Vector2 = lib.GetGestureDragVector
func GetGestureDragAngle() number = lib.GetGestureDragAngle
func GetGesturePinchVector() Vector2 = lib.GetGesturePinchVector
func GetGesturePinchAngle() number = lib.GetGesturePinchAngle
func UpdateCamera(camera pointer, mode number) none = lib.UpdateCamera
func UpdateCameraPro(camera pointer, movement Vector3, rotation Vector3, zoom number) none = lib.UpdateCameraPro
func SetShapesTexture(texture Texture, source Rectangle) none = lib.SetShapesTexture
func DrawPixel(posX number, posY number, color Color) none = lib.DrawPixel
func DrawPixelV(position Vector2, color Color) none = lib.DrawPixelV
func DrawLine(startPosX number, startPosY number, endPosX number, endPosY number, color Color) none = lib.DrawLine
func DrawLineV(startPos Vector2, endPos Vector2, color Color) none = lib.DrawLineV
func DrawLineEx(startPos Vector2, endPos Vector2, thick number, color Color) none = lib.DrawLineEx
func DrawLineBezier(startPos Vector2, endPos Vector2, thick number, color Color) none = lib.DrawLineBezier
func DrawLineBezierQuad(startPos Vector2, endPos Vector2, controlPos Vector2, thick number, color Color) none = lib.DrawLineBezierQuad
func DrawLineBezierCubic(startPos Vector2, endPos Vector2, startControlPos Vector2, endControlPos Vector2, thick number, color Color) none = lib.DrawLineBezierCubic
func DrawLineStrip(points pointer, pointCount number, color Color) none = lib.DrawLineStrip
func DrawCircle(centerX number, centerY number, radius number, color Color) none = lib.DrawCircle
func DrawCircleSector(center Vector2, radius number, startAngle number, endAngle number, segments number, color Color) none = lib.DrawCircleSector
func DrawCircleSectorLines(center Vector2, radius number, startAngle number, endAngle number, segments number, color Color) none = lib.DrawCircleSectorLines
func DrawCircleGradient(centerX number, centerY number, radius number, color1 Color, color2 Color) none = lib.DrawCircleGradient
func DrawCircleV(center Vector2, radius number, color Color) none = lib.DrawCircleV
func DrawCircleLines(centerX number, centerY number, radius number, color Color) none = lib.DrawCircleLines
func DrawEllipse(centerX number, centerY number, radiusH number, radiusV number, color Color) none = lib.DrawEllipse
func DrawEllipseLines(centerX number, centerY number, radiusH number, radiusV number, color Color) none = lib.DrawEllipseLines
func DrawRing(center Vector2, innerRadius number, outerRadius number, startAngle number, endAngle number, segments number, color Color) none = lib.DrawRing
func DrawRingLines(center Vector2, innerRadius number, outerRadius number, startAngle number, endAngle number, segments number, color Color) none = lib.DrawRingLines
func DrawRectangle(posX number, posY number, width number, height number, color Color) none = lib.DrawRectangle
func DrawRectangleV(position Vector2, size Vector2, color Color) none = lib.DrawRectangleV
func DrawRectangleRec(rec Rectangle, color Color) none = lib.DrawRectangleRec
func DrawRectanglePro(rec Rectangle, origin Vector2, rotation number, color Color) none = lib.DrawRectanglePro
func DrawRectangleGradientV(posX number, posY number, width number, height number, color1 Color, color2 Color) none = lib.DrawRectangleGradientV
func DrawRectangleGradientH(posX number, posY number, width number, height number, color1 Color, color2 Color) none = lib.DrawRectangleGradientH
func DrawRectangleGradientEx(rec Rectangle, col1 Color, col2 Color, col3 Color, col4 Color) none = lib.DrawRectangleGradientEx
func DrawRectangleLines(posX number, posY number, width number, height number, color Color) none = lib.DrawRectangleLines
func DrawRectangleLinesEx(rec Rectangle, lineThick number, color Color) none = lib.DrawRectangleLinesEx
func DrawRectangleRounded(rec Rectangle, roundness number, segments number, color Color) none = lib.DrawRectangleRounded
func DrawRectangleRoundedLines(rec Rectangle, roundness number, segments number, lineThick number, color Color) none = lib.DrawRectangleRoundedLines
func DrawTriangle(v1 Vector2, v2 Vector2, v3 Vector2, color Color) none = lib.DrawTriangle
func DrawTriangleLines(v1 Vector2, v2 Vector2, v3 Vector2, color Color) none = lib.DrawTriangleLines
func DrawTriangleFan(points pointer, pointCount number, color Color) none = lib.DrawTriangleFan
func DrawTriangleStrip(points pointer, pointCount number, color Color) none = lib.DrawTriangleStrip
func DrawPoly(center Vector2, sides number, radius number, rotation number, color Color) none = lib.DrawPoly
func DrawPolyLines(center Vector2, sides number, radius number, rotation number, color Color) none = lib.DrawPolyLines
func DrawPolyLinesEx(center Vector2, sides number, radius number, rotation number, lineThick number, color Color) none = lib.DrawPolyLinesEx
func CheckCollisionRecs(rec1 Rectangle, rec2 Rectangle) boolean = lib.CheckCollisionRecs
func CheckCollisionCircles(center1 Vector2, radius1 number, center2 Vector2, radius2 number) boolean = lib.CheckCollisionCircles
func CheckCollisionCircleRec(center Vector2, radius number, rec Rectangle) boolean = lib.CheckCollisionCircleRec
func CheckCollisionPointRec(point Vector2, rec Rectangle) boolean = lib.CheckCollisionPointRec
func CheckCollisionPointCircle(point Vector2, center Vector2, radius number) boolean = lib.CheckCollisionPointCircle
func CheckCollisionPointTriangle(point Vector2, p1 Vector2, p2 Vector2, p3 Vector2) boolean = lib.CheckCollisionPointTriangle
func CheckCollisionPointPoly(point Vector2, points pointer, pointCount number) boolean = lib.CheckCollisionPointPoly
func CheckCollisionLines(startPos1 Vector2, endPos1 Vector2, startPos2 Vector2, endPos2 Vector2, collisionPoint pointer) boolean = lib.CheckCollisionLines
func CheckCollisionPointLine(point Vector2, p1 Vector2, p2 Vector2, threshold number) boolean = lib.CheckCollisionPointLine
func GetCollisionRec(rec1 Rectangle, rec2 Rectangle) Rectangle = lib.GetCollisionRec
func LoadImage(fileName pointer) Image = lib.LoadImage
func LoadImageRaw(fileName pointer, width number, height number, format number, headerSize number) Image = lib.LoadImageRaw
func LoadImageAnim(fileName pointer, frames pointer) Image = lib.LoadImageAnim
func LoadImageFromMemory(fileType pointer, fileData pointer, dataSize number) Image = lib.LoadImageFromMemory
func LoadImageFromTexture(texture Texture) Image = lib.LoadImageFromTexture
func LoadImageFromScreen() Image = lib.LoadImageFromScreen
func IsImageReady(image Image) boolean = lib.IsImageReady
func UnloadImage(image Image) none = lib.UnloadImage
func ExportImage(image Image, fileName pointer) boolean = lib.ExportImage
func ExportImageAsCode(image Image, fileName pointer) boolean = lib.ExportImageAsCode
func GenImageColor(width number, height number, color Color) Image = lib.GenImageColor
func GenImageGradientV(width number, height number, top Color, bottom Color) Image = lib.GenImageGradientV
func GenImageGradientH(width number, height number, left Color, right Color) Image = lib.GenImageGradientH
func GenImageGradientRadial(width number, height number, density number, inner Color, outer Color) Image = lib.GenImageGradientRadial
func GenImageChecked(width number, height number, checksX number, checksY number, col1 Color, col2 Color) Image = lib.GenImageChecked
func GenImageWhiteNoise(width number, height number, factor number) Image = lib.GenImageWhiteNoise
func GenImagePerlinNoise(width number, height number, offsetX number, offsetY number, scale number) Image = lib.GenImagePerlinNoise
func GenImageCellular(width number, height number, tileSize number) Image = lib.GenImageCellular
func GenImageText(width number, height number, text pointer) Image = lib.GenImageText
func ImageCopy(image Image) Image = lib.ImageCopy
func ImageFromImage(image Image, rec Rectangle) Image = lib.ImageFromImage
func ImageText(text pointer, fontSize number, color Color) Image = lib.ImageText
func ImageTextEx(font Font, text pointer, fontSize number, spacing number, tint Color) Image = lib.ImageTextEx
func ImageFormat(image pointer, newFormat number) none = lib.ImageFormat
func ImageToPOT(image pointer, fill Color) none = lib.ImageToPOT
func ImageCrop(image pointer, crop Rectangle) none = lib.ImageCrop
func ImageAlphaCrop(image pointer, threshold number) none = lib.ImageAlphaCrop
func ImageAlphaClear(image pointer, color Color, threshold number) none = lib.ImageAlphaClear
func ImageAlphaMask(image pointer, alphaMask Image) none = lib.ImageAlphaMask
func ImageAlphaPremultiply(image pointer) none = lib.ImageAlphaPremultiply
func ImageBlurGaussian(image pointer, blurSize number) none = lib.ImageBlurGaussian
func ImageResize(image pointer, newWidth number, newHeight number) none = lib.ImageResize
func ImageResizeNN(image pointer, newWidth number, newHeight number) none = lib.ImageResizeNN
func ImageResizeCanvas(image pointer, newWidth number, newHeight number, offsetX number, offsetY number, fill Color) none = lib.ImageResizeCanvas
func ImageMipmaps(image pointer) none = lib.ImageMipmaps
func ImageDither(image pointer, rBpp number, gBpp number, bBpp number, aBpp number) none = lib.ImageDither
func ImageFlipVertical(image pointer) none = lib.ImageFlipVertical
func ImageFlipHorizontal(image pointer) none = lib.ImageFlipHorizontal
func ImageRotateCW(image pointer) none = lib.ImageRotateCW
func ImageRotateCCW(image pointer) none = lib.ImageRotateCCW
func ImageColorTint(image pointer, color Color) none = lib.ImageColorTint
func ImageColorInvert(image pointer) none = lib.ImageColorInvert
func ImageColorGrayscale(image pointer) none = lib.ImageColorGrayscale
func ImageColorContrast(image pointer, contrast number) none = lib.ImageColorContrast
func ImageColorBrightness(image pointer, brightness number) none = lib.ImageColorBrightness
func ImageColorReplace(image pointer, color Color, replace Color) none = lib.ImageColorReplace
func LoadImageColors(image Image) pointer = lib.LoadImageColors
func LoadImagePalette(image Image, maxPaletteSize number, colorCount pointer) pointer = lib.LoadImagePalette
func UnloadImageColors(colors pointer) none = lib.UnloadImageColors
func UnloadImagePalette(colors pointer) none = lib.UnloadImagePalette
func GetImageAlphaBorder(image Image, threshold number) Rectangle = lib.GetImageAlphaBorder
func GetImageColor(image Image, x number, y number) Color = lib.GetImageColor
func ImageClearBackground(dst pointer, color Color) none = lib.ImageClearBackground
func ImageDrawPixel(dst pointer, posX number, posY number, color Color) none = lib.ImageDrawPixel
func ImageDrawPixelV(dst pointer, position Vector2, color Color) none = lib.ImageDrawPixelV
func ImageDrawLine(dst pointer, startPosX number, startPosY number, endPosX number, endPosY number, color Color) none = lib.ImageDrawLine
func ImageDrawLineV(dst pointer, start Vector2, end Vector2, color Color) none = lib.ImageDrawLineV
func ImageDrawCircle(dst pointer, centerX number, centerY number, radius number, color Color) none = lib.ImageDrawCircle
func ImageDrawCircleV(dst pointer, center Vector2, radius number, color Color) none = lib.ImageDrawCircleV
func ImageDrawCircleLines(dst pointer, centerX number, centerY number, radius number, color Color) none = lib.ImageDrawCircleLines
func ImageDrawCircleLinesV(dst pointer, center Vector2, radius number, color Color) none = lib.ImageDrawCircleLinesV
func ImageDrawRectangle(dst pointer, posX number, posY number, width number, height number, color Color) none = lib.ImageDrawRectangle
func ImageDrawRectangleV(dst pointer, position Vector2, size Vector2, color Color) none = lib.ImageDrawRectangleV
func ImageDrawRectangleRec(dst pointer, rec Rectangle, color Color) none = lib.ImageDrawRectangleRec
func ImageDrawRectangleLines(dst pointer, rec Rectangle, thick number, color Color) none = lib.ImageDrawRectangleLines
func ImageDraw(dst pointer, src Image, srcRec Rectangle, dstRec Rectangle, tint Color) none = lib.ImageDraw
func ImageDrawText(dst pointer, text pointer, posX number, posY number, fontSize number, color Color) none = lib.ImageDrawText
func ImageDrawTextEx(dst pointer, font Font, text pointer, position Vector2, fontSize number, spacing number, tint Color) none = lib.ImageDrawTextEx
-- Skip func LoadTexture(fileName pointer) Texture = lib.LoadTexture
func LoadTextureFromImage(image Image) Texture = lib.LoadTextureFromImage
func LoadTextureCubemap(image Image, layout number) Texture = lib.LoadTextureCubemap
func LoadRenderTexture(width number, height number) RenderTexture = lib.LoadRenderTexture
func IsTextureReady(texture Texture) boolean = lib.IsTextureReady
func UnloadTexture(texture Texture) none = lib.UnloadTexture
func IsRenderTextureReady(target RenderTexture) boolean = lib.IsRenderTextureReady
func UnloadRenderTexture(target RenderTexture) none = lib.UnloadRenderTexture
func UpdateTexture(texture Texture, pixels pointer) none = lib.UpdateTexture
func UpdateTextureRec(texture Texture, rec Rectangle, pixels pointer) none = lib.UpdateTextureRec
func GenTextureMipmaps(texture pointer) none = lib.GenTextureMipmaps
func SetTextureFilter(texture Texture, filter number) none = lib.SetTextureFilter
func SetTextureWrap(texture Texture, wrap number) none = lib.SetTextureWrap
func DrawTexture(texture Texture, posX number, posY number, tint Color) none = lib.DrawTexture
func DrawTextureV(texture Texture, position Vector2, tint Color) none = lib.DrawTextureV
func DrawTextureEx(texture Texture, position Vector2, rotation number, scale number, tint Color) none = lib.DrawTextureEx
func DrawTextureRec(texture Texture, source Rectangle, position Vector2, tint Color) none = lib.DrawTextureRec
func DrawTexturePro(texture Texture, source Rectangle, dest Rectangle, origin Vector2, rotation number, tint Color) none = lib.DrawTexturePro
func DrawTextureNPatch(texture Texture, nPatchInfo NPatchInfo, dest Rectangle, origin Vector2, rotation number, tint Color) none = lib.DrawTextureNPatch
func Fade(color Color, alpha number) Color = lib.Fade
func ColorToInt(color Color) number = lib.ColorToInt
func ColorNormalize(color Color) Vector4 = lib.ColorNormalize
func ColorFromNormalized(normalized Vector4) Color = lib.ColorFromNormalized
func ColorToHSV(color Color) Vector3 = lib.ColorToHSV
func ColorFromHSV(hue number, saturation number, value number) Color = lib.ColorFromHSV
func ColorTint(color Color, tint Color) Color = lib.ColorTint
func ColorBrightness(color Color, factor number) Color = lib.ColorBrightness
func ColorContrast(color Color, contrast number) Color = lib.ColorContrast
func ColorAlpha(color Color, alpha number) Color = lib.ColorAlpha
func ColorAlphaBlend(dst Color, src Color, tint Color) Color = lib.ColorAlphaBlend
func GetColor(hexValue number) Color = lib.GetColor
func GetPixelColor(srcPtr pointer, format number) Color = lib.GetPixelColor
func SetPixelColor(dstPtr pointer, color Color, format number) none = lib.SetPixelColor
func GetPixelDataSize(width number, height number, format number) number = lib.GetPixelDataSize
func GetFontDefault() Font = lib.GetFontDefault
func LoadFont(fileName pointer) Font = lib.LoadFont
func LoadFontEx(fileName pointer, fontSize number, fontChars pointer, glyphCount number) Font = lib.LoadFontEx
func LoadFontFromImage(image Image, key Color, firstChar number) Font = lib.LoadFontFromImage
func LoadFontFromMemory(fileType pointer, fileData pointer, dataSize number, fontSize number, fontChars pointer, glyphCount number) Font = lib.LoadFontFromMemory
func IsFontReady(font Font) boolean = lib.IsFontReady
func LoadFontData(fileData pointer, dataSize number, fontSize number, fontChars pointer, glyphCount number, type number) pointer = lib.LoadFontData
func GenImageFontAtlas(chars pointer, recs pointer, glyphCount number, fontSize number, padding number, packMethod number) Image = lib.GenImageFontAtlas
func UnloadFontData(chars pointer, glyphCount number) none = lib.UnloadFontData
func UnloadFont(font Font) none = lib.UnloadFont
func ExportFontAsCode(font Font, fileName pointer) boolean = lib.ExportFontAsCode
func DrawFPS(posX number, posY number) none = lib.DrawFPS
-- Skip func DrawText(text pointer, posX number, posY number, fontSize number, color Color) none = lib.DrawText
func DrawTextEx(font Font, text pointer, position Vector2, fontSize number, spacing number, tint Color) none = lib.DrawTextEx
func DrawTextPro(font Font, text pointer, position Vector2, origin Vector2, rotation number, fontSize number, spacing number, tint Color) none = lib.DrawTextPro
func DrawTextCodepoint(font Font, codepoint number, position Vector2, fontSize number, tint Color) none = lib.DrawTextCodepoint
func DrawTextCodepoints(font Font, codepoints pointer, count number, position Vector2, fontSize number, spacing number, tint Color) none = lib.DrawTextCodepoints
-- Skip func MeasureText(text pointer, fontSize number) number = lib.MeasureText
func MeasureTextEx(font Font, text pointer, fontSize number, spacing number) Vector2 = lib.MeasureTextEx
func GetGlyphIndex(font Font, codepoint number) number = lib.GetGlyphIndex
func GetGlyphInfo(font Font, codepoint number) GlyphInfo = lib.GetGlyphInfo
func GetGlyphAtlasRec(font Font, codepoint number) Rectangle = lib.GetGlyphAtlasRec
func LoadUTF8(codepoints pointer, length number) pointer = lib.LoadUTF8
func UnloadUTF8(text pointer) none = lib.UnloadUTF8
func LoadCodepoints(text pointer, count pointer) pointer = lib.LoadCodepoints
func UnloadCodepoints(codepoints pointer) none = lib.UnloadCodepoints
func GetCodepointCount(text pointer) number = lib.GetCodepointCount
func GetCodepoint(text pointer, codepointSize pointer) number = lib.GetCodepoint
func GetCodepointNext(text pointer, codepointSize pointer) number = lib.GetCodepointNext
func GetCodepointPrevious(text pointer, codepointSize pointer) number = lib.GetCodepointPrevious
func CodepointToUTF8(codepoint number, utf8Size pointer) pointer = lib.CodepointToUTF8
func TextCopy(dst pointer, src pointer) number = lib.TextCopy
func TextIsEqual(text1 pointer, text2 pointer) boolean = lib.TextIsEqual
func TextLength(text pointer) number = lib.TextLength
func TextSubtext(text pointer, position number, length number) pointer = lib.TextSubtext
func TextReplace(text pointer, replace pointer, by pointer) pointer = lib.TextReplace
func TextInsert(text pointer, insert pointer, position number) pointer = lib.TextInsert
func TextJoin(textList pointer, count number, delimiter pointer) pointer = lib.TextJoin
func TextSplit(text pointer, delimiter number, count pointer) pointer = lib.TextSplit
func TextAppend(text pointer, append pointer, position pointer) none = lib.TextAppend
func TextFindIndex(text pointer, find pointer) number = lib.TextFindIndex
func TextToUpper(text pointer) pointer = lib.TextToUpper
func TextToLower(text pointer) pointer = lib.TextToLower
func TextToPascal(text pointer) pointer = lib.TextToPascal
func TextToInteger(text pointer) number = lib.TextToInteger
func DrawLine3D(startPos Vector3, endPos Vector3, color Color) none = lib.DrawLine3D
func DrawPoint3D(position Vector3, color Color) none = lib.DrawPoint3D
func DrawCircle3D(center Vector3, radius number, rotationAxis Vector3, rotationAngle number, color Color) none = lib.DrawCircle3D
func DrawTriangle3D(v1 Vector3, v2 Vector3, v3 Vector3, color Color) none = lib.DrawTriangle3D
func DrawTriangleStrip3D(points pointer, pointCount number, color Color) none = lib.DrawTriangleStrip3D
func DrawCube(position Vector3, width number, height number, length number, color Color) none = lib.DrawCube
func DrawCubeV(position Vector3, size Vector3, color Color) none = lib.DrawCubeV
func DrawCubeWires(position Vector3, width number, height number, length number, color Color) none = lib.DrawCubeWires
func DrawCubeWiresV(position Vector3, size Vector3, color Color) none = lib.DrawCubeWiresV
func DrawSphere(centerPos Vector3, radius number, color Color) none = lib.DrawSphere
func DrawSphereEx(centerPos Vector3, radius number, rings number, slices number, color Color) none = lib.DrawSphereEx
func DrawSphereWires(centerPos Vector3, radius number, rings number, slices number, color Color) none = lib.DrawSphereWires
func DrawCylinder(position Vector3, radiusTop number, radiusBottom number, height number, slices number, color Color) none = lib.DrawCylinder
func DrawCylinderEx(startPos Vector3, endPos Vector3, startRadius number, endRadius number, sides number, color Color) none = lib.DrawCylinderEx
func DrawCylinderWires(position Vector3, radiusTop number, radiusBottom number, height number, slices number, color Color) none = lib.DrawCylinderWires
func DrawCylinderWiresEx(startPos Vector3, endPos Vector3, startRadius number, endRadius number, sides number, color Color) none = lib.DrawCylinderWiresEx
func DrawCapsule(startPos Vector3, endPos Vector3, radius number, slices number, rings number, color Color) none = lib.DrawCapsule
func DrawCapsuleWires(startPos Vector3, endPos Vector3, radius number, slices number, rings number, color Color) none = lib.DrawCapsuleWires
func DrawPlane(centerPos Vector3, size Vector2, color Color) none = lib.DrawPlane
func DrawRay(ray Ray, color Color) none = lib.DrawRay
func DrawGrid(slices number, spacing number) none = lib.DrawGrid
func LoadModel(fileName pointer) Model = lib.LoadModel
func LoadModelFromMesh(mesh Mesh) Model = lib.LoadModelFromMesh
func IsModelReady(model Model) boolean = lib.IsModelReady
func UnloadModel(model Model) none = lib.UnloadModel
func GetModelBoundingBox(model Model) BoundingBox = lib.GetModelBoundingBox
func DrawModel(model Model, position Vector3, scale number, tint Color) none = lib.DrawModel
func DrawModelEx(model Model, position Vector3, rotationAxis Vector3, rotationAngle number, scale Vector3, tint Color) none = lib.DrawModelEx
func DrawModelWires(model Model, position Vector3, scale number, tint Color) none = lib.DrawModelWires
func DrawModelWiresEx(model Model, position Vector3, rotationAxis Vector3, rotationAngle number, scale Vector3, tint Color) none = lib.DrawModelWiresEx
func DrawBoundingBox(box BoundingBox, color Color) none = lib.DrawBoundingBox
func DrawBillboard(camera Camera3D, texture Texture, position Vector3, size number, tint Color) none = lib.DrawBillboard
func DrawBillboardRec(camera Camera3D, texture Texture, source Rectangle, position Vector3, size Vector2, tint Color) none = lib.DrawBillboardRec
func DrawBillboardPro(camera Camera3D, texture Texture, source Rectangle, position Vector3, up Vector3, size Vector2, origin Vector2, rotation number, tint Color) none = lib.DrawBillboardPro
func UploadMesh(mesh pointer, dynamic boolean) none = lib.UploadMesh
func UpdateMeshBuffer(mesh Mesh, index number, data pointer, dataSize number, offset number) none = lib.UpdateMeshBuffer
func UnloadMesh(mesh Mesh) none = lib.UnloadMesh
func DrawMesh(mesh Mesh, material Material, transform Matrix) none = lib.DrawMesh
func DrawMeshInstanced(mesh Mesh, material Material, transforms pointer, instances number) none = lib.DrawMeshInstanced
func ExportMesh(mesh Mesh, fileName pointer) boolean = lib.ExportMesh
func GetMeshBoundingBox(mesh Mesh) BoundingBox = lib.GetMeshBoundingBox
func GenMeshTangents(mesh pointer) none = lib.GenMeshTangents
func GenMeshPoly(sides number, radius number) Mesh = lib.GenMeshPoly
func GenMeshPlane(width number, length number, resX number, resZ number) Mesh = lib.GenMeshPlane
func GenMeshCube(width number, height number, length number) Mesh = lib.GenMeshCube
func GenMeshSphere(radius number, rings number, slices number) Mesh = lib.GenMeshSphere
func GenMeshHemiSphere(radius number, rings number, slices number) Mesh = lib.GenMeshHemiSphere
func GenMeshCylinder(radius number, height number, slices number) Mesh = lib.GenMeshCylinder
func GenMeshCone(radius number, height number, slices number) Mesh = lib.GenMeshCone
func GenMeshTorus(radius number, size number, radSeg number, sides number) Mesh = lib.GenMeshTorus
func GenMeshKnot(radius number, size number, radSeg number, sides number) Mesh = lib.GenMeshKnot
func GenMeshHeightmap(heightmap Image, size Vector3) Mesh = lib.GenMeshHeightmap
func GenMeshCubicmap(cubicmap Image, cubeSize Vector3) Mesh = lib.GenMeshCubicmap
func LoadMaterials(fileName pointer, materialCount pointer) pointer = lib.LoadMaterials
func LoadMaterialDefault() Material = lib.LoadMaterialDefault
func IsMaterialReady(material Material) boolean = lib.IsMaterialReady
func UnloadMaterial(material Material) none = lib.UnloadMaterial
func SetMaterialTexture(material pointer, mapType number, texture Texture) none = lib.SetMaterialTexture
func SetModelMeshMaterial(model pointer, meshId number, materialId number) none = lib.SetModelMeshMaterial
func LoadModelAnimations(fileName pointer, animCount pointer) pointer = lib.LoadModelAnimations
func UpdateModelAnimation(model Model, anim ModelAnimation, frame number) none = lib.UpdateModelAnimation
func UnloadModelAnimation(anim ModelAnimation) none = lib.UnloadModelAnimation
func UnloadModelAnimations(animations pointer, count number) none = lib.UnloadModelAnimations
func IsModelAnimationValid(model Model, anim ModelAnimation) boolean = lib.IsModelAnimationValid
func CheckCollisionSpheres(center1 Vector3, radius1 number, center2 Vector3, radius2 number) boolean = lib.CheckCollisionSpheres
func CheckCollisionBoxes(box1 BoundingBox, box2 BoundingBox) boolean = lib.CheckCollisionBoxes
func CheckCollisionBoxSphere(box BoundingBox, center Vector3, radius number) boolean = lib.CheckCollisionBoxSphere
func GetRayCollisionSphere(ray Ray, center Vector3, radius number) RayCollision = lib.GetRayCollisionSphere
func GetRayCollisionBox(ray Ray, box BoundingBox) RayCollision = lib.GetRayCollisionBox
func GetRayCollisionMesh(ray Ray, mesh Mesh, transform Matrix) RayCollision = lib.GetRayCollisionMesh
func GetRayCollisionTriangle(ray Ray, p1 Vector3, p2 Vector3, p3 Vector3) RayCollision = lib.GetRayCollisionTriangle
func GetRayCollisionQuad(ray Ray, p1 Vector3, p2 Vector3, p3 Vector3, p4 Vector3) RayCollision = lib.GetRayCollisionQuad
type AudioCallback pointer
func InitAudioDevice() none = lib.InitAudioDevice
func CloseAudioDevice() none = lib.CloseAudioDevice
func IsAudioDeviceReady() boolean = lib.IsAudioDeviceReady
func SetMasterVolume(volume number) none = lib.SetMasterVolume
func LoadWave(fileName pointer) Wave = lib.LoadWave
func LoadWaveFromMemory(fileType pointer, fileData pointer, dataSize number) Wave = lib.LoadWaveFromMemory
func IsWaveReady(wave Wave) boolean = lib.IsWaveReady
func LoadSound(fileName pointer) Sound = lib.LoadSound
func LoadSoundFromWave(wave Wave) Sound = lib.LoadSoundFromWave
func IsSoundReady(sound Sound) boolean = lib.IsSoundReady
func UpdateSound(sound Sound, data pointer, sampleCount number) none = lib.UpdateSound
func UnloadWave(wave Wave) none = lib.UnloadWave
func UnloadSound(sound Sound) none = lib.UnloadSound
func ExportWave(wave Wave, fileName pointer) boolean = lib.ExportWave
func ExportWaveAsCode(wave Wave, fileName pointer) boolean = lib.ExportWaveAsCode
func PlaySound(sound Sound) none = lib.PlaySound
func StopSound(sound Sound) none = lib.StopSound
func PauseSound(sound Sound) none = lib.PauseSound
func ResumeSound(sound Sound) none = lib.ResumeSound
func IsSoundPlaying(sound Sound) boolean = lib.IsSoundPlaying
func SetSoundVolume(sound Sound, volume number) none = lib.SetSoundVolume
func SetSoundPitch(sound Sound, pitch number) none = lib.SetSoundPitch
func SetSoundPan(sound Sound, pan number) none = lib.SetSoundPan
func WaveCopy(wave Wave) Wave = lib.WaveCopy
func WaveCrop(wave pointer, initSample number, finalSample number) none = lib.WaveCrop
func WaveFormat(wave pointer, sampleRate number, sampleSize number, channels number) none = lib.WaveFormat
func LoadWaveSamples(wave Wave) pointer = lib.LoadWaveSamples
func UnloadWaveSamples(samples pointer) none = lib.UnloadWaveSamples
func LoadMusicStream(fileName pointer) Music = lib.LoadMusicStream
func LoadMusicStreamFromMemory(fileType pointer, data pointer, dataSize number) Music = lib.LoadMusicStreamFromMemory
func IsMusicReady(music Music) boolean = lib.IsMusicReady
func UnloadMusicStream(music Music) none = lib.UnloadMusicStream
func PlayMusicStream(music Music) none = lib.PlayMusicStream
func IsMusicStreamPlaying(music Music) boolean = lib.IsMusicStreamPlaying
func UpdateMusicStream(music Music) none = lib.UpdateMusicStream
func StopMusicStream(music Music) none = lib.StopMusicStream
func PauseMusicStream(music Music) none = lib.PauseMusicStream
func ResumeMusicStream(music Music) none = lib.ResumeMusicStream
func SeekMusicStream(music Music, position number) none = lib.SeekMusicStream
func SetMusicVolume(music Music, volume number) none = lib.SetMusicVolume
func SetMusicPitch(music Music, pitch number) none = lib.SetMusicPitch
func SetMusicPan(music Music, pan number) none = lib.SetMusicPan
func GetMusicTimeLength(music Music) number = lib.GetMusicTimeLength
func GetMusicTimePlayed(music Music) number = lib.GetMusicTimePlayed
func LoadAudioStream(sampleRate number, sampleSize number, channels number) AudioStream = lib.LoadAudioStream
func IsAudioStreamReady(stream AudioStream) boolean = lib.IsAudioStreamReady
func UnloadAudioStream(stream AudioStream) none = lib.UnloadAudioStream
func UpdateAudioStream(stream AudioStream, data pointer, frameCount number) none = lib.UpdateAudioStream
func IsAudioStreamProcessed(stream AudioStream) boolean = lib.IsAudioStreamProcessed
func PlayAudioStream(stream AudioStream) none = lib.PlayAudioStream
func PauseAudioStream(stream AudioStream) none = lib.PauseAudioStream
func ResumeAudioStream(stream AudioStream) none = lib.ResumeAudioStream
func IsAudioStreamPlaying(stream AudioStream) boolean = lib.IsAudioStreamPlaying
func StopAudioStream(stream AudioStream) none = lib.StopAudioStream
func SetAudioStreamVolume(stream AudioStream, volume number) none = lib.SetAudioStreamVolume
func SetAudioStreamPitch(stream AudioStream, pitch number) none = lib.SetAudioStreamPitch
func SetAudioStreamPan(stream AudioStream, pan number) none = lib.SetAudioStreamPan
func SetAudioStreamBufferSizeDefault(size number) none = lib.SetAudioStreamBufferSizeDefault
func SetAudioStreamCallback(stream AudioStream, callback pointer) none = lib.SetAudioStreamCallback
func AttachAudioStreamProcessor(stream AudioStream, processor pointer) none = lib.AttachAudioStreamProcessor
func DetachAudioStreamProcessor(stream AudioStream, processor pointer) none = lib.DetachAudioStreamProcessor
func AttachAudioMixedProcessor(processor pointer) none = lib.AttachAudioMixedProcessor
func DetachAudioMixedProcessor(processor pointer) none = lib.DetachAudioMixedProcessor
var RAYLIB_VERSION: "4.5"
var MOUSE_LEFT_BUTTON number: MOUSE_BUTTON_LEFT
var MOUSE_RIGHT_BUTTON number: MOUSE_BUTTON_RIGHT
var MOUSE_MIDDLE_BUTTON number: MOUSE_BUTTON_MIDDLE
var MATERIAL_MAP_DIFFUSE number: MATERIAL_MAP_ALBEDO
var MATERIAL_MAP_SPECULAR number: MATERIAL_MAP_METALNESS
var SHADER_LOC_MAP_DIFFUSE number: SHADER_LOC_MAP_ALBEDO
var SHADER_LOC_MAP_SPECULAR number: SHADER_LOC_MAP_METALNESS

import os 'os'
var lib: createLib()
func createLib():
  decls = []
  decls.append(os.CFunc{ sym: 'InitWindow', args: [#int, #int, #voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'WindowShouldClose', args: [], ret: #bool })
  decls.append(os.CFunc{ sym: 'CloseWindow', args: [], ret: #void })
  decls.append(os.CFunc{ sym: 'IsWindowReady', args: [], ret: #bool })
  decls.append(os.CFunc{ sym: 'IsWindowFullscreen', args: [], ret: #bool })
  decls.append(os.CFunc{ sym: 'IsWindowHidden', args: [], ret: #bool })
  decls.append(os.CFunc{ sym: 'IsWindowMinimized', args: [], ret: #bool })
  decls.append(os.CFunc{ sym: 'IsWindowMaximized', args: [], ret: #bool })
  decls.append(os.CFunc{ sym: 'IsWindowFocused', args: [], ret: #bool })
  decls.append(os.CFunc{ sym: 'IsWindowResized', args: [], ret: #bool })
  decls.append(os.CFunc{ sym: 'IsWindowState', args: [#uint], ret: #bool })
  decls.append(os.CFunc{ sym: 'SetWindowState', args: [#uint], ret: #void })
  decls.append(os.CFunc{ sym: 'ClearWindowState', args: [#uint], ret: #void })
  decls.append(os.CFunc{ sym: 'ToggleFullscreen', args: [], ret: #void })
  decls.append(os.CFunc{ sym: 'MaximizeWindow', args: [], ret: #void })
  decls.append(os.CFunc{ sym: 'MinimizeWindow', args: [], ret: #void })
  decls.append(os.CFunc{ sym: 'RestoreWindow', args: [], ret: #void })
  decls.append(os.CFunc{ sym: 'SetWindowIcon', args: [Image], ret: #void })
  decls.append(os.CFunc{ sym: 'SetWindowIcons', args: [#voidPtr, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'SetWindowTitle', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'SetWindowPosition', args: [#int, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'SetWindowMonitor', args: [#int], ret: #void })
  decls.append(os.CFunc{ sym: 'SetWindowMinSize', args: [#int, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'SetWindowSize', args: [#int, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'SetWindowOpacity', args: [#float], ret: #void })
  decls.append(os.CFunc{ sym: 'GetWindowHandle', args: [], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'GetScreenWidth', args: [], ret: #int })
  decls.append(os.CFunc{ sym: 'GetScreenHeight', args: [], ret: #int })
  decls.append(os.CFunc{ sym: 'GetRenderWidth', args: [], ret: #int })
  decls.append(os.CFunc{ sym: 'GetRenderHeight', args: [], ret: #int })
  decls.append(os.CFunc{ sym: 'GetMonitorCount', args: [], ret: #int })
  decls.append(os.CFunc{ sym: 'GetCurrentMonitor', args: [], ret: #int })
  decls.append(os.CFunc{ sym: 'GetMonitorPosition', args: [#int], ret: Vector2 })
  decls.append(os.CFunc{ sym: 'GetMonitorWidth', args: [#int], ret: #int })
  decls.append(os.CFunc{ sym: 'GetMonitorHeight', args: [#int], ret: #int })
  decls.append(os.CFunc{ sym: 'GetMonitorPhysicalWidth', args: [#int], ret: #int })
  decls.append(os.CFunc{ sym: 'GetMonitorPhysicalHeight', args: [#int], ret: #int })
  decls.append(os.CFunc{ sym: 'GetMonitorRefreshRate', args: [#int], ret: #int })
  decls.append(os.CFunc{ sym: 'GetWindowPosition', args: [], ret: Vector2 })
  decls.append(os.CFunc{ sym: 'GetWindowScaleDPI', args: [], ret: Vector2 })
  decls.append(os.CFunc{ sym: 'GetMonitorName', args: [#int], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'SetClipboardText', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'GetClipboardText', args: [], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'EnableEventWaiting', args: [], ret: #void })
  decls.append(os.CFunc{ sym: 'DisableEventWaiting', args: [], ret: #void })
  decls.append(os.CFunc{ sym: 'SwapScreenBuffer', args: [], ret: #void })
  decls.append(os.CFunc{ sym: 'PollInputEvents', args: [], ret: #void })
  decls.append(os.CFunc{ sym: 'WaitTime', args: [#double], ret: #void })
  decls.append(os.CFunc{ sym: 'ShowCursor', args: [], ret: #void })
  decls.append(os.CFunc{ sym: 'HideCursor', args: [], ret: #void })
  decls.append(os.CFunc{ sym: 'IsCursorHidden', args: [], ret: #bool })
  decls.append(os.CFunc{ sym: 'EnableCursor', args: [], ret: #void })
  decls.append(os.CFunc{ sym: 'DisableCursor', args: [], ret: #void })
  decls.append(os.CFunc{ sym: 'IsCursorOnScreen', args: [], ret: #bool })
  decls.append(os.CFunc{ sym: 'ClearBackground', args: [Color], ret: #void })
  decls.append(os.CFunc{ sym: 'BeginDrawing', args: [], ret: #void })
  decls.append(os.CFunc{ sym: 'EndDrawing', args: [], ret: #void })
  decls.append(os.CFunc{ sym: 'BeginMode2D', args: [Camera2D], ret: #void })
  decls.append(os.CFunc{ sym: 'EndMode2D', args: [], ret: #void })
  decls.append(os.CFunc{ sym: 'BeginMode3D', args: [Camera3D], ret: #void })
  decls.append(os.CFunc{ sym: 'EndMode3D', args: [], ret: #void })
  decls.append(os.CFunc{ sym: 'BeginTextureMode', args: [RenderTexture], ret: #void })
  decls.append(os.CFunc{ sym: 'EndTextureMode', args: [], ret: #void })
  decls.append(os.CFunc{ sym: 'BeginShaderMode', args: [Shader], ret: #void })
  decls.append(os.CFunc{ sym: 'EndShaderMode', args: [], ret: #void })
  decls.append(os.CFunc{ sym: 'BeginBlendMode', args: [#int], ret: #void })
  decls.append(os.CFunc{ sym: 'EndBlendMode', args: [], ret: #void })
  decls.append(os.CFunc{ sym: 'BeginScissorMode', args: [#int, #int, #int, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'EndScissorMode', args: [], ret: #void })
  decls.append(os.CFunc{ sym: 'BeginVrStereoMode', args: [VrStereoConfig], ret: #void })
  decls.append(os.CFunc{ sym: 'EndVrStereoMode', args: [], ret: #void })
  decls.append(os.CFunc{ sym: 'LoadVrStereoConfig', args: [VrDeviceInfo], ret: VrStereoConfig })
  decls.append(os.CFunc{ sym: 'UnloadVrStereoConfig', args: [VrStereoConfig], ret: #void })
  decls.append(os.CFunc{ sym: 'LoadShader', args: [#voidPtr, #voidPtr], ret: Shader })
  decls.append(os.CFunc{ sym: 'LoadShaderFromMemory', args: [#voidPtr, #voidPtr], ret: Shader })
  decls.append(os.CFunc{ sym: 'IsShaderReady', args: [Shader], ret: #bool })
  decls.append(os.CFunc{ sym: 'GetShaderLocation', args: [Shader, #voidPtr], ret: #int })
  decls.append(os.CFunc{ sym: 'GetShaderLocationAttrib', args: [Shader, #voidPtr], ret: #int })
  decls.append(os.CFunc{ sym: 'SetShaderValue', args: [Shader, #int, #voidPtr, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'SetShaderValueV', args: [Shader, #int, #voidPtr, #int, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'SetShaderValueMatrix', args: [Shader, #int, Matrix], ret: #void })
  decls.append(os.CFunc{ sym: 'SetShaderValueTexture', args: [Shader, #int, Texture], ret: #void })
  decls.append(os.CFunc{ sym: 'UnloadShader', args: [Shader], ret: #void })
  decls.append(os.CFunc{ sym: 'GetMouseRay', args: [Vector2, Camera3D], ret: Ray })
  decls.append(os.CFunc{ sym: 'GetCameraMatrix', args: [Camera3D], ret: Matrix })
  decls.append(os.CFunc{ sym: 'GetCameraMatrix2D', args: [Camera2D], ret: Matrix })
  decls.append(os.CFunc{ sym: 'GetWorldToScreen', args: [Vector3, Camera3D], ret: Vector2 })
  decls.append(os.CFunc{ sym: 'GetScreenToWorld2D', args: [Vector2, Camera2D], ret: Vector2 })
  decls.append(os.CFunc{ sym: 'GetWorldToScreenEx', args: [Vector3, Camera3D, #int, #int], ret: Vector2 })
  decls.append(os.CFunc{ sym: 'GetWorldToScreen2D', args: [Vector2, Camera2D], ret: Vector2 })
  decls.append(os.CFunc{ sym: 'SetTargetFPS', args: [#int], ret: #void })
  decls.append(os.CFunc{ sym: 'GetFPS', args: [], ret: #int })
  decls.append(os.CFunc{ sym: 'GetFrameTime', args: [], ret: #float })
  decls.append(os.CFunc{ sym: 'GetTime', args: [], ret: #double })
  decls.append(os.CFunc{ sym: 'GetRandomValue', args: [#int, #int], ret: #int })
  decls.append(os.CFunc{ sym: 'SetRandomSeed', args: [#uint], ret: #void })
  decls.append(os.CFunc{ sym: 'TakeScreenshot', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'SetConfigFlags', args: [#uint], ret: #void })
  decls.append(os.CFunc{ sym: 'SetTraceLogLevel', args: [#int], ret: #void })
  decls.append(os.CFunc{ sym: 'MemAlloc', args: [#uint], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'MemRealloc', args: [#voidPtr, #uint], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'MemFree', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'OpenURL', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'SetTraceLogCallback', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'SetLoadFileDataCallback', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'SetSaveFileDataCallback', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'SetLoadFileTextCallback', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'SetSaveFileTextCallback', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'LoadFileData', args: [#voidPtr, #voidPtr], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'UnloadFileData', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'SaveFileData', args: [#voidPtr, #voidPtr, #uint], ret: #bool })
  decls.append(os.CFunc{ sym: 'ExportDataAsCode', args: [#voidPtr, #uint, #voidPtr], ret: #bool })
  decls.append(os.CFunc{ sym: 'LoadFileText', args: [#voidPtr], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'UnloadFileText', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'SaveFileText', args: [#voidPtr, #voidPtr], ret: #bool })
  decls.append(os.CFunc{ sym: 'FileExists', args: [#voidPtr], ret: #bool })
  decls.append(os.CFunc{ sym: 'DirectoryExists', args: [#voidPtr], ret: #bool })
  decls.append(os.CFunc{ sym: 'IsFileExtension', args: [#voidPtr, #voidPtr], ret: #bool })
  decls.append(os.CFunc{ sym: 'GetFileLength', args: [#voidPtr], ret: #int })
  decls.append(os.CFunc{ sym: 'GetFileExtension', args: [#voidPtr], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'GetFileName', args: [#voidPtr], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'GetFileNameWithoutExt', args: [#voidPtr], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'GetDirectoryPath', args: [#voidPtr], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'GetPrevDirectoryPath', args: [#voidPtr], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'GetWorkingDirectory', args: [], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'GetApplicationDirectory', args: [], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'ChangeDirectory', args: [#voidPtr], ret: #bool })
  decls.append(os.CFunc{ sym: 'IsPathFile', args: [#voidPtr], ret: #bool })
  decls.append(os.CFunc{ sym: 'LoadDirectoryFiles', args: [#voidPtr], ret: FilePathList })
  decls.append(os.CFunc{ sym: 'LoadDirectoryFilesEx', args: [#voidPtr, #voidPtr, #bool], ret: FilePathList })
  decls.append(os.CFunc{ sym: 'UnloadDirectoryFiles', args: [FilePathList], ret: #void })
  decls.append(os.CFunc{ sym: 'IsFileDropped', args: [], ret: #bool })
  decls.append(os.CFunc{ sym: 'LoadDroppedFiles', args: [], ret: FilePathList })
  decls.append(os.CFunc{ sym: 'UnloadDroppedFiles', args: [FilePathList], ret: #void })
  decls.append(os.CFunc{ sym: 'GetFileModTime', args: [#voidPtr], ret: #long })
  decls.append(os.CFunc{ sym: 'CompressData', args: [#voidPtr, #int, #voidPtr], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'DecompressData', args: [#voidPtr, #int, #voidPtr], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'EncodeDataBase64', args: [#voidPtr, #int, #voidPtr], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'DecodeDataBase64', args: [#voidPtr, #voidPtr], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'IsKeyPressed', args: [#int], ret: #bool })
  decls.append(os.CFunc{ sym: 'IsKeyDown', args: [#int], ret: #bool })
  decls.append(os.CFunc{ sym: 'IsKeyReleased', args: [#int], ret: #bool })
  decls.append(os.CFunc{ sym: 'IsKeyUp', args: [#int], ret: #bool })
  decls.append(os.CFunc{ sym: 'SetExitKey', args: [#int], ret: #void })
  decls.append(os.CFunc{ sym: 'GetKeyPressed', args: [], ret: #int })
  decls.append(os.CFunc{ sym: 'GetCharPressed', args: [], ret: #int })
  decls.append(os.CFunc{ sym: 'IsGamepadAvailable', args: [#int], ret: #bool })
  decls.append(os.CFunc{ sym: 'GetGamepadName', args: [#int], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'IsGamepadButtonPressed', args: [#int, #int], ret: #bool })
  decls.append(os.CFunc{ sym: 'IsGamepadButtonDown', args: [#int, #int], ret: #bool })
  decls.append(os.CFunc{ sym: 'IsGamepadButtonReleased', args: [#int, #int], ret: #bool })
  decls.append(os.CFunc{ sym: 'IsGamepadButtonUp', args: [#int, #int], ret: #bool })
  decls.append(os.CFunc{ sym: 'GetGamepadButtonPressed', args: [], ret: #int })
  decls.append(os.CFunc{ sym: 'GetGamepadAxisCount', args: [#int], ret: #int })
  decls.append(os.CFunc{ sym: 'GetGamepadAxisMovement', args: [#int, #int], ret: #float })
  decls.append(os.CFunc{ sym: 'SetGamepadMappings', args: [#voidPtr], ret: #int })
  decls.append(os.CFunc{ sym: 'IsMouseButtonPressed', args: [#int], ret: #bool })
  decls.append(os.CFunc{ sym: 'IsMouseButtonDown', args: [#int], ret: #bool })
  decls.append(os.CFunc{ sym: 'IsMouseButtonReleased', args: [#int], ret: #bool })
  decls.append(os.CFunc{ sym: 'IsMouseButtonUp', args: [#int], ret: #bool })
  decls.append(os.CFunc{ sym: 'GetMouseX', args: [], ret: #int })
  decls.append(os.CFunc{ sym: 'GetMouseY', args: [], ret: #int })
  decls.append(os.CFunc{ sym: 'GetMousePosition', args: [], ret: Vector2 })
  decls.append(os.CFunc{ sym: 'GetMouseDelta', args: [], ret: Vector2 })
  decls.append(os.CFunc{ sym: 'SetMousePosition', args: [#int, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'SetMouseOffset', args: [#int, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'SetMouseScale', args: [#float, #float], ret: #void })
  decls.append(os.CFunc{ sym: 'GetMouseWheelMove', args: [], ret: #float })
  decls.append(os.CFunc{ sym: 'GetMouseWheelMoveV', args: [], ret: Vector2 })
  decls.append(os.CFunc{ sym: 'SetMouseCursor', args: [#int], ret: #void })
  decls.append(os.CFunc{ sym: 'GetTouchX', args: [], ret: #int })
  decls.append(os.CFunc{ sym: 'GetTouchY', args: [], ret: #int })
  decls.append(os.CFunc{ sym: 'GetTouchPosition', args: [#int], ret: Vector2 })
  decls.append(os.CFunc{ sym: 'GetTouchPointId', args: [#int], ret: #int })
  decls.append(os.CFunc{ sym: 'GetTouchPointCount', args: [], ret: #int })
  decls.append(os.CFunc{ sym: 'SetGesturesEnabled', args: [#uint], ret: #void })
  decls.append(os.CFunc{ sym: 'IsGestureDetected', args: [#int], ret: #bool })
  decls.append(os.CFunc{ sym: 'GetGestureDetected', args: [], ret: #int })
  decls.append(os.CFunc{ sym: 'GetGestureHoldDuration', args: [], ret: #float })
  decls.append(os.CFunc{ sym: 'GetGestureDragVector', args: [], ret: Vector2 })
  decls.append(os.CFunc{ sym: 'GetGestureDragAngle', args: [], ret: #float })
  decls.append(os.CFunc{ sym: 'GetGesturePinchVector', args: [], ret: Vector2 })
  decls.append(os.CFunc{ sym: 'GetGesturePinchAngle', args: [], ret: #float })
  decls.append(os.CFunc{ sym: 'UpdateCamera', args: [#voidPtr, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'UpdateCameraPro', args: [#voidPtr, Vector3, Vector3, #float], ret: #void })
  decls.append(os.CFunc{ sym: 'SetShapesTexture', args: [Texture, Rectangle], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawPixel', args: [#int, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawPixelV', args: [Vector2, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawLine', args: [#int, #int, #int, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawLineV', args: [Vector2, Vector2, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawLineEx', args: [Vector2, Vector2, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawLineBezier', args: [Vector2, Vector2, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawLineBezierQuad', args: [Vector2, Vector2, Vector2, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawLineBezierCubic', args: [Vector2, Vector2, Vector2, Vector2, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawLineStrip', args: [#voidPtr, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawCircle', args: [#int, #int, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawCircleSector', args: [Vector2, #float, #float, #float, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawCircleSectorLines', args: [Vector2, #float, #float, #float, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawCircleGradient', args: [#int, #int, #float, Color, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawCircleV', args: [Vector2, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawCircleLines', args: [#int, #int, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawEllipse', args: [#int, #int, #float, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawEllipseLines', args: [#int, #int, #float, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawRing', args: [Vector2, #float, #float, #float, #float, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawRingLines', args: [Vector2, #float, #float, #float, #float, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawRectangle', args: [#int, #int, #int, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawRectangleV', args: [Vector2, Vector2, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawRectangleRec', args: [Rectangle, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawRectanglePro', args: [Rectangle, Vector2, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawRectangleGradientV', args: [#int, #int, #int, #int, Color, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawRectangleGradientH', args: [#int, #int, #int, #int, Color, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawRectangleGradientEx', args: [Rectangle, Color, Color, Color, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawRectangleLines', args: [#int, #int, #int, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawRectangleLinesEx', args: [Rectangle, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawRectangleRounded', args: [Rectangle, #float, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawRectangleRoundedLines', args: [Rectangle, #float, #int, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawTriangle', args: [Vector2, Vector2, Vector2, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawTriangleLines', args: [Vector2, Vector2, Vector2, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawTriangleFan', args: [#voidPtr, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawTriangleStrip', args: [#voidPtr, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawPoly', args: [Vector2, #int, #float, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawPolyLines', args: [Vector2, #int, #float, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawPolyLinesEx', args: [Vector2, #int, #float, #float, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'CheckCollisionRecs', args: [Rectangle, Rectangle], ret: #bool })
  decls.append(os.CFunc{ sym: 'CheckCollisionCircles', args: [Vector2, #float, Vector2, #float], ret: #bool })
  decls.append(os.CFunc{ sym: 'CheckCollisionCircleRec', args: [Vector2, #float, Rectangle], ret: #bool })
  decls.append(os.CFunc{ sym: 'CheckCollisionPointRec', args: [Vector2, Rectangle], ret: #bool })
  decls.append(os.CFunc{ sym: 'CheckCollisionPointCircle', args: [Vector2, Vector2, #float], ret: #bool })
  decls.append(os.CFunc{ sym: 'CheckCollisionPointTriangle', args: [Vector2, Vector2, Vector2, Vector2], ret: #bool })
  decls.append(os.CFunc{ sym: 'CheckCollisionPointPoly', args: [Vector2, #voidPtr, #int], ret: #bool })
  decls.append(os.CFunc{ sym: 'CheckCollisionLines', args: [Vector2, Vector2, Vector2, Vector2, #voidPtr], ret: #bool })
  decls.append(os.CFunc{ sym: 'CheckCollisionPointLine', args: [Vector2, Vector2, Vector2, #int], ret: #bool })
  decls.append(os.CFunc{ sym: 'GetCollisionRec', args: [Rectangle, Rectangle], ret: Rectangle })
  decls.append(os.CFunc{ sym: 'LoadImage', args: [#voidPtr], ret: Image })
  decls.append(os.CFunc{ sym: 'LoadImageRaw', args: [#voidPtr, #int, #int, #int, #int], ret: Image })
  decls.append(os.CFunc{ sym: 'LoadImageAnim', args: [#voidPtr, #voidPtr], ret: Image })
  decls.append(os.CFunc{ sym: 'LoadImageFromMemory', args: [#voidPtr, #voidPtr, #int], ret: Image })
  decls.append(os.CFunc{ sym: 'LoadImageFromTexture', args: [Texture], ret: Image })
  decls.append(os.CFunc{ sym: 'LoadImageFromScreen', args: [], ret: Image })
  decls.append(os.CFunc{ sym: 'IsImageReady', args: [Image], ret: #bool })
  decls.append(os.CFunc{ sym: 'UnloadImage', args: [Image], ret: #void })
  decls.append(os.CFunc{ sym: 'ExportImage', args: [Image, #voidPtr], ret: #bool })
  decls.append(os.CFunc{ sym: 'ExportImageAsCode', args: [Image, #voidPtr], ret: #bool })
  decls.append(os.CFunc{ sym: 'GenImageColor', args: [#int, #int, Color], ret: Image })
  decls.append(os.CFunc{ sym: 'GenImageGradientV', args: [#int, #int, Color, Color], ret: Image })
  decls.append(os.CFunc{ sym: 'GenImageGradientH', args: [#int, #int, Color, Color], ret: Image })
  decls.append(os.CFunc{ sym: 'GenImageGradientRadial', args: [#int, #int, #float, Color, Color], ret: Image })
  decls.append(os.CFunc{ sym: 'GenImageChecked', args: [#int, #int, #int, #int, Color, Color], ret: Image })
  decls.append(os.CFunc{ sym: 'GenImageWhiteNoise', args: [#int, #int, #float], ret: Image })
  decls.append(os.CFunc{ sym: 'GenImagePerlinNoise', args: [#int, #int, #int, #int, #float], ret: Image })
  decls.append(os.CFunc{ sym: 'GenImageCellular', args: [#int, #int, #int], ret: Image })
  decls.append(os.CFunc{ sym: 'GenImageText', args: [#int, #int, #voidPtr], ret: Image })
  decls.append(os.CFunc{ sym: 'ImageCopy', args: [Image], ret: Image })
  decls.append(os.CFunc{ sym: 'ImageFromImage', args: [Image, Rectangle], ret: Image })
  decls.append(os.CFunc{ sym: 'ImageText', args: [#voidPtr, #int, Color], ret: Image })
  decls.append(os.CFunc{ sym: 'ImageTextEx', args: [Font, #voidPtr, #float, #float, Color], ret: Image })
  decls.append(os.CFunc{ sym: 'ImageFormat', args: [#voidPtr, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageToPOT', args: [#voidPtr, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageCrop', args: [#voidPtr, Rectangle], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageAlphaCrop', args: [#voidPtr, #float], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageAlphaClear', args: [#voidPtr, Color, #float], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageAlphaMask', args: [#voidPtr, Image], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageAlphaPremultiply', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageBlurGaussian', args: [#voidPtr, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageResize', args: [#voidPtr, #int, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageResizeNN', args: [#voidPtr, #int, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageResizeCanvas', args: [#voidPtr, #int, #int, #int, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageMipmaps', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageDither', args: [#voidPtr, #int, #int, #int, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageFlipVertical', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageFlipHorizontal', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageRotateCW', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageRotateCCW', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageColorTint', args: [#voidPtr, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageColorInvert', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageColorGrayscale', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageColorContrast', args: [#voidPtr, #float], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageColorBrightness', args: [#voidPtr, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageColorReplace', args: [#voidPtr, Color, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'LoadImageColors', args: [Image], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'LoadImagePalette', args: [Image, #int, #voidPtr], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'UnloadImageColors', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'UnloadImagePalette', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'GetImageAlphaBorder', args: [Image, #float], ret: Rectangle })
  decls.append(os.CFunc{ sym: 'GetImageColor', args: [Image, #int, #int], ret: Color })
  decls.append(os.CFunc{ sym: 'ImageClearBackground', args: [#voidPtr, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageDrawPixel', args: [#voidPtr, #int, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageDrawPixelV', args: [#voidPtr, Vector2, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageDrawLine', args: [#voidPtr, #int, #int, #int, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageDrawLineV', args: [#voidPtr, Vector2, Vector2, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageDrawCircle', args: [#voidPtr, #int, #int, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageDrawCircleV', args: [#voidPtr, Vector2, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageDrawCircleLines', args: [#voidPtr, #int, #int, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageDrawCircleLinesV', args: [#voidPtr, Vector2, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageDrawRectangle', args: [#voidPtr, #int, #int, #int, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageDrawRectangleV', args: [#voidPtr, Vector2, Vector2, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageDrawRectangleRec', args: [#voidPtr, Rectangle, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageDrawRectangleLines', args: [#voidPtr, Rectangle, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageDraw', args: [#voidPtr, Image, Rectangle, Rectangle, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageDrawText', args: [#voidPtr, #voidPtr, #int, #int, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'ImageDrawTextEx', args: [#voidPtr, Font, #voidPtr, Vector2, #float, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'LoadTexture', args: [#voidPtr], ret: Texture })
  decls.append(os.CFunc{ sym: 'LoadTextureFromImage', args: [Image], ret: Texture })
  decls.append(os.CFunc{ sym: 'LoadTextureCubemap', args: [Image, #int], ret: Texture })
  decls.append(os.CFunc{ sym: 'LoadRenderTexture', args: [#int, #int], ret: RenderTexture })
  decls.append(os.CFunc{ sym: 'IsTextureReady', args: [Texture], ret: #bool })
  decls.append(os.CFunc{ sym: 'UnloadTexture', args: [Texture], ret: #void })
  decls.append(os.CFunc{ sym: 'IsRenderTextureReady', args: [RenderTexture], ret: #bool })
  decls.append(os.CFunc{ sym: 'UnloadRenderTexture', args: [RenderTexture], ret: #void })
  decls.append(os.CFunc{ sym: 'UpdateTexture', args: [Texture, #voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'UpdateTextureRec', args: [Texture, Rectangle, #voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'GenTextureMipmaps', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'SetTextureFilter', args: [Texture, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'SetTextureWrap', args: [Texture, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawTexture', args: [Texture, #int, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawTextureV', args: [Texture, Vector2, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawTextureEx', args: [Texture, Vector2, #float, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawTextureRec', args: [Texture, Rectangle, Vector2, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawTexturePro', args: [Texture, Rectangle, Rectangle, Vector2, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawTextureNPatch', args: [Texture, NPatchInfo, Rectangle, Vector2, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'Fade', args: [Color, #float], ret: Color })
  decls.append(os.CFunc{ sym: 'ColorToInt', args: [Color], ret: #int })
  decls.append(os.CFunc{ sym: 'ColorNormalize', args: [Color], ret: Vector4 })
  decls.append(os.CFunc{ sym: 'ColorFromNormalized', args: [Vector4], ret: Color })
  decls.append(os.CFunc{ sym: 'ColorToHSV', args: [Color], ret: Vector3 })
  decls.append(os.CFunc{ sym: 'ColorFromHSV', args: [#float, #float, #float], ret: Color })
  decls.append(os.CFunc{ sym: 'ColorTint', args: [Color, Color], ret: Color })
  decls.append(os.CFunc{ sym: 'ColorBrightness', args: [Color, #float], ret: Color })
  decls.append(os.CFunc{ sym: 'ColorContrast', args: [Color, #float], ret: Color })
  decls.append(os.CFunc{ sym: 'ColorAlpha', args: [Color, #float], ret: Color })
  decls.append(os.CFunc{ sym: 'ColorAlphaBlend', args: [Color, Color, Color], ret: Color })
  decls.append(os.CFunc{ sym: 'GetColor', args: [#uint], ret: Color })
  decls.append(os.CFunc{ sym: 'GetPixelColor', args: [#voidPtr, #int], ret: Color })
  decls.append(os.CFunc{ sym: 'SetPixelColor', args: [#voidPtr, Color, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'GetPixelDataSize', args: [#int, #int, #int], ret: #int })
  decls.append(os.CFunc{ sym: 'GetFontDefault', args: [], ret: Font })
  decls.append(os.CFunc{ sym: 'LoadFont', args: [#voidPtr], ret: Font })
  decls.append(os.CFunc{ sym: 'LoadFontEx', args: [#voidPtr, #int, #voidPtr, #int], ret: Font })
  decls.append(os.CFunc{ sym: 'LoadFontFromImage', args: [Image, Color, #int], ret: Font })
  decls.append(os.CFunc{ sym: 'LoadFontFromMemory', args: [#voidPtr, #voidPtr, #int, #int, #voidPtr, #int], ret: Font })
  decls.append(os.CFunc{ sym: 'IsFontReady', args: [Font], ret: #bool })
  decls.append(os.CFunc{ sym: 'LoadFontData', args: [#voidPtr, #int, #int, #voidPtr, #int, #int], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'GenImageFontAtlas', args: [#voidPtr, #voidPtr, #int, #int, #int, #int], ret: Image })
  decls.append(os.CFunc{ sym: 'UnloadFontData', args: [#voidPtr, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'UnloadFont', args: [Font], ret: #void })
  decls.append(os.CFunc{ sym: 'ExportFontAsCode', args: [Font, #voidPtr], ret: #bool })
  decls.append(os.CFunc{ sym: 'DrawFPS', args: [#int, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawText', args: [#voidPtr, #int, #int, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawTextEx', args: [Font, #voidPtr, Vector2, #float, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawTextPro', args: [Font, #voidPtr, Vector2, Vector2, #float, #float, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawTextCodepoint', args: [Font, #int, Vector2, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawTextCodepoints', args: [Font, #voidPtr, #int, Vector2, #float, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'MeasureText', args: [#voidPtr, #int], ret: #int })
  decls.append(os.CFunc{ sym: 'MeasureTextEx', args: [Font, #voidPtr, #float, #float], ret: Vector2 })
  decls.append(os.CFunc{ sym: 'GetGlyphIndex', args: [Font, #int], ret: #int })
  decls.append(os.CFunc{ sym: 'GetGlyphInfo', args: [Font, #int], ret: GlyphInfo })
  decls.append(os.CFunc{ sym: 'GetGlyphAtlasRec', args: [Font, #int], ret: Rectangle })
  decls.append(os.CFunc{ sym: 'LoadUTF8', args: [#voidPtr, #int], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'UnloadUTF8', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'LoadCodepoints', args: [#voidPtr, #voidPtr], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'UnloadCodepoints', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'GetCodepointCount', args: [#voidPtr], ret: #int })
  decls.append(os.CFunc{ sym: 'GetCodepoint', args: [#voidPtr, #voidPtr], ret: #int })
  decls.append(os.CFunc{ sym: 'GetCodepointNext', args: [#voidPtr, #voidPtr], ret: #int })
  decls.append(os.CFunc{ sym: 'GetCodepointPrevious', args: [#voidPtr, #voidPtr], ret: #int })
  decls.append(os.CFunc{ sym: 'CodepointToUTF8', args: [#int, #voidPtr], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'TextCopy', args: [#voidPtr, #voidPtr], ret: #int })
  decls.append(os.CFunc{ sym: 'TextIsEqual', args: [#voidPtr, #voidPtr], ret: #bool })
  decls.append(os.CFunc{ sym: 'TextLength', args: [#voidPtr], ret: #uint })
  decls.append(os.CFunc{ sym: 'TextSubtext', args: [#voidPtr, #int, #int], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'TextReplace', args: [#voidPtr, #voidPtr, #voidPtr], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'TextInsert', args: [#voidPtr, #voidPtr, #int], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'TextJoin', args: [#voidPtr, #int, #voidPtr], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'TextSplit', args: [#voidPtr, #uchar, #voidPtr], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'TextAppend', args: [#voidPtr, #voidPtr, #voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'TextFindIndex', args: [#voidPtr, #voidPtr], ret: #int })
  decls.append(os.CFunc{ sym: 'TextToUpper', args: [#voidPtr], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'TextToLower', args: [#voidPtr], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'TextToPascal', args: [#voidPtr], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'TextToInteger', args: [#voidPtr], ret: #int })
  decls.append(os.CFunc{ sym: 'DrawLine3D', args: [Vector3, Vector3, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawPoint3D', args: [Vector3, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawCircle3D', args: [Vector3, #float, Vector3, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawTriangle3D', args: [Vector3, Vector3, Vector3, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawTriangleStrip3D', args: [#voidPtr, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawCube', args: [Vector3, #float, #float, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawCubeV', args: [Vector3, Vector3, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawCubeWires', args: [Vector3, #float, #float, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawCubeWiresV', args: [Vector3, Vector3, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawSphere', args: [Vector3, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawSphereEx', args: [Vector3, #float, #int, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawSphereWires', args: [Vector3, #float, #int, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawCylinder', args: [Vector3, #float, #float, #float, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawCylinderEx', args: [Vector3, Vector3, #float, #float, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawCylinderWires', args: [Vector3, #float, #float, #float, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawCylinderWiresEx', args: [Vector3, Vector3, #float, #float, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawCapsule', args: [Vector3, Vector3, #float, #int, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawCapsuleWires', args: [Vector3, Vector3, #float, #int, #int, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawPlane', args: [Vector3, Vector2, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawRay', args: [Ray, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawGrid', args: [#int, #float], ret: #void })
  decls.append(os.CFunc{ sym: 'LoadModel', args: [#voidPtr], ret: Model })
  decls.append(os.CFunc{ sym: 'LoadModelFromMesh', args: [Mesh], ret: Model })
  decls.append(os.CFunc{ sym: 'IsModelReady', args: [Model], ret: #bool })
  decls.append(os.CFunc{ sym: 'UnloadModel', args: [Model], ret: #void })
  decls.append(os.CFunc{ sym: 'GetModelBoundingBox', args: [Model], ret: BoundingBox })
  decls.append(os.CFunc{ sym: 'DrawModel', args: [Model, Vector3, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawModelEx', args: [Model, Vector3, Vector3, #float, Vector3, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawModelWires', args: [Model, Vector3, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawModelWiresEx', args: [Model, Vector3, Vector3, #float, Vector3, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawBoundingBox', args: [BoundingBox, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawBillboard', args: [Camera3D, Texture, Vector3, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawBillboardRec', args: [Camera3D, Texture, Rectangle, Vector3, Vector2, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawBillboardPro', args: [Camera3D, Texture, Rectangle, Vector3, Vector3, Vector2, Vector2, #float, Color], ret: #void })
  decls.append(os.CFunc{ sym: 'UploadMesh', args: [#voidPtr, #bool], ret: #void })
  decls.append(os.CFunc{ sym: 'UpdateMeshBuffer', args: [Mesh, #int, #voidPtr, #int, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'UnloadMesh', args: [Mesh], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawMesh', args: [Mesh, Material, Matrix], ret: #void })
  decls.append(os.CFunc{ sym: 'DrawMeshInstanced', args: [Mesh, Material, #voidPtr, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'ExportMesh', args: [Mesh, #voidPtr], ret: #bool })
  decls.append(os.CFunc{ sym: 'GetMeshBoundingBox', args: [Mesh], ret: BoundingBox })
  decls.append(os.CFunc{ sym: 'GenMeshTangents', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'GenMeshPoly', args: [#int, #float], ret: Mesh })
  decls.append(os.CFunc{ sym: 'GenMeshPlane', args: [#float, #float, #int, #int], ret: Mesh })
  decls.append(os.CFunc{ sym: 'GenMeshCube', args: [#float, #float, #float], ret: Mesh })
  decls.append(os.CFunc{ sym: 'GenMeshSphere', args: [#float, #int, #int], ret: Mesh })
  decls.append(os.CFunc{ sym: 'GenMeshHemiSphere', args: [#float, #int, #int], ret: Mesh })
  decls.append(os.CFunc{ sym: 'GenMeshCylinder', args: [#float, #float, #int], ret: Mesh })
  decls.append(os.CFunc{ sym: 'GenMeshCone', args: [#float, #float, #int], ret: Mesh })
  decls.append(os.CFunc{ sym: 'GenMeshTorus', args: [#float, #float, #int, #int], ret: Mesh })
  decls.append(os.CFunc{ sym: 'GenMeshKnot', args: [#float, #float, #int, #int], ret: Mesh })
  decls.append(os.CFunc{ sym: 'GenMeshHeightmap', args: [Image, Vector3], ret: Mesh })
  decls.append(os.CFunc{ sym: 'GenMeshCubicmap', args: [Image, Vector3], ret: Mesh })
  decls.append(os.CFunc{ sym: 'LoadMaterials', args: [#voidPtr, #voidPtr], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'LoadMaterialDefault', args: [], ret: Material })
  decls.append(os.CFunc{ sym: 'IsMaterialReady', args: [Material], ret: #bool })
  decls.append(os.CFunc{ sym: 'UnloadMaterial', args: [Material], ret: #void })
  decls.append(os.CFunc{ sym: 'SetMaterialTexture', args: [#voidPtr, #int, Texture], ret: #void })
  decls.append(os.CFunc{ sym: 'SetModelMeshMaterial', args: [#voidPtr, #int, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'LoadModelAnimations', args: [#voidPtr, #voidPtr], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'UpdateModelAnimation', args: [Model, ModelAnimation, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'UnloadModelAnimation', args: [ModelAnimation], ret: #void })
  decls.append(os.CFunc{ sym: 'UnloadModelAnimations', args: [#voidPtr, #uint], ret: #void })
  decls.append(os.CFunc{ sym: 'IsModelAnimationValid', args: [Model, ModelAnimation], ret: #bool })
  decls.append(os.CFunc{ sym: 'CheckCollisionSpheres', args: [Vector3, #float, Vector3, #float], ret: #bool })
  decls.append(os.CFunc{ sym: 'CheckCollisionBoxes', args: [BoundingBox, BoundingBox], ret: #bool })
  decls.append(os.CFunc{ sym: 'CheckCollisionBoxSphere', args: [BoundingBox, Vector3, #float], ret: #bool })
  decls.append(os.CFunc{ sym: 'GetRayCollisionSphere', args: [Ray, Vector3, #float], ret: RayCollision })
  decls.append(os.CFunc{ sym: 'GetRayCollisionBox', args: [Ray, BoundingBox], ret: RayCollision })
  decls.append(os.CFunc{ sym: 'GetRayCollisionMesh', args: [Ray, Mesh, Matrix], ret: RayCollision })
  decls.append(os.CFunc{ sym: 'GetRayCollisionTriangle', args: [Ray, Vector3, Vector3, Vector3], ret: RayCollision })
  decls.append(os.CFunc{ sym: 'GetRayCollisionQuad', args: [Ray, Vector3, Vector3, Vector3, Vector3], ret: RayCollision })
  decls.append(os.CFunc{ sym: 'InitAudioDevice', args: [], ret: #void })
  decls.append(os.CFunc{ sym: 'CloseAudioDevice', args: [], ret: #void })
  decls.append(os.CFunc{ sym: 'IsAudioDeviceReady', args: [], ret: #bool })
  decls.append(os.CFunc{ sym: 'SetMasterVolume', args: [#float], ret: #void })
  decls.append(os.CFunc{ sym: 'LoadWave', args: [#voidPtr], ret: Wave })
  decls.append(os.CFunc{ sym: 'LoadWaveFromMemory', args: [#voidPtr, #voidPtr, #int], ret: Wave })
  decls.append(os.CFunc{ sym: 'IsWaveReady', args: [Wave], ret: #bool })
  decls.append(os.CFunc{ sym: 'LoadSound', args: [#voidPtr], ret: Sound })
  decls.append(os.CFunc{ sym: 'LoadSoundFromWave', args: [Wave], ret: Sound })
  decls.append(os.CFunc{ sym: 'IsSoundReady', args: [Sound], ret: #bool })
  decls.append(os.CFunc{ sym: 'UpdateSound', args: [Sound, #voidPtr, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'UnloadWave', args: [Wave], ret: #void })
  decls.append(os.CFunc{ sym: 'UnloadSound', args: [Sound], ret: #void })
  decls.append(os.CFunc{ sym: 'ExportWave', args: [Wave, #voidPtr], ret: #bool })
  decls.append(os.CFunc{ sym: 'ExportWaveAsCode', args: [Wave, #voidPtr], ret: #bool })
  decls.append(os.CFunc{ sym: 'PlaySound', args: [Sound], ret: #void })
  decls.append(os.CFunc{ sym: 'StopSound', args: [Sound], ret: #void })
  decls.append(os.CFunc{ sym: 'PauseSound', args: [Sound], ret: #void })
  decls.append(os.CFunc{ sym: 'ResumeSound', args: [Sound], ret: #void })
  decls.append(os.CFunc{ sym: 'IsSoundPlaying', args: [Sound], ret: #bool })
  decls.append(os.CFunc{ sym: 'SetSoundVolume', args: [Sound, #float], ret: #void })
  decls.append(os.CFunc{ sym: 'SetSoundPitch', args: [Sound, #float], ret: #void })
  decls.append(os.CFunc{ sym: 'SetSoundPan', args: [Sound, #float], ret: #void })
  decls.append(os.CFunc{ sym: 'WaveCopy', args: [Wave], ret: Wave })
  decls.append(os.CFunc{ sym: 'WaveCrop', args: [#voidPtr, #int, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'WaveFormat', args: [#voidPtr, #int, #int, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'LoadWaveSamples', args: [Wave], ret: #voidPtr })
  decls.append(os.CFunc{ sym: 'UnloadWaveSamples', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'LoadMusicStream', args: [#voidPtr], ret: Music })
  decls.append(os.CFunc{ sym: 'LoadMusicStreamFromMemory', args: [#voidPtr, #voidPtr, #int], ret: Music })
  decls.append(os.CFunc{ sym: 'IsMusicReady', args: [Music], ret: #bool })
  decls.append(os.CFunc{ sym: 'UnloadMusicStream', args: [Music], ret: #void })
  decls.append(os.CFunc{ sym: 'PlayMusicStream', args: [Music], ret: #void })
  decls.append(os.CFunc{ sym: 'IsMusicStreamPlaying', args: [Music], ret: #bool })
  decls.append(os.CFunc{ sym: 'UpdateMusicStream', args: [Music], ret: #void })
  decls.append(os.CFunc{ sym: 'StopMusicStream', args: [Music], ret: #void })
  decls.append(os.CFunc{ sym: 'PauseMusicStream', args: [Music], ret: #void })
  decls.append(os.CFunc{ sym: 'ResumeMusicStream', args: [Music], ret: #void })
  decls.append(os.CFunc{ sym: 'SeekMusicStream', args: [Music, #float], ret: #void })
  decls.append(os.CFunc{ sym: 'SetMusicVolume', args: [Music, #float], ret: #void })
  decls.append(os.CFunc{ sym: 'SetMusicPitch', args: [Music, #float], ret: #void })
  decls.append(os.CFunc{ sym: 'SetMusicPan', args: [Music, #float], ret: #void })
  decls.append(os.CFunc{ sym: 'GetMusicTimeLength', args: [Music], ret: #float })
  decls.append(os.CFunc{ sym: 'GetMusicTimePlayed', args: [Music], ret: #float })
  decls.append(os.CFunc{ sym: 'LoadAudioStream', args: [#uint, #uint, #uint], ret: AudioStream })
  decls.append(os.CFunc{ sym: 'IsAudioStreamReady', args: [AudioStream], ret: #bool })
  decls.append(os.CFunc{ sym: 'UnloadAudioStream', args: [AudioStream], ret: #void })
  decls.append(os.CFunc{ sym: 'UpdateAudioStream', args: [AudioStream, #voidPtr, #int], ret: #void })
  decls.append(os.CFunc{ sym: 'IsAudioStreamProcessed', args: [AudioStream], ret: #bool })
  decls.append(os.CFunc{ sym: 'PlayAudioStream', args: [AudioStream], ret: #void })
  decls.append(os.CFunc{ sym: 'PauseAudioStream', args: [AudioStream], ret: #void })
  decls.append(os.CFunc{ sym: 'ResumeAudioStream', args: [AudioStream], ret: #void })
  decls.append(os.CFunc{ sym: 'IsAudioStreamPlaying', args: [AudioStream], ret: #bool })
  decls.append(os.CFunc{ sym: 'StopAudioStream', args: [AudioStream], ret: #void })
  decls.append(os.CFunc{ sym: 'SetAudioStreamVolume', args: [AudioStream, #float], ret: #void })
  decls.append(os.CFunc{ sym: 'SetAudioStreamPitch', args: [AudioStream, #float], ret: #void })
  decls.append(os.CFunc{ sym: 'SetAudioStreamPan', args: [AudioStream, #float], ret: #void })
  decls.append(os.CFunc{ sym: 'SetAudioStreamBufferSizeDefault', args: [#int], ret: #void })
  decls.append(os.CFunc{ sym: 'SetAudioStreamCallback', args: [AudioStream, #voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'AttachAudioStreamProcessor', args: [AudioStream, #voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'DetachAudioStreamProcessor', args: [AudioStream, #voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'AttachAudioMixedProcessor', args: [#voidPtr], ret: #void })
  decls.append(os.CFunc{ sym: 'DetachAudioMixedProcessor', args: [#voidPtr], ret: #void })
  decls.append(os.CStruct{ fields: [#float, #float], type: Vector2 })
  decls.append(os.CStruct{ fields: [#float, #float, #float], type: Vector3 })
  decls.append(os.CStruct{ fields: [#float, #float, #float, #float], type: Vector4 })
  decls.append(os.CStruct{ fields: [#float, #float, #float, #float, #float, #float, #float, #float, #float, #float, #float, #float, #float, #float, #float, #float], type: Matrix })
  decls.append(os.CStruct{ fields: [#uchar, #uchar, #uchar, #uchar], type: Color })
  decls.append(os.CStruct{ fields: [#float, #float, #float, #float], type: Rectangle })
  decls.append(os.CStruct{ fields: [#voidPtr, #int, #int, #int, #int], type: Image })
  decls.append(os.CStruct{ fields: [#uint, #int, #int, #int, #int], type: Texture })
  decls.append(os.CStruct{ fields: [#uint, Texture, Texture], type: RenderTexture })
  decls.append(os.CStruct{ fields: [Rectangle, #int, #int, #int, #int, #int], type: NPatchInfo })
  decls.append(os.CStruct{ fields: [#int, #int, #int, #int, Image], type: GlyphInfo })
  decls.append(os.CStruct{ fields: [#int, #int, #int, Texture, #voidPtr, #voidPtr], type: Font })
  decls.append(os.CStruct{ fields: [Vector3, Vector3, Vector3, #float, #int], type: Camera3D })
  decls.append(os.CStruct{ fields: [Vector2, Vector2, #float, #float], type: Camera2D })
  decls.append(os.CStruct{ fields: [#int, #int, #voidPtr, #voidPtr, #voidPtr, #voidPtr, #voidPtr, #voidPtr, #voidPtr, #voidPtr, #voidPtr, #voidPtr, #voidPtr, #uint, #voidPtr], type: Mesh })
  decls.append(os.CStruct{ fields: [#uint, #voidPtr], type: Shader })
  decls.append(os.CStruct{ fields: [Texture, Color, #float], type: MaterialMap })
  decls.append(os.CStruct{ fields: [Shader, #voidPtr, os.CArray{ n: 4, elem: #float}], type: Material })
  decls.append(os.CStruct{ fields: [Vector3, Vector4, Vector3], type: Transform })
  decls.append(os.CStruct{ fields: [os.CArray{ n: 32, elem: #uchar}, #int], type: BoneInfo })
  decls.append(os.CStruct{ fields: [Matrix, #int, #int, #voidPtr, #voidPtr, #voidPtr, #int, #voidPtr, #voidPtr], type: Model })
  decls.append(os.CStruct{ fields: [#int, #int, #voidPtr, #voidPtr], type: ModelAnimation })
  decls.append(os.CStruct{ fields: [Vector3, Vector3], type: Ray })
  decls.append(os.CStruct{ fields: [#bool, #float, Vector3, Vector3], type: RayCollision })
  decls.append(os.CStruct{ fields: [Vector3, Vector3], type: BoundingBox })
  decls.append(os.CStruct{ fields: [#uint, #uint, #uint, #uint, #voidPtr], type: Wave })
  decls.append(os.CStruct{ fields: [#voidPtr, #voidPtr, #uint, #uint, #uint], type: AudioStream })
  decls.append(os.CStruct{ fields: [AudioStream, #uint], type: Sound })
  decls.append(os.CStruct{ fields: [AudioStream, #uint, #bool, #int, #voidPtr], type: Music })
  decls.append(os.CStruct{ fields: [#int, #int, #float, #float, #float, #float, #float, #float, os.CArray{ n: 4, elem: #float}, os.CArray{ n: 4, elem: #float}], type: VrDeviceInfo })
  decls.append(os.CStruct{ fields: [os.CArray{ n: 2, elem: Matrix}, os.CArray{ n: 2, elem: Matrix}, os.CArray{ n: 2, elem: #float}, os.CArray{ n: 2, elem: #float}, os.CArray{ n: 2, elem: #float}, os.CArray{ n: 2, elem: #float}, os.CArray{ n: 2, elem: #float}, os.CArray{ n: 2, elem: #float}], type: VrStereoConfig })
  decls.append(os.CStruct{ fields: [#uint, #uint, #voidPtr], type: FilePathList })
  return os.bindLib(libPath, decls, { genMap: true })
