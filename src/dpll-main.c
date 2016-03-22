#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

#include "cnf.h"


int main(int argc, char** argv) {
    	if(argc != 2) { 
       	     printf("Usage: dpll filename\n");
            exit(0);
        }
	node_count =0;
	failures=0;
	read_clauses(&cs_original,argv[1]);
	//printClauses(&cs_original);
	//printf("\n---\n");
	char result = dpll(cs_original);
	printf("dpll result: %d: used %lld nodes and %lld failures\n",result,node_count,failures);
    return 0;
}
