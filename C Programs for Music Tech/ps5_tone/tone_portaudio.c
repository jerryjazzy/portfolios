/*****************************************************************************
 * tone.c
 *
 * Plays a tone to speaker using PortAudio 
 * Written by Xiao Lu
 * Spring 2016
 *****************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>
#include "portaudio.h"

// #define SAMPLE_RATE 48000 // commented because fs is defined from command line
#define FRAMES_PER_BUFFER 512
#define PI		3.14159265358979323846
#define NUM_CHN 2

/* sound_data is the structure name
 * soundData is the typdef for the structure 
 */
typedef struct sound_data
{
    float *tone;
    unsigned int tone_len;
    unsigned int next_samp;
    unsigned int count;
} soundData;

/* Callback function protoype */
static int paCallback( const void *inputBuffer, void *outputBuffer,
    unsigned long framesPerBuffer,
    const PaStreamCallbackTimeInfo* timeInfo,
    PaStreamCallbackFlags statusFlags,
    void *userData );

int main(int argc, char *argv[])
{
    int i, level_dB;
    double f0, fs, level;
    soundData data;
    
    PaStream *stream;
    PaError err;
    PaStreamParameters outputParams;
    PaStreamParameters inputParams;

    /*
     * Problem 1: Parse command line args
     */
    
    /* ToDo: set default values */

    f0= 440; // frequency of tone to play out
    fs = 48000; // sampling frequency of play out
    level_dB = -24; // level of play out, dBFS
    char *usageLine = "Usage Line: main [–f freq_in_Hz] [–a level_in_dBFS] [-s sampling_freq_in_Hz]";
 
    /* ToDo: parse command line */
    if (argc > 7 || argc%2 == 0)
    {
        printf("%s\n", usageLine);
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
                    level_dB = atoi(argv[i+1]);
                    break;
                case 's':
                    fs = atoi(argv[i+1]);
                    break;
                default:
                    printf("Invalid command! \n%s\n", usageLine);
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
                printf("%s\n", usageLine);
                return -1;
            }
        }
    }
    /* print parameter values */
    printf("Generating tone: f0 = %.1fHz, fs = %.1fHz, level = %ddB\n", f0, fs, level_dB);
    
    /*
     * Problem 2. Initialize tone
     */
    /* ToDo: set up tone parameters */

    data.tone_len = fs;
    data.next_samp = 0;
    data.count = 0;
    level = pow(10, level_dB/20.0);

    printf("Tone level: %f\n", level);
    printf("Tone length: %d samples\n", data.tone_len);

    /* ToDo: malloc storage for tone */
    if ( ( data.tone = (float *)malloc(data.tone_len * sizeof(*data.tone)) ) == NULL ) 
    {
        printf("Fail to allocate storage for the data.\n");
        return -1;
    }

    /* ToDo: initialize tone */
    for (int i = 0; i < data.tone_len; i++)
    {
        data.tone[i] = level * sin(2*PI*i*f0/fs);
    }

    printf("Tone initialized.\n");

    /* Initializing PortAudio */
    err = Pa_Initialize();
    if (err != paNoError) {
        printf("PortAudio error: %s\n", Pa_GetErrorText(err));
        printf("\nExiting.\n");
        exit(1);
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
    outputParams.channelCount = NUM_CHN;
    outputParams.sampleFormat = paFloat32;
    outputParams.suggestedLatency =
        Pa_GetDeviceInfo(outputParams.device)->defaultLowOutputLatency;
    outputParams.hostApiSpecificStreamInfo = NULL;
    
    /* Open audio stream */
    err = Pa_OpenStream(&stream,
        &inputParams, /* no input */
        &outputParams,
        fs, FRAMES_PER_BUFFER,
        paNoFlag, /* flags */
        paCallback,
        &data);
    
    if (err != paNoError) {
        printf("PortAudio error: open stream: %s\n", Pa_GetErrorText(err));
        printf("\nExiting.\n");
        exit(1);
    }
    
    /* Start audio stream */
    err = Pa_StartStream(stream);
    if (err != paNoError) {
        printf(  "PortAudio error: start stream: %s\n", Pa_GetErrorText(err));
        printf("\nExiting.\n");
        exit(1);
    }

    printf("Starting playout\n");
    /* play out for 5 seconds */
    while (data.count < 5 * fs) {
        printf("%d %d\n", data.count, data.next_samp);
        sleep(1);
    }
    printf("Finished playout\n");
    
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
    /* Cast data passed through stream to our structure. */
    soundData *ptr = (soundData *)userData;
    float *out = (float *)outputBuffer;
    float *in = (float *)inputBuffer;
    unsigned int i, j, k;
        
    /* 
     * Problem 3. Fill audio buffer for each callback
     */

    /* ToDo: Fill buffer from tone data */

    k = ptr->next_samp;
    for ( i = 0; i < framesPerBuffer; i++ ) 
    {
        if (k >= ptr->tone_len) 
        { 
                k=0;
        }
        for (j=0; j<NUM_CHN; j++) 
        {
            out[2*i+j] = ptr->tone[k]; // all channels are interleaved in the out[] buffer
        }
        k++; // increment pointer to tone[]
        ptr->count++; // increment count
    }
    ptr->next_samp = k; // same next_samp

    
    return 0;
}
