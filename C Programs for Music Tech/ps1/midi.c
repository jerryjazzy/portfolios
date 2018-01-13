/*
	The program prompts the user for a MIDI note value between 0 and 127 
	and then prints out a note name for the value entered

	Written by  Xiao Lu
*/

#include <stdio.h>
#include <stdbool.h>

int main()
{
	int midi, temp;
	char *note;

	printf("Please enter a MIDI note value: ");
	while (true)
	{
		scanf("%d", &midi);
		// error checking
		if (midi >= 0 && midi <= 127)
		{
			temp = midi % 12;
			switch (temp)
			{
				// mapping the midi value to the pitch class
				case 0: 
						note = "C";
						break;
				case 1: 
						note = "C#";
						break;
				case 2: 
						note = "D";
						break;
				case 3: 
						note = "D#";
						break;
				case 4: 
						note = "E";
						break;
				case 5: 
						note = "F";
						break;
				case 6: 
						note = "F#";
						break;
				case 7: 
						note = "G";
						break;
				case 8: 
						note = "G#";
						break;
				case 9: 
						note = "A";
						break;
				case 10: 
						note = "A#";
						break;
				case 11: 
						note = "B";
						break;
			}
			printf("The MIDI value %d is equivalent to the pitch %s.\n", midi, note); 
			break;
		}
		else
		{	// if wrong, then re-try
			printf("Please enter a value between 0 and 127. Retry: ");
		}
	}
	return 0;
}