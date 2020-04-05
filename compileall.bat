@echo off

if NOT exist bin\nul (
    mkdir bin
    REM copy /b raylib.dll bin
)

for /f "tokens=*" %%a in (examples.txt) do (
    mm %%a
    copy "%%a.exe" bin
    del "%%a.exe"
)