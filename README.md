# raylib-M

These are work-in-progress M bindings for the raylib gamedev library. M is an ALGOL- and Pascal-inspired low-level programming language that was designed by its creator as an alternative to C for systems programming. It has been used by its creator since the 80s and quite a bit of attention has been paid to making sure that code is clear.

You can download the compiler here: http://www.bcas.freeuk.com/mm.exe
The latest source release can be found here: https://github.com/sal55/langs/tree/master/sources

## Work in progress

These bindings are still a work in progress. They are not battle-tested at all. They compile and the core_2d_camera example works, but there are bound to be plenty of things that don't work as expected. These bindings were hand-written and not all of the type signatures have been verified.

## Quirks

Due to differences in namespace handling (M is case-sensitive) and the fact that M does not currently support passing a record (struct) to a C function by value, there are a few quirks.

* Because Color and Vector2 records are always 8 bytes or less in size, they are always passed by value, rather than automatically being passed by reference. As such, there are several compatibility functions to convert them to and from 32-bit unsigned integers so that they can properly be passed to C functions and back. These are `$c2w32`, which converts a Color record to a word32; `newcol`, which converts a word32 to a Color record;`$v22w32`, which converts a Vector2 record to a word32; and `newvec2`, which converts a word32 to a Vector2. *You only need to convert these values back to their respective record values if you intend to modify them.* Otherwise, you can continue to use them without converting them. The types for Color structs that have been converted to word32 is `Col` and the type for Vector2 structs that have been converted to word32 is `Vec2`. Additionally, you do not need to do this for other structs—as mentioned above, they are passed by reference by default and, thus, avoid the aforementioned issue.

* The names of several struct members have been changed to avoid namespace conflicts with reserved words and types. The changes are as follows:
    * color -> clr
    * max -> `max
    * min -> `min
    * shader -> shdr
    * texture -> txtr
    * transform -> trnsfrm

## raymath and rlgl

I have not yet created bindings for raymath or rlgl.