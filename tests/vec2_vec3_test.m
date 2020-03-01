import raylib

proc start=
    Vector2 v2:=Vector2Add(Vector2Zero(), Vector2One())
    Vector3 v30
    Vector3Zero(&v30)
    Vector3 v31
    Vector3One(&v31)
    Vector3 v3
    Vector3Add(&v3, &v30, &v31)
    v3.y+:=2.0
    println v2.x, v2.y, v3.x, v3.y, v3.z
end