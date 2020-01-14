#include <stdio.h>

unsigned int kwadrat(unsigned int a);

int main()
{
	for (int i = 0; i < 10; ++i)
	{
		int a = i;
		int b = kwadrat(a);
		printf("%d ^ 2 = %d\n", a, b);
	}
	return 0;
}