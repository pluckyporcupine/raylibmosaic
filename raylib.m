!basic defines
global const DEG2RAD=pi/180.0
global const RAD2DEG=180.0/pi
global const MAX_TOUCH_POINTS=10

!basic structures
global record Vector2=
    r32 x
    r32 y
end

global record Vector3=
    r32 x
    r32 y
    r32 z
end

global record Vector4=
    r32 x
    r32 y
    r32 z
    r32 w
end

global type Quaternion=Vector4

global record Matrix=
    r32 m0, m4, m8, m12
    r32 m1, m5, m9, m13
    r32 m2, m6, m10, m14
    r32 m3, m7, m11, m15
end

global record Color=
    byte r
    byte g
    byte b
    byte a
end

global record Rectangle=
    r32 x
    r32 y
    r32 width
    r32 height
end

global record Image=
    ref[]void data
    int32 width
    int32 height
    int32 mipmaps
    int32 format
end

global record Texture2D=
    u32 id
    int32 width
    int32 height
    int32 mipmaps
    int32 format
end

global type Texture=Texture2D

global type TextureCubemap=Texture2D

global record RenderTexture2D=
    u32 id
    Texture2D txtr
    Texture2D depth
    byte depthTexture
end

global type RenderTexture=RenderTexture2D

global record NPatchInfo=
    Rectangle sourceRec
    int32 left
    int32 top
    int32 right
    int32 bottom
    int32 `type
end

global record CharInfo=
    int32 value
    int32 offsetX
    int32 offsetY
    int32 advanceX
    image image
end

global record Font=
    int32 baseSize
    int32 charsCount
    Texture2D txtr
    ref[]Rectangle recs
    ref[]CharInfo chars
end

global type SpriteFont=Font

global record Camera3D=
    Vector3 position
    Vector3 target
    Vector3 up
    r32 fovy
    int32 `type
end

global type Camera=Camera3D

global record Camera2D=
    Vector2 offset
    vector2 target
    r32 rotation
    r32 zoom
end

global record Mesh=
    int32 vertexCount
    int32 triangleCount
    ref[]r32 vertices
    ref[]r32 texcoords
    ref[]r32 texcoords2
    ref[]r32 normals
    ref[]r32 tangents
    ref[]char colors
    ref[]i16 indices
    ref[]r32 animVertices
    ref[]r32 animNormals
    ref[]int32 boneIds
    ref[]r32 boneWeights
    int32 vaoId
    ref int32 vboId
end

global record Shader=
    word32 id
    ref[]int32 locs
end

global record MaterialMap=
    Texture2D texture
    color color
    real32 value
end

global record Material=
    shader shader
    ref[]MaterialMap maps
    ref[]r32 params
end

global record Transform=
    Vector3 translation
    Quaternion rotation
    Vector3 scale
end

global record BoneInfo=
    [32]byte name
    int32 parent
end

global record Model=
    Matrix transform
    int32 meshCount
    ref[]Mesh meshes
    int32 materialCount
    ref[]Material materials
    ref int32 meshMaterial
    int32 boneCount
    ref[]BoneInfo bones
    ref Transform bindPose
end

global type rTransform=ref Transform

global record ModelAnimation=
    int32 boneCount
    ref BoneInfo bones
    int32 frameCount
    ref[]rTransform framePoses
end

global record Ray=
    Vector3 position
    Vector3 direction
end

global record RayHitInfo=
    u8 hit
    r32 distance
    Vector3 position
    Vector3 normal
end

global record BoundingBox=
    Vector3 `min
    Vector3 `max
end

global record Wave=
    word32 sampleCount
    word32 sampleRate
    word32 sampleSize
    word32 channels
    ref void data
end

global record rAudioBuffer=
    int dummy
end

global record AudioStream=
    word32 sampleRate
    word32 sampleSize
    word32 channels
    ref rAudioBuffer buffer
end

global record Sound=
    word32 sampleCount
    AudioStream stream
end

global record Music=
    int32 ctxType
    ref void ctxData
    word32 sampleCount
    word32 loopCount
    AudioStream stream
end

global record VrDeviceInfo=
    int32 hResolution
    int32 vResolution
    r32 hScreenSize
    r32 vScreenSize
    r32 vScreenCenter
    r32 eyeToScreenDistance
    r32 lensSeparationDistance
    r32 interpupillaryDistance
    [4]r32 lensDistortionValues
    [4]r32 chromAbCorrection
end

!enums definition

global enum (
    FLAG_SHOW_LOGO          = 1,
    FLAG_FULLSCREEN_MODE    = 2,
    FLAG_WINDOW_RESIZABLE   = 4,
    FLAG_WINDOW_UNDECORATED = 8,
    FLAG_WINDOW_TRANSPARENT = 16,
    FLAG_WINDOW_HIDDEN      = 128,
    FLAG_MSAA_4X_HINT       = 32,
    FLAG_VSYNC_HINT         = 64 )

global enum (
    LOG_ALL                 = 0,
    LOG_TRACE,
    LOG_DEBUG,
    LOG_INFO,
    LOG_WARNING,
    LOG_ERROR,
    LOG_FATAL,
    LOG_NONE )

