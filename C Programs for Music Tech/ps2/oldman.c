/***************************************************************************
 * oldman.c
 * This program prints the lyrcis of the song named "This Old Man".
 * Written by Xiao Lu
 * Spring 2016
 ***************************************************************************/
#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

void printLyrics(int numVerse);

int main()
{
	// Call ten times the printLyrics function
	for (int i = 1; i <= 10; i++)
	 {
	 	printLyrics(i);
	 }
	printf("\n"); // Just for a neat output

	return EXIT_SUCCESS;
}

void printLyrics(int numVerse)
{
	char *where;

	switch (numVerse)
	{
		case 1: where = "on my thumb"; break;
		case 2: where = "on my shoe" ; break;
		case 3: where = "on my tree"; break;
		case 4: where = "on my door" ; break;
		case 5: where = "on my hive"; break;
		case 6: where = "on my sticks" ; break;
		case 7: where = "up in heaven"; break;
		case 8: where = "on my gate" ; break;
		case 9: where = "on my spine"; break;
		case 10: where = "on my hen" ; break;
		default: printf("ERROR!\n");break;
	}
	printf("\nThis old man, he played %d,\n", numVerse);
	printf("He played knick-knack %s;\n", where);
	printf("With a knick-knack paddy-whack, give a dog a bone,\nThis old man came rolling home.\n");
}
