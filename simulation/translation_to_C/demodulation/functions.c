#include "functions.h"

void get_wave(int array[], int size)
{
    FILE *myfile;

    myfile=fopen("new_mod_result.txt", "r");

    for(int i = 0; i < LENGTH; i++)   {
        fscanf(myfile,"%d", &array[i]);
    }

    fclose(myfile);

}

void analyze_zeros(int wave[], int **zeros, const int nro_bits, const int sampling_period_length, double reference)
{
    free(*zeros);
    *zeros = malloc(sizeof(int) * nro_bits);
    if (*zeros == NULL) return;
    int zero_sampling[nro_bits];
    int positive = 0;
    int negative = 0;
    int dif_signal = 0;

    for (int i = 0; i < nro_bits; i++)  {
        int vector_position = PERIOD_SAMPLE * i;
        zero_sampling[i] = 0;
        for (int j = 0; j < sampling_period_length; j++) {
            if (dif_signal > nro_bits)  {
                if (wave[vector_position + j] > reference)   {
                    positive = 1;
                }
                if (wave[vector_position + j] < reference)   {
                    negative = 1;
                }
                if (positive && negative)   {
                    zero_sampling[i] += 1;
                    positive = 0;
                    negative = 0;
                    dif_signal = 0;
                }
            }
            dif_signal++;
        }
    }
    for (int i = 0; i < BITS; i++){
        (*zeros)[i] = zero_sampling[i];
    }
}

double get_mean(int vector[], int vector_size)
{
    double sum = 0;
    for (int i = 0; i < vector_size; i++)   {
        sum += vector[i];
    }

    return sum/vector_size;
}

void get_normalized(double normalized_vector[], int vector[], double mean)
{
    //double normal_vector[BITS];
    for (int i = 0; i < BITS; i++)   {
        normalized_vector[i] = (double)vector[i] / mean;
    }
//    normalized_vector = normal_vector;
}

void print_vector(double vector[])
{
    printf("Demodulated vector: [ ");
    for (int i = 0; i < BITS; i++)    {
        if (vector[i] > 1)    {
            printf("1 ");
        }   else    printf("0 "); 
    }
    printf("]\n");
}
