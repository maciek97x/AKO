#include <stdio.h>

void pole_kola(float* pr);

int main()
{
	float k = 12.32;
	printf("promien = %f\n", k);
	pole_kola(&k);
	printf("pole kola = %f\n", k);
	return 0;
}