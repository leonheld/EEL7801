#include <stdio.h>
#include <stdlib.h>

#define LENGTH 10010

void get_wave(double array[], int size);

void analyze_zeros(double wave[], int **zeros, const int nro_bits, const int sampling_period_length);

double get_mean(int vector[], int vector_size);

void get_normalized(double normalized_vector[], int vector[], double mean);

