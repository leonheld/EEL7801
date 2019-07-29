#include <stdio.h>
#include <stdlib.h>

#define BITS 10
#define PERIOD_SAMPLE 2560
#define LENGTH (BITS*PERIOD_SAMPLE)

void get_wave(int array[], int size);

void analyze_zeros(int wave[], int **zeros, const int nro_bits, const int sampling_period_length, double reference);

double get_mean(int vector[], int vector_size);

void get_normalized(double normalized_vector[], int vector[], double mean);

void print_vector(double vector[]);
