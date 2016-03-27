	.text
	.file	"/cs/home/cb307/.ccache/tmp/dpll.stdout.klovia.cs.st-andrews.ac.uk.18511.6BIdTS.i"
	.globl	containsEmptyClause
	.align	16, 0x90
	.type	containsEmptyClause,@function
containsEmptyClause:
	.cfi_startproc
	pushq	%rbp
.Ltmp0:
	.cfi_def_cfa_offset 16
.Ltmp1:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp2:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movl	$0, -20(%rbp)
.LBB0_1:
	movl	-20(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	4(%rcx), %eax
	jge	.LBB0_6
	movslq	-20(%rbp), %rax
	movq	-16(%rbp), %rcx
	addq	$8, %rcx
	imulq	$24, %rax, %rax
	addq	%rax, %rcx
	cmpl	$0, 4(%rcx)
	jne	.LBB0_4
	movl	$1, -4(%rbp)
	jmp	.LBB0_7
.LBB0_4:
	jmp	.LBB0_5
.LBB0_5:
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB0_1
.LBB0_6:
	movl	$0, -4(%rbp)
.LBB0_7:
	movl	-4(%rbp), %eax
	popq	%rbp
	retq
.Lfunc_end0:
	.size	containsEmptyClause, .Lfunc_end0-containsEmptyClause
	.cfi_endproc

	.globl	unitClause
	.align	16, 0x90
	.type	unitClause,@function
unitClause:
	.cfi_startproc
	pushq	%rbp
.Ltmp3:
	.cfi_def_cfa_offset 16
.Ltmp4:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp5:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movl	$0, -20(%rbp)
.LBB1_1:
	movl	-20(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	4(%rcx), %eax
	jge	.LBB1_6
	movslq	-20(%rbp), %rax
	movq	-16(%rbp), %rcx
	addq	$8, %rcx
	imulq	$24, %rax, %rax
	addq	%rax, %rcx
	cmpl	$1, 4(%rcx)
	jne	.LBB1_4
	movslq	-20(%rbp), %rax
	movq	-16(%rbp), %rcx
	addq	$8, %rcx
	imulq	$24, %rax, %rax
	addq	%rax, %rcx
	movl	8(%rcx), %edx
	movl	%edx, -4(%rbp)
	jmp	.LBB1_7
.LBB1_4:
	jmp	.LBB1_5
.LBB1_5:
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB1_1
.LBB1_6:
	movl	$0, -4(%rbp)
.LBB1_7:
	movl	-4(%rbp), %eax
	popq	%rbp
	retq
.Lfunc_end1:
	.size	unitClause, .Lfunc_end1-unitClause
	.cfi_endproc

	.globl	firstLiteral
	.align	16, 0x90
	.type	firstLiteral,@function
firstLiteral:
	.cfi_startproc
	pushq	%rbp
.Ltmp6:
	.cfi_def_cfa_offset 16
.Ltmp7:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp8:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movl	$0, -20(%rbp)
.LBB2_1:
	movl	-20(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	4(%rcx), %eax
	jge	.LBB2_6
	movslq	-20(%rbp), %rax
	movq	-16(%rbp), %rcx
	addq	$8, %rcx
	imulq	$24, %rax, %rax
	addq	%rax, %rcx
	cmpl	$0, 4(%rcx)
	jle	.LBB2_4
	movslq	-20(%rbp), %rax
	movq	-16(%rbp), %rcx
	addq	$8, %rcx
	imulq	$24, %rax, %rax
	addq	%rax, %rcx
	movl	8(%rcx), %edx
	movl	%edx, -4(%rbp)
	jmp	.LBB2_7
.LBB2_4:
	jmp	.LBB2_5
.LBB2_5:
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	jmp	.LBB2_1
.LBB2_6:
	movl	$0, -4(%rbp)
.LBB2_7:
	movl	-4(%rbp), %eax
	popq	%rbp
	retq
.Lfunc_end2:
	.size	firstLiteral, .Lfunc_end2-firstLiteral
	.cfi_endproc

	.globl	dpll
	.align	16, 0x90
	.type	dpll,@function
dpll:
	.cfi_startproc
	pushq	%rbp
.Ltmp9:
	.cfi_def_cfa_offset 16
.Ltmp10:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Ltmp11:
	.cfi_def_cfa_register %rbp
	subq	$9776, %rsp
	leaq	16(%rbp), %rax
	movq	node_count, %rcx
	addq	$1, %rcx
	movq	%rcx, node_count
	#APP
	nop

	#NO_APP
	cmpl	$0, 4(%rax)
	movq	%rax, -7248(%rbp)
	jne	.LBB3_2
	movb	$1, -1(%rbp)
	jmp	.LBB3_12
.LBB3_2:
	movq	-7248(%rbp), %rdi
	callq	containsEmptyClause
	cmpl	$0, %eax
	je	.LBB3_4
	movq	failures, %rax
	addq	$1, %rax
	movq	%rax, failures
	movb	$0, -1(%rbp)
	jmp	.LBB3_12
.LBB3_4:
	movq	-7248(%rbp), %rdi
	callq	unitClause
	movl	%eax, -8(%rbp)
	cmpl	$0, -8(%rbp)
	je	.LBB3_6
	leaq	-2416(%rbp), %rax
	movl	-8(%rbp), %esi
	movq	%rsp, %rcx
	movl	$301, %edx
	movl	%edx, %edi
	movq	%rcx, -7256(%rbp)
	movq	%rdi, %rcx
	movq	-7256(%rbp), %rdi
	movq	-7248(%rbp), %r8
	movl	%esi, -7260(%rbp)
	movq	%r8, %rsi
	rep;movsq
	leaq	-2416(%rbp), %rdi
	movl	-7260(%rbp), %esi
	movq	%rax, -7272(%rbp)
	callq	simplifyLiteral
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
