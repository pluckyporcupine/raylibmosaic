!basic defines
global const DEG2RAD=pi/180.0
global const RAD2DEG=180.0/pi
global const MAX_TOUCH_POINTS=10

!basic structures
global record Vector2= $caligned
    r32 x
    r32 y
end

global record Vector3= $caligned
    r32 x
    r32 y
    r32 z
end

global record Vector4= $caligned
    r32 x
    r32 y
    r32 z
    r32 w
end

global type Quaternion=Vector4

global record Matrix= $caligned
    r32 m0, m4, m8, m12
    r32 m1, m5, m9, m13
    r32 m2, m6, m10, m14
    r32 m3, m7, m11, m15
end

global record Color= $caligned
    byte r
    byte g
    byte b
    byte a
end

global record Rectangle= $caligned
    r32 x
    r32 y
    r32 width
    r32 height
end

global record Image= $caligned
    ref[0:]void data
    int32 width
    int32 height
    int32 mipmaps
    int32 format
end

global record Texture2D= $caligned
    u32 id
    int32 width
    int32 height
    int32 mipmaps
    int32 format
end

global type Texture=Texture2D

global type TextureCubemap=Texture2D

global record RenderTexture2D= $caligned
    u32 id
    Texture2D txtr
    Texture2D depth
    byte depthTexture
end

global type RenderTexture=RenderTexture2D

global record NPatchInfo= $caligned
    Rectangle sourceRec
    int32 left
    int32 top
    int32 right
    int32 bottom
    int32 `type
end

global record CharInfo= $caligned
    int32 value
    int32 offsetX
    int32 offsetY
    int32 advanceX
    image image
end

global record Font= $caligned
    int32 baseSize
    int32 charsCount
    Texture2D txtr
    ref[0:]Rectangle recs
    ref[0:]CharInfo chars
end

global type SpriteFont=Font

global record Camera3D= $caligned
    Vector3 position
    Vector3 target
    Vector3 up
    r32 fovy
    int32 `type
end

global type Camera=Camera3D

global record Camera2D= $caligned
    Vector2 offset
    vector2 target
    r32 rotation
    r32 zoom
end

global record Mesh= $caligned
    int32 vertexCount
    int32 triangleCount
    ref[0:]r32 vertices
    ref[0:]r32 texcoords
    ref[0:]r32 texcoords2
    ref[0:]r32 normals
    ref[0:]r32 tangents
    ref[0:]char colors
    ref[0:]i16 indices
    ref[0:]r32 animVertices
    ref[0:]r32 animNormals
    ref[0:]int32 boneIds
    ref[0:]r32 boneWeights
    int32 vaoId
    ref int32 vboId
end

global record Shader= $caligned
    word32 id
    ref[0:]int32 locs
end

global record MaterialMap= $caligned
    Texture2D texture
    color color
    real32 value
end

global record Material= $caligned
    shader shader
    ref[0:]MaterialMap maps
    ref[0:]r32 params
end

global record Transform= $caligned
    Vector3 translation
    Quaternion rotation
    Vector3 scale
end

global record BoneInfo= $caligned
    [32]byte name
    int32 parent
end

global record Model= $caligned
    Matrix transform
    int32 meshCount
    ref[0:]Mesh meshes
    int32 materialCount
    ref[0:]Material materials
    ref int32 meshMaterial
    int32 boneCount
    ref[0:]BoneInfo bones
    ref Transform bindPose
end

global type rTransform=ref Transform

global record ModelAnimation= $caligned
    int32 boneCount
    ref BoneInfo bones
    int32 frameCount
    ref[0:]rTransform framePoses
end

global record Ray= $caligned
    Vector3 position
    Vector3 direction
end

global record RayHitInfo= $caligned
    u8 hit
    r32 distance
    Vector3 position
    Vector3 normal
end

global record BoundingBox= $caligned
    Vector3 `min
    Vector3 `max
end

global record Wave= $caligned
    word32 sampleCount
    word32 sampleRate
    word32 sampleSize
    word32 channels
    ref void data
end

global record rAudioBuffer= $caligned
    int dummy
end

global record AudioStream= $caligned
    word32 sampleRate
    word32 sampleSize
    word32 channels
    ref rAudioBuffer buffer
end

global record Sound= $caligned
    word32 sampleCount
    AudioStream stream
end

global record Music= $caligned
    int32 ctxType
    ref void ctxData
    word32 sampleCount
    word32 loopCount
    AudioStream stream
end

global record VrDeviceInfo= $caligned
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

!need to figure out how to implement TraceLogCallback
global record TraceLogCallback= $caligned
    int dummy
