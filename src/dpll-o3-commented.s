	.text
	.file	"/cs/home/cb307/.ccache/tmp/dpll.tmp.pc3-037-l.cs.st-andrews.ac.uk.26311.i"
	.globl	containsEmptyClause
	.align	16, 0x90
	.type	containsEmptyClause,@function
containsEmptyClause:
	.cfi_startproc

    # Comparing this function to the non-optimised version we can
    # see a key difference: no value are ever stored in memory,
    # which will improve performance. This funciton also makes sure
    # not to use any callee-save registers so it doesn't have to
    # waste time pushing anything to the stack.
	movl	4(%rdi), %ecx   # Makes %ecx point 4 bytes after the
                            # argument register's address, which
                            # is the location of num_clauses.

	xorl	%eax, %eax  # Sets the return register to 0.

	testl	%ecx, %ecx  # Performs a bitwise and on num_clauses.
	jle	.LBB0_4         # with itself. Only if num_clauses is 0
                        # will this return 0, upon which we jump
                        # to the end of the function.

	addq	$12, %rdi   # Shifts %rdi to point to num_literals in
                        # the first clause. (+8 bytes points to the
                        # array in clauseset, and +4 points to
                        # num_literals in the first clause).

	xorl	%edx, %edx  # Sets %edx to 0. This represents clauseNo.
	.align	16, 0x90
.LBB0_3:
	movl	$1, %eax    # Sets the return register to 1 in case we
                        # find an empty clause.

	cmpl	$0, (%rdi)  # Compares the num_literals value to the
	je	.LBB0_4         # current clause with 0. If they are equal
                        # the clause is empty and we return.

	addq	$24, %rdi   # If not, adds the size of a clause to our
                        # num_literals address, to get the address
                        # of num_literals in the next clause.

	incl	%edx        # Increments clauseNo.

	xorl	%eax, %eax  # Sets the return register to 0 and checks
	cmpl	%ecx, %edx  # if clause_No is less than num_clauses. If
	jl	.LBB0_3         # so, jump back to .LBB0_3 and keep looping,
                        # otherwise, continue and return.
.LBB0_4:
	retq
.Ltmp0:
	.size	containsEmptyClause, .Ltmp0-containsEmptyClause
	.cfi_endproc

	.globl	unitClause
	.align	16, 0x90
	.type	unitClause,@function
unitClause:
	.cfi_startproc
	movl	4(%rdi), %ecx   # Makes %ecx point 4 bytes after the
                            # argument register's address, which
                            # is the location of num_clauses.

	xorl	%eax, %eax  # Sets the return register to 0.

	testl	%ecx, %ecx  # Performs a bitwise and on num_clauses.
	jle	.LBB1_5         # with itself. Only if num_clauses is 0
                        # will this return 0, upon which we jump
                        # to the end of the function.

	leaq	12(%rdi), %rsi  # Loads the address of the first
                            # clause's num_literals into %rsi.

	xorl	%edx, %edx  # Sets %edx to 0. This represents clauseNo.
	.align	16, 0x90
.LBB1_3:
	cmpl	$1, (%rsi)  # Compares num_literals to 1, if equal,
    je	.LBB1_4         # then we have a unit clause so jump to the
                        # return section.

	incq	%rdx    # Increments clauseNo.
	
    addq	$24, %rsi   # Adds the size of a clause to our
                        # num_literals address, to get the address
                        # of num_literals in the next clause.
	
	xorl	%eax, %eax  # Sets the return register to 0 and checks
	cmpl	%ecx, %edx  # if clause_No is less than num_clauses. If
	jl	.LBB1_3         # so, jump back to .LBB1_3 and keep looping,
    jmp .LBB1_5         # otherwise, jump to the return section.

.LBB1_4:    # We arrive here if a unit clause has been found and we
            # wish to return it

	leaq	(%rdx,%rdx,2), %rax # Multiplies clauseNo in %rdx by 3.
                                # It does this by adding itself to
                                # itself * 2.

	movl	16(%rdi,%rax,8), %eax   # Then multiplies the above
                                    # value by 8 to get 24 times
                                    # the clauseNo. This gives us
                                    # the number of bytes away the
                                    # clause we want is, from the
                                    # start of the clauseset. Then
                                    # we add it to %rdi, which
                                    # contains the address of the
                                    # start of the clauseset,
                                    # giving us the address of the
                                    # clause we want. Then we add 16
                                    # bytes to get the first item
                                    # in the literals array within
                                    # that clause. This address is
                                    # stored in the return register.
