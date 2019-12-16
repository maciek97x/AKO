#include <stdio.h>

void dodaj_16(char*, char*);

int main()
{
	char liczby_A[16] = { -128, -127, -126, -125, -124, -123, -122, -121, 120, 121, 122, 123, 124, 125, 126, 127 };
	char liczby_B[16] = { -3, -3, -3, -3, -3, -3, -3, -3, 3, 3, 3, 3, 3, 3, 3, 3 };
	char liczby_C[16];
	dodaj_16(liczby_A, liczby_B, liczby_C);
	for (int i = 0; i < 16; ++i)
	{
		printf("%4d ", liczby_A[i]);
	}
	printf("\n");
	for (int i = 0; i < 16; ++i)
	{
		printf("%4d ", liczby_B[i]);
	}
	printf("\n");
	for (int i = 0; i < 16; ++i)
	{
		printf("%4d ", liczby_C[i]);
	}
	printf("\n");
	return 0;
}