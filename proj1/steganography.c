/************************************************************************
**
** NAME:        steganography.c
**
** DESCRIPTION: CS61C Fall 2020 Project 1
**
** AUTHOR:      Dan Garcia  -  University of California at Berkeley
**              Copyright (C) Dan Garcia, 2020. All rights reserved.
**				Justin Yokota - Starter Code
**				YOUR NAME HERE
**
** DATE:        2020-08-23
**
**************************************************************************/

#include "imageloader.h"
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>

// Determines what color the cell at the given row/col should be. This should
// not affect Image, and should allocate space for a new Color.
Color *evaluateOnePixel(Image *image, int row, int col) {
    // YOUR CODE HERE
    Color color = image->image[row][col];
    uint8_t blue = color.B;
    uint8_t last = blue & 1;

    Color *pixel = (Color *) malloc(sizeof(Color));
    if (last) {
        pixel->R = 255;
        pixel->G = 255;
        pixel->B = 255;
    } else {
        pixel->R = 0;
        pixel->G = 0;
        pixel->B = 0;
    }
    return pixel;
}

// Given an image, creates a new image extracting the LSB of the B channel.
Image *steganography(Image *image) {
    // YOUR CODE HERE
    uint32_t rows = image->rows;
    uint32_t cols = image->cols;

    Image *newImage = (Image *) malloc(sizeof(Image));
    newImage->rows = rows;
    newImage->cols = cols;
    newImage->image = (Color **) malloc(rows * sizeof(Color *));

    for (int i = 0; i < rows; ++i) {
        newImage->image[i] = (Color *) malloc(cols * sizeof(Color));
        for (int j = 0; j < cols; ++j) {
            Color *pixel = evaluateOnePixel(image, i, j);
            newImage->image[i][j] = *pixel;
            free(pixel);
        }
    }

    return newImage;
}

/*
Loads a file of ppm P3 format from a file, and prints to stdout (e.g. with
printf) a new image, where each pixel is black if the LSB of the B channel is
0, and white if the LSB of the B channel is 1.

argc stores the number of arguments.
argv stores a list of arguments. Here is the expected input:
argv[0] will store the name of the program (this happens automatically).
argv[1] should contain a filename, containing a file of ppm P3 format (not
necessarily with .ppm file extension). If the input is not correct, a malloc
fails, or any other error occurs, you should exit with code -1. Otherwise,
you should return from main with code 0. Make sure to free all memory before
returning!
*/
int main(int argc, char **argv) {
    // YOUR CODE HERE
    if (argc < 2) {
        exit(1);
    }
    char *filename = argv[1];
    Image *img = readData(filename);
    Image *newImage = steganography(img);
    writeData(newImage);
    freeImage(img);
    freeImage(newImage);
    return 0;
}
