/************************************************************************
**
** NAME:        imageloader.c
**
** DESCRIPTION: CS61C Fall 2020 Project 1
**
** AUTHOR:      Dan Garcia  -  University of California at Berkeley
**              Copyright (C) Dan Garcia, 2020. All rights reserved.
**              Justin Yokota - Starter Code
**				YOUR NAME HERE
**
**
** DATE:        2020-08-15
**
**************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <string.h>
#include "imageloader.h"

//Opens a .ppm P3 image file, and constructs an Image object.
//You may find the function fscanf useful.
//Make sure that you close the file with fclose before returning.
Image *readData(char *filename) {
    //YOUR CODE HERE
    FILE *fp = fopen(filename, "r");
    char file_mode[20];
    fscanf(fp, "%s\n", file_mode);

    int cols, rows;
    fscanf(fp, "%d %d\n", &cols, &rows);

    int color_scale;
    fscanf(fp, "%d\n", &color_scale);

    Image *img = (Image *) malloc(sizeof(Image));
    img->cols = cols;
    img->rows = rows;
    img->image = (Color **) malloc(rows * sizeof(Color *));

    for (int i = 0; i < rows; ++i) {
        (img->image)[i] = (Color *) malloc(cols * sizeof(Color));
        Color *c = (img->image)[i];
        for (int j = 0; j < cols; ++j) {
            fscanf(fp, "%hhu %hhu %hhu", &(c[j].R), &(c[j].G), &(c[j].B));
        }
    }

    fclose(fp);
    return img;
}

//Given an image, prints to stdout (e.g. with printf) a .ppm P3 file with the image's data.
void writeData(Image *image) {
    //YOUR CODE HERE
    if (image) {
        uint32_t cols = image->cols;
        uint32_t rows = image->rows;
        printf("P3\n");
        printf("%d %d\n", cols, rows);
        printf("255\n");

        Color **cp = image->image;
        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                Color c = cp[i][j];
                printf("%3u %3u %3u", c.G, c.G, c.B);
                if (j < cols - 1) {
                    printf("   ");
                }
            }
            printf("\n");
        }
    }
}

//Frees an image
void freeImage(Image *image) {
    //YOUR CODE HERE
    uint32_t rows = image->rows;
    for (int i = 0; i < rows; i++) {
        free((image->image)[i]);
    }
    free(image->image);
    free(image);
}