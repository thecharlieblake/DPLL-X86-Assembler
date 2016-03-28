	.text
	.file	"/cs/home/cb307/.ccache/tmp/dpll.stdout.klovia.cs.st-andrews.ac.uk.18511.6BIdTS.i"
	.globl	containsEmptyClause
	.align	16, 0x90
	.type	containsEmptyClause,@function
containsEmptyClause:
	.cfi_startproc
	pushq	%rbp    # Pushes %rbp to stack. Register is callee-save
                    # so we must store the value like this if we
                    # wish to use %rbp in this function
.Ltmp0:
	.cfi_def_cfa_offset 16
.Ltmp1:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp  # Copies the address of the top of the stack
                        # into %rbp, letting us treat that register as
                        # a pointer to the base of the stack in this
                        # function.
.Ltmp2:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp) # Moves the contents of %rdi into the
                            # space 16 bytes below the stack. As a
                            # calling convention %rdi points to the
                            # first argument in the function which
                            # in this case is the pointer to the
                            # clauseset. We can move it into this
                            # space as there is a 128 byte "red zone"
                            # below the head of the stack.

	movl	$0, -20(%rbp)   # Moves value 0 into the stack memory.
                            # It is moved as a doubleword which
                            # is equivalent to a C int.
                            # This represents the "clauseNo" variable.
.LBB0_1:
	movl	-20(%rbp), %eax # Moves value of "clauseNo" into %eax.
	movq	-16(%rbp), %rcx # Moves clauseset pointer into %rcx.

	cmpl	4(%rcx), %eax   # These two instructions jump to .LBB0_6
	jge	.LBB0_6             # if the doubleword 4 bytes after the
                            # clauseset pointer is greater than or
                            # equal to "clauseNo". The first 4 bytes
                            # of clauseset represent the "num_vars"
                            # int, and the next 4 bytes (used in
                            # this instruction) represent
                            # "num_clauses". Hence, if "clauseNo" <
                            # num_clauses, there will be no jump,
                            # which is the exit condition for the
                            # function's for loop.

	movslq	-20(%rbp), %rax # Moves (sign-extended) doubleword value
                            # of "clauseNo" into quadword in %rax.
                            # This is done because later we will
                            # multiply the value by a given number of
                            # bytes to get a memory address, which
                            # needs to be represented as a quadword.

	movq	-16(%rbp), %rcx # Moves clauseset pointer into %rcx.

	addq	$8, %rcx    # Adds 8 to the address of the clauseset
                        # stored in %rcx. This means that it now
                        # points to the clause array within the
                        # clauseset (the two int values in the
                        # struct are 4 bytes each).

	imulq	$24, %rax, %rax # Multiplies the value of "clauseNo" by
                            # by 24 (size in bytes of a clause struct)
                            # and stores result in %rax.

	addq	%rax, %rcx  # Adds the above value to the address of the
                        # clause array. The effect of this is to
                        # make %rcx point to the clause indexed
                        # by "clauseNo".

	cmpl	$0, 4(%rcx) # Compares "num_literals" in the current
    jne	.LBB0_4         # clause, to zero. If they are not equal,
	                    # jumps the next two lines to .LBB0_4 (and the
                        # loop continues).

	movl	$1, -4(%rbp)    # Moves the value 1 into free space in the
                            # stack. (The function will later return
                            # this value).

	jmp	.LBB0_7 # Jumps to the section where the function returns.
.LBB0_4:
	jmp	.LBB0_5
.LBB0_5:
	movl	-20(%rbp), %eax # These four instructions add one to
	addl	$1, %eax        # the "clauseNo" variable in memory. This
	movl	%eax, -20(%rbp) # is the incrementation which takes place
	jmp	.LBB0_1             # in the for loop. Then control jumps back
                            # to the start of the loop.
.LBB0_6:
	movl	$0, -4(%rbp)    # We arrive at this point if the loop has
                            # ended. Moves 0 into memory so that it
                            # can be returned.
.LBB0_7:
	movl	-4(%rbp), %eax  # Puts the return value we stored in
                            # memory into %eax. It is a calling
                            # convention to put the return value into
                            # the first register, and as we are
                            # returning an int / doubleword, we store
                            # it in the lower 32-bit section (%eax).

	popq	%rbp    # restores %rbp (callee save) to its value before
	retq            # the function was called, and then returns.
.Lfunc_end0:
	.size	containsEmptyClause, .Lfunc_end0-containsEmptyClause
	.cfi_endproc

	.globl	unitClause
	.align	16, 0x90
	.type	unitClause,@function
