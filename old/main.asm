org 0x7C00
bits 16

; +--------+ 0x7C00
; |        |
; |        | Initial Snake X
; +--------+ 
; |        |
; |        | Initial Snake Y
; +--------+ 


;
; Start: First instruction to be executed.
;   Jump to the main function
;
start:
    jmp main


;
; Clear: Clears the screen
;
clear:
    push ax

    mov ah, 0x00    ; Set Video Mode
    mov al, 0x03    ; 80x25 16-color text mode
    int 0x10
    
    pop ax
    ret

;
; Sleep: Sleeps for a given amount of time
; Params:
;   - ax: The amount of time to sleep
;
sleep:
    push ax
    push cx
    push dx

    mov cx, ax
    mov dx, ax

    mov ah, 0x00
    int 0x1A

    pop dx
    pop cx
    pop ax
    ret

;
; Puts: Prints a string to the screen
; Params:
;   ds:si - Pointer to the string to print
;
puts:
    push si
    push ax

    .loop:
        lodsb
        or al, al
        jz .done

        mov ah, 0x0E
        mov bh, 0x00
        mov bl, 0x07
        int 0x10

        jmp .loop

    .done:
        pop ax
        pop si
        ret


;
; Main: The main function
;
main:
    ; Setting up the correct segments
    mov ax, 0
    mov ds, ax          ; Data segments
    mov es, ax
    mov ss, ax          ; Stack segment
    mov sp, 0x7C00

    ; Clearing the screen
    call clear

    ; Print the message
    mov si, msg
    call puts

    ; Sleep for 1 second
    mov ax, 0x0100
    call sleep

    ; Clear
    call clear

    ; Sleep for 1 second
    mov ax, 0x0100
    call sleep

    ; Print the message again
    mov si, msg
    call puts

    hlt

    .halt:
        jmp .halt


msg db "Hello, World!", 0

; Adding padding to make the binary 512 bytes long
times 510 - ($ - $$) db 0

; Adding the last two bytes to make the section bootable to the BIOS
dw 0xAA55