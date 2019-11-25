#include <stdio.h>

void liczba_przeciwna(int* a);

int main() {
	int a;
	printf("Podaj liczbe: ");
	scanf_s("%d", &a);
	liczba_przeciwna(&a);
	printf("Przeciwna: %d", a);
	return 0;
}