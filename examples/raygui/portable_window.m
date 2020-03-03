import raylib

proc start=
    int screenWidth:=800
    int screenHeight:=600

    SetConfigFlags(FLAG_WINDOW_UNDECORATED)
    InitWindow(screenWidth, screenHeight, "raygui - portable window")

    Vector2 mousePosition
    Vector2 windowPosition:=(500,200)
    Vector2 panOffset
    byte dragWindow:=0

    SetWindowPosition(windowPosition.x, windowPosition.y)

    byte exitWindow:=0

    SetTargetFPS(60)

    while not exitWindow and not WindowShouldClose() do
        mousePosition:=GetMousePosition()

        if IsMouseButtonPressed(MOUSE_LEFT_BUTTON) then
            Rectangle colRec:=(0,0,screenWidth,20)
            if CheckCollisionPointRec(mousePosition, &colRec) then
                dragWindow:=1
                panOffset:=mousePosition
            fi
        fi

        if dragWindow then
            windowPosition.x+:=mousePosition.x-panOffset.x
            windowPosition.y+:=mousePosition.y-panOffset.y

            if IsMouseButtonReleased(MOUSE_LEFT_BUTTON) then dragWindow:=0 fi
            SetWindowPosition(windowPosition.x, windowPosition.y)
        fi

        BeginDrawing()

            ClearBackground(RAYWHITE)

            Rectangle exitRec:=(0,0,screenWidth,screenHeight)
            exitWindow:=GuiWindowBox(&exitRec, "PORTABLE WINDOW")

            DrawText(TextFormat("Mouse Position: [ %0.f, %0.f ]", mousePosition.x, mousePosition.y), 10, 40, 10, DARKGRAY)
        
        EndDrawing()
    od

    CloseWindow()
end