end

!raymath structs
global record float3= $caligned
    ref[3]real32 v
end

global record float16= $caligned
    ref[16]real32 v
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

global const LOC_MAP_DIFFUSE=LOC_MAP_ALBEDO
global const LOC_MAP_SPECULAR=LOC_MAP_METALNESS

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

global const MAP_DIFFUSE=MAP_ALBEDO
global const MAP_SPECULAR=MAP_METALNESS

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

!rlgl defines
global const int MAX_BATCH_ELEMENTS=8192

global const int MAX_BATCH_BUFFERING=1
global const int MAX_MATRIX_STACK_SIZE=32
global const int MAX_DRAWCALL_REGISTERED=256

global const real32 DEFAULT_NEAR_CULL_DISTANCE=0.01
global const real32 DEFAULT_FAR_CULL_DISTANCE=1000.0

global const int MAX_SHADER_LOCATIONS=32
global const int MAX_MATERIAL_MAPS=12

!rlgl texture parameter macros
global const RL_TEXTURE_WRAP_S=0x2802
global const RL_TEXTURE_WRAP_T=0x2803
global const RL_TEXTURE_MAG_FILTER=0x2800
global const RL_TEXT_MIN_FILTER=0x2801
global const RL_TEXTURE_ANISOTROPIC_FILTER=0x3000

global const RL_FILTER_NEAREST=0x2600
global const RL_FILTER_LINEAR=0x2601
global const RL_FILTER_MIP_NEAREST=0x2700
global const RL_FILTER_NEAREST_MIP_LINEAR=0x2702
global const RL_FILTER_LINEAR_MIP_NEAREST=0x2701
global const RL_FILTER_MIP_LINEAR=0x2703

global const RL_WRAP_REPEAT=0x2901
global const RL_WRAP_CLAMP=0x812F
global const RL_WRAP_MIRROR_REAPEAT=0x8370
global const RL_WRAP_MIRROR_CLAMP=0x8742

global const RL_MODELVIEW=0x1700
global const RL_PROJECTION=0x1701
global const RL_TEXTURE=0x1702

