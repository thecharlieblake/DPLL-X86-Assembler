#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "cnf.h"

int numClauses(clauseset* csPtr) {
    return csPtr->num_clauses;
}



// returns 0 if clause is not satisfied on return, 1 if it is

char simplifyClause(clause* cPtr, int literal) {
    if (cPtr->satisfied) { return 1;}
    for (int i=0;i<cPtr->num_literals;){
        // printf("literal %d neglit %d literal in clause %d\n",literal, -literal,cPtr->literals[i]);
        if(cPtr->literals[i]==literal){
            cPtr->satisfied = 1;
            return 1;
        }
        else if(cPtr->literals[i] == (-literal)){

          //   printf("trying at least ");
            // for(int j = 0; j < cPtr->num_literals; ++j) {
              //   printf("%d ", cPtr->literals[j]); }
            // printf("0\n");

            if(i<(cPtr->num_literals-1)) {
                cPtr->literals[i]=cPtr->literals[cPtr->num_literals-1];
            }
            cPtr->num_literals--;
            
            // for(int j = 0; j < cPtr->num_literals; ++j) {
                // printf("%d ", cPtr->literals[j]); }
            // in this case don't increment i in case literal is repeated
        }
        else {
            i++;
        }
    }
    return 0;
}


// returns a copy since C is call by value

clauseset simplifyLiteral(clauseset cs, int literal) {
    //printf("Now simplify with literal %d\n",literal); printClauses(&cs); 
    for(int i=0; i < cs.num_clauses; ){
        if (simplifyClause(&(cs.clauses[i]),literal)) {
            if (i < cs.num_clauses-1) { 
                cs.clauses[i] = cs.clauses[cs.num_clauses-1];
                //copyClause(&(cs.clauses[cs.num_clauses-1]),&(cs.clauses[i]));
            }
            cs.num_clauses--;
        }
        else {
            i++;
        }
    }
    //printClauses(&cs); printf("Now simplified\n");
    return cs;
}
void printClauses(clauseset* csPtr) {
        clauseset cs = *csPtr;
        printf("p cnf %d %d\n",cs.num_vars,cs.num_clauses);
        for(int i = 0; i < cs.num_clauses; ++i)
        { 
            for(int j = 0; j < cs.clauses[i].num_literals; ++j) {
                printf("%d ", cs.clauses[i].literals[j]); }
            printf("0\n");
        }
}