.LBB1_5:
	retq
.Ltmp1:
	.size	unitClause, .Ltmp1-unitClause
	.cfi_endproc

	.globl	firstLiteral
	.align	16, 0x90
	.type	firstLiteral,@function
firstLiteral:

    # NOTE: This function is identical to the above function apart
    # from the 2 lines below .LBB2_3, which compare %rsi
    # (num_literals) with 0 instead of 1 and jump on greater than
    # rather than equals.

	.cfi_startproc
	movl	4(%rdi), %ecx   # Makes %ecx point 4 bytes after the
                            # argument register's address, which
                            # is the location of num_clauses.

	xorl	%eax, %eax  # Sets the return register to 0.

	testl	%ecx, %ecx  # Performs a bitwise and on num_clauses.
	jle	.LBB2_5         # with itself. Only if num_clauses is 0
                        # will this return 0, upon which we jump
                        # to the end of the function.

	leaq	12(%rdi), %rsi  # Loads the address of the first
                            # clause's num_literals into %rsi.

	xorl	%edx, %edx  # Sets %edx to 0. This represents clauseNo.
	.align	16, 0x90
.LBB2_3:
	cmpl	$0, (%rsi)  # Compares num_literals to 0, if it is
	jg	.LBB2_4         # greater, then we have a non-empty
                        # clause, so jump to the section where
                        # we return the literal.

	incq	%rdx    # Increments clauseNo.
	
    addq	$24, %rsi   # Adds the size of a clause to our
                        # num_literals address, to get the address
                        # of num_literals in the next clause.
	
	xorl	%eax, %eax  # Sets the return register to 0 and checks
	cmpl	%ecx, %edx  # if clause_No is less than num_clauses. If
	jl	.LBB2_3         # so, jump back to .LBB2_3 and keep looping,
    jmp .LBB2_5         # otherwise, jump to the return section.
.LBB2_4:
	leaq	(%rdx,%rdx,2), %rax # Multiplies clauseNo in %rdx by 3.
                                # It does this by adding itself to
                                # itself * 2.

	movl	16(%rdi,%rax,8), %eax   # Then multiplies the above
                                    # value by 8 to get 24 times
                                    # the clauseNo. This gives us
                                    # the number of bytes away the
                                    # clause we want is, from the
                                    # start of the clauseset. Then
                                    # we add it to %rdi, which
                                    # contains the address of the
                                    # start of the clauseset,
                                    # giving us the address of the
                                    # clause we want. Then we add 16
                                    # bytes to get the first item
                                    # in the literals array within
                                    # that clause. This address is
                                    # stored in the return register.
.LBB2_5:
	retq
.Ltmp2:
	.size	firstLiteral, .Ltmp2-firstLiteral
	.cfi_endproc

	.globl	dpll
	.align	16, 0x90
	.type	dpll,@function
dpll:
	.cfi_startproc
	pushq	%rbp    # Pushes %rbp to stack as it is callee-save.
.Ltmp3:
	.cfi_def_cfa_offset 16
	pushq	%r14    # Pushes %r14 to stack as it is callee-save.
.Ltmp4:
	.cfi_def_cfa_offset 24
	pushq	%rbx    # Pushes %rbx to stack as it is callee-save
.Ltmp5:
	.cfi_def_cfa_offset 32
	subq	$9632, %rsp # Allocates 9632 bytes for this function's
                        # stack frame.
.Ltmp6:
	.cfi_def_cfa_offset 9664
.Ltmp7:
	.cfi_offset %rbx, -32
.Ltmp8:
	.cfi_offset %r14, -24
.Ltmp9:
	.cfi_offset %rbp, -16
	incq	node_count(%rip)    # Uses rip-relative addressing to
                                # get and increment value of
                                # node_count
	#APP
	nop

	#NO_APP
	movl	9668(%rsp), %ecx    # Loads the address at which the
                                # clauseset starts (the argument
                                # to this function) into %ecx.

	movb	$1, %al     # Moves 1 into the return register and
	testl	%ecx, %ecx  # tests if num_clauses is 0. If so, jump
	je	.LBB3_19        # to the return section.

	jle	.LBB3_20    # This command jumps to the section where we
                    # assert failure. This jump will never actually
                    # happen as num_clauses will never be less than
                    # 0, which is good as we wouldn't want to jump
                    # to that section here anyway.

	leaq	9664(%rsp), %r14    # Loads the address of the clauseset

	leaq	12(%r14), %rax  # The following commands simply repeat
	xorl	%edx, %edx      # the work done above by the
	.align	16, 0x90        # containsEmptyClause() function, but