unitClause:
	.cfi_startproc
	pushq	%rbp    # Stores value in register on stack - callee save
.Ltmp3:
	.cfi_def_cfa_offset 16
.Ltmp4:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp  # Copies the address of the top of the stack
                        # into %rbp, letting us treat that register as
                        # a pointer to the base of the stack in this
                        # function.
.Ltmp5:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp) # Moves the contents of %rdi into the
                            # space 16 bytes below the stack. As a
                            # calling convention %rdi points to the
                            # first argument in the function which
                            # in this case is the pointer to the
                            # clauseset. We can move it into this
                            # space as there is a 128 byte "red zone"
                            # below the head of the stack.

	movl	$0, -20(%rbp)   # Moves value 0 into the stack memory.
                            # It is moved as a doubleword which
                            # is equivalent to a C int.
                            # This represents the "clauseNo" variable.
.LBB1_1:
	movl	-20(%rbp), %eax # Moves value of "clauseNo" into %eax.
	movq	-16(%rbp), %rcx # Moves clauseset pointer into %rcx.

	cmpl	4(%rcx), %eax   # These two instructions jump to .LBB1_6
	jge	.LBB1_6             # if the doubleword 4 bytes after the
                            # clauseset pointer is greater than or
                            # equal to "clauseNo". The first 4 bytes
                            # of clauseset represent the "num_vars"
                            # int, and the next 4 bytes (used in
                            # this instruction) represent
                            # "num_clauses". Hence, if "clauseNo" <
                            # num_clauses, there will be no jump,
                            # which is the exit condition for the
                            # function's for loop.

	movslq	-20(%rbp), %rax # Moves (sign-extended) doubleword value
                            # of "clauseNo" into quadword in %rax.
                            # This is done because later we will
                            # multiply the value by a given number of
                            # bytes to get a memory address, which
                            # needs to be represented as a quadword.

	movq	-16(%rbp), %rcx # Moves clauseset pointer into %rcx.

	addq	$8, %rcx    # Adds 8 to the address of the clauseset
                        # stored in %rcx. This means that it now
                        # points to the clause array within the
                        # clauseset (the two int values in the
                        # struct are 4 bytes each).

	imulq	$24, %rax, %rax # Multiplies the value of "clauseNo" by
                            # by 24 (size in bytes of a clause struct)
                            # and stores result in %rax.

	addq	%rax, %rcx  # Adds the above value to the address of the
                        # clause array. The effect of this is to
                        # make %rcx point to the clause indexed
                        # by "clauseNo".

	cmpl	$1, 4(%rcx) # Compares "num_literals" in the current
    jne	.LBB1_4         # clause, to one. If they are not equal,
	                    # jumps the next two lines to .LBB1_4 (and the
                        # loop continues).

	movslq	-20(%rbp), %rax # these five instructions are the same as
	movq	-16(%rbp), %rcx # those above. Both are essentially used
	addq	$8, %rcx        # to access the current clause, which is
	imulq	$24, %rax, %rax # in the end pointed to by %rcx.
	addq	%rax, %rcx

	movl	8(%rcx), %edx   # Moves a doubleword from the eighth byte
                            # of the current clause into %edx. This
                            # doubleword contains the first literal
                            # in the clause.

	movl	%edx, -4(%rbp)  # Moves the above literal into free space
                            # in the stack. (The function will later
                            # return this value).

	jmp	.LBB1_7 # Jumps to the section where the function returns.
.LBB1_4:
	jmp	.LBB1_5
.LBB1_5:
	movl	-20(%rbp), %eax # These four instructions add one to
	addl	$1, %eax        # the "clauseNo" variable in memory. This
	movl	%eax, -20(%rbp) # is the incrementation which takes place
	jmp	.LBB1_1             # in the for loop. Then control jumps back
                            # to the start of the loop.
.LBB1_6:
	movl	$0, -4(%rbp)    # We arrive at this point if the loop has
                            # ended. Moves 0 into memory so that it
                            # can be returned.
.LBB1_7:
	movl	-4(%rbp), %eax  # Puts the return value we stored in
                            # memory into %eax. It is a calling
                            # convention to put the return value into
                            # the first register, and as we are
                            # returning an int / doubleword, we store
                            # it in the lower 32-bit section (%eax).

	popq	%rbp    # restores %rbp (callee save) to its value before
	retq            # the function was called, and then returns.
.Lfunc_end1:
	.size	unitClause, .Lfunc_end1-unitClause
	.cfi_endproc

	.globl	firstLiteral
	.align	16, 0x90
	.type	firstLiteral,@function
