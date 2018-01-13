/*****************************************************************************
 * process_audio.c
 *
 * The processing part of the reverb program. (MODE = 2)
 * Written by Xiao Lu
 * Spring 2016
 *****************************************************************************/


#include <stdio.h>
#include <math.h>
#include <sndfile.h>	/* libsndfile */
#include "wav_reverb.h"
#include "convolve.h"	/* FFT-based convolution */

#define MODE	2 

double rms(float *x, int size);

void process_audio(Buf *ibuf, int iframes, int channels, Buf *rbuf, int rframes, Buf *obuf)
{
#if (MODE == 1)
	/* just copy input to output */
	int i, j;
	float *ip, *rp;
	for (i=0; i<channels; i++) {
		ip = ibuf->buf[i];
		rp = rbuf->buf[i];
		for (j=0; j<iframes; j++) {
			obuf->buf[i][j] = ip[j];
		}
		for ( ; j<rframes-1; j++) {
			obuf->buf[i][j] = 0;
		}
	}
#else
#if (MODE == 2)	
	/* do reverberation via time-domain convolution */
	int i, j, k, oframes;
	float *ip, *rp;
	double  gain, rms_iv, rms_ov;
	/* set initial values */
	rms_iv = 0;
	rms_ov = 0;

	// ToDo: convolve each channel signal with reverb impulse response signal
	for ( i = 0; i < channels; i++)
	{
		ip = ibuf->buf[i];
		rp = rbuf->buf[i];
		oframes = iframes + rframes - 1;

		for (j = 0; j < oframes; j++)
		{
			for (k = 0; k < rframes; k++) 
			{
				if ( (j-k) < 0 || (j-k) >= iframes  ) //|| (j-k) > rframes 
					 continue; 
				obuf->buf[i][j] += ip[j-k] * rp[k]; 
			}
		}
		// 	for (k = 0; k < j+1; k++)
		// 	{
		// 		obuf->buf[i][j] += ip[j-k] * rp[k]; // convolution pt.1
		// 	}
		// }
		// for ( ; j < oframes; j++)
		// {
		// 	for (k = 0; k < rframes; k++)
		// 	{
		// 		obuf->buf[i][j] += ip[j-k] * rp[k]; // convolution pt.2
		// 	}
			
		// }

		//scale to make output rms value be equal to input rms value
		rms_iv = rms(ip, iframes);
		rms_ov = rms(obuf->buf[i], oframes);
		gain = rms_iv / rms_ov ;

		for (k = 0; k < oframes; k++)
		{
			obuf->buf[i][k] = obuf->buf[i][k] * gain;
		}
		
	}
	

#else /* (MODE == 3) */
	/* do reverberation via frequency-domain convolution */
	int i;
	/* for each channel */
	for (i=0; i<channels; i++) {
		/* convolve channel signal with reverb impulse response signal */
		/* frequency domain (FFT) convolution */
		convolve(ibuf->buf[i], rbuf->buf[i], iframes, rframes, obuf->buf[i]);
	}
#endif
#endif
}


double rms(float *x, int size)
{
	double temp = 0.0;
	int i = 0;
	while( i < size )
	{
		temp += x[i]*x[i];
		i++;
	}
	temp /= size;

	return sqrt(temp);
}