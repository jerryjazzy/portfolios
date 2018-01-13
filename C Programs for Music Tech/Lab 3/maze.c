/***************************************************************************
 * maze.c
 * 
 * Labb 3
 * Solves a maze using recursive backtracking
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
#define DIM_X 70
#define DIM_Y 25
#define START_MARKER 'S'
#define END_MARKER 'G'
#define VISITED_MARKER '.'
#define CURRENT_MARKER '*'
#define WALL_MARKER '|'
#define FRAME_RATE_DEFAULT 200000

/* global grid */
char grid[DIM_X][DIM_Y];


/* file where maze environment is found */
const char *mazeFilename = "maze.txt";

/* frame rate */
float frameRateSetting = .1;

typedef struct Position {
    int x;
    int y;
} Position;



// function prototypes
void clear();
bool solveMaze(Position p);
void drawGrid();
void display();
void readFile(const char *fileName);
Position setStart();



int main(int argc, char *argv[])
{
    Position pos;  
    char ch;

    /* check to make sure there are either zero or one argument */
    if (argc > 2) {
        printf("Usage: %s [rate]\n", argv[0]);
        return 1;
    }

    /* if an argument is supplied... */
    if (argc == 2) {
        frameRateSetting = atof(argv[1]);
    }

    // initialize the maze
    readFile(mazeFilename);

    clear();
    drawGrid();

    // find start point
    pos = setStart();
    printf("Press return to start maze solver ");
    scanf("%c", &ch);

    // Try to solve the maze
    if (solveMaze(pos)) {
        printf("Maze solved!\n");
    } else {
        printf("Maze is unsolvable.\n");
    }

    return 0;
}

bool solveMaze(Position pos) {
    /* To Do -- write recursive function to solve problem */
    Position N;
    Position S;
    Position E;
    Position W;

    if ((grid[pos.x][pos.y]) == END_MARKER)
    {   
        display();
        return true;

    }

    if (grid[pos.x][pos.y] == WALL_MARKER || grid[pos.x][pos.y] == VISITED_MARKER )
    {
        return false;
    }
    if ((pos.x > DIM_X)|| pos.y > DIM_Y )
    {
        return false;
    }
    // drop a visited marker
    grid[pos.x][pos.y] = VISITED_MARKER;
    // printf("Visited: (%d, %d) \n", pos.x, pos.y);

    // update and display the current maze grid
    //display();
    
    // define and initialize the four points of the compass related to current pos
    N.x = pos.x;        N.y = pos.y - 1;
    S.x = pos.x;        S.y = pos.y + 1;
    W.x  = pos.x - 1;   W.y  = pos.y;
    E.x  = pos.x + 1;   E.y  = pos.y;

    if (solveMaze(S)||solveMaze(N)||solveMaze(E)||solveMaze(W))
    {
        grid[pos.x][pos.y] = CURRENT_MARKER;
        // display();
        // printf("Current: (%d, %d) \n", pos.x, pos.y);
        return true;
    }
    else
    {   
        grid[pos.x][pos.y] = ' '; // Erase the visited marker
        // printf("Erasing: (%d, %d) \n", pos.x, pos.y);
        return false;   
    }
    
}

void display() {
    clear();
    drawGrid();
    usleep(frameRateSetting * FRAME_RATE_DEFAULT);
}

Position setStart() 
{
    int i, j;
    Position p;

    for (i = 0; i < DIM_X; i++) {
        for (j = 0; j < DIM_Y; j++) {
            if (grid[i][j] == START_MARKER) {
                p.x = i; p.y = j;
                return p;
            }
        }
    }
    return p;
}

/* Clears screen using ANSI escape sequences. */
void clear()
{
    printf("\033[2J");
    printf("\033[%d;%dH", 0, 0);
}

/* Prints the grid in its current state. */
void drawGrid() {

    int i, j;

    for (j = 0; j < DIM_Y; j++) {
        for (i = 0; i < DIM_X; i++) {
            printf("%c", grid[i][j]);
        }
        printf("\n");
    }
}

/* Read in a file with an preset environment */    
void readFile(const char *filename)
{
    FILE *fp;
    char ch;
    int i, j;

    fp = fopen(filename, "r");
    if (fp == NULL) {
        printf("File not found.\n");
        usleep(1000000);
        return;
    }

    for (j = 0; j < DIM_Y; j++) {
        for (i = 0; i < DIM_X; i++) {
            ch = fgetc(fp);
            if (ch==EOF) {
                printf("BAD FILE.\n");
                if (ch==EOF) {
                    printf("EOF reached\n");
                }
                return;
            }
            grid[i][j] = ch;
        }
        ch = fgetc(fp); // for return character
    }
    fclose(fp);
}

