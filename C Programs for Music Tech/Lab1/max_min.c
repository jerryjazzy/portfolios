/*
 * =====================================================================================
 *
 *       Filename:  max_min.c
 *
 *    Description:  Gets the maximum and minimum value of an array.
 *
  * =====================================================================================
 */

#include <stdio.h>
#include <limits.h>

#define MAX_LENGTH 5

int main() {
    // Variables Declaration
    int array[MAX_LENGTH];
    int max, min, i;

    // Read array from user
    printf("Please, enter %d array values:", MAX_LENGTH);
    for (i = 0; i < MAX_LENGTH; i++) {
        scanf("%d", &array[i]);
    }

    // Calculate maximum
    max = INT_MIN;
    for (i = 0; i < MAX_LENGTH; i++) {
        if (array[i] > max) {
            max = array[i];
        }
    }

    // Calculate minimum
    min = INT_MAX;
    for (i = 0; i < MAX_LENGTH; i++) {
        if (array[i] < min) {
            min = array[i];
        }
    }

    // Print out results
    printf("Maximum value is %d, and minimum value is %d\n", max, min);

    return 0;
}
