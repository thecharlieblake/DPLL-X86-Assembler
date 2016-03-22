#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#include "cnf.h"

int dimacs_clause_position;

// Originally by Chris Jefferson
// Edited by Ian Gent

// You should implement the following functions in your own code.
// These functions will have to store the clauses in a global variable
// so they can be accessed.

void initialise_cs(clauseset* csPtr, int vars);
void clause_num(int number);

/********
 The DIMACS format is a format for storing SAT problems
 This parser might not handle every slightly badly formatted
 SAT instance out there!

 Here is an example of a dimacs file:

c  simple_v3_c2.cnf
c
p cnf 3 2
1 -3 0
2 3 -1 0

  The format is:
Lines that start c are comments. They can only appear at the start
The 'p' line defines the problem. For us it always starts 'p cnf'.
Then there are the number of variables, then number of clauses.

This instance will call the functions:

set_variables_and_clauses(3, 2);
clause_num(1);
clause_num(-3);
clause_num(0);
...
clause_num(-1);
clause_num(0);
***********/

void read_line(char* buffer, int buf_size, FILE* stream)
{
	// clear buffer to make sure we do not get tricked by
	// fgets not reading
	memset(buffer, 0, buf_size);

	fgets(buffer, buf_size, stream);

	if(strlen(buffer) <= 1)
	{
		printf("Blank line!");
		exit(1);
	}

	if(buffer[strlen(buffer) - 1] != '\n' && !feof(stream))
	{
		printf("Line too long for buffer!\n");
		exit(1);
	}
}

void initialise_cs(clauseset* csPtr, int vars)
{
	csPtr->num_vars = vars;
	csPtr->num_clauses = 0;
}

void finalise_clause(clause* cPtr, int num_lits)
{
	cPtr->num_literals = num_lits;
	cPtr->satisfied = 0;
}

void parse_dimacs(FILE* stream, bool print_info, clauseset* csPtr)
{
	const int buf_size = 10000;
	// Let us assume an upper limit on a line. Naughty!
	char buffer[buf_size];

	do {
		read_line(buffer, buf_size, stream);
	} while(buffer[0] == 'c');


	int vars, clauses;
	if(sscanf(buffer, "p cnf %d %d", &vars, &clauses) != 2)
	{
		printf("Invalid p line: '%s'\n", buffer);
		exit(1);
	}
   if(print_info) 
       printf("Num of vars %d, clauses %d\n",vars,clauses);
    
   if(clauses > CNF_N) {
            // error
            printf("Too many clauses: %d > %d\n",clauses,CNF_N);
            exit(1);
        }

	int clause_lit = 0;
    initialise_cs(csPtr,vars);

    //printClauses(csPtr);

   // if(print_info) 
       // printf("Clause %d, literal: %d\n",csPtr->num_clauses,clause_lit);
	int read_val = 0;
	while(csPtr->num_clauses < clauses && fscanf(stream, "%d", &read_val) == 1)
	{
        if(read_val==0) { 
            // end of clause
            if(csPtr->num_clauses < CNF_N) {
                finalise_clause(&(csPtr->clauses[csPtr->num_clauses]),clause_lit);
            }
            (csPtr->num_clauses)++;
            clause_lit=0;
            //printClauses(csPtr);
        }
        else if(abs(read_val) > vars) {
            // error
            printf("Invalid literal: %d\n",read_val);
            exit(1);
        }
        else if(clause_lit >= CNF_K ) {
            // error
            printf("clause too long for max allowed: %d > %d\n",clause_lit+1,CNF_K);
            exit(1);
        }
        else { 
            csPtr->clauses[csPtr->num_clauses].literals[clause_lit] = read_val;
            clause_lit++;
        }
    }

    if (clause_lit != 0) { 
        printf("Error, last clause not finished\n");
        exit(1);
    }


    if(print_info) {
        if(read_val == 0)
            printf(": End\n");
        else
        {
            if(read_val > 0)
                printf("%d ", read_val);
            else
                printf("!%d ", -read_val);
        }
    }
}


void read_clauses(clauseset* csPtr, char* filename)
{
	FILE* stream = fopen(filename, "r");
	if(!stream)
	{
		perror("Unable to open file: ");
		exit(1);
	}
	//parse_dimacs(stream, true, csPtr);
	parse_dimacs(stream, false, csPtr);

}

