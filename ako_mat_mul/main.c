#include <stdio.h>
#include <time.h>

void mul_mat_asm(int n, unsigned int* A, unsigned int* B, unsigned int* C);

void mul_mat(int n, unsigned int* A, unsigned int* B, unsigned int* C);
void print_mat(int n, unsigned int* A);
void rand_mat(int n, unsigned int* A);

int main()
{
	int n = 16;
	int r = 1;
	unsigned int* A = (unsigned int*)malloc(sizeof(unsigned int) * n * n);
	unsigned int* B = (unsigned int*)malloc(sizeof(unsigned int) * n * n);
	unsigned int* C = (unsigned int*)malloc(sizeof(unsigned int) * n * n);

	rand_mat(n, A);
	rand_mat(n, B);

	print_mat(n, A);
	print_mat(n, B);

	clock_t start = clock();
	for (int i = 0; i < r; ++i) {
		mul_mat(n, A, B, C);
	}
	clock_t end = clock();

	float seconds = (float)(end - start) / CLOCKS_PER_SEC;

	print_mat(n, C);

	printf("C in %f seconds\n", seconds);


	rand_mat(n, C);

	start = clock();
	for (int i = 0; i < r; ++i) {
		mul_mat_asm(n, A, B, C);
	}
	end = clock();

	seconds = (float)(end - start) / CLOCKS_PER_SEC;

	print_mat(n, C);

	printf("asm in %f seconds\n", seconds);

	return 0;
}

void mul_mat(int n, unsigned int* A, unsigned int* B, unsigned int* C)
{
	for (int i = 0; i < n; ++i)
	{
		for (int j = 0; j < n; ++j)
		{
			int s = 0;
			for (int k = 0; k < n; ++k)
			{
				s += A[n * i + k] * B[n * k + j];
			}
			C[n * i + j] = s;
		}
	}
}

void print_mat(int n, unsigned int* A)
{
	printf("\n");
	for (int i = 0; i < n; ++i)
	{
		for (int j = 0; j < n; ++j)
		{
			printf("%6d ", A[n * i + j]);
		}
		printf("\n");
	}
	printf("\n");
}

void rand_mat(int n, unsigned int* A)
{
	for (int i = 0; i < n; ++i)
	{
		for (int j = 0; j < n; ++j)
		{
			A[n * i + j] = rand() % 100;
		}
	}
}
