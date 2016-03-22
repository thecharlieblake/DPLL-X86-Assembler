#define CNF_K 4
#define CNF_N 100

typedef struct {
    char satisfied; 
    int num_literals;
    int literals[CNF_K];
} clause;

typedef struct {
    int num_vars;
    int num_clauses;
    clause clauses[CNF_N];
} clauseset;


// Some functions

int numClauses(clauseset* csPtr);
int unitClause(clauseset* csPtr);
int containsEmptyClause(clauseset* csPtr);
int firstLiteral(clauseset* csPtr);

clauseset simplifyLiteral(clauseset cs, int literal);
void printClauses(clauseset* csPtr);
char dpll(clauseset cs);

// global variables
//
//
clauseset cs_original;
long long node_count;
long long failures;

#ifndef DIMACS_H
#define DIMACS_H

#include <stdio.h>

void read_clauses(clauseset* csPtr, char* filename);

#endif
