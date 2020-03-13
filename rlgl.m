import rlcommon

!basic structs
global record VrStereoConfig= $caligned
    Shader distortionShader
    ref[2]Matrix eyesProjection
    ref[2]Matrix eyesViewOffset
    [4]int32 eyeViewportRight
    [4]int32 eyeViewportLeft
end

importdll raylib=
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