firstLiteral:
	.cfi_startproc
	pushq	%rbp    # Pushes %rbp to stack. Register is callee-save
                    # so we must store the value like this if we
                    # wish to use %rbp in this function
.Ltmp6:
	.cfi_def_cfa_offset 16
.Ltmp7:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp  # Copies the address of the top of the stack
                        # into %rbp, letting us treat that register as
                        # a pointer to the base of the stack in this
                        # function.
.Ltmp8:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp) # Moves the contents of %rdi into the
                            # space 16 bytes below the stack. As a
                            # calling convention %rdi points to the
                            # first argument in the function which
                            # in this case is the pointer to the
                            # clauseset. We can move it into this
                            # space as there is a 128 byte "red zone"
                            # below the head of the stack.

	movl	$0, -20(%rbp)   # Moves value 0 into the stack memory.
                            # It is moved as a doubleword which
                            # is equivalent to a C int.
                            # This represents the "clauseNo" variable.
.LBB2_1:
	movl	-20(%rbp), %eax # Moves value of "clauseNo" into %eax.
	movq	-16(%rbp), %rcx # Moves clauseset pointer into %rcx.

	cmpl	4(%rcx), %eax   # These two instructions jump to .LBB2_6
	jge	.LBB2_6             # if the doubleword 4 bytes after the
                            # clauseset pointer is greater than or
                            # equal to "clauseNo". The first 4 bytes
                            # of clauseset represent the "num_vars"
                            # int, and the next 4 bytes (used in
                            # this instruction) represent
                            # "num_clauses". Hence, if "clauseNo" <
                            # num_clauses, there will be no jump,
                            # which is the exit condition for the
                            # function's for loop.

	movslq	-20(%rbp), %rax # Moves (sign-extended) doubleword value
                            # of "clauseNo" into quadword in %rax.
                            # This is done because later we will
                            # multiply the value by a given number of
                            # bytes to get a memory address, which
                            # needs to be represented as a quadword.

	movq	-16(%rbp), %rcx # Moves clauseset pointer into %rcx.

	addq	$8, %rcx    # Adds 8 to the address of the clauseset
                        # stored in %rcx. This means that it now
                        # points to the clause array within the
                        # clauseset (the two int values in the
                        # struct are 4 bytes each).

	imulq	$24, %rax, %rax # Multiplies the value of "clauseNo" by
                            # by 24 (size in bytes of a clause struct)
                            # and stores result in %rax.

	addq	%rax, %rcx  # Adds the above value to the address of the
                        # clause array. The effect of this is to
                        # make %rcx point to the clause indexed
                        # by "clauseNo".

	cmpl	$0, 4(%rcx) # Compares "num_literals" in the current
    jle .LBB2_4         # clause, to zero. If it is less than or equal
                        # then jump to .LBB2_4 (and the loop
                        # continues).

	movslq	-20(%rbp), %rax # these five instructions are the same as
	movq	-16(%rbp), %rcx # those above. Both are essentially used
	addq	$8, %rcx        # to access the current clause, which is
	imulq	$24, %rax, %rax # in the end pointed to by %rcx.
	addq	%rax, %rcx

	movl	8(%rcx), %edx   # Moves a doubleword from the eighth byte
                            # of the current clause into %edx. This
                            # doubleword contains the first literal
                            # in the clause.

	movl	%edx, -4(%rbp)  # Moves the above literal into free space
                            # in the stack. (The function will later
                            # return this value).

	jmp	.LBB2_7 # Jumps to the section where the function returns.
.LBB2_4:
	jmp	.LBB2_5
.LBB2_5:
	movl	-20(%rbp), %eax # These four instructions add one to
	addl	$1, %eax        # the "clauseNo" variable in memory. This
	movl	%eax, -20(%rbp) # is the incrementation which takes place
	jmp	.LBB2_1             # in the for loop. Then control jumps back
                            # to the start of the loop.
.LBB2_6:
	movl	$0, -4(%rbp)    # We arrive at this point if the loop has
                            # ended. Moves 0 into memory so that it
                            # can be returned.
.LBB2_7:
	movl	-4(%rbp), %eax  # Puts the return value we stored in
                            # memory into %eax. It is a calling
                            # convention to put the return value into
                            # the first register, and as we are
                            # returning an int / doubleword, we store
                            # it in the lower 32-bit section (%eax).

	popq	%rbp    # restores %rbp (callee save) to its value before
	retq            # the function was called, and then returns.
.Lfunc_end2:
	.size	firstLiteral, .Lfunc_end2-firstLiteral
	.cfi_endproc

	.globl	dpll
	.align	16, 0x90
	.type	dpll,@function
