#include <stdio.h>
#include <stdlib.h>

int trif(int n)
{
	return n*(n+1)/2;
}

int hexf(int n)
{
	return n*(2*n+1);
}

int pentf(int n)
{
	return n*(3*n+1)/2;
}



int main(void)
{
	long long hex = 40755;
	long long hexn = 143;
	long long max = 40756;
	long long pent = 40755;
	long long pentn = 165;
	long long tri = 40755;
	long long trin = 286;

	do
	{
		do
		{
			++trin;
			tri = trif(trin);
		} while (tri < max);
		if (tri > max)
		{
			max = tri;
			printf("  %llu\n", max);
		}
		

		do
		{
			++hexn;
			hex = hexf(hexn);
		} while (hex < max);
		if (hex > max)
		{
			max = hex;
			printf("  %llu\n", max);
		}
		

		do
		{
			++pentn;
			pent = pentf(pentn);
		} while (pent < max);
		if (pent > max)
		{
			max = pent;
			printf("  %llu\n", max);
		}
	} while ((tri != pent) + (tri != hex));
	printf("%llu\n", max);
	return 0;
}