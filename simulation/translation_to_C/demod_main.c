#include "functions.h"

int main(void)
{
    printf("Original vector (obtained from simulation in Octave/Matlab): [ 1 0 1 0 1 1 1 0 0 1 ]\n");

    double array[LENGTH];
    int *zeros;
    double normalized_vector[10];
    int demodulated_wave[10];

    get_wave(array, LENGTH);
    
    zeros = NULL;
    analyze_zeros(array, &zeros, 10, 1001);

    double mean = get_mean(zeros, 10);
    get_normalized(normalized_vector, zeros, mean);

    printf("Demodulated vector: [ ");
    for (int i = 0; i < 10; i++)    {
        if (normalized_vector[i] > 1)    {
            demodulated_wave[i] = 1;
        }   else    demodulated_wave[i] = 0;
        printf("%d ", demodulated_wave[i]); 
    }
    printf("]");

    free(zeros);

    return 0;
}
