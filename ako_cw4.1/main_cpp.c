#include <stdio.h>
int szukaj4_max(int a, int b, int c);

int main()
{
	int x, y, z, t, wynik;
	printf("\nProsze podac trzy liczby calkowite ze znakiem: ");
	scanf_s("%d %d %d %d", &x, &y, &z, &t, 32);

	wynik = szukaj4_max(x, y, z, t);
	printf("\nSposrod podanych liczb %d, %d, %d, %d, liczba %d jest najwieksza\n", x, y, z, t, wynik);
	return 0;
}
