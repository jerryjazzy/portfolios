/*
	This program calculates how many hours and minutes are in the given amount of seconds

	Written by Xiao Lu
*/

#include <stdio.h>
#include <limits.h>
#include <stdbool.h>

int main() {

	int numSec;
	int hour, min, sec;
	
	while (true){ // an infinite loop until there's a break

		// ask for an integer input
		printf("Please enter number of seconds: ");
	    scanf("%d", &numSec);

	    // error checking (if wrong, keep prompting for a positive integer)
	    if (numSec >= 0 && numSec <= INT_MAX)
	    {
			 // calculate the time
		    sec = numSec % 60;
		    min = numSec / 60;
		    hour = min / 60;
		    min = min - hour * 60;

	    	// output
	    	printf("%d seconds are equal to %d hour(s), %d minute(s), %d second(s)\n", numSec, hour, min, sec);
	    	break;
	    }
	    else 
	    {
	    	printf("Invalid value. Please try again.\n");
	    }
	}
   
    return 0;
}