global const RL_LINES=0x0001
global const RL_TRIANGLES=0x0004
global const RL_QUADS=0x0007

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
    clang function  "GetWindowPosition"         ()Vector2
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
    clang proc      "ClearBackground"           (Color)
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
    clang proc      "GetMouseRay"               (ref Ray, Vector2, ref Camera)
    clang proc      "GetCameraMatrix"           (ref Matrix, ref Camera)
    clang proc      "GetCameraMatrix2D"         (ref Matrix, ref Camera2D)
    clang function  "GetWorldToScreen"          (ref Vector3, ref Camera)Vector2
    clang function  "GetWorldToScreenEx"        (ref Vector3, ref Camera, int32, int32)Vector2
    clang function  "GetWorldToScreen2D"        (Vector2, ref Camera2D)Vector2
    clang function  "GetScreenToWorld2D"        (Vector2, ref Camera2D)Vector2

    !timing functions
    clang proc      "SetTargetFPS"              (int32)
    clang function  "GetFPS"                    ()int32
    clang function  "GetFrameTime"              ()real32
    clang function  "GetTime"                   ()real64

    !color functions
    clang function  "ColorToInt"                (Color)int32
    clang proc      "ColorNormalize"            (ref Vector4, Color)
    clang function  "ColorFromNormalize"        (ref Vector4)Color
    clang proc      "ColorToHSV"                (ref Vector3, Color)
    clang function  "ColorFromHSV"              (ref Vector3)Color
    clang function  "GetColor"                  (int32)Color
    clang function  "Fade"                      (Color, real32)Color

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
    clang function  "GetDirectoryFiles"         (ref char, ref char)ref[0:]ichar
    clang proc      "ClearDirectoryFiles"       ()
    clang function  "ChangeDirectory"           (ref char)byte
    clang function  "IsFileDropped"             ()byte
    clang function  "GetDroppedFiles"           (ref int)ref[0:]ichar
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
    clang function  "GetMousePosition"          ()Vector2
    clang proc      "SetMousePosition"          (int32, int32)
    clang proc      "SetMouseOffset"            (int32, int32)
    clang proc      "SetMouseScale0"            (real32, real32)
    clang function  "GetMouseWheelMove"         ()int32

    !touch input functions
    clang function  "GetTouchX"                 ()int32
    clang function  "GetTouchY"                 ()int32
    clang function  "GetTouchPosition"          (int32)Vector2

    !gesture/touch handling functions
    clang proc      "SetGesturesEnabled"        (u32)
    clang function  "IsGestureDetected"         (int32)byte
    clang function  "GetGestureDetected"        ()int32
    clang function  "GetTouchPointsCount"       ()int32
    clang function  "GetGestureHoldDuration"    ()real32
    clang function  "GetGestureDragVector"      ()Vector2
    clang function  "GetGestureDragAngle"       ()real32
    clang function  "GetGesturePinchVector"     ()Vector2
    clang function  "GetGesturePinchAngle"      ()real32

    !camera functions
    clang proc      "SetCameraMode"             (ref Camera, int32)
    clang proc      "UpdateCamera"              (ref Camera)
    clang proc      "SetCameraPanControl"       (int32)
    clang proc      "SetCameraAltControl"       (int32)
    clang proc      "SetCameraSmoothZoomControl"(int32)
    clang proc      "SetCameraMoveControls"     (int32, int32, int32, int32, int32, int32)

    !basic shapes drawing functions
    clang proc      "DrawPixel"                 (int32, int32, Color)
    clang proc      "DrawlPixelV"               (Vector2, Color)
    clang proc      "DrawLine"                  (int32, int32, int32, int32, Color)
    clang proc      "DrawLineV"                 (Vector2, Vector2, Color)
    clang proc      "DrawLineEx"                (Vector2, Vector2, real32, Color)
    clang proc      "DrawLineBezier"            (Vector2, Vector2, real32, Color)
    clang proc      "DrawLineStrip"             (ref Vector2, int32, Color)              ! ref[0:]Vector2? - void DrawLineStrip(Vector2 *points, int numPoints, Color color);
    clang proc      "DrawCircle"                (int32, int32, real32, Color)
    clang proc      "DrawCircleSector"          (Vector2, real32, int32, int32, int32, Color)
    clang proc      "DrawCircleSectorLines"     (Vector2, real32, int32, int32, int32, Color)
    clang proc      "DrawCircleGradient"        (int32, int32, real32, Color, Color)
    clang proc      "DrawCircleV"               (Vector2, real32, Color)
    clang proc      "DrawCircleLines"           (int32, int32, float32, Color)
    clang proc      "DrawEllipse"               (int32, int32, real32, real32, Color)
    clang proc      "DrawEllipseLines"          (int32, int32, real32, real32, Color)
    clang proc      "DrawRing"                  (Vector2, real32, real32, int32, int32, int32, Color)
    clang proc      "DrawRingLines"             (Vector2, real32, real32, int32, int32, int32, Color)
    clang proc      "DrawRectangle"             (int32, int32, int32, int32, Color)
    clang proc      "DrawRectangleV"            (Vector2, Vector2, Color)
    clang proc      "DrawRectangleRec"          (ref Rectangle, Color)
    clang proc      "DrawRectanglePro"          (ref Rectangle, Vector2, real32, Color)
    clang proc      "DrawRectangleGradientV"    (int32, int32, int32, int32, Color, Color)
    clang proc      "DrawRectangleGradientH"    (int32, int32, int32, int32, Color, Color)
    clang proc      "DrawRectangleGradientEx"   (ref Rectangle, Color, Color, Color, Color)
    clang proc      "DrawRectangleLines"        (int32, int32, int32, int32, Color)
    clang proc      "DrawRectangleLinesEx"      (ref Rectangle, int32, Color)
    clang proc      "DrawRectangleRounded"      (ref Rectangle, real32, int32, Color)
    clang proc      "DrawRectangleRoundedLines" (ref Rectangle, real32, int32, int32, Color)
    clang proc      "DrawTriangle"              (Vector2, Vector2, Vector2, Color)
    clang proc      "DrawTriangleLines"         (Vector2, Vector2, Vector2, Color)
    clang proc      "DrawTriangleFan"           (ref Vector2, int32, Color)              ! ref[0:]Vector2?
    clang proc      "DrawTriangleStrip"         (ref Vector2, int32, Color)              ! ref[0:]Vector2?
    clang proc      "DrawPoly"                  (Vector2, int32, real32, real32, Color)
    clang proc      "DrawPolyLines"             (Vector2, int32, real32, real32, Color)

    clang proc      "SetShapesTexture"          (ref Texture2D, ref Rectangle)

    !basic shapes collision detection functions
    clang function  "CheckCollisionRecs"        (ref Rectangle, ref Rectangle)byte
    clang function  "CheckCollisionCircles"     (Vector2, real32, Vector2, real32)byte
    clang function  "CheckCollisionCircleRec"   (Vector2, real32, ref Rectangle)byte
    clang proc      "GetCollisionRec"           (ref Rectangle, ref Rectangle, ref Rectangle)
    clang function  "CheckCollisionPointRec"    (Vector2, ref Rectangle)byte
    clang function  "CheckCollisionPointCircle" (Vector2, Vector2, real32)byte
    clang function  "CheckCollisionPointTriangle"   (Vector2, Vector2, Vector2, Vector2)byte
    
    !Image/Texture2D data handling functions
    clang proc      "LoadImage"                 (ref Image, ref char)
    clang proc      "LoadImageEx"               (ref Image, ref Color, int32, int32)    ! ref[0:]Color?
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
    clang function  "GetImageData"              (ref Image)ref Color
    clang proc      "GetImageDataNormalized"    (ref Vector4, ref Image)
    clang proc      "GetImageAlphaBorder"       (ref Rectangle, ref Image, real32)
    clang function  "GetPixelDataSize"          (int32, int32, int32)int32
    clang proc      "GetTextureData"            (ref Image, ref Texture2D)
    clang proc      "GetScreenData"             (ref Image)
    clang proc      "UpdateTexture"             (ref Texture2D, ref void)

    !Image manipulation functions
    clang proc      "ImageCopy"                 (ref Image, ref Image)
    clang proc      "ImageFromImage"            (ref Image, ref Image, ref Rectangle)
    clang proc      "ImagetoPOT"                (ref Image, Color)                    ! ref[0:]Image? - RLAPI void ImageToPOT(Image *image, Color fillColor);
    clang proc      "ImageFormat"               (ref Image, int32)
    clang proc      "ImageAlphaMask"            (ref Image, ref Image)
    clang proc      "ImageAlphaClear"           (ref Image, Color, real32)
    clang proc      "ImageAlphaCrop"            (ref Image, real32)
    clang proc      "ImageAlphaPremultiply"     (ref Image)
    clang proc      "ImageCrop"                 (ref Image, ref Rectangle)
    clang proc      "ImageResize"               (ref Image, int32, int32)
    clang proc      "ImageResizeNN"             (ref Image, int32, int32)
    clang proc      "ImageResizeCanvas"         (ref Image, int32, int32, int32, int32, Color)
    clang proc      "ImageMipmaps"              (ref Image)
    clang proc      "ImageDither"               (ref Image, int32, int32, int32, int32)
    clang function  "ImageExtractPalette"       (ref Image, int32, ref int32)ref Color
    clang proc      "ImageText"                 (ref Image, ref char, int32, Color)
    clang proc      "ImageTextEx"               (ref Image, ref Font, ref char, real32, real32, Color)
    clang proc      "ImageDraw"                 (ref Image, ref Image, ref Rectangle, ref Rectangle, Color)
    clang proc      "ImageDrawRectangle"        (ref Image, ref Rectangle, Color)
    clang proc      "ImageDrawRectangleLines"   (ref Image, ref Rectangle, int32, Color)
    clang proc      "ImageDrawText"             (ref Image, Vector2, ref char, int32, Color)
    clang proc      "ImageDrawTextEx"           (ref Image, Vector2, ref Font, ref char, real32, real32, Color)
    clang proc      "ImageFlipVertical"         (ref Image)
    clang proc      "ImageFlipHorizontal"       (ref Image)
    clang proc      "ImageRotateCW"             (ref Image)
    clang proc      "ImageRotateCCW"            (ref Image)
    clang proc      "ImageColorTint"            (ref Image, Color)
    clang proc      "ImageColorInvert"          (ref Image)
    clang proc      "ImageColorGrayscale"       (ref Image)
    clang proc      "ImageColorContrast"        (ref Image, real32)
    clang proc      "ImageColorBrightness"      (ref Image, int32)
    clang proc      "ImageColorReplace"         (ref Image, Color, Color)

    !Image generation functions
    clang proc      "GenImageColor"             (ref Image, int32, int32, Color)
    clang proc      "GenImageGradientV"         (ref Image, int32, int32, Color, Color)
    clang proc      "GenImageGradientH"         (ref Image, int32, int32, Color, Color)
    clang proc      "GenImageGradientRadial"    (ref Image, int32, int32, real32, Color, Color)
    clang proc      "GenImageChecked"           (ref Image, int32, int32, int32, int32, Color, Color)
    clang proc      "GenImageWhiteNoise"        (ref Image, int32, int32, real32)
    clang proc      "GenImagePerlinNoise"       (ref Image, int32, int32, int32, int32, real32)
    clang proc      "GenImageCellular"          (ref Image, int32, int32, int32)

    !Texture2D config functions
    clang proc      "GenTextureMipmaps"         (ref Texture2D)
    clang proc      "SetTextureFilter"          (ref Texture2D, int32)
    clang proc      "SetTextureWrap"            (ref Texture2D, int32)

    !Texture2D drawing functions
    clang proc      "DrawTexture"               (ref Texture2D, int32, int32, Color)
    clang proc      "DrawTextureV"              (ref Texture2D, Vector2, Color)
    clang proc      "DrawTextureEx"             (ref Texture2D, Vector2, real32, real32, Color)
    clang proc      "DrawTextureRec"            (ref Texture2D, ref Rectangle, Vector2, Color)
    clang proc      "DrawTextureQuad"           (ref Texture2D, Vector2, Vector2, ref Rectangle, Color)
    clang proc      "DrawTexturePro"            (ref Texture2D, ref Rectangle, ref Rectangle, Vector2, real32, Color)
    clang proc      "DrawTextureNPatch"         (ref Texture2D, ref NPatchInfo, ref Rectangle, Vector2, real32, Color)

    !font (un)loading functions
    clang proc      "GetFontDefault"            (ref Font)
    clang proc      "LoadFont"                  (ref Font, ref char)
    clang proc      "LoadFontEx"                (ref Font, ref char, int32, ref int32, int32)
    clang proc      "LoadFontFromImage"         (ref Font, ref Image, Color, int32)
    clang proc      "LoadFontData"              (ref CharInfo, ref char, int32, ref int32, int32, int32)                ! ref[0:]CharInfo? - CharInfo *LoadFontData(const char *fileName, int fontSize, int *fontChars, int charsCount, int type);
    clang proc      "GenImageFontAtlas"         (ref Image, ref CharInfo, ref Rectangle, int32, int32, int32, int32)    ! ref[0:]Rectangle? - RLAPI Image GenImageFontAtlas(const CharInfo *chars, Rectangle **recs, int charsCount, int fontSize, int padding, int packMethod);
    clang proc      "UnloadFont"                (ref Font)

    !text drawing functions
    clang proc      "DrawFPS"                   (int32, int32)
    clang proc      "DrawText"                  (ref char, int32, int32, int32, Color)
    clang proc      "DrawTextEx"                (ref Font, ref char, Vector2, real32, real32, Color)
    clang proc      "DrawTextRec"               (ref Font, ref char, ref Rectangle, real32, real32, byte, Color)
    clang proc      "DrawTextRecEx"             (ref Font, ref char, ref Rectangle, real32, real32, byte, Color, int32, int32, Color, Color)
    clang proc      "DrawTextCodepoint"         (ref Font, int32, Vector2, real32, Color)

    !text misc functions
    clang function  "MeasureText"               (ref char, int32)int32
    clang function  "MeasureTextEx"             (ref Font, ref char, real32, real32)Vector2
    clang function  "GetGlyphIndex"             (ref Font, int32)int32

    !text strings management functions
    clang function  "TextCopy"                  (ref char, ref char)int32
    clang function  "TextIsEqual"               (ref char, ref char)byte
    clang function  "TextLength"                (ref char)u32
    clang function  "TextFormat"                (ref char, ...)ref char
    clang function  "TextSubtext"               (ref char, int32, int32)ref char
    clang function  "TextReplace"               (ref char, ref char, ref char)ref char
    clang function  "TextInsert"                (ref char, ref char, int32)ref char
    clang function  "TextJoin"                  (ref[0:]ichar, int32, ref char)ref char
    clang function  "TextSplit"                 (ref char, ref char, ref int32)ref[0:]ichar
    clang proc      "TextAppend"                (ref char, ref char, ref int32)
    clang function  "TextFindIndex"             (ref char, ref char)int32
    clang function  "TextToUpper"               (ref char)ref char
    clang function  "TextToLower"               (ref char)ref char
    clang function  "TextToPascal"              (ref char)ref char
    clang function  "TextToInteger"             (ref char)int32
    clang function  "TextToUtf8"                (ref int32, int32)ref char

    !basic geometric 3D shapes drawing functions
    clang proc      "DrawLine3D"                (ref Vector3, ref Vector3, Color)
    clang proc      "DrawPoint3D"               (ref Vector3, Color)
    clang proc      "DrawCircle3D"              (ref Vector3, real32, ref Vector3, real32, Color)
    clang proc      "DrawCube"                  (ref Vector3, real32, real32, real32, Color)
    clang proc      "DrawCubeV"                 (ref Vector3, ref Vector3, Color)
    clang proc      "DrawCubeWires"             (ref Vector3, real32, real32, real32, Color)
    clang proc      "DrawCubeWiresV"            (ref Vector3, ref Vector3, Color)
    clang proc      "DrawCubeTexture"           (ref Texture2D, ref Vector3, real32, real32, real32, Color)
    clang proc      "DrawSphere"                (ref Vector3, real32, Color)
    clang proc      "DrawSphereEx"              (ref Vector3, real32, int32, int32, Color)
    clang proc      "DrawSphereWires"           (ref Vector3, real32, int32, int32, Color)
    clang proc      "DrawCylinder"              (ref Vector3, real32, real32, real32, int32, Color)
    clang proc      "DrawCylinderWires"         (ref Vector3, real32, real32, real32, int32, Color)
    clang proc      "DrawPlane"                 (ref Vector3, Vector2, Color)
    clang proc      "DrawRay"                   (ref Ray, Color)
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
    clang proc      "DrawModel"                 (ref Model, ref Vector3, real32, Color)
    clang proc      "DrawModelEx"               (ref Model, ref Vector3, ref Vector3, real32, ref Vector3, Color)
    clang proc      "DrawModelWires"            (ref Model, ref Vector3, real32, Color)
    clang proc      "DrawModelWiresEx"          (ref Model, ref Vector3, ref Vector3, real32, ref Vector3, Color)
    clang proc      "DrawBoundingBox"           (ref BoundingBox, Color)
    clang proc      "DrawBillboard"             (ref Camera, ref Texture2D, ref Vector3, real32, Color)
    clang proc      "DrawBillboardRec"          (ref Camera, ref Texture2D, ref Rectangle, ref Vector3, real32, Color)

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

    !raymath functions

    !utils math
    clang function  "Clamp"                     (real32, real32, real32)real32
    clang function  "Lerp"                      (real32, real32, real32)real32

    !Vector2 math
    clang function  "Vector2Zero"               ()Vector2
    clang function  "Vector2One"                ()Vector2
    clang function  "Vector2Add"                (Vector2, Vector2)Vector2
    clang function  "Vector2Subtract"           (Vector2, Vector2)Vector2
    clang function  "Vector2Length"             (Vector2)real32
    clang function  "Vector2DotProduct"         (Vector2, Vector2)real32
    clang function  "Vector2Distance"           (Vector2, Vector2)real32
    clang function  "Vector2Angle"              (Vector2, Vector2)real32
    clang function  "Vector2Scale"              (Vector2, real32)Vector2
    clang function  "Vector2MultiplyV"          (Vector2, Vector2)Vector2
    clang function  "Vector2Negate"             (Vector2)Vector2
    clang function  "Vector2Divide"             (Vector2, real32)Vector2
    clang function  "Vector2DivideV"            (Vector2, Vector2)Vector2
    clang function  "Vector2Normalize"          (Vector2)Vector2
    clang function  "Vector2Lerp"               (Vector2, Vector2, real32)Vector2

    !Vector3 math
    clang proc      "Vector3Zero"               (ref Vector3)
    clang proc      "Vector3One"                (ref Vector3)
    clang proc      "Vector3Add"                (ref Vector3, ref Vector3, ref Vector3)
    clang proc      "Vector3Subtract"           (ref Vector3, ref Vector3, ref Vector3)
    clang proc      "Vector3Scale"              (ref Vector3, ref Vector3, real32)
    clang proc      "Vector3Multiply"           (ref Vector3, ref Vector3, ref Vector3)
    clang function  "Vector3CrossProduct"       (ref Vector3, ref Vector3)real32
    clang proc      "Vector3Perpendicular"      (ref Vector3, ref Vector3)
    clang function  "Vector3Length"             (ref Vector3)real32
    clang function  "Vector3DotProduct"         (ref Vector3, ref Vector3)real32
    clang function  "Vector3Distance"           (ref Vector3, ref Vector3)real32
    clang proc      "Vector3Negate"             (ref Vector3, ref Vector3)
    clang proc      "Vector3Divide"             (ref Vector3, ref Vector3, real32)
    clang proc      "Vector3DivideV"            (ref Vector3, ref Vector3, ref Vector3)
    clang proc      "Vector3Normalize"          (ref Vector3, ref Vector3)
    clang proc      "Vector3OrthoNormalize"     (ref Vector3, ref Vector3)
    clang proc      "Vector3Transform"          (ref Vector3, ref Vector3, ref Vector3)
    clang proc      "Vector3RotateByQuaternion" (ref Vector3, ref Vector3, ref Quaternion)
    clang proc      "Vector3Lerp"               (ref Vector3, ref Vector3, ref Vector3, real32)
    clang proc      "Vector3Reflect"            (ref Vector3, ref Vector3, ref Vector3)
    clang proc      "Vector3Min"                (ref Vector3, ref Vector3, ref Vector3)
    clang proc      "Vector3Max"                (ref Vector3, ref Vector3, ref Vector3)
    clang proc      "Vector3Barycenter"         (ref Vector3, ref Vector3, ref Vector3, ref Vector3, ref Vector3)
    clang function  "Vector3ToFloatV"           (ref Vector3)float3

    !Matrix math
    clang function  "MatrixDeterminant"             (ref Matrix)real32
    clang function  "MatrixTrace"                   (ref Matrix)real32
    clang proc      "MatrixTranspose"               (ref Matrix, ref Matrix)
    clang proc      "MatrixInvert"                  (ref Matrix, ref Matrix)
    clang proc      "MatrixNormalize"               (ref Matrix, ref Matrix)
    clang proc      "MatrixIdentity"                (ref Matrix)
    clang proc      "MatrixAdd"                     (ref Matrix, ref Matrix, ref Matrix)
    clang proc      "MatrixSubtract"                (ref Matrix, ref Matrix, ref Matrix)
    clang proc      "MatrixTranslate"               (ref Matrix, real32, real32, real32)
    clang proc      "MatrixRotate"                  (ref Matrix, ref Matrix, real32)
    clang proc      "MatrixRotateXYZ"               (ref Matrix, ref Vector3)
    clang proc      "MatrixRotateX"                 (ref Matrix, real32)
    clang proc      "MatrixRotateY"                 (ref Matrix, real32)
    clang proc      "MatrixRotateZ"                 (ref Matrix, real32)
    clang proc      "MatrixScale"                   (ref Matrix, real32, real32, real32)
    clang proc      "MatrixMultiply"                (ref Matrix, ref Matrix, ref Matrix)
    clang proc      "MatrixFrustum"                 (ref Matrix, real64, real64, real64, real64, real64, real64)
    clang proc      "MatrixPerspective"             (ref Matrix, real64, real64, real64, real64)
    clang proc      "MatrixOrtho"                   (ref Matrix, real64, real64, real64, real64, real64, real64)
    clang proc      "MatrixLookAt"                  (ref Matrix, ref Vector3, ref Vector3, ref Vector3)
    clang function  "MatrixToFloatV"                (ref Matrix)float16

    !Quaternion math
    clang proc      "QuaternionIdentity"            (ref Quaternion)
    clang function  "QuaternionLength"              (ref Quaternion)real32
    clang proc      "QuaternionNormalize"           (ref Quaternion, ref Quaternion)
    clang proc      "QuaternionInvert"              (ref Quaternion, ref Quaternion)
    clang proc      "QuaternionMultiply"            (ref Quaternion, ref Quaternion, ref Quaternion)
    clang proc      "QuaternionLerp"                (ref Quaternion, ref Quaternion, ref Quaternion, real32)
    clang proc      "QuaternionNlerp"               (ref Quaternion, ref Quaternion, ref Quaternion, real32)
    clang proc      "QuaternionSlerp"               (ref Quaternion, ref Quaternion, ref Quaternion, real32)
    clang proc      "QuaternionFromVector3ToVector3"(ref Quaternion, ref Vector3, ref Vector3)
    clang proc      "QuaternionFromMatrix"          (ref Quaternion, ref Matrix)
    clang proc      "QuaternionToMatrix"            (ref Matrix, ref Quaternion)
    clang proc      "QuaternionFromAxisAngle"       (ref Quaternion, ref Vector3, real32)
    clang proc      "QuaternionToAxisAngle"         (ref Quaternion, ref Vector3, ref real32)
    clang proc      "QuaternionFromEuler"           (ref Quaternion, real32, real32, real32)
    clang proc      "QuaternionToEuler"             (ref Vector3, ref Quaternion)
    clang proc      "QuaternionTransform"           (ref Quaternion, ref Quaternion, ref Matrix)

    !rlgl functions

    !Matrix operations
    clang proc      "rlMatrixMode"                  (int32)
    clang proc      "rlPushMatrix"                  ()
    clang proc      "rlPopMatrix"                   ()
    clang proc      "rlLoadIdentity"                ()
    clang proc      "rlTranslatef"                  (real32, real32, real32)
    clang proc      "rlRotatef"                     (real32, real32, real32, real32)
    clang proc      "rlScalef"                      (real32, real32, real32)
    clang proc      "rlMultMatrixf"                 (ref real32)                        ! ref[0:]real32?
    clang proc      "rlFrustum"                     (real64, real64, real64, real64, real64, real64)
    clang proc      "rlOrtho"                       (real64, real64, real64, real64, real64, real64)
    clang proc      "rlViewport"                    (int32, int32, int32, int32)

    !vertex level operations
    clang proc      "rlBegin"                       (int32)
    clang proc      "rlEnd"                         ()
    clang proc      "rlVertex2i"                    (int32, int32)
    clang proc      "rlVectex2f"                    (real32, real32)
    clang proc      "rlVectex3f"                    (real32, real32, real32)
    clang proc      "rlTexCoord2f"                  (real32, real32)
    clang proc      "rlNormal3f"                    (real32, real32, real32)
    clang proc      "rlColor4ub"                    (byte, byte, byte, byte)
    clang proc      "rlColor3f"                     (real32, real32, real32)
    clang proc      "rlColor4f"                     (real32, real32, real32, real32)

    !OpenGL equivalent functions
    clang proc      "rlEnableTexture"               (u32)
    clang proc      "rlDisableTexture"              ()
    clang proc      "rlTextureParameters"           (u32, int32, int32)
    clang proc      "rlEnableRenderTexture"         (u32)
    clang proc      "rlDisableRenderTexture"        ()
    clang proc      "rlEnableDepthTest"             ()
    clang proc      "rlDisableDepthTest"            ()
    clang proc      "rlEnableBackfaceCulling"       ()
    clang proc      "rlDisableBackfaceCulling"      ()
    clang proc      "rlEnableScissorTest"           ()
    clang proc      "rlDisableScissorTest"          ()
    clang proc      "rlScissor"                     (int32, int32, int32, int32)
    clang proc      "rlEnableWireMode"              ()
    clang proc      "rlDisableWireMode"             ()
    clang proc      "rlDeleteTextures"              (u32)
    clang proc      "rlDeleteRenderTextures"        (ref RenderTexture2D)
    clang proc      "rlDeleteShader"                (u32)
    clang proc      "rlDeleteVertexArrays"          (u32)
    clang proc      "rlDeleteBuffers"               (u32)
    clang proc      "rlClearColor"                  (byte, byte, byte, byte)
    clang proc      "rlClearScreenBuffers"          ()
    clang proc      "rlUpdateBuffer"                (int32, ref[0:]void, int32)
    clang function  "rlLoadAttribBuffer"            (u32, int32, ref[0:]void, int32, byte)u32

    !rlgl functionality
    clang proc      "rlglInit"                      (int32, int32)
    clang proc      "rlglClose"                     ()
    clang proc      "rlglDraw"                      ()

    clang function  "rlglGetVersion"                ()int32
    clang function  "rlCheckBufferLimit"            (int32)byte
    clang proc      "rlSetDebugMarker"              (ref[0:]char)
    clang proc      "rlLoadExtensions"              (ref void)
    clang proc      "rlUnproject"                   (ref Vector3, ref Vector3, ref Matrix, ref Matrix)
    
    clang function  "rlLoadTexture"                 (ref void, int32, int32, int32, int32)u32
    clang function  "rlLoadTextureDepth"            (int32, int32, int32, byte)u32
    clang function  "rlLoadTextureCubemap"          (ref void, int32, int32)u32
    clang proc      "rlUpdateTexture"               (u32, int32, int32, int32, ref[0:]void)
    clang proc      "rlGetGlTextureFormats"         (int32, ref u32, ref u32, ref u32)      ! ref[0:]u32?
    clang proc      "rlUnloadTexture"               (u32)

    clang proc      "rlGenerateMipmaps"             (ref Texture2D)
    clang function  "rlReadTexturePixels"           (ref Texture2D)ref[0:]void
    clang function  "rlReadScreenPixels"            (int32, int32)ref[0:]u32

    clang proc      "rlLoadRenderTexture"           (ref RenderTexture2D, int32, int32, int32, int32, byte)
    clang proc      "rlRenderTextureAttach"         (ref RenderTexture, u32, int32)
    clang function  "rlRenderTextureComplete"       (ref RenderTexture)byte

    clang proc      "rlLoadMesh"                    (ref Mesh, byte)
    clang proc      "rlUpdateMesh"                  (ref Mesh, int32, int32)
    clang proc      "rlUpdateMeshAt"                (ref Mesh, int32, int32, int32)
    clang proc      "rlDrawMesh"                    (ref Mesh, ref Material, ref Matrix)
    clang proc      "rlUnloadMesh"                  (ref Mesh)
end