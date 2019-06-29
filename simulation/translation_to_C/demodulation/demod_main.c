#include "functions.h"

int main(void)
{
    printf("Original vector (obtained from modulation in C): \
        \b\b\b\b\b\b\b\b[ 1 0 1 0 1 1 1 0 0 1 ]\n");

    int array[LENGTH];
    int *zeros;
    double normalized_vector[BITS];
    int demodulated_wave[BITS];

    get_wave(array, LENGTH);

    zeros = NULL;
    analyze_zeros(array, &zeros, BITS, PERIOD_SAMPLE, get_mean(array, LENGTH));

    double mean = get_mean(zeros, BITS);
    get_normalized(normalized_vector, zeros, mean);
    print_vector(normalized_vector);

    free(zeros);

    return 0;
}