dpll:
	.cfi_startproc
	pushq	%rbp    # Pushes %rbp to stack. Register is callee-save
                    # so we must store the value like this if we
                    # wish to use %rbp in this function
.Ltmp9:
	.cfi_def_cfa_offset 16
.Ltmp10:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp  # Copies the address of the top of the stack
                        # into %rbp, letting us treat that register as
                        # a pointer to the base of the stack in this
                        # function.
.Ltmp11:
	.cfi_def_cfa_register %rbp
	subq	$9776, %rsp # Subtracts 9776 from the address of the stack
                        # pointer. This allocates 9776 bytes of space
                        # on stack.

	leaq	16(%rbp), %rax  # Loads the effective address 16 bytes
                            # after %rbp on the stack. This points to
                            # the clauseset passed as an argument to
                            # this function.

	movq	node_count, %rcx    # Moves value in memory pointed to by
    addq	$1, %rcx            # "node_count" (global var) into %rcx,
	movq	%rcx, node_count    # add 1, then move result back.
	
    #APP
	nop
	#NO_APP

	cmpl	$0, 4(%rax) # Compares "num_clauses" in clauseset to 0.
                        # Line after next jumps depending on result.

	movq	%rax, -7248(%rbp)   # Stores the address of the clauseset
                                # in stack memory.

	jne	.LBB3_2             # Either jumps to next section, or (if
	movb	$1, -1(%rbp)    # "num-clauses" == 0) puts 1 into memory
	jmp	.LBB3_12            # and jumps to section where function will
                            # effectively return that 1.
.LBB3_2:
	movq	-7248(%rbp), %rdi   # Moves the address of the clauseset
    callq	containsEmptyClause # into %rdi. It is a calling
                                # convention that we put the first
	                            # argument to a function in this
                                # register. Then we call the function.

	cmpl	$0, %eax    # Compares the result of the function call
	je	.LBB3_4         # (by convention stored in first register -
                        # %eax as it is a doubleword) with 0. If they
                        # are equal, jumps to next section where
                        # function continues. Otherwise continue
                        # here where the function will return.

	movq	failures, %rax  # These three commands move "failures"
	addq	$1, %rax        # into a register, increment it, and
	movq	%rax, failures  # return the value to memory.

	movb	$0, -1(%rbp)    # Moves value 0 into memory and then jumps
	jmp	.LBB3_12            # to section where that value is returned.
.LBB3_4:
	movq	-7248(%rbp), %rdi   # Moves the address of the clauseset
    callq	unitClause          # into %rdi. It is a calling
                                # convention that we put the first
	                            # argument to a function in this
                                # register. Then we call the function.

	movl	%eax, -8(%rbp)  # Moves the result of the function into
	cmpl	$0, -8(%rbp)    # memory, compares the value with 0, and
	je	.LBB3_6             # if they are equal then we don't have a
                            # unit clause so we jump to a later
                            # section.

	leaq	-2416(%rbp), %rax   # ??? Still no idea, although 2416 -
                                # 2408 gives the 8 bytes used above

    # The following commands are largely used to set up the necessary
    # conditions for the "rep" command used below. This command copies
    # "count" chunks of 8 bytes from the source to the destination.
    # This requires us to set up three things. The source address must
    # be in %rsi, The destination in %rdi, and the count in %ecx. I
    # have marked below which commands set up which. There are also
    # 2 commands which move the unit returned by the unitClause()
    # function into a different point in memory, which are marked as
    # (unit).
	movl	-8(%rbp), %esi  # (unit) Moves the unit into %esi.
	movq	%rsp, %rcx  # (dest) Moves the address of the stack poiner
                        # into %rcx.
	movl	$301, %edx  # (count) Moves count value (301) into %edx.
	movl	%edx, %edi  # (count) Moves count value into %edi.
	movq	%rcx, -7256(%rbp)   # (dest) Saves the address of the
                                # stack pointer in memory.
	movq	%rdi, %rcx  # (count) Moves count value into %rcx. That
                        # our value was a doubleword and is now acting
                        # as a quadword does not matter, as %ecx, not
                        # %rcx is the count register.
	movq	-7256(%rbp), %rdi   # (dest) Gets the address of the stack
                                # pointer from memory and sets %rdi -
                                # our destination - to that value.
	movq	-7248(%rbp), %r8    # (source) Gets the address of the
                                # clauseset stored in memory earlier
                                # and puts it in %r8.
	movl	%esi, -7260(%rbp)   # (unit) Moves the unit into memory.
	movq	%r8, %rsi   # (source) Puts the address of the clauseset
                        # into the source register, %rsi.
	rep;movsq   # Copies 2408 bytes from memory (from the previous
                # callstack) into this function's stack. This data
                # represents the clauseset. It is copied into memory
                # because we wish to pass it as an argument to 


	leaq	-2416(%rbp), %rdi   # ???
	movl	-7260(%rbp), %esi   # Moves the current unit into %esi
                                # which by convention stores the 2nd
                                # argument to a function.
	movq	%rax, -7272(%rbp)   # ???
	callq	simplifyLiteral # calls the function - its first ar
	leaq	-2416(%rbp), %rax
	movq	%rsp, %rcx
	movl	$301, %edx
	movl	%edx, %edi
	leaq	-2416(%rbp), %rsi
	movq	%rcx, -7280(%rbp)
	movq	%rdi, %rcx
	movq	-7280(%rbp), %rdi
	rep;movsq
	movq	%rax, -7288(%rbp)
	callq	dpll
	movb	%al, -1(%rbp)
	jmp	.LBB3_12
