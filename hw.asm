extern print_str
global start
bits 16

section .text
start:
    xor ax, ax            ; AX = 0
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov esp, 0x7C00
    jmp 0x0000:setcs      ; Set CS to 0
setcs:
    cld                   ; GCC code requires direction flag to be cleared 

    push dword welcome
    call dword print_str  ; call function
    cli
    hlt

section .data
welcome db 'Developped by Marius Van Nieuwenhuyse', 0x0D, 0x0A, 0