import* raylib

record Player=
    Vector2 pos
    Vector2 spd
    int radius
end

record Enemy=
    Vector2 pos
    Vector2 spd
    int radius
    int radiusBounds
    byte moveRight
end

record Points=
    Vector2 pos
    int radius
    int val
    byte active
end

record Home=
    Rectangle rec
    byte active
    byte save
    Color col
end

global const int screenWidth=800
global const int screenHeight=450

global byte gameOver=0
global byte pause=0
global int score=0
global int hiScore=0

global Player plyr
global Enemy en
global Points pts
global Home hm
global byte follow=0

proc start=
    InitWindow(screenWidth, screenHeight, "sample game: gold fever")

    InitGame()

    SetTargetFPS(60)

    while not WindowShouldClose() do
        UpdateDrawFrame()
    od

    CloseWindow()
end

proc InitGame=
    pause:=0
    score:=0

    plyr.pos:=(50,50)
    plyr.radius:=20
    plyr.spd:=(5,5)

    en.pos:=(screenWidth-50,screenHeight/2)
    en.radius:=20
    en.radiusBounds:=150
    en.spd:=(3,3)
    en.moveRight:=1
    follow:=0

    pts.radius:=10
    pts.pos:=(GetRandomValue(pts.radius, screenWidth-pts.radius), GetRandomValue(pts.radius, screenHeight-pts.radius))
    pts.val:=100
    pts.active:=1

    hm.rec.width:=50
    hm.rec.height:=50
    hm.rec.x:=GetRandomValue(0, screenWidth-hm.rec.width)
    hm.rec.y:=GetRandomValue(0, screenHeight-hm.rec.height)
    hm.active:=0
    hm.save:=0
end

proc UpdateGame=
    if not gameOver then
        if IsKeyPressed(KEY_P) then pause:=abs(pause-1) fi

        if not pause then
            if IsKeyDown(KEY_RIGHT) then plyr.pos.x+:=plyr.spd.x fi
            if IsKeyDown(KEY_LEFT) then plyr.pos.x-:=plyr.spd.x fi
            if IsKeyDown(KEY_UP) then plyr.pos.y-:=plyr.spd.y fi
            if IsKeyDown(KEY_DOWN) then plyr.pos.y+:=plyr.spd.y fi

            if plyr.pos.x-plyr.radius<=0 then plyr.pos.x:=plyr.radius fi
            if plyr.pos.x+plyr.radius>=screenWidth then plyr.pos.x:=screenWidth-plyr.radius fi
            if plyr.pos.y-plyr.radius<=0 then plyr.pos.y:=plyr.radius fi
            if plyr.pos.y+plyr.radius>=screenHeight then plyr.pos.y:=screenHeight-plyr.radius fi

            if follow or CheckCollisionCircles(plyr.pos, plyr.radius, en.pos, en.radiusBounds) then
                if plyr.pos.x>en.pos.x then en.pos.x+:=en.spd.x fi
                if plyr.pos.x<en.pos.x then en.pos.x-:=en.spd.x fi
                
                if plyr.pos.y>en.pos.y then en.pos.y+:=en.spd.y fi
                if plyr.pos.y<en.pos.y then en.pos.y-:=en.spd.y fi
            else
                if en.moveRight then en.pos.x+:=en.spd.x
                else en.pos.x-:=en.spd.x fi
            fi

            if en.pos.x-en.radius<=0 then en.moveRight:=1 fi
            if en.pos.x+en.radius>=screenWidth then en.moveRight:=0 fi
            
            if en.pos.x-en.radius<=0 then en.pos.x:=en.radius fi
            if en.pos.x+en.radius>=screenWidth then en.pos.x:=screenWidth-en.radius fi
            if en.pos.y-en.radius<=0 then en.pos.y:=en.radius fi
            if en.pos.y+en.radius>=screenHeight then en.pos.y:=screenHeight-en.radius fi
            
            if CheckCollisionCircles(plyr.pos, plyr.radius, pts.pos, pts.radius) and pts.active then
                follow:=1
                pts.active:=0
                hm.active:=1
            fi
            
            if CheckCollisionCircles(plyr.pos, plyr.radius, en.pos, en.radius) and not hm.save then
                gameOver:=1

                if hiScore<score then hiScore:=score fi
            fi

            if CheckCollisionCircleRec(plyr.pos, plyr.radius, &hm.rec) then
                follow:=0

                if not pts.active then
                    score+:=pts.val
                    pts.active:=1
                    en.spd.x+:=0.5
                    en.spd.y+:=0.5
                    pts.pos:=(GetRandomValue(pts.radius, screenWidth-pts.radius), GetRandomValue(pts.radius, screenHeight-pts.radius))
                fi
                
                hm.save:=1
            else hm.save:=0 fi
        fi
    else
        if IsKeyPressed(KEY_ENTER) then
            InitGame()
            gameOver:=0
        fi
    fi
end

proc DrawGame=
    BeginDrawing()

        ClearBackground(RAYWHITE)

        if not gameOver then
            if follow then
                DrawRectangle(0, 0, screenWidth, screenHeight, RED)
                DrawRectangle(10, 10, screenWidth-20, screenHeight-20, RAYWHITE)
            fi

            DrawRectangleLines(hm.rec.x, hm.rec.y, hm.rec.width, hm.rec.height, BLUE)

            DrawCircleLines(en.pos.x, en.pos.y, en.radiusBounds, RED)
            DrawCircleV(en.pos, en.radius, MAROON)

            DrawCircleV(plyr.pos, plyr.radius, GRAY)
            if pts.active then DrawCircleV(pts.pos, pts.radius, GOLD) fi

            DrawText(TextFormat("SCORE: %04i", score), 20, 15, 20, GRAY)
            DrawText(TextFormat("HI-SCORE: %04i", hiScore), 300, 15, 20, GRAY)

            if pause then DrawText("GAME PAUSED", screenWidth/2-MeasureText("GAME PAUSED",40)/2, screenHeight/2-40, 40, GRAY) fi
        else DrawText("PRESS [ENTER] TO PLAY AGAIN", GetScreenWidth()/2-MeasureText("PRESS [ENTER] TO PLAY AGAIN",20)/2, GetScreenHeight()/2-50, 20, GRAY) fi
    
    EndDrawing()
end

proc UpdateDrawFrame=
    UpdateGame()
    DrawGame()
end