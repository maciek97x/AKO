#include <stdio.h>

char* komunikat(char*);

int main()
{
	char* tekst = "To jest komunikat.";
	char* tekst2 = komunikat(tekst);
	printf("%s\n", tekst2);
	return 0;
}