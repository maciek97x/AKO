#include <stdio.h>

void szyfruj(char* tekst);

int main()
{
	char tekst[] = "abcdefgh";
	printf("%s\n", tekst);
	szyfruj(tekst);
	printf("%s\n", tekst);
	return 0;
}