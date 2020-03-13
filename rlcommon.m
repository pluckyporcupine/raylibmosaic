!common structs
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

global record RenderTexture2D= $caligned
    u32 id
    Texture2D txtr
    Texture2D depth
    byte depthTexture
end

global type RenderTexture=RenderTexture2D

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

global const int MAX_SHADER_LOCATIONS=32
global const int MAX_MATERIAL_MAPS=12

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

global record Camera3D= $caligned
    Vector3 position
    Vector3 target
    Vector3 up
    r32 fovy
    int32 `type
end

global type Camera=Camera3D

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

!common enums
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
    BLEND_ALPHA             = 0,
    BLEND_ADDITIVE,
    BLEND_MULTIPLIED )

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