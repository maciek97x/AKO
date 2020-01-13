#include <stdio.h>

int roznica(int*, int**);

int main()
{
	int a, b, * wsk, wynik;
	wsk = &b;
	a = 21;
	b = 25;
	wynik = roznica(&a, &wsk);
	printf("%d - %d = %d", a, b, wynik);
	return 0;
}