global enum (
    KEY_APOSTROPHE          = 39,
    KEY_COMMA               = 44,
    KEY_MINUS               = 45,
    KEY_PERIOD              = 46,
    KEY_SLASH               = 47,
    KEY_ZERO                = 48,
    KEY_ONE                 = 49,
    KEY_TWO                 = 50,
    KEY_THREE               = 51,
    KEY_FOUR                = 52,
    KEY_FIVE                = 53,
    KEY_SIX                 = 54,
    KEY_SEVEN               = 55,
    KEY_EIGHT               = 56,
    KEY_NINE                = 57,
    KEY_SEMICOLON           = 59,
    KEY_EQUAL               = 61,
    KEY_A                   = 65,
    KEY_B                   = 66,
    KEY_C                   = 67,
    KEY_D                   = 68,
    KEY_E                   = 69,
    KEY_F                   = 70,
    KEY_G                   = 71,
    KEY_H                   = 72,
    KEY_I                   = 73,
    KEY_J                   = 74,
    KEY_K                   = 75,
    KEY_L                   = 76,
    KEY_M                   = 77,
    KEY_N                   = 78,
    KEY_O                   = 79,
    KEY_P                   = 80,
    KEY_Q                   = 81,
    KEY_R                   = 82,
    KEY_S                   = 83,
    KEY_T                   = 84,
    KEY_U                   = 85,
    KEY_V                   = 86,
    KEY_W                   = 87,
    KEY_X                   = 88,
    KEY_Y                   = 89,
    KEY_Z                   = 90,

    KEY_SPACE               = 32,
    KEY_ESCAPE              = 256,
    KEY_ENTER               = 257,
    KEY_TAB                 = 258,
    KEY_BACKSPACE           = 259,
    KEY_INSERT              = 260,
    KEY_DELETE              = 261,
    KEY_RIGHT               = 262,
    KEY_LEFT                = 263,
    KEY_DOWN                = 264,
    KEY_UP                  = 265,
    KEY_PAGE_UP             = 266,
    KEY_PAGE_DOWN           = 267,
    KEY_HOME                = 268,
    KEY_END                 = 269,
    KEY_CAPS_LOCK           = 280,
    KEY_SCROLL_LOCK         = 281,
    KEY_NUM_LOCK            = 282,
    KEY_PRINT_SCREEN        = 283,
    KEY_PAUSE               = 284,
    KEY_F1                  = 290,
    KEY_F2                  = 291,
    KEY_F3                  = 292,
    KEY_F4                  = 293,
    KEY_F5                  = 294,
    KEY_F6                  = 295,
    KEY_F7                  = 296,
    KEY_F8                  = 297,
    KEY_F9                  = 298,
    KEY_F10                 = 299,
    KEY_F11                 = 300,
    KEY_F12                 = 301,
    KEY_LEFT_SHIFT          = 340,
    KEY_LEFT_CONTROL        = 341,
    KEY_LEFT_ALT            = 342,
    KEY_LEFT_SUPER          = 343,
    KEY_RIGHT_SHIFT         = 344,
    KEY_RIGHT_CONTROL       = 345,
    KEY_RIGHT_ALT           = 346,
    KEY_RIGHT_SUPER         = 347,
    KEY_KB_MENU             = 348,
    KEY_LEFT_BRACKET        = 91,
    KEY_BACKSLASH           = 92,
    KEY_RIGHT_BRACKET       = 93,
    KEY_GRAVE               = 96,

    KEY_KP_0                = 320,
    KEY_KP_1                = 321,
    KEY_KP_2                = 322,
    KEY_KP_3                = 323,
    KEY_KP_4                = 324,
    KEY_KP_5                = 325,
    KEY_KP_6                = 326,
    KEY_KP_7                = 327,
    KEY_KP_8                = 328,
    KEY_KP_9                = 329,
    KEY_KP_DECIMAL          = 330,
    KEY_KP_DIVIDE           = 331,
    KEY_KP_MULTIPLY         = 332,
    KEY_KP_SUBTRACT         = 333,
    KEY_KP_ADD              = 334,
    KEY_KP_ENTER            = 335,
    KEY_KP_EQUAL            = 336 )

global enum (
    KEY_BACK                = 4,
    KEY_MENU                = 82,
    KEY_VOLUME_UP           = 24,
    KEY_VOLUME_DOWN         = 25 )

global enum (
    MOUSE_LEFT_BUTTON       = 0,
    MOUSE_RIGHT_BUTTON      = 1,
    MOUSE_MIDDLE_BUTTON     = 2 )

global enum (
    GAMEPAD_BUTTON_UNKNOWN  = 0,

    GAMEPAD_BUTTON_LEFT_FACE_UP,
    GAMEPAD_BUTTON_LEFT_FACE_RIGHT,
    GAMEPAD_BUTTON_LEFT_FACE_DOWN,
    GAMEPAD_BUTTON_LEFT_FACE_LEFT,

    GAMEPAD_BUTTON_RIGHT_FACE_UP,
    GAMEPAD_BUTTON_RIGHT_FACE_RIGHT,
    GAMEPAD_BUTTON_RIGHT_FACE_DOWN,
    GAMEPAD_BUTTON_RIGHT_FACE_LEFT,
    
    GAMEPAD_BUTTON_LEFT_TRIGGER_1,
    GAMEPAD_BUTTON_LEFT_TRIGGER_2,
    GAMEPAD_BUTTON_RIGHT_TRIGGER_1,
    GAMEPAD_BUTTON_RIGHT_TRIGGER_2,

    GAMEPAD_BUTTON_MIDDLE_LEFT,
    GAMEPAD_BUTTON_MIDDLE,
    GAMEPAD_BUTTON_MIDDLE_RIGHT,

    GAMEPAD_BUTTON_LEFT_THUMB,
    GAMEPAD_BUTTON_RIGHT_THUMB )

global enum (
    GAMEPAD_AXIS_UNKNOWN    = 0,
    
    GAMEPAD_AXIS_LEFT_X,
    GAMEPAD_AXIS_LEFT_Y,

    GAMEPAD_AXIS_RIGHT_X,
    GAMEPAD_AXIS_RIGHT_Y,

    GAMEPAD_AXIS_LEFT_TRIGGER,
    GAMEPAD_AXIS_RIGHT_TRIGGER )

global enum (
    LOC_VERTEX_POSITION     = 0,
    LOC_VERTEX_TEXCOORD01,
    LOC_VERTEX_TEXCOORD02,
    LOC_VERTEX_NORMAL,
    LOC_VERTEX_TANGENT,
    LOC_VERTEX_COLOR,
    LOC_MATRIX_MVP,
    LOC_MATRIX_MODEL,
    LOC_MATRIX_VIEW,
    LOC_MATRIX_PROJECTION,
    LOC_VECTOR_VIEW,
    LOC_COLOR_DIFFUSE,
    LOC_COLOR_SPECULAR,
    LOC_COLOR_AMBIENT,
    LOC_MAP_ALBEDO,
    LOC_MAP_METALNESS,
    LOC_MAP_NORMAL,
    LOC_MAP_ROUGHNESS,
    LOC_MAP_OCCLUSION,
    LOC_MAP_EMISSION,
    LOC_MAP_HEIGHT,
    LOC_MAP_CUBEMAP,
    LOC_MAP_IRRADIANCE,
    LOC_MAP_PREFILTER,
    LOC_MAP_BRDF )

global type LOC_MAP_DIFFUSE=LOC_MAP_ALBEDO
global type LOC_MAP_SPECULAR=LOC_MAP_METALNESS

global enum (
    UNIFORM_FLOAT            = 0,
    UNIFORM_VEC2,
    UNIFORM_VEC3,
    UNIFORM_VEC4,
    UNIFORM_INT,
    UNIFORM_IVEC2,
    UNIFORM_IVEC3,
    UNIFORM_IVEC4,
    UNIFORM_SAMPLER2D )

