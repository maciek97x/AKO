#include <stdio.h>

int porownaj(int a, int b);

int main()
{
	int a = 0x0123;
	int b = 0x0124;
	printf("%d\n", porownaj(a, b));
	a = 0x0201;
	b = 0x0100;
	printf("%d\n", porownaj(a, b));
	a = 0x0200;
	b = 0x0100;
	printf("%d\n", porownaj(a, b));
	a = 0x0200;
	b = 0x0101;
	printf("%d\n", porownaj(a, b));
	return 0;
}