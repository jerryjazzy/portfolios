/***************************************************************************
 * tower.c
 * 
 * Lab 3
 * Solves the Tower of Hanoi problem
 *
 * Written by Xiao Lu
 * March 2016
 ***************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>
#include <stdbool.h>
#include <time.h>
#include <string.h>


/* constants */
#define NUM_COLUMNS 3 
#define HEIGHT 8 // default: 8
#define FRAME_RATE_DEFAULT 500000

/* global grid */
char grid[NUM_COLUMNS][HEIGHT];

/* frame rate */
float frameRateSetting = 0.1; // default: 1.0

// function prototypes
void clear();
void init();
void draw();
void display();
void moveTower(int N, int source, int middle, int destination);


int main(int argc, char *argv[])
{

    /* check to make sure there are either zero or one argument */
    if (argc > 2) {
        printf("Usage: %s [rate]\n", argv[0]);
        return 1;
    }
    /* if an argument is supplied... */
    if (argc == 2) {
        frameRateSetting = atof(argv[1]);
    }

    init();
    clear();
    draw();

    // user hits return to start
    printf("Press return to move tower ");
    char ch;
    scanf("%c", &ch);

    // use recursive function to solve problem
    moveTower(HEIGHT, 0, 1, 2);

    printf("Done.\n");

    return 0;
}

int numMoves = 0; // count the number of moves
int height_s, height_d;

void moveTower(int num, int source, int middle, int destination) {
    /* TODO: Implement the recursive function */

    if (num >= 1)
    {
        // first recursion - temporarily put the top disk onto the middle pole   
        moveTower(num - 1, source, destination, middle);
        printf("num = %d \n", num);
    
        // calculate heights of source&destination for displaying
        height_s = 0;
        height_d = 0;
        while ( grid[source][height_s] == 0 )
        {
             height_s++;
        } 
        for ( int i = 0; i < HEIGHT; i++)
        {
             if (grid[destination][i] != 0)
             {
                 height_d++;
             }
        }  
        height_s = HEIGHT - height_s;

        // move the disk
        grid[destination][HEIGHT - height_d - 1] = grid[source][HEIGHT - height_s];
        grid[source][HEIGHT - height_s] = 0;
        numMoves++;        
        display();

        // second recursion
        moveTower(num - 1, middle, source, destination);        
    }
    else
    {   
        display();
        printf("%d moves.\n", numMoves);
    }

}

void init() {
    int i, j;

    for (j = 0; j < HEIGHT; j++) {
        grid[0][j] = j+1;
    }

    for (i = 1; i < NUM_COLUMNS; i++) {
        for (j = 0; j < HEIGHT; j++) {
            grid[i][j] = 0;
        }
    }
}

void display()
{
    clear();
    draw();
    usleep(frameRateSetting * FRAME_RATE_DEFAULT);
}

/* Clears screen using ANSI escape sequences. */
void clear()
{
    printf("\033[2J");
    printf("\033[%d;%dH", 0, 0);
}


/* Prints the grid in its current state. */
void draw()
{
    int cols, num = 0;

    for (num = 0; num <  HEIGHT; num++) {
        for (cols = 0; cols < NUM_COLUMNS; cols++) {
            if (grid[cols][num] != 0) {
                printf("  %d  ", grid[cols][num]); 
            } else {
                printf("     ");
            }
        }
        printf("\n");
    }
    printf(" ---  ---  --- ");
    printf("\n");
}
