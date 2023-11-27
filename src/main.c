#include <stdint.h>
#include "utils.h"

#define NULL 0

#define RED 0x28
#define GREEN 0x2f
#define BLACK 0x00

#define WIDTH 32
#define HEIGHT 20

/**
 * a = 1100 00 1
 * s = 1110 01 1
 * d = 1100 10 0
 * w = 1110 11 1
 */
int8_t dirs[4][2] = {{-1, 0}, {0, 1}, {1, 0}, {0, -1}};
int8_t *dir = dirs[2];

int8_t startPos[2] = {WIDTH / 2, HEIGHT / 2};
int8_t endPos[2] = {WIDTH / 2 - 1, HEIGHT / 2};

char key;
int8_t idx;

void main() {
    square(startPos[0], startPos[1], GREEN);

    while(1) {
        // Handle key presses
        key = getc();

        if (key != 0) {
            idx = key >> 1 & 0x3;
            dir = dirs[idx];
        }


        square(endPos[0], endPos[1], BLACK);

        endPos[0] = startPos[0];
        endPos[1] = startPos[1];

        // Update the Snake position according to the direction
        startPos[0] += dir[0];
        startPos[1] += dir[1];

        startPos[0] %= WIDTH;
        startPos[1] %= HEIGHT;
        
        square(startPos[0], startPos[1], GREEN);

        sleep();
    }
}
