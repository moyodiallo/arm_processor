AS_ARM = arm-none-eabi-as
LD_ARM = arm-none-eabi-ld
CFLAGS = -march=armv2a -mno-thumb-interwork -Wall -O1
LD_FLAGS = -Bstatic -fix-v4bx

EXEC = test1 test2 test3 test4 test5 test6 test7 test8 test9

all : ${EXEC}


# Opcode, shift and branch testing
test1 : test1.o
test2 : test2.o
test3 : test3.o
test4 : test4.o
test5 : test5.o
test6 : test6.o
test7 : test7.o
test8 : test8.o
test9 : test9.o


# branch and link

# load and store test

# multi_transfert

# multiplication

test3 : test3.o

% : %.o 
	${LD_ARM} ${LD_FLAGS} -T sections.lds -o $@ $<

%.o: %.s
	$(AS_ARM) -o $@ -c $<

clean :
	rm -f test1 test2 test3 test4 test5 test6 test7 test8 test9 *.o
