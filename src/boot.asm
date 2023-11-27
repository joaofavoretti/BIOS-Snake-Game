extern main
extern exit
extern __bss_sizeb
extern __bss_start

global start

bits 16

section .text
start:
    xor ax, ax                  ; AX = 0
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov esp, 0x7C00
    jmp 0x0000:.setcs            ; Set CS to 0
.setcs:
    cld                         ; GCC code requires direction flag to be cleared 

    ; Zero fill the BSS section
    mov cx, __bss_sizeb         ; Size of BSS computed in linker script
    mov di, __bss_start         ; Start of BSS defined in linker script
    rep stosb                   ; AL still zero, Fill memory with zero

    ; Setting up Video Mode 320x200 256 colors
    mov ah, 0x00                ; Set Video Mode   
    mov al, 0x13                ; 320x200 256 colors
    int 0x10                    ; Call BIOS Interrupt

    ; Enter C main function
    call dword main

    ; Exit the program
    call dword exit
