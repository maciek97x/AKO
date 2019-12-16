#include <stdio.h>

float nowy_exp(float x);

int main()
{
	float x;
	printf("\nx=");
	scanf_s("%f", &x);
	printf("\ne^x=%f", nowy_exp(x));
	return 0;
}