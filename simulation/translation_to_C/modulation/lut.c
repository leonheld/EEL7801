	#include "lut.h"

void lut_association(_Bool input_binary_signal[], int **output_analog_signal)
{
	free(*output_analog_signal);
	*output_analog_signal = malloc(VECTOR_SIZE * sizeof(int));
	if (*output_analog_signal == NULL)	return;
	for (int i = 0; i < DATA_SIZE; i++)	{
		int multiple1 = i * DATA_SIZE * 64;
		if (input_binary_signal[i] == 1)	{
			for (int j = 0; j < DATA_SIZE; j++)	{
				int multiple2 = j * 64;
				for (int k = 0; k < 64; k++)	{
					(*output_analog_signal)[multiple1 + multiple2 + k] = lut_T[k % 32];
				}
			}
		}	else	{
			for (int j = 0; j < DATA_SIZE; j++)	{
				int multiple2 = j * 64;
				for (int k = 0; k < 64; k++)	{
					(*output_analog_signal)[multiple1 + multiple2 + k] = lut_2T[k];
				}
			}
		}
	}
	
}

void print_vector(int vector[], int size){
	printf("Modulated vector: [");
	for (int i = 0; i < size; i++)	{
		if (i != size - 1)	{
			printf("%d,", vector[i]);
		}	else	printf("%d]\n", vector[i]);
	}
}