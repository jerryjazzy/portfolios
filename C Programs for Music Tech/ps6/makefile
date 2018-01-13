# Makefile
# Program to apply reverberation to an audio file
#


CC      = gcc
CFLAGS  = -g -std=c99 -Wall -I/usr/local/Cellar/libsndfile/1.0.26/include
LIBS    = -L/usr/local/lib -lsndfile

EXE  	= wav_reverb 
SRCS 	= wav_reverb.c process_audio.c convolve.c
OBJS 	= wav_reverb.o process_audio.o convolve.o
DEPS 	= wav_reverb.h process_audio.h convolve.h

#compile *.c to *.o
# the -o $@ says to put the output of the compilation in the file named 
# 	on the left side of the :
# the $< is the first item in the dependencies list, 
#
%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

$(EXE): $(OBJS)
	$(CC) $(CFLAGS) -o $(EXE) $(OBJS) $(LIBS)

clean:
	rm -f *~ core $(EXE) *.o
	rm -rf *.dSYM
