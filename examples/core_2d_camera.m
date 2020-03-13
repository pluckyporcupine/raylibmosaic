import* raylib

const int MAX_BUILDINGS=100

proc start=
    const int screenWidth=800
    const int screenHeight=450

    InitWindow(screenWidth, screenHeight, cast("raylib [core] example - 2d camera"))

    Rectangle player:=(400, 280, 40, 40)

    static [0:MAX_BUILDINGS]Rectangle buildings
    static [0:MAX_BUILDINGS]Color buildColors

    int spacing:=0

    for i:=0 to MAX_BUILDINGS-1 do
        buildings[i].width:=GetRandomValue(50,200)
        buildings[i].height:=GetRandomValue(100,800)
        buildings[i].y:=screenHeight-130-buildings[i].height
        buildings[i].x:=-6000+spacing

        spacing+:=buildings[i].width
        buildColors[i]:=(GetRandomValue(200,240),GetRandomValue(200,240),GetRandomValue(200,250),255)
    od

    Camera2D camera:=( (player.x+20, player.y+20), (screenWidth/2, screenHeight/2), 0.0, 1.0 )

    SetTargetFPS(60)

    while not WindowShouldClose() do
        if IsKeyDown(KEY_RIGHT) then player.x+:=2
        elsif IsKeyDown(KEY_LEFT) then player.x-:=2 fi

        camera.target.x:=player.x+20
        camera.target.y:=player.y+20

        if IsKeyDown(KEY_A) then camera.rotation-:=1
        elsif IsKeyDown(KEY_S) then camera.rotation+:=1 fi

        if camera.rotation>40 then camera.rotation:=40
        elsif camera.rotation<-40 then camera.rotation:=-40 fi

        camera.zoom+:=GetMouseWheelMove()*0.05

        if IsKeyPressed(KEY_R) then
            camera.zoom:=1.0
            camera.rotation:=0.0
        fi

        BeginDrawing()

            ClearBackground(RAYWHITE)

            BeginMode2D(&camera)

                DrawRectangle(-6000,320,13000,8000,DARKGRAY)

                for i:=0 to MAX_BUILDINGS-1 do
                    DrawRectangleRec(&buildings[i],buildColors[i])
                od

                DrawRectangleRec(&player,RED)

                DrawLine(camera.target.x,-screenHeight*10,camera.target.x,screenHeight*10,GREEN)
                DrawLine(-screenWidth*10,camera.target.y,screenWidth*10,camera.target.y,GREEN)
            
            EndMode2D()

            DrawText(cast("SCREEN AREA"),640,10,20,RED)

            DrawRectangle(0,0,screenWidth,5,RED)
            DrawRectangle(0,5,5,screenHeight-10,RED)
            DrawRectangle(screenWidth-5,5,5,screenHeight-10,RED)
            DrawRectangle(0,screenHeight-5,screenWidth,5,RED)

            DrawRectangle(10,10,250,113,Fade(SKYBLUE,0.5))
            DrawRectangleLines(10,10,250,113,BLUE)

            DrawText(cast("Free 2d camera controls:"),20,20,10,BLACK)
            DrawText(cast("- Right/Left to move Offset"),40,40,10,DARKGRAY)
            DrawText(cast("- Mouse Wheel to Zoom in-out"),40,60,10,DARKGRAY)
            DrawText(cast("- A/S to Rotate"),40,80,10,DARKGRAY)
            DrawText(cast("- R to reset Zoom and Rotation"),40,100,10,DARKGRAY)

        EndDrawing()
    od
end