#include <stdio.h>

int main()
{
	long long a = 1;
	long long b = 1;
	long long c = 0;
	long long d = 0;
	do
	{
		c = a + b;
		if (c % 2 == 0)
		{
			printf("%u\n",c);
			d += c;
		}
		a = b;
		b = c;
	} while (c < 99999999999);
	printf("%u\n",d);
}