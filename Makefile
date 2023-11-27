SRC_DIR=src
BUILD_DIR=build

ASM=nasm
AFLAGS=-f elf32

CC=gcc
CFLAGS=-fno-PIC -fomit-frame-pointer -ffreestanding -m16 -Os -c

LD=ld
LFLAGS=-melf_i386 --build-id=none -T linker.ld

GDB_FLAGS=-s -S

$(BUILD_DIR)/game.img: $(BUILD_DIR)/game.elf
	objcopy -O binary $(BUILD_DIR)/game.elf $(BUILD_DIR)/game.img

$(BUILD_DIR)/game.elf: linker.ld $(BUILD_DIR)/boot.o $(BUILD_DIR)/main.o $(BUILD_DIR)/utils.o
	$(LD) $(LFLAGS) $(BUILD_DIR)/main.o $(BUILD_DIR)/utils.o $(BUILD_DIR)/boot.o -o $(BUILD_DIR)/game.elf

$(BUILD_DIR)/main.o: $(SRC_DIR)/main.c $(SRC_DIR)/utils.h
	$(CC) $(CFLAGS) $(SRC_DIR)/main.c -o $(BUILD_DIR)/main.o

$(BUILD_DIR)/utils.o: $(SRC_DIR)/utils.asm
	$(ASM) $(AFLAGS) $(SRC_DIR)/utils.asm -o $(BUILD_DIR)/utils.o

$(BUILD_DIR)/boot.o: $(SRC_DIR)/boot.asm
	$(ASM) $(AFLAGS) $(SRC_DIR)/boot.asm -o $(BUILD_DIR)/boot.o

.PHONY: run size debug gdb

run: $(BUILD_DIR)/game.img
	qemu-system-i386 -fda $(BUILD_DIR)/game.img

size: $(BUILD_DIR)/game.img
	python3 size.py $(BUILD_DIR)/game.img

debug: $(BUILD_DIR)/game.img
	qemu-system-i386 $(GDB_FLAGS) -fda $(BUILD_DIR)/game.img

gdb:
	gdb -q -x gdbinit
