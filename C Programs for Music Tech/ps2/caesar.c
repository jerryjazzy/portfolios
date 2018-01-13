/***************************************************************************
 * caesar.c
 * The program encrypts messages using Caesar’s cipher.
 * Written by Xiao Lu
 * Spring 2016
 ***************************************************************************/
#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h> 
#include "inputlib.h"

#define IDX_Z 90  // index of the uppercase Z in ASCII code
#define IDX_z 122 // index of the lowercase z in ASCII code

bool isNumber(char *param);
char *encrypt(char *msg, unsigned long shift);

int main(int argc, char *argv[])
{
	unsigned long shift; // works for non-negative integers less than 2^31
	char *msg, *result; 
	char *ptr; // for the strtoul function
	
	// Error checkings
	if (argc != 2)
	{
		printf("Please put ONE argument!\n");
		exit(1);
	}
	if ( !isNumber( argv[1]) )
	{	
		printf("The argument can only be a non-negative integer!\n");
		exit(1);
	}

	shift = strtoul(argv[1], &ptr, 10);// Note: strtoul(const char *str, char **endptr, int base)

	printf("Please enter plaintext to encrypt: ");
	msg = getString();

	// Call the encryption function
	result = encrypt(msg, shift);

	// Print the result
	printf("Ciphertext: %s\n", result);

	return EXIT_SUCCESS;
}


/* This function checks if the given string is a non-negative integer or not. */
bool isNumber(char *param)
{   
	int i = 0;
    while (param[i]) 
    { // Since param[i] is a char, it only equals to 0 when it's NULL, elsewise anything is non-zero.
        if (!isdigit((int)param[i]))
        {
        	// printf("Includes non-digit element(s).\n");
            return false;
        }
       i++;
    }
    return true;
} 


/* This function encripts the message given, based on Caeser's cipher. */
char *encrypt(char *msg, unsigned long shift)
{
	shift = shift % 26; // to ensure that any number is valid
	int i = 0;
	char *result = malloc((strlen(msg)+1) * sizeof(char));

	while ( msg[i] )
	{
		if ( islower(msg[i]) )
		{
			if (msg[i] + shift > IDX_z)
			{
				result[i] = msg[i] + shift - 26;
			}
			else
			{
				result[i] = msg[i] + shift;
			}
		}
		else if ( isupper(msg[i]) )
		{
			if (msg[i] + shift > IDX_Z)
			{
				result[i] = msg[i] + shift - 26;
			}
			else
			{
				result[i] = msg[i] + shift;
			}
		}
		else
		{
			result[i] = msg[i];
		}

		i++;	
	}
	result[i] = '\0'; // to mark the result as a string

	return result;
}
