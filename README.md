# raylib-mosaic

These are work-in-progress Mosaic bindings for [the raylib gamedev library](https://github.com/raysan5/raylib).

You can download the compiler here: http://www.bcas.freeuk.com/mm.exe

The latest source release can be found here: https://github.com/sal55/langs/tree/master/sources

## Work in progress

These bindings are still a work in progress. They are not battle-tested at all. They compile and the core_2d_camera example works, but there are bound to be plenty of things that don't work as expected. These bindings were hand-written and not all of the type signatures have been verified. Furthermore, `TraceLogCallback` is likely not fully implemented.

Addendum: I've already found a significant number of type mismatches. For the time being, assume that only what has been used in the published translations of examples works properly. Quite a lot more will likely work, but there is also a chance that it won't. If you find any errors, please either post an issue or submit a pull request with a fix.

## Quirks

Due to reserved words and differences in calling conventions, there are a few quirks.

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

  This does not apply to `Col` and `Vec2`, as they are passed back and forth as 32-bit unsigned integers.

## raymath and rlgl

I have not yet created bindings for raymath or rlgl.
