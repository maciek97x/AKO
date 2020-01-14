#include <stdio.h>

unsigned char iteracja(unsigned char a);

int main()
{
	unsigned char w = iteracja((unsigned char)32);
	printf("%d\n", (int)w);
	return 0;
}