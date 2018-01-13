/*****************************************************************************
 * wav_reverb.c
 *
 * Adds reverberation to the audio source given a recording of an impulse response
 * Written by Xiao Lu
 * Spring 2016
 *****************************************************************************/


#include <stdio.h>
#include <stdlib.h> 	/* malloc */
#include <stdbool.h>	/* true, false */
#include <string.h>		/* memset */
#include <sndfile.h>	/* libsndfile */
#include "wav_reverb.h"	/* data structures */
#include "process_audio.h"	/* external function prototypes */

/* local function prototypes */
bool read_input(SNDFILE *sfile, SF_INFO *sfinfo, Buf *buf);
bool write_output(SNDFILE *sfile, SF_INFO *sfinfo, Buf *buf, long frames);

int main(int argc, char *argv[])
{
	char *ifilename, *rfilename, *ofilename;
	int i, oframes;
	char *usageLine = "main ifile.wav reverb_file.wav [ofile.wav]";
	/* my data structures */
	Buf ibuf, rbuf, obuf;
	/* libsndfile data structures */
	SNDFILE *isfile, *rsfile, *osfile; 
	SF_INFO isfinfo, rsfinfo, osfinfo;

	/* zero libsndfile structures */
	memset(&isfinfo, 0, sizeof(isfinfo));
  	memset(&rsfinfo, 0, sizeof(rsfinfo));
  	memset(&osfinfo, 0, sizeof(osfinfo));

  	/* zero buffer pointers in Buf structures */
  	for (i=0; i<MAX_CHN; i++) {
  		ibuf.buf[i] = 0;
  		rbuf.buf[i] = 0;
  		obuf.buf[i] = 0;
  	}

	// Problem 1:
	// ToDo: Parse command line and open all files
	if ( argc < 3 || argc > 4 )
    {
        printf("%s\n", usageLine);
        return -1;
    }
    ifilename = argv[1];
    rfilename = argv[2];
    if (argc == 3)
    {	ofilename = "foo.wav"; }
    else 
    { 	ofilename = argv[3]; }	

    /* Open input file */
    if ( (isfile = sf_open (ifilename, SFM_READ, &isfinfo)) == NULL ) {
        fprintf (stderr, "Error: could not open wav file: %s\n", ifilename);
        return -1;
    }

    /* Open reverb file */
    if ( (rsfile = sf_open (rfilename, SFM_READ, &rsfinfo)) == NULL ) {
        fprintf (stderr, "Error: could not open wav file: %s\n", rfilename);
        return -1;
    }


	/* Print input file information */
	printf("Input audio file %s:\n\tFrames: %d Channels: %d Samplerate: %d\n", 
		ifilename, (int)isfinfo.frames, isfinfo.channels, isfinfo.samplerate);

	printf("Impulse response file %s:\n\tFrames: %d Channels: %d Samplerate: %d\n", 
		rfilename, (int)rsfinfo.frames, rsfinfo.channels, rsfinfo.samplerate);

	/* If sample rates don't match, exit */
	if ( isfinfo.samplerate != rsfinfo.samplerate )
	{
		printf("Sample rates dont' match.\n");
		return -1;
	}
	/* If number of channels don't match or too many channels, exit */
	if ( isfinfo.channels != rsfinfo.channels )
	{
		printf("No. of channels dont' match.\n");
		return -1;
	}

	/* When opening a file for writing, the caller must fill in structure members 
	* 	samplerate, channels, and format. 
	* Make these the same as input file.
	*/
	osfinfo.samplerate = isfinfo.samplerate;
	osfinfo.channels = isfinfo.channels;
	osfinfo.format = isfinfo.format;
    osfinfo.frames = isfinfo.frames + rsfinfo.frames;	 // ?
    oframes = osfinfo.frames;
	/* open output file */
    if ( (osfile = sf_open (ofilename, SFM_WRITE, &osfinfo)) == NULL ) {
        printf ("Error : could not open wav file : %s\n", ofilename);
        return -1;
    }

	// Problem 2:
	// ToDo: Allocate all buffers and read input into buffers

	/* Allocate separate buffers for each channel of 
	 * input, reverb and output files
	 */
	for (i=0; i<isfinfo.channels; i++) {
		if ( (ibuf.buf[i] = (float *)malloc(isfinfo.frames * sizeof(*ibuf.buf[i]))) == NULL ) 
	    {
	        printf("Fail to allocate storage for the ibuf.\n");
	        return -1;
	    }
	    if ( (rbuf.buf[i] = (float *)malloc(rsfinfo.frames * sizeof(*rbuf.buf[i]))) == NULL ) 
	    {
	        printf("Fail to allocate storage for the rbuf.\n");
	        return -1;
	    }
		/* output is length of input + length of reverb -1 */
		if ( ( obuf.buf[i] = (float *)malloc(osfinfo.frames * sizeof(*obuf.buf[i])) ) == NULL ) 
	    {
	        printf("Fail to allocate storage for the obuf.\n");
	        return -1;
	    }

	}
	printf("Allocated buffers\n");

	/* read interleaved data from files into de-interleaved buffers */
	/* input */
	if ( !read_input(isfile, &isfinfo, &ibuf) ) {
		fprintf(stderr, "ERROR: Cannot read input file %s", ifilename);
		return -1;
	}
	/* reverb */
	if ( !read_input(rsfile, &rsfinfo, &rbuf) ) {
		fprintf(stderr, "ERROR: Cannot read input file %s", rfilename);
		return -1;
	}
	printf("Read input files\n");

	/* process each channel of input with reverb impulse response
	 * to make output
	 */
	printf("Processing audio...\n");
	process_audio(&ibuf, isfinfo.frames, isfinfo.channels, &rbuf, rsfinfo.frames, &obuf);
	printf("Finished processing audio\n");

	/* interleave output data and write output file */
	if ( !write_output(osfile, &osfinfo, &obuf, oframes) ) {
		fprintf(stderr, "ERROR: Cannot write output file %s", ofilename);
		return -1;
	}

	/* Must close file; output will not be written correctly if you do not do this */
	sf_close (isfile);
	sf_close (rsfile);
	sf_close (osfile);

	/* free all buffer storage */
	printf("Freeing buffers\n");
	for (i=0; i<MAX_CHN; i++) {
		if (ibuf.buf[i] != NULL)
			free(ibuf.buf[i]);
		if (rbuf.buf[i] != NULL)
			free(rbuf.buf[i]);
		if (obuf.buf[i] != NULL)
			free(obuf.buf[i]);
	}

}

