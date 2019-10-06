#ifndef LUT_H
#define LUT_H

#include <stdlib.h>
#include <stdio.h>

#define DATA_SIZE 10

#define VECTOR_SIZE 6400

static const int lut_2T[] = {
	0x8,0x9,0xa,0xa,0xb,0xc,0xc,0xd,
	0xe,0xe,0xf,0xf,0xf,0x10,0x10,0x10,
	0x10,0x10,0x10,0x10,0xf,0xf,0xf,0xe,
	0xe,0xd,0xc,0xc,0xb,0xa,0xa,0x9,
	0x8,0x7,0x6,0x6,0x5,0x4,0x4,0x3,
	0x2,0x2,0x1,0x1,0x1,0x0,0x0,0x0,
	0x0,0x0,0x0,0x0,0x1,0x1,0x1,0x2,
	0x2,0x3,0x4,0x4,0x5,0x6,0x6,0x7};

static const int lut_T[] = {
	0x8,0xa,0xb,0xc,0xe,0xf,0xf,0x10,
	0x10,0x10,0xf,0xf,0xe,0xc,0xb,0xa,
	0x8,0x6,0x5,0x4,0x2,0x1,0x1,0x0,
	0x0,0x0,0x1,0x1,0x2,0x4,0x5,0x6};

void lut_association(int input_binary_signal[], int **output_analog_signal);

void print_vector(int vector[], int size);

#endif
