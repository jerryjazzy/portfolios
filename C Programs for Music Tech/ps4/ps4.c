/***************************************************************************
 * ps4.c
 * This program reads in a WAV file, displays the header and related info,
 * calculates either the max or the RMS value, then normalizes the data, 
 * and finally outputs a new WAV file.
 *
 * Written by Xiao Lu
 * Spring 2016
 ***************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>
#include <float.h>
#include <math.h>


#define MODE_MAX 1
#define MODE_RMS 2

double my_abs(short x);
double max( double x, double y );
double rms(short *x, int size);

int main(int argc, char *argv[])
{
	char *ifile, *ofile; 
	char *usageLine = "USAGE LINE: main –max level_dBFS | -rms level_dBFS ifile ofile" ;
	int level_dBFS;
	int mode;
	FILE *ifp, *ofp;
	char c;
	unsigned char header[44];
	int numChan, fsamp, bitsPerSample, dataSize;
	short *x, *x_new;
	int numSamples; 
	double vmax = DBL_MIN;
	double vrms = 0;
	double target_value;

	// parsing & error checking
	if (argc != 5)
	{
		printf("%s\n", usageLine);
		return -1;
	}

	if ( strncmp(argv[1],"-max", 4) == 0)
	{
		mode = MODE_MAX;
	}
	else if ( strncmp(argv[1],"-rms", 4) == 0 )
	{
		mode = MODE_RMS;
	}
	else
	{
		printf("%s\n", usageLine);
		return -1;
	}

	level_dBFS = atoi(argv[2]);	
	ifile = argv[3];
	ofile = argv[4];

	// open the file and read in the data
	if ( (ifp = fopen(ifile, "r")) == NULL) 
	{
		printf("Cannot open %s.\n", ifile);
		return -1;
	}
	
	if ( fread(header, sizeof(header), 1, ifp) != 1 ) 
	{
		printf("Cannot read the header.\n");
		return -1;
	}


	printf("--- Header ---\n");
	for (int i = 0; i < 44; i++)
	{
		// if header[i] is an ASCII character, then print the character, otherwise print a SPACE character
		c = isalpha(header[i]) ? header[i] : ' '; // <-- nice method

		/*	Print each byte of the wav header as character and hexadecimal values 
			as 4 lies of 11 characters per line */
		printf("%c %02x ", c, header[i]);
		if (i == 10){printf("\n");}
		if (i == 21){printf("\n");}
		if (i == 32){printf("\n");}
		if (i == 43){printf("\n");}
	}
	printf("--- Info ---\n");

	// print some info of the file, dealing with little endian
	numChan = header[23]<<8 | header[22];
	printf("number of channels: %d\n", numChan);
	fsamp = header[27]<<24 | header[26]<<16 | header[25]<<8 | header[24];
	printf("sampling rate: %d\n", fsamp);
	bitsPerSample = header[35]<<8 | header[34];
	printf("bits per sample: %d\n", bitsPerSample);
	dataSize = header[43]<<24 | header[42]<<16 | header[41]<<8 | header[40];
	printf("data size(in bytes): %d\n", dataSize);

	// calculate the no. of samples
	numSamples = dataSize * 8 / bitsPerSample;

	// create pointers to store the binary data of sound
	if ( (x = (short *)malloc(numSamples * sizeof(*x))) == NULL) 
	{
		printf("Fail to allocate storage for the data.\n");
		return -1;
	}
	if ( (x_new = (short *)malloc(numSamples * sizeof(*x_new))) == NULL) 
	{
		printf("Fail to allocate storage for the data.\n");
		return -1;
	}

	printf("No. of Samples = %d\n", numSamples);

	// read the data to x
	if ( fread(x, sizeof(*x), numSamples, ifp) != numSamples ) 
	{
		printf("Cannot read the data.\n");
		return -1;
	}

	target_value = 32767 * pow(10, level_dBFS/20.0);// 32767 is used as a normalization factor

	printf("--- Result ---\n");
	if ( mode == MODE_MAX )
	{
		for (int i = 0; i < numSamples; i++)
		{
			vmax = max( vmax, my_abs(x[i]) );
		}
		for (int i = 0; i < numSamples; i++)
		{
			x_new[i] = x[i] * (target_value / vmax);
		}
		printf("Mode: Max\nThe maximum value is %f\n", vmax);
	}
	else if ( mode == MODE_RMS )
	{
		vrms = rms(x, numSamples);

		for (int i = 0; i < numSamples; i++)
		{
			x_new[i] = x[i] * (target_value / vrms);
		}
		printf("Mode: RMS\nThe RMS is %f\n", vrms);
	}	

	// write the adjusted data into the output file with a WAV header
	if ( (ofp = fopen(ofile, "w")) == NULL ) 
	{
		printf("Cannot open %s.\n", ofile);
		return -1;
	}
	if ( fwrite(header, sizeof(header), 1, ofp) != 1 ) 
	{
		printf("Cannot write the header.\n");
		return -1;
	}
	if ( fwrite(x_new, sizeof(*x_new), numSamples, ofp) != numSamples ) 
	{
		printf("Cannot write the data.\n");
		return -1;
	}

	// close the files and deallocate memories used.
	free(x);
	free(x_new);
	fclose(ifp);
	fclose(ofp);
	printf("Done.\n");

	return 0;
}


double my_abs(short x)
{
	return  ((x) >= 0 ) ? (x) : (-x) ;
}

double max( double x, double y )
{
	return (x >= y ) ? (x) : (y) ;
}

double rms(short *x, int size)
{
	double temp;
	int i = 0;
	while( i < size )
	{
		temp += x[i]*x[i];
		i++;
	}
	temp /= size;

	return sqrt(temp);
}