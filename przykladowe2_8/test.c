#include <stdio.h>

unsigned int  sprawdz_calk(unsigned int a);

int main()
{
	unsigned int a;
	a = 0x007F;
	printf("%d\n", sprawdz_calk(a));
	a = 0x0080;
	printf("%d\n", sprawdz_calk(a));
	a = 0xFF80;
	printf("%d\n", sprawdz_calk(a));
	return 0;
}