/*
 * =====================================================================================
 *
 *       Filename:  reverse.c
 *
 *    Description:  Reverses an array.
 *
 * =====================================================================================
 */

#include <stdio.h>

#define MAX_LENGTH 6

int main() {

    // Variables declaration
    int array[MAX_LENGTH];
    int tmp, i;

    // Read the array from the user
    printf("Please, enter %d array values: ", MAX_LENGTH);
    for (i = 0; i < MAX_LENGTH; i++) {
        printf("Enter element %d: ", i);
        scanf("%d", &array[i]);
    }

    // Reverse the array
    for (i = 0; i < MAX_LENGTH / 2; i++) {
        tmp = array[i];
        array[i] = array[MAX_LENGTH - 1 - i];
        array[MAX_LENGTH - 1 - i] = tmp;
    }

    // Print out the reversed array
    printf("Reversed array:\n");
    for (i = 0; i < MAX_LENGTH; i++) {
        printf("%d\n", array[i]);
    }

    return 0;
}
