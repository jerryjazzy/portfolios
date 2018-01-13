/*
 * =====================================================================================
 *
 *       Filename:  limits.c
 *
 *    Description:  Check the limits of the default types.
 *
  * =====================================================================================
 */

#include <stdio.h>
#include <limits.h>

int main() {

    // Print out multiple limits
    printf("The maximum value for a short is: %d\n", SHRT_MAX);
    printf("The maximum value for a unsigned short is: %d\n", USHRT_MAX);
    printf("The maximum value for an int is: %d\n", INT_MAX);

    return 0;
}
