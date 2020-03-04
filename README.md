# raylib-mosaic

These are work-in-progress Mosaic bindings for [the raylib gamedev library](https://github.com/raysan5/raylib). These bindings are made for only confirmed to be working with raylib-2.6.0.

You can find more information about Mosaic [here](https://github.com/sal55/langs/blob/master/Mosaic/readme.md).

## Work in progress

These bindings are still a work in progress. They are not battle-tested at all. They compile and the core_2d_camera example works, but there are bound to be plenty of things that don't work as expected. These bindings were hand-written and not all of the type signatures have been verified. Furthermore, `TraceLogCallback` is likely not fully implemented.

~~**Addendum:** I've already found a significant number of type mismatches. For the time being, assume that only what has been used in the published translations of examples works properly. Quite a lot more will likely work, but there is also a chance that it won't. If you find any errors, please either post an issue or submit a pull request with a fix.~~

**Update 2/29/2020:** While these are not yet battle-tested, the functions that *are* confirmed to work have been tested quite a bit at this point. There is a high probability that a large subset of the raylib library will work, but I can't say for sure just yet. As noted above, post an issue or submit a pull request if necessary.

## Quirks

Due to reserved words and differences in calling conventions, there are a few quirks.

* Records (structs) of <=8 bytes that are passed to a C function must be passed by value. All others must be passed by reference. The compiler should help you in remembering this. For further clarity, compiling with the option `-recs` will show you all records in your code and their sizes. Records of <=8 bytes are marked with an `S`.

* The names of several struct members have been changed to avoid namespace conflicts with reserved words. The changes are as follows:
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

Alternatively, you could build your own raygui DLL and change `importdll raylib` on line 1488 of raylib.m to `importdll raygui`. The bindings for raylib and raygui are intentionally being kept separate for the time being for this purpose.

I have not yet written bindings for any of raylib's other modules.

All bindings are in raylib.m.

## Quick compile

I've added a `compileall.bat` script that will compile all of the examples that have been translated to Mosaic thus far and copy them into a folder called `bin`, along with a copy of the included raylib DLL.

There are currently two caveats:

  1. Until I can figure out a good solution for the examples that require resources, the script only compiles the examples that do not require external resources.
  2. The script assumes that `mm.exe` is somewhere in your path. As it is a single-file compiler, it is not difficult to add to your path.