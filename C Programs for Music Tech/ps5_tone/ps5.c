/***************************************************************************
 * ps5.c
 * 
 *
 * Written by Xiao Lu
 * Spring 2016
 ***************************************************************************/


#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>
// #include <float.h>
#include <math.h>

#define PI 3.14159265358979323846

typedef struct sound_data {
          float *tone;
          unsigned int tone_len;
          unsigned int next_samp;
          unsigned int count;
} SoundData;

int main(int argc, char *argv[])
{
	double f0= 440; // frequency of tone to play out
    double fs = 48000; // sampling frequency of play out
    int level_dBFS = -24; // level of play out, dBFS
    char *usageLine = "main [–f freq_in_Hz] [–a level_in_dBFS] [-s sampling_freq_in_Hz]";

    /* Pt.1 - Command Line Parsing & Error Checking */
    if (argc > 7 || argc%2 == 0)
    {
    	printf("%s. \n", usageLine);
    	return -1;
    }
    for (int i = 1; i <= argc-1; i+=2)
    {
	    if (argv[i][0] == '-')
	    {
	    	switch (argv[i][1])
	    	{
	    		case 'f':
	    			f0 = atoi(argv[i+1]);
	    			break;
	    		case 'a':
	    			level_dBFS = atoi(argv[i+1]);
	    			break;
	    		case 's':
	    			fs = atoi(argv[i+1]);
	    			break;
	    		default:
	    			printf("Invalid command! \nInput f for frequency, a for level in dBFS, or s for sample rate \n");
	    			return -1;
	    	}
	    }
	    else
	    {
	    	if ( argc == 1 )
	    	{
	    		break;
	    	}
	    	else
	    	{
		    	printf("%s.\n", usageLine);
		    	return -1;
	    	}
	    }
	}

    printf("f0: %f, fs: %f, level: %d\n", f0, fs, level_dBFS );

    /* Pt.2 - Generate the tone */
    SoundData data;
    data.tone_len = fs;
    data.next_samp = 0;
    data.count = 0;
	double level = pow(10, level_dBFS/20.0);

	// storage allocation
	if ( (data.tone = (float *)malloc(data.tone_len * sizeof(*data.tone))) == NULL) 
	{
		printf("Fail to allocate storage for the data.\n");
		return -1;
	}
	// Fill the tone[] array with a sine wave signal.
	for (int i = 0; i < data.tone_len; i++)
	{
		data.tone[i] = level * sin(2*PI*i*f0/fs);
	}

	for (int i = 0; i < 100; i++)
	{
		printf("%f\n", data.tone[i]);
	}

	free(data.tone);
	return 0;
}