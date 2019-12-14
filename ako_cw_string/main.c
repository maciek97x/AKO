#include<stdlib.h>
#include<stdio.h>

void read_int32(__int32* n);
void print_int32(__int32 n);
char* int32_to_str(__int32 n);
void printf_asm(char* pattern, ... );

int main()
{
	__int32 n = 0xABAB;
	char* s;
	read_int32(&n);
	print_int32(n);
	s = int32_to_str(n);
	printf("s=%s", s);
	return 0;
}