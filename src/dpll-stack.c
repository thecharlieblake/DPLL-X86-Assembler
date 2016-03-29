#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

#include "cnf.h"

typedef enum {
    node_cnt,
    fails,
    instruction_ptr,
    stack_ptr,
    stack_size,
    clauseset_addr,
    unit_addr,
    literal_addr,
    leftResult_addr,
    simplifyLiteral_clauseset_addr,
    simplifyLiteral_clauseset_addr_2
} StackInfoFields;

const char * const SIFieldNames[10] = {
    "Failures",
    "Instruction Pointer",
    "Stack Pointer",
    "Stack Frame Size",
    "Clauseset Address",
    "Unit Address",
    "Literal Address",
    "LeftResult Address",
    "SimplifyLiteral() Clauseset Address",
    "SimplifyLiteral() Clauseset Address 2"
};

typedef struct {
    long long info[11];
} StackInfo;
    
void printStackInfo(StackInfo* si);

    // Complete the implementation of containsEmptyClause
    // This function takes a pointer to a clause set
    //  and returns:
    //  	1 if there is an empty clause in the clause set
    //  	0 if there is not

int containsEmptyClause(clauseset* csPtr) {
    for (int clauseNo = 0; clauseNo < csPtr->num_clauses; clauseNo++) {
        if (csPtr->clauses[clauseNo].num_literals == 0)
            return 1;
    }
    return 0;
}

    // Complete the implementation of unitClause
    // This function takes a pointer to a clause set
    //  and returns:
    //  	0 if there is no unit clause
    //  	the unique literal in a unit clause if there is at least one

int unitClause(clauseset* csPtr) {
    for (int clauseNo = 0; clauseNo < csPtr->num_clauses; clauseNo++) {
        if (csPtr->clauses[clauseNo].num_literals == 1)
            return csPtr->clauses[clauseNo].literals[0];
    }
    return 0;
}
    // Complete the implementation of firstLiteral
    // This function takes a pointer to a clause set
    //  and returns the first literal in the first 
    //  clause which is not empty
    //
    //  If there is no literal (clause set empty or all clauses empty)
    //  then it returns 0

int firstLiteral(clauseset* csPtr) {
    for (int clauseNo = 0; clauseNo < csPtr->num_clauses; clauseNo++) {
        if (csPtr->clauses[clauseNo].num_literals > 0)
            return csPtr->clauses[clauseNo].literals[0];
    }
    return 0;
}

char dpll(clauseset cs) { 
    node_count++;

    // Create the stack info object which contains the info
    // we will later print
    StackInfo si;
    // Set the default values for stack info numbers to -1
    for (int i = 1; i < 11; i++)
        si.info[i] = -1;

    si.info[node_cnt] = node_count;
    si.info[fails] = failures;
   
    // Gets the address of the instruction pointer, the
    // address of the stack pointer, the size of the
    // current stack, the location of the argument "cs"
    // for dpll(),
    long long i_ptr, head_ptr, base_ptr, cs_addr;
    __asm__ ("call _here\n_here: pop %0" : "=r"(i_ptr));
    __asm__ ("movq %%rsp, %0" : "=r"(head_ptr));
    __asm__ ("movq %%rbp, %0" : "=r"(base_ptr));
    __asm__ ("leaq 16(%%rbp), %0" : "=r"(cs_addr));
    si.info[instruction_ptr] = i_ptr;
    si.info[stack_ptr] = head_ptr;
    si.info[stack_size] = base_ptr - head_ptr;
    si.info[clauseset_addr] = cs_addr;

    char ret;
    if(cs.num_clauses == 0) {
        ret = 1;
    }
    else if (containsEmptyClause(&cs)) {
	    failures++;
        si.info[fails] = failures;
        ret = 0;
    }
    else {
        int unit = unitClause(&cs);

        // Gets the address of unit and puts it in stackInfo
        __asm__ ("leaq -136(%%rbp), %0" : "=r"(si.info[unit_addr]));

        if (unit) { 
            clauseset cs2 = simplifyLiteral(cs,unit);
            __asm__ ("leaq -2544(%%rbp), %0" : "=r"(si.info[simplifyLiteral_clauseset_addr]));
            ret = dpll(cs2);
        }
        else {
            int literal = firstLiteral(&cs);
            assert(literal != 0);

            // Gets the address of literal and puts it in stackInfo
            __asm__ ("leaq -2548(%%rbp), %0" : "=r"(si.info[literal_addr]));

            clauseset cs2 = simplifyLiteral(cs,literal);
            __asm__ ("leaq -4960(%%rbp), %0" : "=r"(si.info[simplifyLiteral_clauseset_addr]));

            char leftResult = dpll(cs2);
            if(leftResult) {
                __asm__ ("leaq -4961(%%rbp), %0" : "=r"(si.info[leftResult_addr]));
                ret = leftResult;
            }
            else {
                clauseset cs3 = simplifyLiteral(cs,-literal);
                __asm__ ("leaq -7376(%%rbp), %0" : "=r"(si.info[simplifyLiteral_clauseset_addr_2]));
                ret = dpll(cs3);
            }
        }
    }

    printStackInfo(&si);
    return ret;
}

void printStackInfo(StackInfo* si) {
    printf("===== Node %lld =====\n", si->info[node_cnt]);

    for (int i = 0; i < 10; i++) {
        long long v = si->info[i + 1];
        if (v != -1)
            printf("%s: %lld\n", SIFieldNames[i], v);
    }

    printf("\n");
}
