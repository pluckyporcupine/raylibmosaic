import rlcommon

!basic structs
global record float3= $caligned
    ref[3]real32 v
end

global record float16= $caligned
    ref[16]real32 v
end

importdll raylib=
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
end