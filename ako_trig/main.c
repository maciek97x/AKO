#include <stdio.h>

float pi();
float sin(float);
float cos(float);
float tan(float);
float cot(float);
float atan(float);
float asin(float);
float acos(float);
float acot(float);

int main()
{
	float x[11];
	float f_pi = pi();
	for (int i = 0; i < 11; ++i) x[i] = (-1 + 0.2 * i);
	printf("x=     ");
	for (int i = 0; i < 11; ++i) printf("%7.3f ", x[i]);
	printf("\nsinx=  ");
	for (int i = 0; i < 11; ++i) printf("%7.3f ", sin(x[i]));
	printf("\ncosx=  ");
	for (int i = 0; i < 11; ++i) printf("%7.3f ", cos(x[i]));
	printf("\ntanx=  ");
	for (int i = 0; i < 11; ++i) printf("%7.3f ", tan(x[i]));
	printf("\ncotx=  ");
	for (int i = 0; i < 11; ++i) printf("%7.3f ", cot(x[i]));
	printf("\natanx= ");
	for (int i = 0; i < 11; ++i) printf("%7.3f ", atan(x[i]));
	printf("\nasinx= ");
	for (int i = 0; i < 11; ++i) printf("%7.3f ", asin(x[i]));
	printf("\nacosx= ");
	for (int i = 0; i < 11; ++i) printf("%7.3f ", acos(x[i]));
	printf("\nacotx= ");
	for (int i = 0; i < 11; ++i) printf("%7.3f ", acot(x[i]));
	printf("\n");
	return 0;
}