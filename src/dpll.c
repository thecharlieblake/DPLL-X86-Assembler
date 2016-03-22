#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

#include "cnf.h"


    
    // Complete the implementation of containsEmptyClause
    // This function takes a pointer to a clause set
    //  and returns:
    //  	1 if there is an empty clause in the clause set
    //  	0 if there is not

int containsEmptyClause(clauseset* csPtr) {
}

    // Complete the implementation of unitClause
    // This function takes a pointer to a clause set
    //  and returns:
    //  	0 if there is no unit clause
    //  	the unique literal in a unit clause if there is at least one

int unitClause(clauseset* csPtr) {
}
    // Complete the implementation of firstLiteral
    // This function takes a pointer to a clause set
    //  and returns the first literal in the first 
    //  clause which is not empty
    //
    //  If there is no literal (clause set empty or all clausese empty)
    //  then it returns 0

int firstLiteral(clauseset* csPtr) {
}

char dpll(clauseset cs) { 

    node_count++;
   
    __asm__ ("nop;" ); // pointless assembler instruction

    if(cs.num_clauses == 0) {
        // printf(" empty clauseset\n");
        return 1;
    }
    else if (containsEmptyClause(&cs)) {
        // printf(" fail empty clause\n");
	failures++;
        return 0;
    }
    else {
        int unit = unitClause(&cs);
        // printf(" unit test returns %d \n", unit);
        if (unit) { 
            return dpll(simplifyLiteral(cs,unit));
        }
        else {
            int literal = firstLiteral(&cs);
            assert(literal != 0);
            char leftResult = dpll(simplifyLiteral(cs,literal));
            if(leftResult) {
                return leftResult;
            }
            else {
                return dpll(simplifyLiteral(cs,-literal));
            }
        }
    }
}