global enum (
    MAP_ALBEDO              = 0,
    MAP_METALNESS           = 1,
    MAP_NORMAL              = 2,
    MAP_ROUGHNESS           = 3,
    MAP_OCCLUSION,
    MAP_EMISSION,
    MAP_HEIGHT,
    MAP_CUBEMAP,
    MAP_IRRADIANCE,
    MAP_PREFILTER,
    MAP_BRDF )

global type MAP_DIFFUSE=MAP_ALBEDO
global type MAP_SPECULAR=MAP_METALNESS

global enum (
    UNCOMPRESSED_GRAYSCALE  = 1,    ! 8 bit per pixel (no alpha)
    UNCOMPRESSED_GRAY_ALPHA,        ! 8*2 bpp (2 channels)
    UNCOMPRESSED_R5G6B5,            ! 16 bpp
    UNCOMPRESSED_R8G8B8,            ! 24 bpp
    UNCOMPRESSED_R5G5B5A1,          ! 16 bpp (1 bit alpha)
    UNCOMPRESSED_R4G4B4A4,          ! 16 bpp (4 bit alpha)
    UNCOMPRESSED_R8G8B8A8,          ! 32 bpp
    UNCOMPRESSED_R32,               ! 32 bpp (1 channel - float)
    UNCOMPRESSED_R32G32B32,         ! 32*3 bpp (3 channels - float)
    UNCOMPRESSED_R32G32B32A32,      ! 32*4 bpp (4 channels - float)
    COMPRESSED_DXT1_RGB,            ! 4 bpp (no alpha)
    COMPRESSED_DXT1_RGBA,           ! 4 bpp (1 bit alpha)
    COMPRESSED_DXT3_RGBA,           ! 8 bpp
    COMPRESSED_DXT5_RGBA,           ! 8 bpp
    COMPRESSED_ETC1_RGB,            ! 4 bpp
    COMPRESSED_ETC2_RGB,            ! 4 bpp
    COMPRESSED_ETC2_EAC_RGBA,       ! 8 bpp
    COMPRESSED_PVRT_RGB,            ! 4 bpp
    COMPRESSED_PVRT_RGBA,           ! 4 bpp
    COMPRESSED_ASTC_4x4_RGBA,       ! 8 bpp
    COMPRESSED_ASTC_8x8_RGBA )      ! 2 bpp

global enum (
    FILTER_POINT            = 0,
    FILTER_BILINEAR,
    FILTER_TRILINEAR,
    FILTER_ANISOTROPIC_4X,
    FILTER_ANISOTROPIC_8X,
    FILTER_ANISOTROPIC_16X )

global enum (
    CUBEMAP_AUTO_DETECT     = 0,
    CUBEMAP_LINE_VERTICAL,
    CUBEMAP_LINE_HORIZONTAL,
    CUBEMAP_CROSS_THREE_BY_FOUR,
    CUBEMAP_CROSS_FOUR_BY_THREE,
    CUBEMAP_PANORAMA )

global enum (
    WRAP_REPEAT             = 0,
    WRAP_CLAMP,
    WRAP_MIRROR_REPEAT,
    WRAP_MIRROR_CLAMP )

global enum (
    FONT_DEFAULT            = 0,
    FONT_BITMAP,
    FONT_SDF )

global enum (
    BLEND_ALPHA             = 0,
    BLEND_ADDITIVE,
    BLEND_MULTIPLIED )

global enum (
    GESTURE_NONE            = 0,
    GESTURE_TAP             = 1,
    GESTURE_DOUBLETAP       = 2,
    GESTURE_HOLD            = 4,
    GESTURE_DRAG            = 8,
    GESTURE_SWIPE_RIGHT     = 16,
    GESTURE_SWIPE_LEFT      = 32,
    GESTURE_SWIPE_UP        = 64,
    GESTURE_SWIPE_DOWN      = 128,
    GESTURE_PINCH_IN        = 256,
    GESTURE_PINCH_OUT       = 512 )

global enum (
    CAMERA_CUSTOM           = 0,
    CAMERA_FREE,
    CAMERA_ORBITAL,
    CAMERA_FIRST_PERSON,
    CAMERA_THRID_PERSON )

global enum (
    CAMERA_PERSPECTIVE      = 0,
    CAMERA_ORTHOGRAPHIC )

global enum (
    NPT_9PATCH              = 0,
    NPT_3PATCH_VERTICAL,
    NPT_3PATCH_HORIZONTAL )

!need to figure out how to implement TraceLogCallback
global record TraceLogCallback=
    int dummy
end

!basic colors
global Color LIGHTGRAY=(200,200,200,255)
global Color GRAY=(130,130,130,255)
global Color DARKGRAY=(80,80,80,255)
global Color YELLOW=(253,249,0,255)
global Color GOLD=(255,203,0,255)
global Color ORANGE=(255,161,0,255)
global Color PINK=(255,109,194,255)
global Color RED=(230,41,55,255)
global Color MAROON=(190,33,55,255)
global Color GREEN=(0,228,48,255)
global Color LIME=(0,158,47,255)
global Color DARKGREEN=(0,117,44,255)
global Color SKYBLUE=(102,191,255,255)
global Color BLUE=(0,121,241,255)
global Color DARKBLUE=(0,82,172,255)
global Color PURPLE=(200,122,255,255)
global Color VIOLET=(135,60,192,255)
global Color DARKPURPLE=(112,31,126,255)
global Color BEIGE=(211,176,131,255)
global Color BROWN=(127,106,79,255)
global Color DARKBROWN=(76,63,47,255)

global Color WHITE=(255,255,255,255)
global Color BLACK=(0,0,0,255)
global Color BLANK=(0,0,0,0)
global Color MAGENTA=(255,0,255,255)
global Color RAYWHITE=(245,245,245,255)

!compatibility
global function $c2w32(Color &c)Col=
     cast(&c,ref Col)^
end

global function $v22w32(Vector2 &v2)Vec2=
     cast(&v2,ref Vec2)^
end

global function newcol(Col c)ref Color=
    return cast(&c)
end

global function newvec2(Vec2 v2)ref Vector2=
    return cast(&v2)
end

global type Col=word32
global type Vec2=word32

