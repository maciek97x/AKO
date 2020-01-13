#include <stdio.h>
#include <stdlib.h>

int* szukaj_elem_min(int tab[], int n);

int main()
{
	int n = 20;
	int* tab;
	int* wsk;
	tab = (int*)malloc(n * sizeof(int));
	for (int i = 0; i < n; ++i) tab[i] = rand() % 100 - 50;
	for (int i = 0; i < n; ++i) printf("%d ", tab[i]);
	wsk = szukaj_elem_min(tab, n);
	printf("\nmin = %d\n", *wsk);
	return 0;
}