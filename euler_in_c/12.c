#include "stdio.h"

int main()
{
	int n = 0;
	int start = 0;
	int *t = &start;
	int i = 0;



	do
	{
		int divisor;
		int total = 0;
		for (divisor = 1; divisor <= i / 2; divisor++)
		{
			if ((i % divisor == 0) && (i != divisor))
			{
				++total; 
				if (total > *t)
				{
					*t = total;
				}
			}
		}
		printf("%u   %u  %u\n", i, total, *t);
		n += 1;
		i = n*(n+1)/2;
	} while (*t < 500);

	printf("%u\n", *t);
	return 0;
}