importdll libraylib=
    !core module
    clang proc      "InitWindow"                (int32, int32, ref char)
    clang function  "WindowShouldClose"         ()byte
    clang proc      "CloseWindow"               ()
    clang function  "IsWindowReady"             ()byte
    clang function  "IsWindowMinimized"         ()byte
    clang function  "IsWindowResized"           ()byte
    clang function  "IsWindowHidden"            ()byte
    clang proc      "ToggleFullscreen"          ()
    clang proc      "UnhideWindow"              ()
    clang proc      "HideWindow"                ()
    clang proc      "SetWindowIcon"             (ref Image)
    clang proc      "SetWindowTitle"            (ref char)
    clang proc      "SetWindowPosition"         (int32, int32)
    clang proc      "SetWindowMonitor"          (int32)
    clang proc      "SetWindowMinSize"          (int32, int32)
    clang proc      "SetWindowSize"             (int32, int32)
    clang function  "GetWindowHandle"           ()ref void
    clang function  "GetScreenWidth"            ()int32
    clang function  "GetScreenHeight"           ()int32
    clang function  "GetMonitorCount"           ()int32
    clang function  "GetMonitorWidth"           (int32)int32
    clang function  "GetMonitorHeight"          (int32)int32
    clang function  "GetMonitorPhysicalWidth"   (int32)int32
    clang function  "GetMonitorPhysicalHeight"  (int32)int32
    clang function  "GetWindowPosition"         ()Vec2
    clang function  "GetMonitorName"            (int32)ref char
    clang function  "GetClipboardText"          ()ref char
    clang proc      "SetClipboardText"          (ref char)

    !cursor functions
    clang proc      "ShowCursor"                ()
    clang proc      "HideCursor"                ()
    clang function  "IsCursorHidden"            ()byte
    clang proc      "EnableCursor"              ()
    clang proc      "DisableCursor"             ()

    !drawing functions
    clang proc      "ClearBackground"           (Col)
    clang proc      "BeginDrawing"              ()
    clang proc      "EndDrawing"                ()
    clang proc      "BeginMode2D"               (ref Camera2D)
    clang proc      "EndMode2D"                 ()
    clang proc      "BeginMode3D"               (ref Camera3D)
    clang proc      "EndMode3D"                 ()
    clang proc      "BeginTextureMode"          (ref RenderTexture2D)
    clang proc      "EndTextureMode"            ()
    clang proc      "BeginScissorMode"          (int32, int32, int32, int32)
    clang proc      "EndScissorMode"            ()

    !screen space functions
    clang proc      "GetMouseRay"               (ref Ray, Vec2, ref Camera)
    clang proc      "GetCameraMatrix"           (ref Matrix, ref Camera)
    clang proc      "GetCameraMatrix2D"         (ref Matrix, ref Camera2D)
    clang function  "GetWorldToScreen"          (ref Vector3, ref Camera)Vec2
    clang function  "GetWorldToScreenEx"        (ref Vector3, ref Camera, int32, int32)Vec2
    clang function  "GetWorldToScreen2D"        (Vec2, ref Camera2D)Vec2
    clang function  "GetScreenToWorld2D"        (Vec2, ref Camera2D)Vec2

    !timing functions
    clang proc      "SetTargetFPS"              (int32)
    clang function  "GetFPS"                    ()int32
    clang function  "GetFrameTime"              ()real32
    clang function  "GetTime"                   ()real64

    !color functions
    clang function  "ColorToInt"                (Col)int32
    clang proc      "ColorNormalize"            (ref Vector4, Col)
    clang function  "ColorFromNormalize"        (ref Vector4)Col
    clang proc      "ColorToHSV"                (ref Vector3, Col)
    clang function  "ColorFromHSV"              (ref Vector3)Col
    clang function  "GetColor"                  (int32)Col
    clang function  "Fade"                      (Col, real32)Col

    !misc functions
    clang proc      "SetConfigFlags"            (u32)
    clang proc      "SetTraceLogLevel"          (int32)
    clang proc      "SetTraceLogExit"           (int32)
    clang proc      "SetTraceLogCallback"       (ref TraceLogCallback)
    clang proc      "TakeScreenshot"            (ref char)
    clang function  "GetRandomValue"            (int32, int32)int32

    !file management functions
    clang function  "FileExists"                (ref char)byte
    clang function  "IsFileExtension"           (ref char, ref char)byte
    clang function  "DirectoryExists"           (ref char)byte
    clang function  "GetExtension"              (ref char)ref char
    clang function  "GetFileName"               (ref char)ref char
    clang function  "GetFileNameWithoutExt"     (ref char)ref char
    clang function  "GetDirectoryPath"          (ref char)ref char
    clang function  "GetPrevDirectoryPath"      (ref char)ref char
    clang function  "GetWorkingDirectory"       ()ref char
    clang function  "GetDirectoryFiles"         (ref char, ref char)ref[]ichar
    clang proc      "ClearDirectoryFiles"       ()
    clang function  "ChangeDirectory"           (ref char)byte
    clang function  "IsFileDropped"             ()byte
    clang function  "GetDroppedFiles"           (ref int)ref[]ichar
    clang function  "GetFileModTime"            (ref char)int64

    !data compression functions
    clang function  "CompressData"              (ref char, int32, ref int32)ref char
    clang function  "DecompressData"            (ref char, int32, ref int32)ref char

    !persistent storage management
    clang proc      "StorageSaveValue"          (int32, int32)
    clang function  "StorageLoadValue"          (int32)int32

    clang proc      "OpenURL"                   (ref char)

    !keyboard input functions
    clang function  "IsKeyPressed"              (int32)byte
    clang function  "IsKeyDown"                 (int32)byte
    clang function  "IsKeyReleased"             (int32)byte
    clang function  "IsKeyUp"                   (int32)byte
    clang proc      "SetExitKey"                (int32)
    clang function  "GetKeyPressed"             ()int32

    !gamepad input functions
    clang function  "IsGamepadAvailable"        (int32)byte
    clang function  "IsGamepadName"             (int32, ref char)byte
    clang function  "GetGamepadName"            (int32)ref char
    clang function  "IsGamepadButtonPressed"    (int32, int32)byte
    clang function  "IsGamepadButtonDown"       (int32, int32)byte
    clang function  "IsGamepadButtonReleased"   (int32, int32)byte
    clang function  "IsGamepadButtonUp"         (int32, int32)byte
    clang function  "GetGamepadButtonPressed"   ()int32
    clang function  "GetGamepadAxisCount"       (int32)int32
    clang function  "GetGamepadAxisMovement"    (int32, int32)real32

    !mouse input functions
    clang function  "IsMouseButtonPressed"      (int32)byte
    clang function  "IsMouseButtonDown"         (int32)byte
    clang function  "IsMouseButtonReleased"     (int32)byte
    clang function  "IsMouseButtonUp"           (int32)byte
    clang function  "GetMouseX"                 ()int32
    clang function  "GetMouseY"                 ()int32
    clang function  "GetMousePosition"          ()Vec2
    clang proc      "SetMousePosition"          (int32, int32)
    clang proc      "SetMouseOffset"            (int32, int32)
    clang proc      "SetMouseScale0"            (real32, real32)
    clang function  "GetMouseWheelMove"         ()int32

    !touch input functions
    clang function  "GetTouchX"                 ()int32
    clang function  "GetTouchY"                 ()int32
    clang function  "GetTouchPosition"          (int32)Vec2

    !gesture/touch handling functions
    clang proc      "SetGesturesEnabled"        (u32)
    clang function  "IsGestureDetected"         (int32)byte
    clang function  "GetGestureDetected"        ()int32
    clang function  "GetTouchPointsCount"       ()int32
    clang function  "GetGestureHoldDuration"    ()real32
    clang function  "GetGestureDragVector"      ()Vec2
    clang function  "GetGestureDragAngle"       ()real32
    clang function  "GetGesturePinchVector"     ()Vec2
    clang function  "GetGesturePinchAngle"      ()real32

    !camera functions
    clang proc      "SetCameraMode"             (ref Camera, int32)
    clang proc      "UpdateCamera"              (ref Camera)
    clang proc      "SetCameraPanControl"       (int32)
    clang proc      "SetCameraAltControl"       (int32)
    clang proc      "SetCameraSmoothZoomControl"(int32)
    clang proc      "SetCameraMoveControls"     (int32, int32, int32, int32, int32, int32)

    !basic shapes drawing functions
    clang proc      "DrawPixel"                 (int32, int32, Col)
    clang proc      "DrawlPixelV"               (Vec2, Col)
    clang proc      "DrawLine"                  (int32, int32, int32, int32, Col)
    clang proc      "DrawLineV"                 (Vec2, Vec2, Col)
    clang proc      "DrawLineEx"                (Vec2, Vec2, real32, Col)
    clang proc      "DrawLineBezier"            (Vec2, Vec2, real32, Col)
    clang proc      "DrawLineStrip"             (ref Vec2, int32, Col)              ! unsure if "ref Vec2" will work here. definitely an array. "ref[]Vec2"? - void DrawLineStrip(Vector2 *points, int numPoints, Color color);
    clang proc      "DrawCircle"                (int32, int32, real32, Col)
    clang proc      "DrawCircleSector"          (Vec2, real32, int32, int32, int32, Col)
    clang proc      "DrawCircleSectorLines"     (Vec2, real32, int32, int32, int32, Col)
    clang proc      "DrawCircleGradient"        (int32, int32, real32, Col, Col)
    clang proc      "DrawCircleV"               (Vec2, real32, Col)
    clang proc      "DrawCircleLines"           (int32, int32, float32, Col)
    clang proc      "DrawEllipse"               (int32, int32, real32, real32, Col)
    clang proc      "DrawEllipseLines"          (int32, int32, real32, real32, Col)
    clang proc      "DrawRing"                  (Vec2, real32, real32, int32, int32, int32, Col)
    clang proc      "DrawRingLines"             (Vec2, real32, real32, int32, int32, int32, Col)
    clang proc      "DrawRectangle"             (int32, int32, int32, int32, Col)
    clang proc      "DrawRectangleV"            (Vec2, Vec2, Col)
    clang proc      "DrawRectangleRec"          (ref Rectangle, Col)
    clang proc      "DrawRectanglePro"          (ref Rectangle, Vec2, real32, Col)
    clang proc      "DrawRectangleGradientV"    (int32, int32, int32, int32, Col, Col)
    clang proc      "DrawRectangleGradientH"    (int32, int32, int32, int32, Col, Col)
    clang proc      "DrawRectangleGradientEx"   (ref Rectangle, Col, Col, Col, Col)
    clang proc      "DrawRectangleLines"        (int32, int32, int32, int32, Col)
    clang proc      "DrawRectangleLinesEx"      (ref Rectangle, int32, Col)
    clang proc      "DrawRectangleRounded"      (ref Rectangle, real32, int32, Col)
    clang proc      "DrawRectangleRoundedLines" (ref Rectangle, real32, int32, int32, Col)
    clang proc      "DrawTriangle"              (Vec2, Vec2, Vec2, Col)
    clang proc      "DrawTriangleLines"         (Vec2, Vec2, Vec2, Col)
    clang proc      "DrawTriangleFan"           (ref Vec2, int32, Col)              ! unsure if "ref Vec2" will work here. definitely an array. "ref[]Vec2"?
    clang proc      "DrawTriangleStrip"         (ref Vec2, int32, Col)              ! unsure if "ref Vec2" will work here. definitely an array. "ref[]Vec2"?
    clang proc      "DrawPoly"                  (Vec2, int32, real32, real32, Col)
    clang proc      "DrawPolyLines"             (Vec2, int32, real32, real32, Col)

    clang proc      "SetShapesTexture"          (ref Texture2D, ref Rectangle)

    !basic shapes collision detection functions
    clang function  "CheckCollisionRecs"        (ref Rectangle, ref Rectangle)byte
    clang function  "CheckCollisionCircles"     (Vec2, real32, Vec2, real32)byte
    clang function  "CheckCollisionCircleRec"   (Vec2, real32, ref Rectangle)byte
    clang proc      "GetCollisionRec"           (ref Rectangle, ref Rectangle, ref Rectangle)
    clang function  "CheckCollisionPointRec"    (Vec2, ref Rectangle)byte
    clang function  "CheckCollisionPointCircle" (Vec2, Vec2, real32)byte
    clang function  "CheckCollisionPointTriangle"   (Vec2, Vec2, Vec2, Vec2)byte
    
    !Image/Texture2D data handling functions
    clang proc      "LoadImage"                 (ref Image, ref char)
    clang proc      "LoadImageEx"               (ref Image, ref Col, int32, int32)  ! unsure if "ref Col" will work here. definitely an array. "ref[]Col"?
    clang proc      "LoadImagePro"              (ref Image, ref void, int32, int32, int32)
    clang proc      "LoadImageRaw"              (ref Image, ref char, int32, int32, int32, int32)
    clang proc      "ExportImage"               (ref Image, ref char)
    clang proc      "ExportImageAsCode"         (ref Image, ref char)
    clang proc      "LoadTexture"               (ref Texture2D, ref char)
    clang proc      "LoadTextureFromImage"      (ref Texture2D, ref Image)
    clang proc      "LoadTextureCubemap"        (ref TextureCubemap, ref Image, int32)
    clang proc      "LoadRenderTexture"         (ref RenderTexture2D, int32, int32)
    clang proc      "UnloadImage"               (ref Image)
    clang proc      "UnloadTexture"             (ref Texture2D)
    clang proc      "UnloadRenderTexture"       (ref RenderTexture2D)
    clang function  "GetImageData"              (ref Image)ref Col
    clang proc      "GetImageDataNormalized"    (ref Vector4, ref Image)
    clang proc      "GetImageAlphaBorder"       (ref Rectangle, ref Image, real32)
    clang function  "GetPixelDataSize"          (int32, int32, int32)int32
    clang proc      "GetTextureData"            (ref Image, ref Texture2D)
    clang proc      "GetScreenData"             (ref Image)
    clang proc      "UpdateTexture"             (ref Texture2D, ref void)

    !Image manipulation functions
    clang proc      "ImageCopy"                 (ref Image, ref Image)
    clang proc      "ImageFromImage"            (ref Image, ref Image, ref Rectangle)
    clang proc      "ImagetoPOT"                (ref Image, Col)                    ! unsure whether there will be a semantic difference between the normal "ref Image" calls and the "ref Image" calls that are used for an actual pointer. "ref[]Image"? - RLAPI void ImageToPOT(Image *image, Color fillColor);
    clang proc      "ImageFormat"               (ref Image, int32)
    clang proc      "ImageAlphaMask"            (ref Image, ref Image)
    clang proc      "ImageAlphaClear"           (ref Image, Col, real32)
    clang proc      "ImageAlphaCrop"            (ref Image, real32)
    clang proc      "ImageAlphaPremultiply"     (ref Image)
    clang proc      "ImageCrop"                 (ref Image, ref Rectangle)
    clang proc      "ImageResize"               (ref Image, int32, int32)
    clang proc      "ImageResizeNN"             (ref Image, int32, int32)
    clang proc      "ImageResizeCanvas"         (ref Image, int32, int32, int32, int32, Col)
    clang proc      "ImageMipmaps"              (ref Image)
    clang proc      "ImageDither"               (ref Image, int32, int32, int32, int32)
    clang function  "ImageExtractPalette"       (ref Image, int32, ref int32)ref Col
    clang proc      "ImageText"                 (ref Image, ref char, int32, Col)
    clang proc      "ImageTextEx"               (ref Image, ref Font, ref char, real32, real32, Col)
    clang proc      "ImageDraw"                 (ref Image, ref Image, ref Rectangle, ref Rectangle, Col)
    clang proc      "ImageDrawRectangle"        (ref Image, ref Rectangle, Col)
    clang proc      "ImageDrawRectangleLines"   (ref Image, ref Rectangle, int32, Col)
    clang proc      "ImageDrawText"             (ref Image, Vec2, ref char, int32, Col)
    clang proc      "ImageDrawTextEx"           (ref Image, Vec2, ref Font, ref char, real32, real32, Col)
    clang proc      "ImageFlipVertical"         (ref Image)
    clang proc      "ImageFlipHorizontal"       (ref Image)
    clang proc      "ImageRotateCW"             (ref Image)
    clang proc      "ImageRotateCCW"            (ref Image)
    clang proc      "ImageColorTint"            (ref Image, Col)
    clang proc      "ImageColorInvert"          (ref Image)
    clang proc      "ImageColorGrayscale"       (ref Image)
    clang proc      "ImageColorContrast"        (ref Image, real32)
    clang proc      "ImageColorBrightness"      (ref Image, int32)
    clang proc      "ImageColorReplace"         (ref Image, Col, Col)

    !Image generation functions
    clang proc      "GenImageColor"             (ref Image, int32, int32, Col)
    clang proc      "GenImageGradientV"         (ref Image, int32, int32, Col, Col)
    clang proc      "GenImageGradientH"         (ref Image, int32, int32, Col, Col)
    clang proc      "GenImageGradientRadial"    (ref Image, int32, int32, real32, Col, Col)
    clang proc      "GenImageChecked"           (ref Image, int32, int32, int32, int32, Col, Col)
    clang proc      "GenImageWhiteNoise"        (ref Image, int32, int32, real32)
    clang proc      "GenImagePerlinNoise"       (ref Image, int32, int32, int32, int32, real32)
    clang proc      "GenImageCellular"          (ref Image, int32, int32, int32)

    !Texture2D config functions
    clang proc      "GenTextureMipmaps"         (ref Texture2D)
    clang proc      "SetTextureFilter"          (ref Texture2D, int32)
    clang proc      "SetTextureWrap"            (ref Texture2D, int32)

    !Texture2D drawing functions
    clang proc      "DrawTexture"               (ref Texture2D, int32, int32, Col)
    clang proc      "DrawTextureV"              (ref Texture2D, Vec2, Col)
    clang proc      "DrawTextureEx"             (ref Texture2D, Vec2, real32, real32, Col)
    clang proc      "DrawTextureRec"            (ref Texture2D, ref Rectangle, Vec2, Col)
    clang proc      "DrawTextureQuad"           (ref Texture2D, Vec2, Vec2, ref Rectangle, Col)
    clang proc      "DrawTexturePro"            (ref Texture2D, ref Rectangle, ref Rectangle, Vec2, real32, Col)
    clang proc      "DrawTextureNPatch"         (ref Texture2D, ref NPatchInfo, ref Rectangle, Vec2, real32, Col)

    !font (un)loading functions
    clang proc      "GetFontDefault"            (ref Font)
    clang proc      "LoadFont"                  (ref Font, ref char)
    clang proc      "LoadFontEx"                (ref Font, ref char, int32, ref int32, int32)
    clang proc      "LoadFontFromImage"         (ref Font, ref Image, Col, int32)
    clang proc      "LoadFontData"              (ref CharInfo, ref char, int32, ref int32, int32, int32)                !unsure if "ref CharInfo" will work here - CharInfo *LoadFontData(const char *fileName, int fontSize, int *fontChars, int charsCount, int type);
    clang proc      "GenImageFontAtlas"         (ref Image, ref CharInfo, ref Rectangle, int32, int32, int32, int32)    !unsure if "ref Rectangle" will work here - RLAPI Image GenImageFontAtlas(const CharInfo *chars, Rectangle **recs, int charsCount, int fontSize, int padding, int packMethod);
    clang proc      "UnloadFont"                (ref Font)

    !text drawing functions
    clang proc      "DrawFPS"                   (int32, int32)
    clang proc      "DrawText"                  (ref char, int32, int32, int32, Col)
    clang proc      "DrawTextEx"                (ref Font, ref char, Vec2, real32, real32, Col)
    clang proc      "DrawTextRec"               (ref Font, ref char, ref Rectangle, real32, real32, byte, Col)
    clang proc      "DrawTextRecEx"             (ref Font, ref char, ref Rectangle, real32, real32, byte, Col, int32, int32, Col, Col)
    clang proc      "DrawTextCodepoint"         (ref Font, int32, Vec2, real32, Col)

    !text misc functions
    clang function  "MeasureText"               (ref char, int32)int32
    clang function  "MeasureTextEx"             (ref Font, ref char, real32, real32)Vec2
    clang function  "GetGlyphIndex"             (ref Font, int32)int32

    !text strings management functions
    clang function  "TextCopy"                  (ref char, ref char)int32
    clang function  "TextIsEqual"               (ref char, ref char)byte
    clang function  "TextLength"                (ref char)u32
    clang function  "TextFormat"                (ref char, ...)ref char
    clang function  "TextSubtext"               (ref char, int32, int32)ref char
    clang function  "TextReplace"               (ref char, ref char, ref char)ref char
    clang function  "TextInsert"                (ref char, ref char, int32)ref char
    clang function  "TextJoin"                  (ref[]ichar, int32, ref char)ref char
    clang function  "TextSplit"                 (ref char, ref char, ref int32)ref[]ichar
    clang proc      "TextAppend"                (ref char, ref char, ref int32)
    clang function  "TextFindIndex"             (ref char, ref char)int32
    clang function  "TextToUpper"               (ref char)ref char
    clang function  "TextToLower"               (ref char)ref char
    clang function  "TextToPascal"              (ref char)ref char
    clang function  "TextToInteger"             (ref char)int32
    clang function  "TextToUtf8"                (ref int32, int32)ref char

    !basic geometric 3D shapes drawing functions
    clang proc      "DrawLine3D"                (ref Vector3, ref Vector3, Col)
    clang proc      "DrawPoint3D"               (ref Vector3, Col)
    clang proc      "DrawCircle3D"              (ref Vector3, real32, ref Vector3, real32, Col)
    clang proc      "DrawCube"                  (ref Vector3, real32, real32, real32, Col)
    clang proc      "DrawCubeV"                 (ref Vector3, ref Vector3, Col)
    clang proc      "DrawCubeWires"             (ref Vector3, real32, real32, real32, Col)
    clang proc      "DrawCubeWiresV"            (ref Vector3, ref Vector3, Col)
    clang proc      "DrawCubeTexture"           (ref Texture2D, ref Vector3, real32, real32, real32, Col)
    clang proc      "DrawSphere"                (ref Vector3, real32, Col)
    clang proc      "DrawSphereEx"              (ref Vector3, real32, int32, int32, Col)
    clang proc      "DrawSphereWires"           (ref Vector3, real32, int32, int32, Col)
    clang proc      "DrawCylinder"              (ref Vector3, real32, real32, real32, int32, Col)
    clang proc      "DrawCylinderWires"         (ref Vector3, real32, real32, real32, int32, Col)
    clang proc      "DrawPlane"                 (ref Vector3, Vec2, Col)
    clang proc      "DrawRay"                   (ref Ray, Col)
    clang proc      "DrawGrid"                  (int32, real32)
    clang proc      "DrawGizmo"                 (ref Vector3)

    !model (un)loading functions
    clang proc      "LoadModel"                 (ref Model, ref char)
    clang proc      "LoadModelFromMesh"         (ref Model, ref Mesh)
    clang proc      "UnloadModel"               (ref Model)

    !mesh (un)loading functions
    clang function  "LoadMeshes"                (ref char, ref int32)ref Mesh
    clang proc      "ExportMesh"                (ref Mesh, ref char)
    clang proc      "UnloadMesh"                (ref Mesh)

    !material (un)loading functions
    clang proc      "LoadMaterials"             (ref Material, ref char, ref int32)
    clang proc      "LoadMaterialDefault"       (ref Material)
    clang proc      "UnloadMaterial"            (ref Material)
    clang proc      "SetMaterialTexture"        (ref Material, int32, ref Texture2D)
    clang proc      "SetModelMeshMaterial"      (ref Model, int32, int32)

    !model animations (un)loading functions
    clang proc      "LoadModelAnimations"       (ref ModelAnimation, ref char, ref int)
    clang proc      "UpdateModelAnimation"      (ref Model, ref ModelAnimation, int32)
    clang proc      "UnloadModelAnimation"      (ref ModelAnimation)
    clang function  "IsModelAnimationValid"     (ref Model, ref ModelAnimation)byte

    !mesh generation functions
    clang proc      "GenMeshPoly"               (ref Mesh, int32, real32)
    clang proc      "GenMeshPlane"              (ref Mesh, real32, real32, int32, int32)
    clang proc      "GenMeshCube"               (ref Mesh, real32, real32, real32)
    clang proc      "GenMeshSphere"             (ref Mesh, real32, int32, int32)
    clang proc      "GenMeshHemiSphere"         (ref Mesh, real32, real32, int32)
    clang proc      "GenMeshCylinder"           (ref Mesh, real32, real32, int32)
    clang proc      "GenMeshTorus"              (ref Mesh, real32, real32, int32, int32)
    clang proc      "GenMeshKnot"               (ref Mesh, real32, real32, int32, int32)
    clang proc      "GenMeshHeightmap"          (ref Mesh, ref Image, ref Vector3)
    clang proc      "GenMeshCubicmap"           (ref Mesh, ref Image, ref Vector3)

    !mesh manipulation functions
    clang proc      "MeshBoundingBox"           (ref BoundingBox, ref Mesh)
    clang proc      "MeshTangents"              (ref Mesh)
    clang proc      "MeshBinormals"             (ref Mesh)

    !model drawing functions
    clang proc      "DrawModel"                 (ref Model, ref Vector3, real32, Col)
    clang proc      "DrawModelEx"               (ref Model, ref Vector3, ref Vector3, real32, ref Vector3, Col)
    clang proc      "DrawModelWires"            (ref Model, ref Vector3, real32, Col)
    clang proc      "DrawModelWiresEx"          (ref Model, ref Vector3, ref Vector3, real32, ref Vector3, Col)
    clang proc      "DrawBoundingBox"           (ref BoundingBox, Col)
    clang proc      "DrawBillboard"             (ref Camera, ref Texture2D, ref Vector3, real32, Col)
    clang proc      "DrawBillboardRec"          (ref Camera, ref Texture2D, ref Rectangle, ref Vector3, real32, Col)

    !3D collision detection functions
    clang function  "CheckCollisionSpheres"     (ref Vector3, real32, ref Vector3, real32)byte
    clang function  "CheckCollisionBoxes"       (ref BoundingBox, ref BoundingBox)byte
    clang function  "CheckCollisionBoxSphere"   (ref BoundingBox, ref Vector3, real32)byte
    clang function  "CheckCollisionRaySphere"   (ref Ray, ref Vector3, real32)byte
    clang function  "CheckCollisionRaySphereEx" (ref Ray, ref Vector3, real32, ref Vector3)byte
    clang function  "CheckCollisionRayBox"      (ref Ray, ref BoundingBox)byte
    clang proc      "GetCollisionRayModel"      (ref RayHitInfo, ref Ray, ref Model)
    clang proc      "GetCollisionRayTriangle"   (ref RayHitInfo, ref Ray, ref Vector3, ref Vector3, ref Vector3)
    clang proc      "GetCollisionRayGround"     (ref RayHitInfo, ref Ray, real32)

    !shader (un)loading functions
    clang function  "LoadText"                  (ref char)ref char
    clang proc      "LoadShader"                (ref Shader, ref char, ref char)
    clang proc      "LoadShaderCode"            (ref Shader, ref char, ref char)
    clang proc      "UnloadShader"              (ref Shader)

    clang proc      "GetShaderDefault"          (ref Shader)
    clang proc      "GetTextureDefault"         (ref Texture2D)

    !shader configuration functions
    clang function  "GetShaderLocation"         (ref Shader, ref char)int32
    clang proc      "SetShaderValue"            (ref Shader, int32, ref void, int32)
    clang proc      "SetShaderValueV"           (ref Shader, int32, ref void, int32, int32)
    clang proc      "SetShaderValueMatrix"      (ref Shader, int32, ref Matrix)
    clang proc      "SetShaderValueTexture"     (ref Shader, int32, ref Texture2D)
    clang proc      "SetMatrixProjection"       (ref Matrix)
    clang proc      "SetMatrixModelview"        (ref Matrix)
    clang proc      "GetMatrixModelview"        (ref Matrix)
    clang proc      "GetMatrixProjection"       (ref Matrix)

    !texture maps generation (PBR)
    clang proc      "GenTextureCubemap"         (ref Texture2D, ref Shader, ref Texture2D, int32)
    clang proc      "GenTextureIrradiance"      (ref Texture2D, ref Shader, ref Texture2D, int32)
    clang proc      "GenTexturePrefilter"       (ref Texture2D, ref Shader, ref Texture2D, int32)
    clang proc      "GenTextureBRDF"            (ref Texture2D, ref Shader, int32)

    !shading begin/end functions
    clang proc      "BeginShaderMode"           (ref Shader)
    clang proc      "EndShaderMode"             ()
    clang proc      "BeginBlendMode"            (int32)
    clang proc      "EndBlendMode"              ()

    !VR control functions
    clang proc      "InitVrSimulator"           ()
    clang proc      "CloseVrSimulator"          ()
    clang proc      "UpdateVrTracking"          (ref Camera)
    clang proc      "SetVrConfiguration"        (ref VrDeviceInfo, ref Shader)
    clang function  "IsVrSimulatorReady"        ()byte
    clang proc      "ToggleVrMode"              ()
    clang proc      "BeginVrDrawing"            ()
    clang proc      "EndVrDrawing"              ()

    !audio device management functions
    clang proc      "InitAudioDevice"           ()
    clang proc      "CloseAudioDevice"          ()
    clang function  "IsAudioDeviceReady"        ()byte
    clang proc      "SetMasterVolume"           (real32)

    !wave/sound (un)loading functions
    clang proc      "LoadWave"                  (ref Wave, ref char)
    clang proc      "LoadSound"                 (ref Sound, ref char)
    clang proc      "LoadSoundFromWave"         (ref Sound, ref Wave)
    clang proc      "UpdateSound"               (ref Sound, ref void, int32)
    clang proc      "UnloadWave"                (ref Wave)
    clang proc      "UnloadSound"               (ref Sound)
    clang proc      "ExportWave"                (ref Wave, ref char)
    clang proc      "ExportWaveAsCode"          (ref Wave, ref char)

    !wave/sound management functions
    clang proc      "PlaySound"                 (ref Sound)
    clang proc      "StopSound"                 (ref Sound)
    clang proc      "PauseSound"                (ref Sound)
    clang proc      "ResumeSound"               (ref Sound)
    clang proc      "PlaySoundMulti"            (ref Sound)
    clang proc      "StopSoundMulti"            ()
    clang function  "GetSoundsPlaying"          ()int
    clang function  "IsSoundPlaying"            (ref Sound)byte
    clang proc      "SetSoundVolume"            (ref Sound, real32)
    clang proc      "SetSoundPitch"             (ref Sound, real32)
    clang proc      "WaveFormat"                (ref Wave, int32, int32, int32)
    clang function  "WaveCopy"                  (ref Wave)ref Wave
    clang proc      "WaveCrop"                  (ref Wave, int32, int32)
    clang function  "GetWaveData"               (ref Wave)ref real32

    !music management functions
    clang proc      "LoadMusicStream"           (ref Music, ref char)
    clang proc      "UnloadMusicStream"         (ref Music)
    clang proc      "PlayMusicStream"           (ref Music)
    clang proc      "UpdateMusicStream"         (ref Music)
    clang proc      "StopMusicStream"           (ref Music)
    clang proc      "PauseMusicStream"          (ref Music)
    clang proc      "ResumeMusicStream"         (ref Music)
    clang function  "IsMusicPlaying"            (ref Music)byte
    clang proc      "SetMusicVolume"            (ref Music, real32)
    clang proc      "SetMusicPitch"             (ref Music, real32)
    clang proc      "SetMusicLoopCount"         (ref Music, int32)
    clang function  "GetMusicTimeLength"        (ref Music)real32
    clang function  "GetMusicTimePlayed"        (ref Music)real32

    !AudioStream management functions
    clang proc      "InitAudioStream"           (ref AudioStream, u32, u32, u32)
    clang proc      "UpdateAudioStream"         (ref AudioStream, ref void, int32)
    clang proc      "CloseAudioStream"          (ref AudioStream)
    clang function  "IsAudioStreamProcessed"    (ref AudioStream)byte
    clang proc      "PlayAudioStream"           (ref AudioStream)
    clang proc      "PauseAudioStream"          (ref AudioStream)
    clang proc      "ResumeAudioStream"         (ref AudioStream)
    clang function  "IsAudioStreamPlaying"      (ref AudioStream)byte
    clang proc      "StopAudioStream"           (ref AudioStream)
    clang proc      "SetAudioStreamVolume"      (ref AudioStream, real32)
    clang proc      "SetAudioStreamPitch"       (ref AudioStream, real32)
end