bool read_input(SNDFILE *sfile, SF_INFO *sfinfo, Buf *buf)
{
	int i, j, count;
	float frame_buf[MAX_CHN]; /* to hold one sample frame of audio data */
	for (i=0; i < sfinfo->frames; i++) {
		/* for each frame */
		if ( (count = sf_read_float (sfile, frame_buf, sfinfo->channels)) != sfinfo->channels ) 
		{
			fprintf(stderr, "Error: on sample frame %d\n", i);
			return false;
		}
		//ToDo: de-interleave the frame[j] into separate channel buffers buf->buf[j][i]
		for (j = 0; j < count; j++)
		{
			buf->buf[j][i] = frame_buf[j];
		}
	}
	return true;
}

bool write_output(SNDFILE *sfile, SF_INFO *sfinfo, Buf *buf, long frames)
{
	int i, j, count;
	float frame_buf[MAX_CHN]; /* to hold one sample frame of audio data */
	for (i=0; i<frames; i++) {
		/* for each frame */
		//ToDo: interleave separate channel buffers buf->buf[j][i] into a frame_buf[j]
		for (j = 0; j < sfinfo->channels; j++)
		{
			frame_buf[j] = buf->buf[j][i];
		}
		if ( (count = sf_write_float (sfile, frame_buf, sfinfo->channels)) != sfinfo->channels ) 
		{
			fprintf(stderr, "Error: on sample frame %d\n", i);
			return false;
		}
	}
	printf("Wrote %ld frames\n", frames);
	return true;
}
