#include "new_lut.h"
#include <time.h>

int main()
{
	clock_t start, end;
	double cpu_time_used;

	start = clock();
	
	int transmitted_data[DATA_SIZE] = {1, 0, 1, 0, 1, 1, 1, 0, 0, 1};
	new_lut_associator(transmitted_data);

	end = clock();

	cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
	//printf("The code took %f seconds to execute \n", cpu_time_used);


	return 0;
}