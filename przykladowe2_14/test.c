#include <stdio.h>
#include <stdlib.h>

void float_to_double(float*, double*);

int main()
{
	float a = 123.456f;
	float* f_wsk = &a;
	double* d_wsk = (double*)malloc(sizeof(double));
	float_to_double(f_wsk, d_wsk);
	printf("%f\n%f\n", *f_wsk, *d_wsk);
	return 0;
}