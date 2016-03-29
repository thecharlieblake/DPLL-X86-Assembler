CC = clang
AFLAGS = -Wall -Wextra -fno-verbose-asm # for assembler
CFLAGS = -Wall -Wextra -std=c99         # for c compiler
LFLAGS = -Wall -Wextra  # for object code creation/linker
OFLAGS = -O0                            # for most compilations

all: dpll dpll-o3 dpll-stack dpll.s dpll-o3.s dpll-stack.s
clean:
	rm -f dpll dpll-stack dpll-o3 dpll.s cnf.o dimacs.o dpll-main.o dpll-o3.s dpll-stack.s dpll-commented.o dpll-o3-commented.o dpll-stack.o

dpll: cnf.o dimacs.o dpll-main.o dpll-commented.o
	${CC} ${LFLAGS} dpll-commented.o cnf.o dimacs.o dpll-main.o -o dpll 
dpll-o3: cnf.o dimacs.o dpll-main.o dpll-o3-commented.o
	${CC} ${LFLAGS} dpll-o3-commented.o cnf.o dimacs.o dpll-main.o -o dpll-o3 
dpll-stack: cnf.o dimacs.o dpll-main.o dpll-stack.o
	${CC} ${LFLAGS} dpll-stack.o cnf.o dimacs.o dpll-main.o -o dpll-stack

cnf.o : cnf.c cnf.h
	${CC} ${CFLAGS} cnf.c -c ${OFLAGS}
dimacs.o: dimacs.c cnf.h
	${CC} ${CFLAGS} dimacs.c -c ${OFLAGS}
dpll-main.o: dpll-main.c cnf.h
	${CC} ${CFLAGS} dpll-main.c -c ${OFLAGS}

dpll-o3.s: dpll.c cnf.h
	${CC} ${AFLAGS} dpll.c -c -S -o dpll-o3.s  -O3
dpll.s: dpll.c cnf.h
	${CC} ${AFLAGS} dpll.c -c -S -o dpll.s ${OFLAGS}
dpll-stack.s: dpll-stack.c cnf.h
	${CC} ${CFLAGS} dpll-stack.c -c -S -o dpll-stack.s ${OFLAGS}

dpll-commented.o: dpll-commented.s
	${CC} ${LFLAGS} dpll-commented.s -c ${OFLAGS} -o dpll-commented.o
dpll-o3-commented.o: dpll-o3-commented.s
	${CC} ${LFLAGS} dpll-o3-commented.s -c ${OFLAGS} -o dpll-o3-commented.o
dpll-stack.o: dpll-stack.s
	${CC} ${CFLAGS} dpll-stack.s -c ${OFLAGS} -o dpll-stack.o

dpll-o3-commented.s:
	echo "You need to create dpll-commented-o3.s manually: not created by make to avoid deleting your comments"
	false
dpll-commented.s:
	echo "You need to create dpll-commented.s manually: not created by make to avoid deleting your comments"
	false
