#include "functions.h"

void setup()
{
    printf("Original vector (obtained from modulation in C): \
        \b\b\b\b\b\b\b\b[ 1 0 1 0 1 1 1 0 0 1 ]\n");

    int arrayMod[LENGTH_DEMOD];
    int *zeros;
    double normalized_vector[BITS_DEMOD];
    int demodulated_wave[BITS_DEMOD];
    Serial1.println("Vetores gerados.");

    modulate_signal(arrayMod);
    Serial1.println("Vetor modulado.");

    zeros = NULL;
    analyze_zeros(arrayMod, &zeros, BITS_DEMOD, PERIOD_SAMPLE_DEMOD, get_mean(arrayMod, LENGTH_DEMOD));
    Serial1.println("Análise dos \"zeros\" realizada");

    double mean = get_mean(zeros, BITS_DEMOD);
    get_normalized(normalized_vector, zeros, mean);
    print_vector(normalized_vector);

    free(zeros);

    Serial1.println("Setup executado com sucesso!");
}

void loop()
{
}