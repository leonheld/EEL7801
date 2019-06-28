#include "lut.h"

int main(void)
{
	_Bool transmitted_data[DATA_SIZE] = {1, 0, 1, 1, 1, 1, 1, 1, 0, 1};
	int *modulated_signal;

	modulated_signal = NULL;
	lut_association(transmitted_data, &modulated_signal);
	print_vector(modulated_signal, VECTOR_SIZE);
	free(modulated_signal);

	return 0;

}