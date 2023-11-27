#include <stdint.h>

/**
 * Get the key that was pressed, if any. Returns 0 if no key was pressed.
 */
char getc();

/**
 * Exit the program.
 */
void exit();

/**
 * Draw a square on the screen
 * Params:
 *  x: x coordinate of the top left corner of the square
 *  y: y coordinate of the top left corner of the square
 *  color: color of the square
 */
void square(int8_t x, int8_t y, int8_t color);

/**
 * Sleep for a given number of microseconds
*/
void sleep();