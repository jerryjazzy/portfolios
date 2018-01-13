/***************************************************************************
 * vigenere.c
 * The program encrypts messages using Vigenere's cipher.
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
#define IDX_A 65 // index of the uowercase A in ASCII code
#define IDX_z 122 // index of the lowercase z in ASCII code

bool checkAlpha(char *param);
char *encrypt(char *msg, char *keyword);

int main(int argc, char *argv[])
{
	char keyword[strlen(argv[1])];
	char *message;
	char *result;

	// Error checkings
	if (argc != 2)
	{
		printf("Please put ONE argument!\n");
		exit(1);
	}
	if ( !checkAlpha( argv[1]) )
	{	
		printf("Only alphabetical characters are allowed!\n");
		exit(1);
	}

	// read in the inputs
	strcpy(keyword, argv[1]);
	printf("Please enter plaintext: ");
	message = getString();

	// Call the encryption function
	result = encrypt(message, keyword);

	// Print the encoded text
	printf("Ciphertext: %s\n", result);

	return EXIT_SUCCESS;
}

/* This function checks if the given string is a non-negative integer or not. */
bool checkAlpha(char *param)
{   
	int i = 0;
    while (param[i]) 
    { // Since param[i] is a char, it only equals to 0 when it's NULL, elsewise anything is non-zero.
        if (!isalpha((int)param[i]))
        {
        	// printf("Includes non-digit element(s).\n");
            return false;
        }
       i++;
    }
    return true;
} 

/* This function encripts the message given, based on Vigenere's cipher. */
char *encrypt(char *msg, char *keyword)
{
	int len_msg = strlen(msg);
	int len_key = strlen(keyword);
	char *result = malloc((len_msg+1) * sizeof(char));
	int key[len_msg];
	int i = 0, j = 0, temp;

	// Calculate the key
	while (i < len_msg)
	{
		temp = i % len_key;
		key[i] = toupper(keyword[temp]) - IDX_A;
		i++;
	}

	// Start to encrypt
	i = 0;
	while ( msg[i] )
	{
		if ( islower(msg[i]) )
		{
			if (msg[i] + key[j] > IDX_z)
			{
				result[i] = msg[i] + key[j] - 26;
			}
			else
			{
				result[i] = msg[i] + key[j];
			}
		}
		else if ( isupper(msg[i]) )
		{
			if (msg[i] + key[j] > IDX_Z)
			{
				result[i] = msg[i] + key[j] - 26;
			}
			else
			{
				result[i] = msg[i] + key[j];
			}
		}
		else
		{
			result[i] = msg[i];
			j -= 1;

		}

		i++;
		j++;	
	}

	result[i] = '\0'; // to mark the result as a string

	return result;
}

