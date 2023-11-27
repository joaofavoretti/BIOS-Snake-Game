# BIOS Snake Game
Trying to make a Snake Game using just BIOS interruptions and currently 392 bytes of code (`make size` to check it).

The main problem is that I want the BIOS itself to run the code. Because of that, I have a memory limit of 512 bytes that is how much the BIOS loads of the memory to run it.

I still could not bum enough instructions to make it fit in 512 bytes. That is why I only have a 2-square snake walking around the screen so far.

## Demo
![Demo](assets/demo.gif)

## Compiling

The repo has a Makefile that compiles all the source code and link them together using a file called `linker.ld` to create a 512 image file.

```
make
```

## Running

You can use the `game.img` file with qemu as a flopping disk image to run the program

```
make run
```

You can move the snake with the standard `WASD` letters from the keyboard.
