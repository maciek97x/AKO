#include <stdio.h>

int zaokr_do_calk(int a);

int main()
{
	int a = 0x04F;
	printf("%x\n", a);
	printf("%x\n", zaokr_do_calk(a));
	a = 0x000111AF;
	printf("%x\n", a);
	printf("%x\n", zaokr_do_calk(a));
	return 0;
}