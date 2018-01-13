/*****************************************************************************
 * play_wavfiles.c
 *
 * The program plays a selected one of several WAV files to the laptop speaker. 
 * Written by Xiao Lu
 * Spring 2016
 *****************************************************************************/

#include <stdio.h>
#include <stdlib.h> 	/* malloc() */
#include <unistd.h>     /* sleep() */
#include <stdbool.h>	/* true, false */
#include <string.h>		/* memset() */
#include <ctype.h>		/* tolower() */
#include <math.h>		/* sin() */
#include <sndfile.h>	/* libsndfile */
#include <portaudio.h>	/* portaudio */
#include <ncurses.h> 	/* This library is for getting input without hitting return */

#define MAX_PATH_LEN        256
#define MAX_IFILES		    8
#define MAX_CHN	            2
#define FRAMES_PER_BUFFER   512 /* must be divisible by 2 -- see fade-out window code */
#define PI		            3.14159265358979323846

/* data structure to pass to callback */
struct BUF_tag {
    /* libsndfile data structures */
    SNDFILE *sndfile[MAX_IFILES]; 
    SF_INFO sfinfo[MAX_IFILES];
	unsigned int num_chan;
    int selection;
};
typedef struct BUF_tag Buf;

/* PortAudio callback function protoype */
static int paCallback( const void *inputBuffer, void *outputBuffer,
    unsigned long framesPerBuffer,
    const PaStreamCallbackTimeInfo* timeInfo,
    PaStreamCallbackFlags statusFlags,
    void *userData );

