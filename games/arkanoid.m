import clib
import raylib

!some defines
global const int PLAYER_MAX_LIFE=5
global const int LINES_OF_BRICKS=5
global const int BRICKS_PER_LINE=20

!types and structures definitions
enum ( LOGO, TITLE, GAMEPLAY, ENDING )

record Player=
    Vector2 position
    Vector2 size
    int life
end

record Ball=
    Vector2 position
    Vector2 speed
    int radius
    int active
end

record Brick=
    Vector2 position
    int active
end

!global var declarations
global const int screenWidth=800
global const int screenHeight=450

global int gameOver=0
global int pause=0

global Player pl
global Ball ba
global [0:LINES_OF_BRICKS,0:BRICKS_PER_LINE]Brick br
global Vector2 brickSize

proc start=
    InitWindow(screenWidth, screenHeight, "sample game: arkanoid")

    InitGame()

    SetTargetFPS(60)

    while not WindowShouldClose() do
        UpdateDrawFrame()
    od

    UnloadGame()

    CloseWindow()
end

proc InitGame()=
    brickSize:=( GetScreenWidth()/BRICKS_PER_LINE, 40 )

    pl.position:=( screenWidth/2, screenHeight*7/8 )
    pl.size:=( screenWidth/10, 20 )
    pl.life:=PLAYER_MAX_LIFE

    ba.position:=( screenWidth/2, screenHeight*7/8 - 30 )
    ba.speed:=(0,0)
    ba.radius:=7
    ba.active:=0

    int initialDownPosition:=50

    for i:=0 to LINES_OF_BRICKS-1 do
        for j:=0 to BRICKS_PER_LINE-1 do
            br[i,j].position:=( j*brickSize.x + brickSize.x/2, i*brickSize.y + initialDownPosition )
            br[i,j].active:=1
        od
    od
end

proc UpdateGame()=
    if not gameOver then
        if IsKeyPressed(KEY_P) then pause:=abs(pause-1) fi

        if not pause then
            if IsKeyDown(KEY_LEFT) then pl.position.x-:=5
            elsif IsKeyDown(KEY_RIGHT) then pl.position.x+:=5 fi
            if (pl.position.x-pl.size.x/2) <= 0 then pl.position.x:=pl.size.x/2 fi
            if (pl.position.x+pl.size.x/2) >= screenWidth then pl.position.x:=screenWidth-pl.size.x/2 fi

            if not ba.active then
                if IsKeyPressed(KEY_SPACE) then
                    ba.active:=1
                    ba.speed:=( 0, -5 )
                fi
            fi

            if ba.active then
                ba.position.x+:=ba.speed.x
                ba.position.y+:=ba.speed.y
            else
                ba.position:=( pl.position.x, screenHeight*7/8-30 )
            fi

            if ba.position.x+ba.radius>=screenWidth or ba.position.x-ba.radius<=0 then ba.speed.x*:=-1 fi
            if ba.position.y-ba.radius<=0 then ba.speed.y*:=-1 fi
            if ba.position.y+ba.radius>=screenHeight then
                ba.speed:=( 0, 0 )
                ba.active:=0

                --pl.life
            fi

            Rectangle plRe:=( pl.position.x-pl.size.x/2, pl.position.y-pl.size.y/2, pl.size.x, pl.size.y )
            if CheckCollisionCircleRec(ba.position, ba.radius, &plRe) then
                if ba.speed.y>0 then
                    ba.speed.y*:=-1
                    ba.speed.x:=(ba.position.x-pl.position.x)/(pl.size.x/2)*5
                fi
            fi

            for i:=0 to LINES_OF_BRICKS-1 do
                for j:=0 to BRICKS_PER_LINE-1 do
                    if br[i,j].active then
                        if ba.position.y-ba.radius <= br[i,j].position.y+brickSize.y/2 and
                           ba.position.y-ba.radius > br[i,j].position.y+brickSize.y/2+ba.speed.y and
                           abs(ba.position.x-br[i,j].position.x) < brickSize.x/2+ba.radius*2/3 and
                           ba.speed.y<0 then
                            br[i,j].active:=0
                            ba.speed.y*:=-1
                        elsif ba.position.y+ba.radius >= br[i,j].position.y-brickSize.y/2 and
                              ba.position.y+ba.radius < br[i,j].position.y-brickSize.y/2+ba.speed.y and
                              abs(ba.position.x-br[i,j].position.x) < brickSize.x/2+ba.radius*2/3 and
                              ba.speed.y > 0 then
                                br[i,j].active:=0
                                ba.speed.y*:=-1
                        elsif ba.position.x+ba.radius >= br[i,j].position.x-brickSize.x/2 and
                              ba.position.x+ba.radius < br[i,j].position.x-brickSize.x/2+ba.speed.x and
                              abs(ba.position.y-br[i,j].position.y) < brickSize.y/2+ba.radius*2/3 and
                              ba.speed.x > 0 then
                                br[i,j].active:=0
                                ba.speed.x*:=-1
                        elsif ba.position.x-ba.radius <= br[i,j].position.x+brickSize.x/2 and
                              ba.position.x-ba.radius > br[i,j].position.x+brickSize.x/2+ba.speed.x and
                              abs(ba.position.y-br[i,j].position.y) < brickSize.y/2+ba.radius*2/3 and
                              ba.speed.x < 0 then
                                br[i,j].active:=0
                                ba.speed.x*:=-1
                        fi
                    fi
                od
            od

            if pl.life <= 0 then gameOver:=1
            else
                gameOver:=1

                for i:=0 to LINES_OF_BRICKS-1 do
                    for j:=0 to BRICKS_PER_LINE-1 do
                        if br[i,j].active then
                            gameOver:=0
                        fi
                    od
                od
            fi
        fi
    else
        if IsKeyPressed(KEY_ENTER) then
            InitGame()
            gameOver:=0
        fi
    fi
end

proc DrawGame()=
    BeginDrawing()

        ClearBackground(RAYWHITE)

        if not gameOver then
            DrawRectangle(pl.position.x-pl.size.x/2, pl.position.y-pl.size.y/2, pl.size.x, pl.size.y, BLACK)

            for i:=0 to pl.life-1 do DrawRectangle(20+40*i, screenHeight-30, 35, 10, LIGHTGRAY) od

            DrawCircleV(ba.position, ba.radius, MAROON)

            for i:=0 to LINES_OF_BRICKS-1 do
                for j:=0 to BRICKS_PER_LINE-1 do
                    if br[i,j].active then
                        if not ((i+j) rem 2) then DrawRectangle(br[i,j].position.x-brickSize.x/2,
                                                                br[i,j].position.y-brickSize.y/2,
                                                                brickSize.x,
                                                                brickSize.y,
                                                                GRAY)
                        else DrawRectangle(br[i,j].position.x-brickSize.x/2,
                                           br[i,j].position.y-brickSize.y/2,
                                           brickSize.x,
                                           brickSize.y,
                                           DARKGRAY)
                        fi
                    fi
                od
            od

            if pause then DrawText("GAME PAUSED", screenWidth/2-MeasureText("GAME PAUSED", 40)/2,
                                   screenHeight/2-40, 40, GRAY) fi
        else DrawText("PRESS [ENTER] TO PLAY AGAIN", 
                      GetScreenWidth()/2-MeasureText("PRESS [ENTER] TO PLAY AGAIN", 20)/2,
                      GetScreenHeight()/2-50, 20, GRAY)
        fi
    EndDrawing()
end

proc UnloadGame()=
    !not implemented
end

proc UpdateDrawFrame()=
    UpdateGame()
    DrawGame()
end