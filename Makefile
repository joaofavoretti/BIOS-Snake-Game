kernel.bin: kernel.elf
	objcopy -O binary kernel.elf kernel.bin

kernel.elf: linker.ld hw.o kmain.o
	ld -melf_i386 --build-id=none -T linker.ld kmain.o hw.o -o kernel.elf

kmain.o: kmain.c
	gcc -fno-PIC -ffreestanding -m16 -c kmain.c -o kmain.o 

hw.o: hw.asm
	nasm -f elf32 hw.asm -o hw.o

.PHONE: run

run: kernel.bin
	qemu-system-i386 -kernel kernel.bin