int main(int argc, char *argv[])
{
	char ifilename[MAX_IFILES][MAX_PATH_LEN], ch;
	int i, selection;
	unsigned int num_input_files, samp_rate, num_chan;
	FILE *fp;
    char *usageLine = "Usage Line: main ifile_list.txt";
	/* my data structure */
	Buf iBuf, *p = &iBuf;
	/* PortAudio data structures */
    PaStream *stream;
    PaError err;
    PaStreamParameters outputParams;
    PaStreamParameters inputParams;

	/* zero libsndfile structures */
	for (i=0; i<MAX_IFILES; i++) {
		memset(&p->sfinfo[i], 0, sizeof(p->sfinfo[i]));
	}
	/* 
	 * Parse command line and open all files 
	 */

     /* print usage and return if not enough args */
     if (argc != 2)
     {
         printf("%s\n", usageLine);
         return -1;
     }
  	/* open list of files */
    fp = fopen(argv[1],"r");

  	for (i=0; i<MAX_IFILES; i++) {
	    /* read file from list */
        if (fscanf(fp,"%s", ifilename[i]) == EOF )
            break;
 		/* open audio file */
        if ( (p->sndfile[i] = sf_open (ifilename[i], SFM_READ, &p->sfinfo[i])) == NULL ) 
        {
            fprintf (stderr, "Error: could not open wav file: %s\n", ifilename[i]);
            return -1;
        }
		/* Print file information */
		printf("#%d   Frames: %8d, Channels: %d, Samplerate: %d, %s\n",  
			i, (int)p->sfinfo[i].frames, p->sfinfo[i].channels, p->sfinfo[i].samplerate, ifilename[i]);
 	}
 	num_input_files = i;
    printf("Total no. of input files: %d\n", num_input_files );

 	/* check for compatibility of input files */

    samp_rate = p->sfinfo[0].samplerate;
    num_chan = p->sfinfo[0].channels;
    for (i = 1; i < num_input_files; i++)
    {
        /* If sample rates don't match, exit */        
        if ( p->sfinfo[i].samplerate != samp_rate )
        {
            printf("Sample rates dont' match.\n");
            return -1;
        }
        /* If number of channels don't match or too many channels, exit */
        if ( p->sfinfo[i].channels != num_chan )
        {
            printf("Number of channels dont' match.\n");
            return -1;
        }
    }
    /* check that number of channels are not greater than MAX_CHN */
    if (num_chan>MAX_CHN)
    {
        printf("Number of channels can't be greater than %d.\n", MAX_CHN);
        return -1;
    }

	/* initialize structure */
	p->num_chan = num_chan;
    /* initially, don't play any file */
    p->selection = -1;

    /* pause so user can read console printout */
    sleep(1);

	/* Initializing PortAudio */
    err = Pa_Initialize();
    if (err != paNoError) {
        printf("PortAudio error: %s\n", Pa_GetErrorText(err));
        printf("\nExiting.\n");
        return -1;
    }
    
    /* Input stream parameters */
    inputParams.device = Pa_GetDefaultInputDevice();
    inputParams.channelCount = 1;
    inputParams.sampleFormat = paFloat32;
    inputParams.suggestedLatency =
        Pa_GetDeviceInfo(inputParams.device)->defaultLowInputLatency;
    inputParams.hostApiSpecificStreamInfo = NULL;

    /* Ouput stream parameters */
    outputParams.device = Pa_GetDefaultOutputDevice();
    outputParams.channelCount = 2;
    outputParams.sampleFormat = paFloat32;
    outputParams.suggestedLatency =
        Pa_GetDeviceInfo(outputParams.device)->defaultLowOutputLatency;
    outputParams.hostApiSpecificStreamInfo = NULL;
    
    /* Open audio stream */
    err = Pa_OpenStream(&stream,
        &inputParams, /* no input */
        &outputParams,
        samp_rate, FRAMES_PER_BUFFER,
        paNoFlag, /* flags */
        paCallback,
        &iBuf);
    
    if (err != paNoError) {
        printf("PortAudio error: open stream: %s\n", Pa_GetErrorText(err));
        printf("\nExiting.\n");
        return -1;
    }
    
     /* Start audio stream */
    err = Pa_StartStream(stream);
    if (err != paNoError) {
        printf(  "PortAudio error: start stream: %s\n", Pa_GetErrorText(err));
        printf("\nExiting.\n");
        return -1;
    }

	/* Initialize ncurses 
     * to permit interactive character input 
     */
	initscr(); /* Start curses mode */
	cbreak();  /* Line buffering disabled */
	noecho(); /* Uncomment this if you don't want to echo characters when typing */  

    printw("Select input file by number:\n");
    for (i=0; i<num_input_files; i++) {
    	printw("%2d %s\n", i, ifilename[i]);
    }
    printw("Q to quit\n");
    mvprintw(6, 0, "               Selection: ");
	refresh();

	ch = '\0'; /* Init ch to null character */
	while (ch != 'q') {
		ch = tolower(getch()); 
		if (ch >= '0' && ch < '0'+num_input_files) {
			selection = ch-'0';
            /* write information to be read in callback
             * this "one-way" communication of a single item
             * eliminated the possibility of race condition due to
             * asynchronous threads
             */
            p->selection = selection;
            mvprintw(6, 0, "Playing #%d, New selection: ", selection);
		} 
        refresh();
	}

	/* End curses mode  */
	endwin();

    /* Stop stream */
    err = Pa_StopStream(stream);
    if (err != paNoError) {
        printf(  "PortAudio error: stop stream: %s\n", Pa_GetErrorText(err));
        printf("\nExiting.\n");
        exit(1);
    }
    
    /* Close stream */
    err = Pa_CloseStream(stream);
    if (err != paNoError) {
        printf(  "PortAudio error: close stream: %s\n", Pa_GetErrorText(err));
        printf("\nExiting.\n");
        exit(1);
    }
    
    /* Terminate PortAudio */
    err = Pa_Terminate();
    if (err != paNoError) {
        printf("PortAudio error: terminate: %s\n", Pa_GetErrorText(err));
        printf("\nExiting.\n");
        exit(1);
    }
    
	/* Close files */
	for (i=0; i<num_input_files; i++) {
		sf_close (p->sndfile[i]);
	}

    return 0;
}


/* This routine will be called by the PortAudio engine when audio is needed.
 * It may called at interrupt level on some machines so don't do anything
 * in the routine that requires significant resources.
 */
static int paCallback(const void *inputBuffer, void *outputBuffer,
    unsigned long framesPerBuffer,
    const PaStreamCallbackTimeInfo* timeInfo,
    PaStreamCallbackFlags statusFlags,
    void *userData)
{
    Buf *p = (Buf *)userData; /* Cast data passed through stream to our structure. */
    float *output = (float *)outputBuffer;
    //float *input = (float *)inputBuffer; /* input not used in this code */
    unsigned int num_samples = framesPerBuffer * p->num_chan; /* number or samples in buffer */
    unsigned int selection, i, count;
 
    selection = p->selection;
    if (selection == -1) {
        /* if selection == -1 then just zero output buffer */
        memset(output, 0, sizeof(*output));
    }
    else {
     	/* read a buffer of input data
     	 * count is number of samples read 
         */
    	count = sf_read_float (p->sndfile[selection], output, num_samples);
    	if (count < num_samples) {
    		/* if a partial buffer was read, 
             * seek back to the beginning of the data part of audio file 
             */
            sf_seek(p->sndfile[selection], 0, SF_SEEK_SET) ;
         	/* and read rest buffer */
            count = sf_read_float (p->sndfile[selection], output, num_samples);
    	}
    }

    return 0;
}