.LBB3_4:                    # without actually calling the function.
	cmpl	$0, (%rax)      # The num_literals values for each
	je	.LBB3_5             # subsequent clause are loaded into %rax
	incl	%edx            # and we keep looping back to .LBB3_4
	addq	$24, %rax       # until clauseNo (%edx) is not <
	cmpl	%ecx, %edx      # num_clauses (%ecx). If at any point
	jl	.LBB3_4             # num_literals = 1, then we jump to
                            # .LBB3_5, which is the equivalent of
                            # containsEmptyClause() returning 1.
                            # Otherwise we continue below, as
                            # though 0 had been returned.

	testl	%ecx, %ecx  # These two lines assert an error if
    jle	.LBB320         # num_clauses = 0. We know it doesn't at
                        # this point, so this is another pointless
                        # command to jump to .LBB3_20.

	leaq	12(%r14), %rdx  # These lines are similar to those
	xorl	%eax, %eax      # above, but instead replicate the
	.align	16, 0x90        # unitClause() function. If we find
.LBB3_9:                    # a unit clause then it jumps to
	cmpl	$1, (%rdx)      # .LBB3_10. Otherwise it continues
	je	.LBB3_10            # and jumps forward to .LBB3_11.
	incq	%rax
	addq	$24, %rdx
	cmpl	%ecx, %eax
	jl	.LBB3_9
	jmp	.LBB3_11


.LBB3_5:    # We arrive here if the code replicating
            # containsEmptyClause() returned true.

	incq	failures(%rip)  # Uses rip-relative addressing to
	xorl	%eax, %eax      # increment the global failures varable
	jmp	.LBB3_19            # and then jump to where this function
                            # returns.

.LBB3_10:   # Arrives here if we found a unit clause.
	leaq	(%rax,%rax,2), %rax     # These lines are essentially
	movl	16(%r14,%rax,8), %eax   # checking if the unit is 0,
	testl	%eax, %eax              # and if so, we jump to .LBB3_11
	je	.LBB3_11                    # If it were zero we would
                                    # actually have jumped there in
                                    # .LBB3_9, so these lines aren't
                                    # necessary.

    # These 3 lines set up the rep command below. Note how much more
    # concise this is in the optimised code.
	movl	$301, %ecx  # Moves 301 into the "count" register.
	movq	%rsp, %rdi  # Moves stack head into destination register. 
	movq	%r14, %rsi  # Moves addr of clauseset into source reg.
	rep;movsq   # Copies clauseset into head of stack frame. This is
                # done as the clauseset is an argument to
                # simplifyLiteral() which is called after the jump
                # to .LBB3_18 below.

	leaq	7224(%rsp), %rbx    # Moves an address into which
	movq	%rbx, %rdi          # simplifyLiteral() can return an
                                # object, into the first argument reg.

	movl	%eax, %esi  # Moves the unit to the second argument reg.
	jmp	.LBB3_18    # Jumps to where simplifyLiteral() is called.

.LBB3_11:   # Arrives here if unitClause() didn't find a unit clause.

	leaq	12(%r14), %rdx  # The role of these lines is to replicate
	xorl	%eax, %eax      # the firstLiteral() function.
	.align	16, 0x90        # If a literal is found then jumps to
.LBB3_14:                   # .LBB3_15, where the funciton
	cmpl	$0, (%rdx)      # continues. If we get to the loop
	jg	.LBB3_15            # without having found one then jumps
	incq	%rax            # to .LBB3_20 where an assert error
	addq	$24, %rdx       # is thrown.
	cmpl	%ecx, %eax
	jl	.LBB3_14
	jmp	.LBB3_20

