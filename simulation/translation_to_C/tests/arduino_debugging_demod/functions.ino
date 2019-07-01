#include "functions.h"

void modulate_signal(int arrayMod[])
{
    int transmitted_data[DATA_SIZE_MOD] = {1, 0, 1, 0, 1, 1, 1, 0, 0, 1};
    modulated_signal = NULL;
    lut_association(transmitted_data, &modulated_signal);
}

void lut_association(int input_binary_signal[], int **output_analog_signal)
{
    free(*output_analog_signal);
    *output_analog_signal = (int *) malloc(VECTOR_SIZE_MOD * sizeof(int));
    if (*output_analog_signal == NULL)  return;
    Serial1.println("Alocação de memória: modulação.")
    for (int i = 0; i < DATA_SIZE_MOD; i++) {
        int multiple1 = i * DATA_SIZE_MOD * 256;
        if (input_binary_signal[i] == 1)    {
            for (int j = 0; j < DATA_SIZE_MOD; j++) {
                int multiple2 = j * 256;
                for (int k = 0; k < 256; k++)   {
                    (*output_analog_signal)[multiple1 + multiple2 + k] = lut_T[k % 128];
                }
            }
        }   else    {
            for (int j = 0; j < DATA_SIZE_MOD; j++) {
                int multiple2 = j * 256;
                for (int k = 0; k < 256; k++)   {
                    (*output_analog_signal)[multiple1 + multiple2 + k] = lut_2T[k];
                }
            }
        }
    }
    
}

void analyze_zeros(int wave[], int **zeros, const int nro_bits, const int sampling_period_length, double reference)
{
    free(*zeros);
    *zeros = (int *)malloc(sizeof(int) * nro_bits);
    if (*zeros == NULL) return;
    Serial1.println("Alocação de memória: demodulação.");
    int zero_sampling[nro_bits];
    int positive = 0;
    int negative = 0;
    int dif_signal = 0;

    for (int i = 0; i < nro_bits; i++)  {
        int vector_position = PERIOD_SAMPLE_DEMOD * i;
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
    for (int i = 0; i < BITS_DEMOD; i++){
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
    //double normal_vector[BITS_DEMOD];
    for (int i = 0; i < BITS_DEMOD; i++)   {
        normalized_vector[i] = (double)vector[i] / mean;
    }
//    normalized_vector = normal_vector;
}

void print_vector(double vector[])
{
    printf("Demodulated vector: [ ");
    for (int i = 0; i < BITS_DEMOD; i++)    {
        if (vector[i] > 1)    {
            Serial1.println("1 ");
        }   else    Serial1.println("0 "); 
    }
    printf("]\n");
}
