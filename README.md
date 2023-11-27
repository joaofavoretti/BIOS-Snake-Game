# BIOS Snake Game
Trying to make a Snake Game using just BIOS interruptions and 512 bytes os code memory.

## Demo
![Demo](assets/demo.gif)

## Compiling

Compiles all the source code and link them together using a special `linked.ld` to create a 512 image file.

```
make
```

## Running

Uses the `game.img` file that was created using qemu.s

```
make run
```
