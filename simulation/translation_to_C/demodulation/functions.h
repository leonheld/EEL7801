#include <stdio.h>
#include <stdlib.h>

#define LENGTH 25600

void get_wave(int array[], int size);

void analyze_zeros(int wave[], int **zeros, const int nro_bits, const int sampling_period_length);

double get_mean(int vector[], int vector_size);

void get_normalized(double normalized_vector[], int vector[], double mean);

