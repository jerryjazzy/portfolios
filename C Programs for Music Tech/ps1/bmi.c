/*
	The program calculates BMI and informs the status by inputting one's height and weight

	Written by  Xiao Lu
*/

#include <stdio.h>
#include <stdbool.h>

int main()
{
	float weight, inches, height;
	int feet;
	float BMI;
	char *status;

	// read in the weight and height, and then do error checking.
	while (true)
	{
		printf("Please enter your weight in pounds: ");
		scanf("%f", &weight);
		if (weight >= 0){break;	}
		else{printf("It should be non-negative...right?\n");}
	}
	while (true)
	{
		printf("Your Height (feet): ");
		scanf("%d", &feet);
		if (feet >= 0){break;}
		else{printf("It should be non-negative...right?\n");}
	}
	while (true)
	{
		printf("Height (inches): ");
		scanf("%f", &inches);
		if (inches >= 0){break;}
		else{printf("It should be non-negative...right?\n");}
	}

	// calculate BMI according to the given formula
	height = inches + 12 * feet ;
	BMI = (weight / (height*height)) * 703.0;

	// obtain the corresponded status
	if (BMI < 18.5){ status = "Underweight";}
	else if (BMI <= 24.9){ status = "Normal";}
	else if (BMI <= 29.9){ status = "Overweight";}
	else { status = "Obese";}

	// display the results
	printf("Your BMI is %.1f. You are %s.\n", BMI, status);//note: the BMI is rounded to one decimal place

	return 0;

}