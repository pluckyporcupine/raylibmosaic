# raylib-mosaic

These are work-in-progress Mosaic bindings for [the raylib gamedev library](https://github.com/raysan5/raylib).

You can find more information about Mosaic [here](https://github.com/sal55/langs/blob/master/Mosaic/readme.md).

*Note:* The Mosaic compiler that was used for this is only available for 64-bit Windows. [A Linux version](https://github.com/sal55/langs/blob/master/mu64.c) of the compiler that is written in and compiles to C exists, but this has not been tested with it.

## Current state

Only a subset of the bindings has been tested, but that subset gives me reason to believe that most, if not all, of the bindings should work. If you find any that don't, open an issue and I will issue a fix as soon as possible.

There is tentative support for raylib 3.0, but it has not been tested as of yet.

## Quirks

Due to reserved words and differences in calling conventions, there are a few quirks.

* Due to the way that the bindings are structured, you must `import* raylib` or all modules you use (if you use multiple) rather than simply `import raylib`. This ensures that the program will not try to import `rlcommon` multiple times.

* Records (structs) of <=8 bytes that are passed to a C function must be passed by value. All others must be passed by reference. The compiler should help you in remembering this. For further clarity, compiling with the option `-recs` will show you all records in your code and their sizes. Records of <=8 bytes are marked with an `S`.

* The names of several struct members have been changed to avoid naming conflicts with reserved words. The changes are as follows:
    * max -> `max
    * min -> `min
    * type -> `type

* Due to differences in calling conventions, a reference to the variable that you want to store the data returned by any function that returns a struct in must become its first argument.

  For example:
  `Image image = LoadImage("resources/cubicmap.png");` becomes
  ```
  Image img
  LoadImage(&img,"resources/cubicmap.png")
  ```
  **Important note:** This does not apply to functions that return Color, float3, float16, or Vector2 structs because they are <=8 bytes.

## Other raylib modules

There are (poorly tested) raymath and rlgl bindings.

I have also written (also poorly tested) bindings for raygui. If you would like to use raygui, you currently need to build raylib from source and modify the Makefile to include raygui. For convenience, I have included a pre-built raylib DLL that includes raygui.

Alternatively, you could build your own raygui DLL and change `importdll raylib` on line 148 of raygui.m to `importdll raygui`.

I have not yet written bindings for any of raylib's other modules.

## Quick compile

I've added a `compileall.bat` script that will compile all of the examples that have been translated to Mosaic thus far and copy them into a folder called `bin`, along with a copy of the included raylib DLL.

There are currently two caveats:

  1. Until I can figure out a good solution for the examples that require resources, the script only compiles the examples that do not require external resources.
  2. The script assumes that `mm.exe` is somewhere in your path. As it is a single-file compiler, it is not difficult to add to your path.