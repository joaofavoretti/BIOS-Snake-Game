#include <stdint.h>
#include "utils.h"

#define RED 0x28
#define GREEN 0x2f

#define WIDTH 32
#define HEIGHT 20

/**
 * a = 1100 00 1
 * s = 1110 01 1
 * d = 1100 10 0
 * w = 1110 11 1
 */
int8_t dirs[4][2] = {{-1, 0}, {0, 1}, {1, 0}, {0, -1}};
int8_t dir[2] = {1, 0};

int8_t startPos[2] = {WIDTH / 2, HEIGHT / 2};
// int8_t endPost[2] = {WIDTH / 2 - 1, HEIGHT / 2};

char key;
int8_t idx;

void main() {
    do {
        key = getc();

        if (key != 0) {
            idx = key >> 1 & 0x3;
            dir[0] = dirs[idx][0];
            dir[1] = dirs[idx][1];
        }

        startPos[0] += dir[0];
        startPos[1] += dir[1];

        square(startPos[0], startPos[1], GREEN);
        // square(endPost[0], endPost[1], GREEN);

        sleep();
    } while (1);

    
}
