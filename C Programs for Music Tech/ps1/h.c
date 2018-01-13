/*
	The program reads a number, N, from the keyboard
	and prints out a block letter H on the screen with sides of size N.
 
	Written by  Xiao Lu
 */

#include <stdio.h>
#include <stdbool.h>

int main()
{
    int size;
    printf("Enter the size of H: ");
    
    // Read the input and check errors
    while (true)
    {
        scanf("%d", &size);
        if (size < 0)
        {
            printf("Wrong input!\nPlease enter a non-negative value: ");
        }
        else{break;}
    }
    
    int i,j;
    
    for (j = 0; j < size; j++)
    {
        for (i = 0; i < size; i++)
        {
            printf("*");
        }
        for (i = size; i < size*2; i++)
        {
            printf(" ");
        }
        for (i = size*2; i < size*3; i++)
        {
            printf("*");
        }
        printf("\n");
    }
    
    for (j = size; j < size*2; j++)
    {
        for (i = 0; i < size*3; i++)
        {printf("*");}
        
        printf("\n");
    }
    
    for (j = size * 2; j < size * 3; j++)
    {
        for (i = 0; i < size; i++)
        {
            printf("*");
        }
        for (i = size; i < size*2; i++)
        {
            printf(" ");
        }
        for (i = size*2; i < size*3; i++)
        {
            printf("*");
        }
        printf("\n");
    }
    
    return 0;
}