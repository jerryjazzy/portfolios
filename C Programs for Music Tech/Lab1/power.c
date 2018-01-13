#include <stdio.h>

int main()
{
    /* Declare variables */
    int base, expo, i; 
    long result = 1;

    /* Input base */
    printf("Please, enter base: ");
    scanf("%d", &base);

    /* Input exponent */
    printf("Please, enter exponent: ");
    scanf("%d", &expo);

    /* Compute power */
    for (i = 1; i <= expo; ++i) {
        result *= base;
    }

    /* Print result */
    printf("The result is %ld\n", result);

    return 0;
}
