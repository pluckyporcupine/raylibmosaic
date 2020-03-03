import raylib

proc start=
    int screenWidth:=800
    int screenHeight:=450

    InitWindow(screenWidth, screenHeight, "raylib [shapes] example - draw ring")

    Vector2 center:=( (GetScreenWidth()-300)/2, GetScreenHeight()/2 )

    real32 innerRadius:=80.0
    real32 outerRadius:=190.0

    int startAngle:=0
    int endAngle:=360
    int segments:=0

    byte drRi:=1
    byte drRiLi:=0
    byte drCiLi:=0

    SetTargetFPS(60)

    while not WindowShouldClose() do
        BeginDrawing()

            ClearBackground(RAYWHITE)

            DrawLine(500, 0, 500, GetScreenHeight(), Fade(LIGHTGRAY,0.6))
            DrawRectangle(500, 0, GetScreenWidth()-500, GetScreenHeight(), Fade(LIGHTGRAY,0.3))

            if drRi then DrawRing(center, innerRadius, outerRadius, startAngle, endAngle, segments, Fade(MAROON, 0.3)) fi
            if drRiLi then DrawRingLines(center, innerRadius, outerRadius, startAngle, endAngle, segments, Fade(BLACK, 0.4)) fi
            if drCiLi then DrawCircleSectorLines(center, outerRadius, startAngle, endAngle, segments, Fade(BLACK, 0.4)) fi

            Rectangle startRec:=(600,40,120,20)
            startAngle:=GuiSliderBar(&startRec, "StartAngle", "", startAngle, -450, 450)
            Rectangle endRec:=(600,70,120,20)
            endAngle:=GuiSliderBar(&endRec, "EndAngle", "", endAngle, -450, 450)
            
            Rectangle innerRec:=(600,140,120,20)
            innerRadius:=GuiSliderBar(&innerRec, "InnerRadius", "", innerRadius, 0, 100)
            Rectangle outerRec:=(600,170,120,20)
            outerRadius:=GuiSliderBar(&outerRec, "OuterRadius", "", outerRadius, 0, 200)

            Rectangle segRec:=(600,240,120,20)
            segments:=GuiSliderBar(&segRec, "Segments", "", segments, 0, 100)

            Rectangle recDR:=(600,320,20,20)
            drRi:=GuiCheckBox(&recDR, "Draw Ring", drRi)
            Rectangle recDRL:=(600,350,20,20)
            drRiLi:=GuiCheckBox(&recDRL, "Draw RingLines", drRiLi)
            Rectangle recDCL:=(600,380,20,20)
            drCiLi:=GuiCheckBox(&recDCL, "Draw CircleLines", drCiLi)

            DrawText(TextFormat("MODE: %s", (segments>=4|"MANUAL"|"AUTO")), 600, 270, 10, (segments>=4|MAROON|DARKGRAY))

            DrawFPS(10,10)

        EndDrawing()
    od

    CloseWindow()
end