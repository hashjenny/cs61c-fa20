#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "lfsr.h"

unsigned get_bit(uint16_t x, uint16_t n) {
    return (x >> n) & 1;
}

void set_bit(uint16_t *x, uint16_t n, uint16_t v) {
    unsigned y = (*x) & (~(1 << n));
    *x = y | (v << n);
}

void lfsr_calculate(uint16_t *reg) {
    /* YOUR CODE HERE */
    uint16_t source = *reg;
    *reg = (*reg) >> 1;
    uint16_t left = get_bit(source, 0)
            ^ get_bit(source, 2)
            ^ get_bit(source, 3)
            ^ get_bit(source, 5);
    set_bit(reg, 15, left);
}

