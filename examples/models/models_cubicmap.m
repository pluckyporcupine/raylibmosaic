import* raylib

proc start=
    const int screenWidth=800
    const int screenHeight=450

    InitWindow(screenWidth, screenHeight, "raylib [models] example - cubesmap loading and drawing")

    Camera cmra:=( (16.0, 14.0, 16.0), (0.0, 0.0, 0.0), (0.0, 1.0, 0.0), 45.0, 0 )

    Image img
    LoadImage(&img,"resources/cubicmap.png")
    Texture2D cubicmap
    LoadTextureFromImage(&cubicmap, &img)

    Vector3 vec1:=(1.0,1.0,1.0)
    Mesh msh
    GenMeshCubicmap(&msh, &img, &vec1)
    Model mdl
    LoadModelFromMesh(&mdl, &msh)
    
    Texture2D txtr
    LoadTexture(&txtr,"resources/cubicmap_atlas.png")
    mdl.materials[0].maps[MAP_DIFFUSE].texture:=txtr

    Vector3 mapPosition:=(-16.0, 0.0, -8.0)

    UnloadImage(&img)

    SetCameraMode(&cmra, CAMERA_ORBITAL)

    SetTargetFPS(60)

    while not WindowShouldClose() do

        UpdateCamera(&cmra)
        
        BeginDrawing()

            ClearBackground(RAYWHITE)
            
            BeginMode3D(&cmra)

                DrawModel(&mdl, &mapPosition, 1.0, WHITE)

            EndMode3D()

            int32 i:=screenWidth - cubicmap.width*4 - 20
            Vector2 cubeVec:=(i, 20)
            DrawTextureEx(&cubicmap, cubeVec, 0.0, 4.0, WHITE)
            DrawRectangleLines(i, 20, cubicmap.width*4, cubicmap.height*4, GREEN)

            DrawText("cubicmap image used to", 658, 90, 10, GRAY)
            DrawText("generate map 3d model", 658, 104, 10, GRAY)

            DrawFPS(10, 10)

        EndDrawing()
    od

    UnloadTexture(&cubicmap)
    UnloadTexture(&txtr)
    UnloadModel(&mdl)

    CloseWindow()
end