.LBB3_15:
	leaq	(%rax,%rax,2), %rax     # These lines are essentially
	movl	16(%r14,%rax,8), %ebp   # checking if the literal is 0,
	testl	%ebp, %ebp              # and if so we jump to .LBB3_20.
	je	.LBB3_20                    # If this were so, we would
                                    # actually have jumped there in
                                    # the above section, so these
                                    # lines aren't actually
                                    # necessary.

	movl	$301, %ecx  # Moves 301 into the "count" register.
	movq	%rsp, %rdi  # Moves stack head into destination register. 
	movq	%r14, %rsi  # Moves addr of clauseset into source reg.
	rep;movsq   # Copies clauseset into head of stack frame. This is
                # done as the clauseset is an argument to
                # simplifyLiteral() which is called below.

	leaq	4816(%rsp), %rbx    # Moves an address into which
	movq	%rbx, %rdi          # simplifyLiteral() can return an
                                # object, into the first argument reg.

	movl	%ebp, %esi  # Moves the literal passed as the 2nd argument
                        # into the second argument register.

	callq	simplifyLiteral # Calls function with the above arguments.

	movl	$301, %ecx  # Moves 301 into the "count" register.
	movq	%rsp, %rdi  # Moves stack head into destination register. 
	movq	%rbx, %rsi  # Moves address into which simplifyLiteral()
                        # returned its result, into the source reg.
	rep;movsq       # Copies the returned clauseset into the head of
	callq	dpll    # the stack frame and calls dpll which uses that
                    # as its argument.

	testb	%al, %al    # Tests the return result of dpll() to see
	jne	.LBB3_19        # if it is 0. If it is not, then jump to
                        # the part of the code where this overall
                        # function returns. Its return value will
                        # be the return value of dpll().

	negl	%ebp    # Negates the value of the literal

	movl	$301, %ecx  # Moves 301 into the "count" register.
	movq	%rsp, %rdi  # Moves stack head into destination register. 
	movq	%r14, %rsi  # Moves addr of clauseset into source reg.
	rep;movsq   # Copies clauseset into head of stack frame. This is
                # done as the clauseset is an argument to
                # simplifyLiteral() which is called below.
	leaq	2408(%rsp), %rbx    # Moves an address into which
	movq	%rbx, %rdi          # simplifyLiteral() can return an
	movl	%ebp, %esi          # object, into the first argument reg.

.LBB3_18:   # The following lines call dpll() and get ready to return
            # the result from this overall function. This is a good
            # piece of optimisation as it is called in two separate
            # parts of the source code: these correspond to the two 
            # lines which read "return dpll(...)".
	callq	simplifyLiteral
	movl	$301, %ecx  # Moves 301 into the "count" register.
	movq	%rsp, %rdi  # Moves stack head into destination register. 
	movq	%rbx, %rsi  # Moves address into which simplifyLiteral()
                        # returned its result, into the source reg.
	rep;movsq       # Copies the returned clauseset into the head of
	callq	dpll    # the stack frame and calls dpll which uses that
                    # as its argument.

.LBB3_19:   # Arrives here once we are ready to return from the
            # overall function.
	movsbl	%al, %eax   # Moves the char value in %al to a
                        # doubleword (sign extended).

	addq	$9632, %rsp # Adds the number of bytes we took for this
                        # stack frame to the stack pointer. This
                        # frees the stack space allocated at the
                        # start of the function.

	popq	%rbx    # Pops the values off
	popq	%r14    # the stack which we pushed
	popq	%rbp    # at the start.
	retq
.LBB3_20:
	movl	$.L.str, %edi
	movl	$.L.str1, %esi
	movl	$75, %edx
	movl	$.L__PRETTY_FUNCTION__.dpll, %ecx
	callq	__assert_fail
.Ltmp10:
	.size	dpll, .Ltmp10-dpll
	.cfi_endproc

	.type	node_count,@object
	.comm	node_count,8,8
	.type	failures,@object
	.comm	failures,8,8
	.type	.L.str,@object
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"literal != 0"
	.size	.L.str, 13

	.type	.L.str1,@object
.L.str1:
	.asciz	"dpll.c"
	.size	.L.str1, 7

	.type	.L__PRETTY_FUNCTION__.dpll,@object
.L__PRETTY_FUNCTION__.dpll:
	.asciz	"char dpll(clauseset)"
	.size	.L__PRETTY_FUNCTION__.dpll, 21

	.type	cs_original,@object
	.comm	cs_original,2408,4

	.ident	"clang version 3.5.0 (tags/RELEASE_350/final)"
	.section	".note.GNU-stack","",@progbits
