#ifndef __PROCESS_AUDIO
#define __PROCESS_AUDIO

void process_audio(Buf *ibuf, int iframes, int channels, Buf *rbuf, int rframes, Buf *obuf);
// double rms(float *x, int size);

#endif /* __PROCESS_AUDIO */