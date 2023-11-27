global getc
global exit
global square
global sleep

bits 16

section .text
;
; char getc: Get char from keyboard
; Return:
;   al: ASCII Character
;
getc:
    ; Check if there is a key pressed
    mov ah, 0x11
    int 0x16

    jne .handleKey

    ; Return 0 if no key pressed
    xor ax, ax
    retf

    .handleKey:
        mov ah, 0x10        ; Read expanded keyboard character
        int 0x16            ; Keyboard Services interruption
        xor ah, ah          ; Add 0 to the first byte of ax
        ret                 ; TODO: Try `ret` instead


;
; void exit: Exit program
; 
exit:
    cli                 ; Disable interruptions
    hlt                 ; Halt CPU


; 
; void square: Draw a square on screen at (x, y) with color
; Params:
;   x (esp+0x4): x coordinate of the square
;   y (esp+0x8): y coordinate of the square
;   color (esp+0x12): 8-bit color of the square 
;
%define VGA_SEGMENT 0xA000
%define SQUARE_SIZE 10
%define SCREEN_WIDTH 320
square:
    pushad                  ; Save Registers

    ; Defining the position of the function parameters
    %define X [ds:esp+36]
    %define Y [ds:esp+40]
    %define COLOR [ds:esp+44]

    ; Set the VGA Segment
    ; It is where the video memory is located on the memory
    mov ax, VGA_SEGMENT
    mov es, ax                  ; ES = VGA_SEGMENT

    mov bx, SQUARE_SIZE         ; EBX = Y counter

    .writeLine:
        dec bx                  ; EBX--

        ; Calculate the addressing of the first pixel of the current row
        mov ax, X               ; EAX = X
        mov cx, SQUARE_SIZE     ; ECX = SQUARE_SIZE
        mul cx                  ; EAX = X * SQUARE_SIZE
        mov di, ax              ; EDI = X * SQUARE_SIZE
        mov ax, Y               ; AX = Y
        mov cx, SQUARE_SIZE     ; CX = SQUARE_SIZE
        mul cx                  ; AX = Y * SQUARE_SIZE
        add ax, bx              ; AX = Y * SQUARE_SIZE + Y
        mov cx, SCREEN_WIDTH    ; ECX = X_RESOLUTION
        mul cx                  ; EAX = (Y * SQUARE_SIZE + Y) * X_RESOLUTION
        add di, ax              ; EDI = (Y * SQUARE_SIZE + Y) * X_RESOLUTION + X * SQUARE_SIZE

        ; Write a row of pixels to the screen memory
        mov cx, SQUARE_SIZE     ; ECX = SQUARE_SIZE
        mov al, COLOR           ; AL = COLOR
        rep stosb               ; Write ECX bytes of AL to [ES:EDI] and increment EDI

        ; Repeat until Y counter is 0
        cmp bx, 0
        jne .writeLine

    ; Set the Extended Data Segment back to 0
    xor ax, ax
    mov es, ax

    ; Restore Registers
    popad

    retf


;
; void sleep: Sleep for a number of milliseconds
;
sleep:
    pushad
    
    mov ah, 0x86        ; Get System Time
    mov cx, 0x2         ; Wait for 2 ticks
    int 0x15            ; BIOS Timer Services interruption
    
    popad
    ret