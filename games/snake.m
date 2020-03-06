import raylib

!defines
global const int SNAKE_LENGTH=256
global const int SQUARE_SIZE=31

!structs
record Snake=
    Vector2 position
    Vector2 size
    Vector2 speed
    Color col
end

record Food=
    Vector2 position
    Vector2 size
    byte active
    Color col
end

!global vars
global const int screenWidth=800
global const int screenHeight=450

global int framesCounter=0
global byte gameOver=0
global byte pause=0

global Food fruit
global [0:SNAKE_LENGTH]Snake snek
global [0:SNAKE_LENGTH]Vector2 snekPos
global byte allowMove=0
global Vector2 offset
global int counterTail=0

proc start=
    InitWindow(screenWidth, screenHeight, "sample game: snake")

    InitGame()

    SetTargetFPS(60)

    while not WindowShouldClose() do
        UpdateDrawFrame()
    od

    UnloadGame()

    CloseWindow()
end

proc InitGame=
    framesCounter:=0
    gameOver:=0
    pause:=0

    counterTail:=1
    allowMove:=0

    offset.x:=screenWidth rem SQUARE_SIZE
    offset.y:=screenHeight rem SQUARE_SIZE

    for i:=0 to SNAKE_LENGTH-1 do
        snek[i].position:=(offset.x/2,offset.y/2)
        snek[i].size:=(SQUARE_SIZE,SQUARE_SIZE)
        snek[i].speed:=(SQUARE_SIZE,0)

        if not i then snek[i].col:=DARKBLUE
        else snek[i].col:=BLUE fi
    od
    
    Vector2 fruitSize:=(SQUARE_SIZE,SQUARE_SIZE)
    fruit.size:=fruitSize
    fruit.col:=SKYBLUE
    fruit.active:=0
end

proc UpdateGame=
    if not gameOver then
        if IsKeyPressed(KEY_P) then pause:=abs(pause-1) fi

        if not pause then
            if IsKeyPressed(KEY_RIGHT) and snek[0].speed.x=0 and allowMove then
                Vector2 snekSpd:=(SQUARE_SIZE,0)
                snek[0].speed:=snekSpd
                allowMove:=0
            fi
            if IsKeyPressed(KEY_LEFT) and snek[0].speed.x=0 and allowMove then
                Vector2 snekSpd2:=(-SQUARE_SIZE,0)
                snek[0].speed:=snekSpd2
                allowMove:=0
            fi
            if IsKeyPressed(KEY_UP) and snek[0].speed.y=0 and allowMove then
                Vector2 snekSpd3:=(0, -SQUARE_SIZE)
                snek[0].speed:=snekSpd3
                allowMove:=0
            fi
            if IsKeyPressed(KEY_DOWN) and snek[0].speed.y=0 and allowMove then
                Vector2 snekSpd4:=(0, SQUARE_SIZE)
                snek[0].speed:=snekSpd4
                allowMove:=0
            fi

            for i:=0 to counterTail-1 do snekPos[i]:=snek[i].position od

            if not (framesCounter rem 5) then
                for i:=0 to counterTail-1 do
                    if not i then
                        snek[0].position.x+:=snek[0].speed.x
                        snek[0].position.y+:=snek[0].speed.y
                        allowMove:=1
                    else snek[i].position:=snekPos[i-1] fi
                od
            fi

            if snek[0].position.x>screenWidth-offset.x or \
               snek[0].position.y>screenHeight-offset.y or \
               snek[0].position.x<0 or \
               snek[0].position.y<0 then
                gameOver:=1
            fi

            for i:=1 to counterTail-1 do
                if snek[0].position.x=snek[i].position.x and \
                   snek[0].position.y=snek[i].position.y then
                    gameOver:=1
                fi
            od

            if not fruit.active then
                fruit.active:=1
                Vector2 fruitPos:=(GetRandomValue(0, (screenWidth/SQUARE_SIZE)-1)*SQUARE_SIZE+offset.x/2, GetRandomValue(0, (screenHeight/SQUARE_SIZE)-1)*SQUARE_SIZE+offset.y/2)
                fruit.position:=fruitPos

                for i:=0 to counterTail-1 do
                    while fruit.position.x=snek[i].position.x and fruit.position.y=snek[i].position.y do
                        Vector2 fruitPos2:=(GetRandomValue(0, (screenWidth/SQUARE_SIZE)-1)*SQUARE_SIZE+offset.x/2, GetRandomValue(0, (screenHeight/SQUARE_SIZE)-1)*SQUARE_SIZE+offset.y/2)
                        fruit.position:=fruitPos2
                        restart all
                    od
                od
            fi

            if snek[0].position.x<fruit.position.x+fruit.size.x and \
               snek[0].position.x+snek[0].size.x>fruit.position.x and \
               snek[0].position.y<fruit.position.y+fruit.size.y and \
               snek[0].position.y+snek[0].size.y>fruit.position.y then
                snek[counterTail].position:=snekPos[counterTail-1]
                counterTail+:=1
                fruit.active:=0
            fi

            ++framesCounter
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

        Vector2 dL1, dL2

        if not gameOver then
            for i:=0 to screenWidth/SQUARE_SIZE do
                dL1.x:=SQUARE_SIZE*i+offset.x/2
                dL1.y:=offset.y/2
                dL2.x:=SQUARE_SIZE*i+offset.x/2
                dL2.y:=screenHeight-offset.y/2
                DrawLineV(dL1, dL2, LIGHTGRAY)
            od
            for i:=0 to screenHeight/SQUARE_SIZE do
                dL1.x:=offset.x/2
                dL1.y:=SQUARE_SIZE*i+offset.y/2
                dL2.x:=screenWidth-offset.x/2
                dL2.y:=SQUARE_SIZE*i+offset.y/2
                DrawLineV(dL1, dL2, LIGHTGRAY)
            od

            for i:=0 to counterTail-1 do DrawRectangleV(snek[i].position, snek[i].size, snek[i].col) od

            DrawRectangleV(fruit.position, fruit.size, fruit.col)

            if pause then DrawText("GAME PAUSED", screenWidth/2-MeasureText("GAME PAUSED",40)/2, screenHeight/2-40, 40, GRAY) fi
        else
            DrawText("PRESS [ENTER] TO PLAY AGAIN", GetScreenWidth()/2-MeasureText("PRESS [ENTER] TO PLAY AGAIN", 20)/2, GetScreenHeight()/2-50, 20, GRAY)
        fi

    EndDrawing()
end

proc UnloadGame=

end

proc UpdateDrawFrame=
    UpdateGame()
    DrawGame()
end