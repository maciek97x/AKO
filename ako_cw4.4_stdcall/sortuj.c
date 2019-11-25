#include <stdio.h>

#define n 10

void __stdcall przestaw(int tabl[], int m);

int main()
{
	int a[n];
	for (int i = 0; i < n; ++i) a[i] = rand() % 100;
	for (int i = 0; i < n; ++i) printf("%d ", a[i]);
	printf("\n");
	for (int i = n; i > 1; --i) przestaw(a, i);
	for (int i = 0; i < n; ++i) printf("%d ", a[i]);
	return 0;
}