#include <stdio.h>

extern __int64 dodaj7_64(__int64 a1, __int64 a2, __int64 a3, __int64 a4, __int64 a5, __int64 a6, __int64 a7);

int main()
{
	__int64 a[7] = {
		   1,
		   2,
		   3,
		   4,
		   300000, 
		   2000000,
		   10000000 };

	__int64 suma;
	suma = dodaj7_64(a[0], a[1], a[2], a[3], a[4], a[5], a[6]);

	printf("\nSuma elementów tablicy wynosi %I64d\n", suma);
	return 0;
}