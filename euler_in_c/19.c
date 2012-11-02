#include <stdio.h>
#include <stdlib.h>




int main(void)
{
	int y = 1;
	int day = 2;
	int count = 0;
	int month[12]= { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
	int leap[12] = { 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
	do
	{
		int i = 0;
		for (i = 0; i < 12; ++i)
		{
			if (day % 7 == 0)
			 {
			 	count += 1;
			 }
			if ((y % 4 == 0) & (y != 0))
			{
				day += leap[i];
			}
			else
			{
				day += month[i];
			}
		}
		printf("%u %u\n", 1900 + y, y%4);
		++y;
	} while (y < 101);
	printf("%u\n", count);
	return 0;
}

