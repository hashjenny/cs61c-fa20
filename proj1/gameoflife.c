/************************************************************************
**
** NAME:        gameoflife.c
**
** DESCRIPTION: CS61C Fall 2020 Project 1
**
** AUTHOR:      Justin Yokota - Starter Code
**				YOUR NAME HERE
**
**
** DATE:        2020-08-23
**
**************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include "imageloader.h"


uint32_t get_bit(uint32_t num, uint32_t n) {
    return (num >> n) & 1;
}


// flag: 0 -> red, 1 -> green, default -> blue
uint8_t get_next(Color *neighbors, uint8_t color_chanel, uint32_t rule, int flag) {
    uint8_t new_red = 0;
    for (int i = 7; i >= 0; --i) {
        uint32_t life = get_bit(color_chanel, i);
        int alive = 0;
        for (int j = 0; j < 8; ++j) {
            uint8_t chanel;
            switch (flag) {
                case 0:
                    chanel = neighbors[j].R;
                    break;
                case 1:
                    chanel = neighbors[j].G;
                    break;
                default:
                    chanel = neighbors[j].B;
            }
            if (get_bit(chanel, i) == 1) {
                alive++;
            }
        }

        uint32_t offset = life ? alive + 9 : alive;
        uint32_t result = get_bit(rule, offset);
        new_red = (new_red << 1) + result;
    }
    return new_red;
}

//Determines what color the cell at the given row/col should be. This function allocates space for a new Color.
//Note that you will need to read the eight neighbors of the cell in question. The grid "wraps", so we treat the top row as adjacent to the bottom row
//and the left column as adjacent to the right column.
Color *evaluateOneCell(Image *image, int row, int col, uint32_t rule)
{
	//YOUR CODE HERE
    Color color = image->image[row][col];

    Color *neighbors = (Color *) malloc(8 * sizeof(Color));

    uint32_t top = row > 0 ? (row - 1) : image->rows - 1;
    uint32_t down = row < image->rows - 1 ? (row + 1) : 0;
    uint32_t left = col > 0 ? (col - 1) : image->cols - 1;
    uint32_t right = col < image->cols + 1 ? (col + 1) : 0;

    neighbors[0] = image->image[row][right];
    neighbors[1] = image->image[down][right];
    neighbors[2] = image->image[down][col];
    neighbors[3] = image->image[down][left];
    neighbors[4] = image->image[row][left];
    neighbors[5] = image->image[top][left];
    neighbors[6] = image->image[top][col];
    neighbors[7] = image->image[top][right];

    uint8_t new_red = get_next(neighbors, color.R, rule, 0);
    uint8_t new_green = get_next(neighbors, color.G, rule, 1);
    uint8_t new_blue = get_next(neighbors, color.B, rule, 2);
    free(neighbors);

    Color *pixel = (Color *) malloc(sizeof(Color));
    pixel->R = new_red;
    pixel->G = new_green;
    pixel->B = new_blue;
    return pixel;
}


//The main body of Life; given an image and a rule, computes one iteration of the Game of Life.
//You should be able to copy most of this from steganography.c
Image *life(Image *image, uint32_t rule)
{
	//YOUR CODE HERE
    uint32_t rows = image->rows;
    uint32_t cols = image->cols;

    Image *new_image = (Image *) malloc(sizeof(Image));
    new_image->rows = rows;
    new_image->cols = cols;
    new_image->image = (Color **) malloc(rows * sizeof(Color *));

    for (int i = 0; i < rows; ++i) {
        new_image->image[i] = (Color *) malloc(cols * sizeof(Color));
        for (int j = 0; j < cols; ++j) {
            Color *pixel = evaluateOneCell(image, i, j, rule);
            new_image->image[i][j] = *pixel;
            free(pixel);
        }
    }

    return new_image;
}

/*
Loads a .ppm from a file, computes the next iteration of the game of life, then prints to stdout the new image.

argc stores the number of arguments.
argv stores a list of arguments. Here is the expected input:
argv[0] will store the name of the program (this happens automatically).
argv[1] should contain a filename, containing a .ppm.
argv[2] should contain a hexadecimal number (such as 0x1808). Note that this will be a string.
You may find the function strtol useful for this conversion.
If the input is not correct, a malloc fails, or any other error occurs, you should exit with code -1.
Otherwise, you should return from main with code 0.
Make sure to free all memory before returning!

You may find it useful to copy the code from steganography.c, to start.
*/
int main(int argc, char **argv)
{
	//YOUR CODE HERE
    if (argc < 3) {
        exit(1);
    }
    char *filename = argv[1];
    char *rule_str = argv[2];
    uint32_t rule = strtol(rule_str, NULL, 0);

    Image *img = readData(filename);
    Image *new_image = life(img, rule);
    writeData(new_image);
    freeImage(new_image);
    freeImage(img);
    return 0;
}
