# Makefile
# Program uses sndfile, portaudio and ncurses
#

CC      = gcc
CFLAGS  = -g -std=c99 -Wall -I. -I/usr/local/Cellar/libsndfile/1.0.26/include
LIBS    = -L/usr/local/lib -lsndfile -lportaudio -lncurses 

EXE  	= play_wavfiles 
SRCS 	= play_wavfiles.c
OBJS 	= play_wavfiles.o
DEPS 	= play_wavfiles.h

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