.LBB3_6:
	movq	-7248(%rbp), %rdi
	callq	firstLiteral
	movl	%eax, -2420(%rbp)
	cmpl	$0, -2420(%rbp)
	je	.LBB3_8
	jmp	.LBB3_9
.LBB3_8:
	movabsq	$.L.str, %rdi
	movabsq	$.L.str.1, %rsi
	movl	$75, %edx
	movabsq	$.L__PRETTY_FUNCTION__.dpll, %rcx
	callq	__assert_fail
.LBB3_9:
	leaq	-4832(%rbp), %rax
	movl	-2420(%rbp), %esi
	movq	%rsp, %rcx
	movl	$301, %edx
	movl	%edx, %edi
	movq	%rcx, -7296(%rbp)
	movq	%rdi, %rcx
	movq	-7296(%rbp), %rdi
	movq	-7248(%rbp), %r8
	movl	%esi, -7300(%rbp)
	movq	%r8, %rsi
	rep;movsq
	leaq	-4832(%rbp), %rdi
	movl	-7300(%rbp), %esi
	movq	%rax, -7312(%rbp)
	callq	simplifyLiteral
	leaq	-4832(%rbp), %rax
	movq	%rsp, %rcx
	movl	$301, %edx
	movl	%edx, %edi
	leaq	-4832(%rbp), %rsi
	movq	%rcx, -7320(%rbp)
	movq	%rdi, %rcx
	movq	-7320(%rbp), %rdi
	rep;movsq
	movq	%rax, -7328(%rbp)
	callq	dpll
	movb	%al, -2421(%rbp)
	cmpb	$0, -2421(%rbp)
	je	.LBB3_11
	movb	-2421(%rbp), %al
	movb	%al, -1(%rbp)
	jmp	.LBB3_12
.LBB3_11:
	leaq	-7240(%rbp), %rax
	xorl	%ecx, %ecx
	subl	-2420(%rbp), %ecx
	movq	%rsp, %rdx
	movl	$301, %esi
	movl	%esi, %edi
	movl	%ecx, -7332(%rbp)
	movq	%rdi, %rcx
	movq	%rdx, %rdi
	movq	-7248(%rbp), %rsi
	rep;movsq
	leaq	-7240(%rbp), %rdi
	movl	-7332(%rbp), %esi
	movq	%rax, -7344(%rbp)
	callq	simplifyLiteral
	leaq	-7240(%rbp), %rax
	movq	%rsp, %rcx
	movl	$301, %esi
	movl	%esi, %edx
	leaq	-7240(%rbp), %rsi
	movq	%rcx, -7352(%rbp)
	movq	%rdx, %rcx
	movq	-7352(%rbp), %rdi
	rep;movsq
	movq	%rax, -7360(%rbp)
	callq	dpll
	movb	%al, -1(%rbp)
.LBB3_12:
	movsbl	-1(%rbp), %eax
	addq	$9776, %rsp
	popq	%rbp
	retq
.Lfunc_end3:
	.size	dpll, .Lfunc_end3-dpll
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

	.type	.L.str.1,@object
.L.str.1:
	.asciz	"dpll.c"
	.size	.L.str.1, 7

	.type	.L__PRETTY_FUNCTION__.dpll,@object
.L__PRETTY_FUNCTION__.dpll:
	.asciz	"char dpll(clauseset)"
	.size	.L__PRETTY_FUNCTION__.dpll, 21

	.type	cs_original,@object
	.comm	cs_original,2408,4

	.ident	"clang version 3.7.0 (tags/RELEASE_370/final)"
	.section	".note.GNU-stack","",@progbits
