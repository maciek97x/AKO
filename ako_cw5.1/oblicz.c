#include <stdio.h>

float srednia_harm(float* tablica, unsigned int n);

int main()
{
	int n;
	printf("\nn=");
	scanf_s("%d", &n);
	float* tablica = (float*)malloc(sizeof(float) * n);
	for (int i = 0; i < n; ++i)
	{
		printf("\nt[%d]=", i);
		scanf_s("%f", &tablica[i]);
	}
	printf("\nsrednia_harm=%f", srednia_harm(tablica, n));
	return 0;
}