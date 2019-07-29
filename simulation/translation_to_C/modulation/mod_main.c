#include "lut.h"
#include <time.h>

int main(void)
{
	clock_t start, end;
	double cpu_time_used;

	start = clock();

	_Bool transmitted_data[DATA_SIZE] = {1, 0, 1, 0, 1, 1, 1, 0, 0, 1};
	int *modulated_signal;

	modulated_signal = NULL;
	lut_association(transmitted_data, &modulated_signal);
	print_vector(modulated_signal, VECTOR_SIZE);
	free(modulated_signal);

	end = clock();

	cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
	//printf("The code took %f seconds to execute \n", cpu_time_used);

	return 0;

}