/*
* sort_struct.c
*
* written by Xiao Lu
*/


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define MAX_STUDENTS 100
#define STR_LEN	32
#define ID_LEN 6

typedef struct {
	char first[STR_LEN];
	char last[STR_LEN];
	int id;
} Student;

bool read_name(FILE *fp, char *name)
{
	int i, c;
	/* skip white space */
	for (i=0; i<STR_LEN-1; i++) {
		if ( (c = fgetc(fp)) == EOF) 
			return false;
		if (c != ' ' && c != '\t' && c != '\n')
			break;
	}
	/* read name up to ',' */
	name[0] = c;
	//printf("%2d %c\n", 0, c);
	for (i=1; i<STR_LEN-1; i++) {
		if ( (c = fgetc(fp)) == EOF)
			return false;
		if (c == ',' || c == '\n') {
			//printf("found ,\n");
			break;
		}
		name[i] = c;
		//printf("%2d %c\n", i, c);
	}
	//printf("%2d %d\n", i, 0);
	name[i] = 0;
	return true;
}

int comp_first(const void * a, const void * b)
{
	/* for sorting first names */
	Student *p1 = (Student *)a;
	Student *p2 = (Student *)b;
	return strncmp(p1->first, p2->first, STR_LEN-1); // return -1 for (a<b), 0 for =, and +1 for (a>b)
}

int comp_last(const void * a, const void * b)
{
	//to do
	Student *p1 = (Student *)a;
	Student *p2 = (Student *)b;
	return strncmp(p1->last, p2->last, STR_LEN-1);
}

int comp_id(const void * a, const void * b)
{
	//to do
	Student *p1 = (Student *)a;
	Student *p2 = (Student *)b;
	if ((p1->id) < (p2->id))
	 	{ return -1; } 
	else if ((p1->id) == (p2->id))
		{ return 0; }
	else 
		{ return 1; }
}

int main(int argc, char *argv[])
{
	int i, num_students;
	char *sort_key;
	FILE *fp1, *fp2;
	Student student[MAX_STUDENTS];

	/* parse command line */
	if (argc != 4) {
		fprintf(stderr, "Usage: %s in_file out_file sort_key\n", argv[0]);
		fprintf(stderr, "where sort_key is first|last|id\n");
		return -1;
	}

	/* open input file */
	if ( (fp1 = fopen(argv[1], "r")) == NULL ) {
		fprintf(stderr, "Cannot open %s\n", argv[1]);
		return -1;
	}
	/* open output file */
	fp2 = fopen(argv[2], "w+");

	/* sort key */
	sort_key = argv[3];

	/* read input into student array */
	// fscanf(fr,"%s, %s, %d\n", &first, &last, &id);
	for (i=0; i<MAX_STUDENTS; i++) {
		//to do
		if ( read_name(fp1, student[i].first) &&
			 read_name(fp1, student[i].last) &&
			 fscanf(fp1,"%d", &student[i].id )
			 ) 
		{
			printf("%d, %s, %s, %d\n",i, student[i].first, student[i].last, student[i].id);
		}
		else {
			break;
		}
	}
	num_students = i;
	printf("Read records for %d students\n", num_students);

	/* use quicksort to sort student array */
	if (strncmp(sort_key, "first", 5) == 0) {
		/* sort on first name */
		qsort(&student[0], num_students, sizeof(student[0]), comp_first );
	}
	else if (strncmp(sort_key, "last", 4) == 0) {
		/* sort on last name */
		//to do
		qsort(&student[0], num_students, sizeof(student[0]), comp_last );
	}
	else if (strncmp(sort_key, "id", 2) == 0) {
		/* sort on student id */
		//to do
		qsort(&student[0], num_students, sizeof(student[0]), comp_id );
	}
	else {
		fprintf(stderr, "Unknown sort key: %s\n", sort_key);
		return -1;
	}

	/* write student array to output file */
	//to do
	for (i = 0; i < num_students; i++) {
		//to do
		printf("%d, %s, %s, %d\n", i, student[i].first, student[i].last, student[i].id);
		fprintf(fp2, "%s, %s, %d\n", student[i].first, student[i].last, student[i].id);
	}

	/* close the files */
	fclose(fp1);
	fclose(fp2);

	return 0;
}
