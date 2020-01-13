#include <stdlib.h>
#include <stdio.h>


int* kopia_tablicy(int tab[], unsigned int);

int main()
{
	unsigned int n = 10;
	int* tab1;
	int* tab2;
	tab1 = (int*) malloc(n * sizeof(int));
	for (int i = 0; i < n; ++i) tab1[i] = rand()%10;

	tab2 = kopia_tablicy(tab1, n);
	for (int i = 0; i < n; ++i) printf("%d ", tab1[i]);
	printf("\n");
	for (int i = 0; i < n; ++i) printf("%d ", tab2[i]);
	printf("\n");
	return 0;
}