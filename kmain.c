#include <stdint.h>

void print_str(char *str) {
    while (*str) {
        /* AH=0x0e, AL=char to print, BH=page, BL=fg color */
        __asm__ __volatile__ ("int $0x10"
                              :
                              : "a" ((0x0e<<8) | *str++),
                                "b" (0x0000));
    }
}