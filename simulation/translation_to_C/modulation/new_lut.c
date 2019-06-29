#include "new_lut.h"

//instead of copying all values to a vector and then send the vector itself, just access the original lut according to the binary vector inputted

void new_lut_associator(int input_binary_signal[])
{
	//printf("Modulated vector: [");
	for (int i = 0; i < DATA_SIZE; i++)	{
		int multiple1 = i * DATA_SIZE * 256;
		if (input_binary_signal[i] == 1)	{
			for (int j = 0; j < DATA_SIZE; j++)	{
				int multiple2 = j * 256;
				for (int k = 0; k < 256; k++)	{
					if ((i == DATA_SIZE - 1) && (j == DATA_SIZE - 1) && (k == 255))	{printf("%d\n", lut_T[k % 128]);}
					else printf("%d ", lut_T[k % 128]);
				}
			}
		}	else	{
			for (int j = 0; j < DATA_SIZE; j++)	{
				int multiple2 = j * 256;
				for (int k = 0; k < 256; k++)	{
					if ((i == DATA_SIZE - 1) && (j == DATA_SIZE - 1) && (k == 255))	{printf("%d\n", lut_2T[k]);}
					else printf("%d ", lut_2T[k]);
				}
			}
		}
	}
}